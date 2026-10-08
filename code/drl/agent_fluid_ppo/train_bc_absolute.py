from __future__ import annotations

import argparse
from collections.abc import Callable
import json
import math
import os
from pathlib import Path
import platform
import time
from typing import Any

import gymnasium as gym
import numpy as np
import stable_baselines3 as sb3
from stable_baselines3 import PPO
from stable_baselines3.common.monitor import Monitor
from stable_baselines3.common.policies import ActorCriticPolicy
from stable_baselines3.common.vec_env import SubprocVecEnv, VecNormalize
import torch as th

from .callbacks import EpisodeBudgetCallback
from .checkpointing import (
    MODEL_FILE,
    VECNORMALIZE_FILE,
    file_sha256,
    restore_rng_state,
    validate_checkpoint,
)
from .env import JuliaDogfishEnv
from .train import (
    DEFAULT_CONFIG,
    DEFAULT_SEED_POLICY,
    EXPERIMENT_ROOT,
    REPOSITORY_ROOT,
    TESTBED_ROOT,
    git_revision,
    parse_gpu_map,
    read_episode_history,
    validate_resume_action_repeat,
    validate_resume_observation_history_length,
    validate_loaded_model,
)


DEFAULT_CONTRACT = (
    EXPERIMENT_ROOT / "configs" / "bc_ppo_contract.json"
)


def absolute_environment_factory(
    *,
    rank: int,
    gpu_id: str,
    episode_offset: int,
    args: argparse.Namespace,
    teacher: bool,
) -> Callable[[], gym.Env]:
    def build() -> gym.Env:
        worker_family = "bc_teacher_workers" if teacher else "workers"
        environment = JuliaDogfishEnv(
            testbed_root=args.testbed_root,
            config_path=args.config,
            output_root=args.output_root / worker_family / f"worker_{rank:02d}",
            worker_id=rank,
            gpu_id=gpu_id,
            rollout_horizon=args.rollout_horizon,
            episode_offset=episode_offset,
            action_mode="absolute",
            emit_seed_action=teacher,
            action_repeat=args.action_repeat,
            observation_history_length=args.observation_history_length,
            julia_bin=args.julia_bin,
            seed_policy=args.seed_policy,
        )
        if teacher:
            return environment
        return Monitor(
            environment,
            filename=str(args.output_root / f"monitor_worker_{rank:02d}.csv"),
            info_keywords=(
                "raw_score",
                "shifted_score",
                "target_reached",
                "termination",
                "release_elapsed",
                "steps",
            ),
            override_existing=args.resume_checkpoint is None,
        )

    return build


def collect_teacher_dataset(
    args: argparse.Namespace, gpu_map: list[str]
) -> tuple[np.ndarray, np.ndarray, dict[str, Any]]:
    factories = [
        absolute_environment_factory(
            rank=rank,
            gpu_id=gpu_id,
            episode_offset=0,
            args=args,
            teacher=True,
        )
        for rank, gpu_id in enumerate(gpu_map)
    ]
    environment = SubprocVecEnv(factories, start_method="spawn")
    rng = np.random.default_rng(args.seed + 1_000_003)
    observations: list[np.ndarray] = []
    teacher_actions: list[np.ndarray] = []
    completed: list[dict[str, Any]] = []
    cfd_transitions = 0
    wall_start = time.perf_counter()
    try:
        environment.seed(args.seed)
        observation = environment.reset()
        for _ in range(args.bc_steps_per_env):
            labels = np.asarray(
                environment.env_method("teacher_action_normalized"),
                dtype=np.float32,
            )
            if labels.shape != (len(gpu_map), 2):
                raise ValueError(f"unexpected teacher action shape: {labels.shape}")
            observations.append(np.asarray(observation, dtype=np.float32).copy())
            teacher_actions.append(labels.copy())
            execution_actions = np.clip(
                labels
                + rng.normal(
                    0.0,
                    args.bc_teacher_noise_std,
                    size=labels.shape,
                ).astype(np.float32),
                -1.0,
                1.0,
            )
            observation, _, dones, infos = environment.step(execution_actions)
            for done, info in zip(dones, infos, strict=True):
                cfd_transitions += int(
                    info.get("cfd_steps_advanced", args.action_repeat)
                )
                if bool(done):
                    completed.append(
                        {
                            key: info.get(key)
                            for key in (
                                "worker_id",
                                "worker_episode",
                                "raw_score",
                                "shifted_score",
                                "target_reached",
                                "termination",
                                "steps",
                            )
                        }
                    )
    finally:
        try:
            environment.close()
        except (BrokenPipeError, EOFError):
            pass
    observation_array = np.concatenate(observations, axis=0)
    action_array = np.concatenate(teacher_actions, axis=0)
    completed_by_worker = {rank: 0 for rank in range(len(gpu_map))}
    for row in completed:
        worker_id = int(row["worker_id"])
        completed_by_worker[worker_id] += 1
    if args.require_complete_teacher_episode_per_env and any(
        count < 1 for count in completed_by_worker.values()
    ):
        raise RuntimeError(
            "behavior-cloning dataset does not contain a complete teacher "
            f"episode from every environment: {completed_by_worker}"
        )
    metadata = {
        "schema_version": "agent-fluid.bc-teacher-dataset.v1",
        "policy_transitions": int(observation_array.shape[0]),
        "cfd_transitions": int(cfd_transitions),
        "steps_per_environment": args.bc_steps_per_env,
        "policy_steps_per_environment": args.bc_steps_per_env,
        "action_repeat": args.action_repeat,
        "environment_count": len(gpu_map),
        "completed_teacher_episodes": len(completed),
        "completed_teacher_episodes_by_worker": completed_by_worker,
        "completed_episode_summaries": completed,
        "teacher_action_noise_std": args.bc_teacher_noise_std,
        "collection_wall_time_s": time.perf_counter() - wall_start,
    }
    return observation_array, action_array, metadata


