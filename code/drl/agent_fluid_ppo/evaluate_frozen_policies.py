from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor
from dataclasses import asdict, dataclass
import json
import math
import os
from pathlib import Path
import pickle
import subprocess
from typing import Any

import numpy as np
from stable_baselines3 import PPO
from stable_baselines3.common.vec_env import VecNormalize
import torch as th

from .checkpointing import file_sha256, validate_checkpoint
from .env import JuliaDogfishEnv


@dataclass(frozen=True)
class PolicySpec:
    label: str
    action_mode: str
    model_path: Path
    vecnormalize_path: Path
    checkpoint_path: Path | None


def parse_policy(value: str) -> PolicySpec:
    fields = value.split("|")
    if len(fields) != 5:
        raise argparse.ArgumentTypeError(
            "policy must be LABEL|ACTION_MODE|MODEL|VECNORMALIZE|CHECKPOINT_OR_DASH"
        )
    label, action_mode, model, vecnormalize, checkpoint = fields
    if not label or any(character not in "abcdefghijklmnopqrstuvwxyz0123456789_-" for character in label):
        raise argparse.ArgumentTypeError(f"invalid policy label: {label!r}")
    if action_mode not in {"residual", "absolute"}:
        raise argparse.ArgumentTypeError(f"invalid action mode: {action_mode!r}")
    return PolicySpec(
        label=label,
        action_mode=action_mode,
        model_path=Path(model).resolve(),
        vecnormalize_path=Path(vecnormalize).resolve(),
        checkpoint_path=None if checkpoint == "-" else Path(checkpoint).resolve(),
    )


def parse_gpu_map(value: str) -> list[str]:
    result = [item.strip() for item in value.split(",") if item.strip()]
    if not result:
        raise argparse.ArgumentTypeError("gpu map must not be empty")
    return result


def json_safe(value: Any) -> Any:
    if isinstance(value, dict):
        return {str(key): json_safe(item) for key, item in value.items()}
    if isinstance(value, (list, tuple)):
        return [json_safe(item) for item in value]
    if isinstance(value, np.ndarray):
        return value.tolist()
    if isinstance(value, np.generic):
        return value.item()
    if isinstance(value, Path):
        return str(value)
    return value


def repository_revision(root: Path) -> str | None:
    try:
        return subprocess.check_output(
            ["git", "rev-parse", "HEAD"], cwd=root, text=True
        ).strip()
    except (OSError, subprocess.CalledProcessError):
        return None


def validate_and_freeze_sources(
    *,
    specs: list[PolicySpec],
    testbed_root: Path,
    config: Path,
    seed_policy: Path,
    prewarm_snapshot: Path,
    gpu_map: list[str],
    seed: int,
    action_repeat: int,
    observation_history_length: int = 8,
) -> dict[str, Any]:
    labels = [spec.label for spec in specs]
    if len(labels) != len(set(labels)):
        raise ValueError("policy labels must be unique")
    sources = []
    for spec in specs:
        if not spec.model_path.is_file():
            raise FileNotFoundError(spec.model_path)
        if not spec.vecnormalize_path.is_file():
            raise FileNotFoundError(spec.vecnormalize_path)
        checkpoint_metadata = (
            validate_checkpoint(spec.checkpoint_path)
            if spec.checkpoint_path is not None
            else None
        )
        source_run_root = (
            spec.checkpoint_path.parents[1]
            if spec.checkpoint_path is not None
            else spec.model_path.parent
        )
        training_manifest_path = source_run_root / "training_manifest.json"
        if not training_manifest_path.is_file():
            raise FileNotFoundError(
                f"policy {spec.label} is missing its training manifest: "
                f"{training_manifest_path}"
            )
        training_manifest = json.loads(
            training_manifest_path.read_text(encoding="utf-8")
        )
        training_arguments = dict(training_manifest.get("arguments", {}))
        trained_action_repeat = int(training_arguments.get("action_repeat", 1))
        if trained_action_repeat != action_repeat:
            raise ValueError(
                f"policy {spec.label} was trained with action_repeat="
                f"{trained_action_repeat}, but evaluation requested "
                f"action_repeat={action_repeat}"
            )
        trained_observation_history_length = int(
            training_arguments.get("observation_history_length", 8)
        )
        if trained_observation_history_length != observation_history_length:
            raise ValueError(
                f"policy {spec.label} was trained with "
                "observation_history_length="
                f"{trained_observation_history_length}, but evaluation requested "
                f"observation_history_length={observation_history_length}"
            )
        sources.append(
            {
                **json_safe(asdict(spec)),
                "model_sha256": file_sha256(spec.model_path),
                "vecnormalize_sha256": file_sha256(spec.vecnormalize_path),
                "checkpoint_valid": checkpoint_metadata is not None,
                "checkpoint_metadata": checkpoint_metadata,
                "training_manifest_path": str(training_manifest_path),
                "training_manifest_sha256": file_sha256(training_manifest_path),
                "trained_action_repeat": trained_action_repeat,
                "trained_observation_history_length": (
                    trained_observation_history_length
                ),
            }
        )
    return {
        "schema_version": "agent-fluid.frozen-deterministic-policy-evaluation.v1",
        "purpose": "Distinguish deterministic mean-policy competence from stochastic exploration successes in PPO training.",
        "deterministic_action": True,
        "normalization_training": False,
        "reward_normalization": False,
        "episodes_per_policy": 1,
        "fixed_initial_condition": True,
        "training_seed": seed,
        "action_repeat": action_repeat,
        "observation_history_length": observation_history_length,
        "testbed_root": str(testbed_root),
        "testbed_revision": repository_revision(testbed_root),
        "environment_config": {
            "path": str(config),
            "sha256": file_sha256(config),
        },
        "seed_policy": {
            "path": str(seed_policy),
            "sha256": file_sha256(seed_policy),
        },
        "prewarm_snapshot": {
            "path": str(prewarm_snapshot),
            "sha256": file_sha256(prewarm_snapshot),
        },
        "gpu_map": gpu_map,
        "policies": sources,
    }


def load_frozen_normalizer(path: Path) -> VecNormalize:
    with path.open("rb") as handle:
        normalizer = pickle.load(handle)
    if not isinstance(normalizer, VecNormalize):
        raise TypeError(f"not a VecNormalize snapshot: {path}")
    normalizer.training = False
    normalizer.norm_reward = False
    return normalizer


def evaluate_one(
    *,
    spec: PolicySpec,
    lane_id: int,
    gpu_id: str,
    args: argparse.Namespace,
) -> dict[str, Any]:
    policy_root = args.output_root / "policies" / spec.label
    policy_root.mkdir(parents=True, exist_ok=False)
    environment = JuliaDogfishEnv(
        testbed_root=args.testbed_root,
        config_path=args.config,
        output_root=policy_root / "cfd",
        worker_id=lane_id,
        gpu_id=gpu_id,
        rollout_horizon=args.rollout_horizon,
        action_mode=spec.action_mode,
        emit_seed_action=False,
        action_repeat=args.action_repeat,
        observation_history_length=args.observation_history_length,
        julia_bin=args.julia_bin,
        seed_policy=args.seed_policy,
    )
    model = PPO.load(str(spec.model_path), device="cpu")
    normalizer = load_frozen_normalizer(spec.vecnormalize_path)
    action_sum = np.zeros(2, dtype=np.float64)
    action_square_sum = np.zeros(2, dtype=np.float64)
    action_min = np.full(2, np.inf, dtype=np.float64)
    action_max = np.full(2, -np.inf, dtype=np.float64)
    saturation_count = np.zeros(2, dtype=np.int64)
    reward_sum = 0.0
    policy_steps = 0
    terminal_info: dict[str, Any] | None = None
    try:
        observation, reset_info = environment.reset(seed=args.seed)
        while True:
            normalized_observation = normalizer.normalize_obs(
                observation.reshape(1, -1)
            )
            action, _ = model.predict(normalized_observation, deterministic=True)
            action_vector = np.asarray(action, dtype=np.float32).reshape(-1, 2)[0]
            action_sum += action_vector
            action_square_sum += np.square(action_vector, dtype=np.float64)
            action_min = np.minimum(action_min, action_vector)
            action_max = np.maximum(action_max, action_vector)
            saturation_count += np.abs(action_vector) >= 0.999
            observation, reward, terminated, truncated, info = environment.step(
                action_vector
            )
            reward_sum += reward
            policy_steps += 1
            if terminated or truncated:
                terminal_info = info
                break
    finally:
        environment.close()
    if terminal_info is None:
        raise RuntimeError(f"policy {spec.label} did not produce a terminal event")

    episode_root = policy_root / "cfd" / "episode_000001"
    summary_path = episode_root / "summary.json"
    if not summary_path.is_file():
        raise FileNotFoundError(summary_path)
    summary = json.loads(summary_path.read_text(encoding="utf-8"))
    if not bool(summary.get("loaded_prewarm_snapshot")):
        raise ValueError(f"{spec.label} did not load the frozen prewarm snapshot")
    expected_flow_speed = float(args.expected_flow_speed)
    if not math.isclose(
        float(summary.get("flow_speed")), expected_flow_speed, rel_tol=0.0, abs_tol=1e-6
    ):
        raise ValueError(
            f"{spec.label} flow speed mismatch: {summary.get('flow_speed')}"
        )

    action_mean = action_sum / policy_steps
    action_variance = np.maximum(
        action_square_sum / policy_steps - np.square(action_mean), 0.0
    )
    def summary_or_terminal(name: str) -> Any:
        value = summary.get(name)
        return terminal_info.get(name) if value is None else value

    result = {
        "schema_version": "agent-fluid.deterministic-policy-result.v1",
        "label": spec.label,
        "action_mode": spec.action_mode,
        "deterministic_action": True,
        "normalization_training": False,
        "gpu_id": gpu_id,
        "lane_id": lane_id,
        "model_sha256": file_sha256(spec.model_path),
        "vecnormalize_sha256": file_sha256(spec.vecnormalize_path),
        "reset_info": reset_info,
        "policy_steps": policy_steps,
        "cfd_steps": terminal_info.get("action_count"),
        "action_repeat": args.action_repeat,
        "observation_history_length": args.observation_history_length,
        "undiscounted_reward_sum": reward_sum,
        "terminal": terminal_info,
        "summary": {
            "path": str(summary_path),
            "sha256": file_sha256(summary_path),
            "flow_speed": summary.get("flow_speed"),
            "loaded_prewarm_snapshot": summary.get("loaded_prewarm_snapshot"),
            "termination": summary_or_terminal("termination"),
            "target_reached": summary_or_terminal("target_reached"),
            "raw_score": summary_or_terminal("raw_score"),
            "shifted_score": summary_or_terminal("shifted_score"),
            "release_elapsed": summary_or_terminal("release_elapsed"),
            "steps": summary_or_terminal("steps"),
        },
        "normalized_network_action": {
            "mean": action_mean.tolist(),
            "standard_deviation_over_time": np.sqrt(action_variance).tolist(),
            "minimum": action_min.tolist(),
            "maximum": action_max.tolist(),
            "saturation_fraction": (saturation_count / policy_steps).tolist(),
        },
    }
    result = json_safe(result)
    (policy_root / "result.json").write_text(
        json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return result


def evaluate_lane(
    lane_id: int,
    gpu_id: str,
    specs: list[PolicySpec],
    args: argparse.Namespace,
) -> list[dict[str, Any]]:
    return [
        evaluate_one(spec=spec, lane_id=lane_id, gpu_id=gpu_id, args=args)
        for spec in specs
    ]


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Evaluate frozen PPO checkpoints with deterministic mean actions."
    )
    parser.add_argument("--testbed-root", type=Path, required=True)
    parser.add_argument("--config", type=Path, required=True)
    parser.add_argument("--seed-policy", type=Path, required=True)
    parser.add_argument("--prewarm-snapshot", type=Path, required=True)
    parser.add_argument("--output-root", type=Path, required=True)
    parser.add_argument("--gpu-map", type=parse_gpu_map, required=True)
    parser.add_argument("--julia-bin", required=True)
    parser.add_argument("--seed", type=int, default=20260825)
    parser.add_argument("--rollout-horizon", type=float, default=300.0)
    parser.add_argument("--action-repeat", type=int, default=1)
    parser.add_argument("--observation-history-length", type=int, default=8)
    parser.add_argument("--expected-flow-speed", type=float, default=0.18)
    parser.add_argument("--policy", action="append", type=parse_policy, required=True)
    return parser