def behavior_clone_actor(
    *,
    model: PPO,
    normalized_environment: VecNormalize,
    observations: np.ndarray,
    teacher_actions: np.ndarray,
    args: argparse.Namespace,
) -> dict[str, Any]:
    normalized_observations = normalized_environment.normalize_obs(
        observations.copy()
    ).astype(np.float32)
    rng = np.random.default_rng(args.seed + 2_000_003)
    indices = rng.permutation(len(normalized_observations))
    validation_count = max(1, int(len(indices) * args.bc_validation_fraction))
    validation_indices = indices[:validation_count]
    training_indices = indices[validation_count:]
    if len(training_indices) < 1:
        raise ValueError("behavior-cloning training split is empty")

    policy = model.policy
    actor_parameters = [
        *policy.mlp_extractor.policy_net.parameters(),
        *policy.action_net.parameters(),
    ]
    optimizer = th.optim.Adam(actor_parameters, lr=args.bc_learning_rate)
    loss_history: list[float] = []
    policy.set_training_mode(True)
    for _ in range(args.bc_epochs):
        epoch_indices = rng.permutation(training_indices)
        epoch_squared_error = 0.0
        epoch_values = 0
        for start in range(0, len(epoch_indices), args.bc_batch_size):
            batch_indices = epoch_indices[start : start + args.bc_batch_size]
            observation_tensor = th.as_tensor(
                normalized_observations[batch_indices],
                dtype=th.float32,
                device=policy.device,
            )
            target_tensor = th.as_tensor(
                teacher_actions[batch_indices],
                dtype=th.float32,
                device=policy.device,
            )
            predicted_mean = policy.get_distribution(
                observation_tensor
            ).distribution.mean
            loss = th.nn.functional.mse_loss(predicted_mean, target_tensor)
            optimizer.zero_grad(set_to_none=True)
            loss.backward()
            th.nn.utils.clip_grad_norm_(actor_parameters, 1.0)
            optimizer.step()
            epoch_squared_error += float(loss.detach().cpu().item()) * len(
                batch_indices
            )
            epoch_values += len(batch_indices)
        loss_history.append(epoch_squared_error / max(epoch_values, 1))

    policy.set_training_mode(False)
    with th.no_grad():
        validation_observations = th.as_tensor(
            normalized_observations[validation_indices],
            dtype=th.float32,
            device=policy.device,
        )
        validation_targets = th.as_tensor(
            teacher_actions[validation_indices],
            dtype=th.float32,
            device=policy.device,
        )
        validation_predictions = policy.get_distribution(
            validation_observations
        ).distribution.mean
        validation_errors = validation_predictions - validation_targets
        validation_mse = float(
            th.mean(validation_errors * validation_errors).cpu().item()
        )
        validation_mae = float(th.mean(th.abs(validation_errors)).cpu().item())
        validation_max = float(th.max(th.abs(validation_errors)).cpu().item())
    return {
        "schema_version": "agent-fluid.behavior-cloning-metrics.v1",
        "epochs": args.bc_epochs,
        "batch_size": args.bc_batch_size,
        "learning_rate": args.bc_learning_rate,
        "training_samples": len(training_indices),
        "validation_samples": len(validation_indices),
        "epoch_mse": loss_history,
        "final_training_mse": loss_history[-1],
        "validation_mse_normalized_action": validation_mse,
        "validation_rmse_normalized_action": math.sqrt(validation_mse),
        "validation_mae_normalized_action": validation_mae,
        "validation_max_abs_normalized_action": validation_max,
        "validation_rmse_deg_s2": math.sqrt(validation_mse) * 1800.0,
        "validation_mae_deg_s2": validation_mae * 1800.0,
    }


def write_initial_manifest(
    *,
    args: argparse.Namespace,
    gpu_map: list[str],
    contract: dict[str, Any],
    dataset_metadata: dict[str, Any],
    bc_metrics: dict[str, Any],
    dataset_path: Path,
) -> None:
    prewarm_value = os.environ.get("DOGFISH_WAKE_LOAD_PREWARM_SNAPSHOT")
    prewarm_path = Path(prewarm_value).resolve() if prewarm_value else None
    manifest = {
        "schema_version": "agent-fluid.bc-absolute-ppo-training.v1",
        "algorithm": "Behavior cloning warm-start plus Stable-Baselines3 PPO",
        "action_mode": "absolute_two_joint_angular_accelerations",
        "analytic_seed_used_during_ppo": False,
        "stable_baselines3": sb3.__version__,
        "torch": th.__version__,
        "numpy": np.__version__,
        "python": platform.python_version(),
        "testbed_revision": git_revision(args.testbed_root),
        "arguments": {
            key: str(value) if isinstance(value, Path) else value
            for key, value in vars(args).items()
        },
        "gpu_map": gpu_map,
        "contract": contract,
        "environment_config": {
            "path": str(args.config),
            "sha256": file_sha256(args.config),
        },
        "teacher_seed_policy": {
            "path": str(args.seed_policy),
            "sha256": file_sha256(args.seed_policy),
            "used_after_behavior_cloning": False,
        },
        "prewarm_snapshot": {
            "path": str(prewarm_path) if prewarm_path is not None else None,
            "sha256": (
                file_sha256(prewarm_path)
                if prewarm_path is not None and prewarm_path.is_file()
                else None
            ),
        },
        "bc_dataset": {
            **dataset_metadata,
            "path": str(dataset_path),
            "sha256": file_sha256(dataset_path),
        },
        "bc_metrics": bc_metrics,
        "data_efficiency_accounting": {
            "teacher_cfd_transitions": dataset_metadata["cfd_transitions"],
            "teacher_completed_episodes": dataset_metadata[
                "completed_teacher_episodes"
            ],
            "ppo_completed_episodes": "read from episodes.jsonl",
        },
    }
    (args.output_root / "training_manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Behavior-cloned absolute-action PPO baseline."
    )
    parser.add_argument("--testbed-root", type=Path, default=TESTBED_ROOT)
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG)
    parser.add_argument(
        "--contract", type=Path, default=DEFAULT_CONTRACT
    )
    parser.add_argument("--seed-policy", type=Path, default=DEFAULT_SEED_POLICY)
    parser.add_argument("--output-root", type=Path, required=True)
    parser.add_argument("--gpu-map", type=parse_gpu_map, default=parse_gpu_map("0,0,1,1"))
    parser.add_argument("--julia-bin", default="julia")
    parser.add_argument("--seed", type=int, default=20260825)
    parser.add_argument("--episode-budget", type=int, default=600)
    parser.add_argument("--checkpoint-interval", type=int, default=10)
    parser.add_argument("--resume-checkpoint", type=Path)
    parser.add_argument("--rollout-horizon", type=float, default=300.0)
    parser.add_argument("--action-repeat", type=int, default=4)
    parser.add_argument("--observation-history-length", type=int, default=8)
    parser.add_argument("--n-steps", type=int, default=512)
    parser.add_argument("--batch-size", type=int, default=64)
    parser.add_argument("--n-epochs", type=int, default=10)
    parser.add_argument("--learning-rate", type=float, default=3.0e-5)
    parser.add_argument("--gamma", type=float, default=0.9996000599960001)
    parser.add_argument("--gae-lambda", type=float, default=0.9980014995000627)
    parser.add_argument("--clip-range", type=float, default=0.2)
    parser.add_argument("--target-kl", type=float, default=0.03)
    parser.add_argument("--action-std", type=float, default=0.05)
    parser.add_argument("--bc-steps-per-env", type=int, default=8192)
    parser.add_argument("--bc-teacher-noise-std", type=float, default=0.05)
    parser.add_argument("--bc-epochs", type=int, default=30)
    parser.add_argument("--bc-batch-size", type=int, default=512)
    parser.add_argument("--bc-learning-rate", type=float, default=1.0e-3)
    parser.add_argument("--bc-validation-fraction", type=float, default=0.1)
    parser.add_argument(
        "--require-complete-teacher-episode-per-env",
        action=argparse.BooleanOptionalAction, default=True,
        help=(
            "Reject a BC dataset unless every CFD lane completes at least one "
            "teacher-driven episode."
        ),
    )
    parser.add_argument(
        "--freeze-observation-normalization",
        action=argparse.BooleanOptionalAction, default=True,
        help="Keep the BC dataset observation statistics fixed during PPO.",
    )
    return parser