def main() -> None:
    args = build_argument_parser().parse_args()
    for name in (
        "testbed_root",
        "config",
        "seed_policy",
        "prewarm_snapshot",
        "output_root",
    ):
        setattr(args, name, getattr(args, name).resolve())
    specs = list(args.policy)
    gpu_map = list(args.gpu_map)
    if args.action_repeat < 1:
        raise ValueError("action repeat must be a positive integer")
    if args.observation_history_length < 1:
        raise ValueError("observation history length must be a positive integer")
    if len(gpu_map) > len(specs):
        gpu_map = gpu_map[: len(specs)]
    if args.output_root.exists():
        raise FileExistsError(args.output_root)
    os.environ["DOGFISH_WAKE_LOAD_PREWARM_SNAPSHOT"] = str(
        args.prewarm_snapshot
    )
    args.output_root.mkdir(parents=True)
    th.set_num_threads(1)
    manifest = validate_and_freeze_sources(
        specs=specs,
        testbed_root=args.testbed_root,
        config=args.config,
        seed_policy=args.seed_policy,
        prewarm_snapshot=args.prewarm_snapshot,
        gpu_map=gpu_map,
        seed=args.seed,
        action_repeat=args.action_repeat,
        observation_history_length=args.observation_history_length,
    )
    (args.output_root / "frozen_evaluation_manifest.json").write_text(
        json.dumps(json_safe(manifest), indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    lane_specs = [specs[index :: len(gpu_map)] for index in range(len(gpu_map))]
    with ThreadPoolExecutor(max_workers=len(gpu_map)) as executor:
        futures = [
            executor.submit(evaluate_lane, lane, gpu, assigned, args)
            for lane, (gpu, assigned) in enumerate(zip(gpu_map, lane_specs))
        ]
        lane_results = [future.result() for future in futures]
    by_label = {
        result["label"]: result
        for lane_result in lane_results
        for result in lane_result
    }
    ordered_results = [by_label[spec.label] for spec in specs]
    aggregate = {
        "schema_version": "agent-fluid.deterministic-policy-evaluation-summary.v1",
        "status": "complete",
        "evaluation_manifest": str(
            args.output_root / "frozen_evaluation_manifest.json"
        ),
        "policy_count": len(ordered_results),
        "target_reached_count": sum(
            bool(result["summary"]["target_reached"])
            for result in ordered_results
        ),
        "results": ordered_results,
    }
    (args.output_root / "evaluation_summary.json").write_text(
        json.dumps(json_safe(aggregate), indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(json.dumps(json_safe(aggregate), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