def main() -> None:
    attempt_wall_start = time.perf_counter()
    args = build_argument_parser().parse_args()
    for name in (
        "testbed_root",
        "config",
        "contract",
        "seed_policy",
        "output_root",
    ):
        setattr(args, name, getattr(args, name).resolve())
    if args.resume_checkpoint is not None:
        args.resume_checkpoint = args.resume_checkpoint.resolve()
        validate_resume_action_repeat(args.output_root, args.action_repeat)
        validate_resume_observation_history_length(
            args.output_root, args.observation_history_length
        )
    gpu_map = list(args.gpu_map)
    if len(gpu_map) != 4 or not (
        gpu_map[0] == gpu_map[1]
        and gpu_map[2] == gpu_map[3]
        and gpu_map[0] != gpu_map[2]
    ):
        raise SystemExit("training requires the two-GPU 2+2 worker map")
    if not 0.0 < args.bc_validation_fraction < 1.0:
        raise SystemExit("BC validation fraction must be between zero and one")
    if args.action_repeat < 1:
        raise SystemExit("action repeat must be a positive integer")
    if args.observation_history_length < 1:
        raise SystemExit("observation history length must be a positive integer")
    if args.target_kl is not None and args.target_kl <= 0.0:
        raise SystemExit("target KL must be positive")
    contract = json.loads(args.contract.read_text(encoding="utf-8"))

    resume_metadata: dict[str, Any] | None = None
    completed_episodes = 0
    cfd_episodes_consumed = 0
    prior_training_wall_time_s = 0.0
    worker_episode_counts: dict[int, int] = {}
    if args.resume_checkpoint is not None:
        expected_parent = args.output_root / "checkpoints"
        if args.resume_checkpoint.parent != expected_parent:
            raise SystemExit("resume checkpoint does not belong to output root")
        resume_metadata = validate_checkpoint(args.resume_checkpoint)
        completed_episodes = int(resume_metadata["completed_episodes"])
        worker_episode_counts = {
            int(rank): int(count)
            for rank, count in resume_metadata["worker_episode_counts"].items()
        }
        logged_cfd, logged_wall, logged_workers = read_episode_history(
            args.output_root / "episodes.jsonl"
        )
        cfd_episodes_consumed = max(
            logged_cfd,
            int(resume_metadata.get("cfd_episodes_consumed", completed_episodes)),
        )
        prior_training_wall_time_s = max(
            logged_wall,
            float(resume_metadata.get("training_wall_time_s", 0.0)),
        )
        for rank, count in logged_workers.items():
            worker_episode_counts[rank] = max(
                count, worker_episode_counts.get(rank, 0)
            )
        if completed_episodes >= args.episode_budget:
            raise SystemExit("resume checkpoint already meets episode budget")
        with (args.output_root / "resume_events.jsonl").open(
            "a", encoding="utf-8"
        ) as handle:
            handle.write(
                json.dumps(
                    {
                        "checkpoint": str(args.resume_checkpoint),
                        "completed_episodes": completed_episodes,
                        "cfd_episodes_consumed": cfd_episodes_consumed,
                        "episode_budget": args.episode_budget,
                    },
                    sort_keys=True,
                )
                + "\n"
            )

    factories = [
        absolute_environment_factory(
            rank=rank,
            gpu_id=gpu_id,
            episode_offset=worker_episode_counts.get(rank, 0),
            args=args,
            teacher=False,
        )
        for rank, gpu_id in enumerate(gpu_map)
    ]
    vector_environment: SubprocVecEnv | None = None
    normalized_environment: VecNormalize | None = None
    model: PPO | None = None
    if resume_metadata is None:
        if (args.output_root / "training_manifest.json").exists():
            raise SystemExit("new training output root already contains a run")
        observations, teacher_actions, dataset_metadata = collect_teacher_dataset(
            args, gpu_map
        )
        dataset_path = args.output_root / "bc_dataset.npz"
        np.savez_compressed(
            dataset_path,
            observations=observations,
            teacher_actions=teacher_actions,
        )
        vector_environment = SubprocVecEnv(factories, start_method="spawn")
        normalized_environment = VecNormalize(
            vector_environment,
            training=True,
            norm_obs=True,
            norm_reward=False,
            clip_obs=10.0,
        )
        normalized_environment.obs_rms.update(observations)
        normalized_environment.training = not args.freeze_observation_normalization
        model = PPO(
            ActorCriticPolicy,
            normalized_environment,
            learning_rate=args.learning_rate,
            n_steps=args.n_steps,
            batch_size=args.batch_size,
            n_epochs=args.n_epochs,
            gamma=args.gamma,
            gae_lambda=args.gae_lambda,
            clip_range=args.clip_range,
            target_kl=args.target_kl,
            normalize_advantage=True,
            ent_coef=0.0,
            vf_coef=0.5,
            max_grad_norm=0.5,
            policy_kwargs={
                "activation_fn": th.nn.Tanh,
                "net_arch": {"pi": [128, 128], "vf": [128, 128]},
                "log_std_init": math.log(args.action_std),
            },
            tensorboard_log=str(args.output_root / "tensorboard"),
            verbose=1,
            seed=args.seed,
            device="cpu",
        )
        bc_metrics = behavior_clone_actor(
            model=model,
            normalized_environment=normalized_environment,
            observations=observations,
            teacher_actions=teacher_actions,
            args=args,
        )
        model.save(str(args.output_root / "bc_initialized_model.zip"))
        normalized_environment.save(
            str(args.output_root / "bc_initialized_vecnormalize.pkl")
        )
        (args.output_root / "bc_metrics.json").write_text(
            json.dumps(bc_metrics, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
        write_initial_manifest(
            args=args,
            gpu_map=gpu_map,
            contract=contract,
            dataset_metadata=dataset_metadata,
            bc_metrics=bc_metrics,
            dataset_path=dataset_path,
        )
    else:
        vector_environment = SubprocVecEnv(factories, start_method="spawn")
        normalized_environment = VecNormalize.load(
            str(args.resume_checkpoint / VECNORMALIZE_FILE), vector_environment
        )
        normalized_environment.training = not args.freeze_observation_normalization
        normalized_environment.norm_reward = False
        model = PPO.load(
            str(args.resume_checkpoint / MODEL_FILE),
            env=normalized_environment,
            device="cpu",
            force_reset=True,
        )
        validate_loaded_model(model, args, gpu_map)
        restore_rng_state(args.resume_checkpoint)

    assert normalized_environment is not None and model is not None
    callback = EpisodeBudgetCallback(
        episode_budget=args.episode_budget,
        checkpoint_interval=args.checkpoint_interval,
        output_root=args.output_root,
        completed_episodes=completed_episodes,
        cfd_episodes_consumed=cfd_episodes_consumed,
        prior_training_wall_time_s=prior_training_wall_time_s,
        attempt_wall_start=attempt_wall_start,
        worker_episode_counts=worker_episode_counts,
    )
    try:
        model.learn(
            total_timesteps=100_000_000,
            callback=callback,
            progress_bar=False,
            reset_num_timesteps=resume_metadata is None,
        )
    finally:
        model.save(str(args.output_root / "final_model.zip"))
        normalized_environment.save(
            str(args.output_root / "final_vecnormalize.pkl")
        )
        try:
            normalized_environment.close()
        except (BrokenPipeError, EOFError):
            pass


if __name__ == "__main__":
    main()
