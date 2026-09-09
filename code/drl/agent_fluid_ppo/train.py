from __future__ import annotations

import argparse
import json
from pathlib import Path
import subprocess

from stable_baselines3 import PPO


REPOSITORY_ROOT = Path(__file__).resolve().parents[3]
EXPERIMENT_ROOT = Path(__file__).resolve().parents[1]
TESTBED_ROOT = REPOSITORY_ROOT / "code" / "simulation" / "2d"
DEFAULT_CONFIG = EXPERIMENT_ROOT / "configs" / "free_swim_multiwake_ppo_l64.toml"
DEFAULT_SEED_POLICY = TESTBED_ROOT / "cases" / "dogfish_2d_shape_policy" / "candidate_target_policy.jl"


def parse_gpu_map(value: str) -> list[str]:
    result = [item.strip() for item in value.split(",") if item.strip()]
    if not result:
        raise argparse.ArgumentTypeError("GPU map must contain at least one device")
    return result


def git_revision(root: Path) -> str | None:
    try:
        return subprocess.check_output(
            ["git", "rev-parse", "HEAD"], cwd=root, text=True
        ).strip()
    except (OSError, subprocess.CalledProcessError):
        return None


def read_episode_history(
    episode_log: Path,
) -> tuple[int, float, dict[int, int]]:
    if not episode_log.is_file():
        return 0, 0.0, {}
    rows: list[dict[str, object]] = []
    with episode_log.open("r", encoding="utf-8") as handle:
        for line_number, line in enumerate(handle, start=1):
            if not line.strip():
                continue
            try:
                rows.append(json.loads(line))
            except json.JSONDecodeError as error:
                raise ValueError(
                    f"invalid episode log JSON at {episode_log}:{line_number}"
                ) from error
    worker_counts: dict[int, int] = {}
    for row in rows:
        worker_id = int(row.get("worker_id", -1))
        worker_episode = int(row.get("worker_episode", 0))
        if worker_id >= 0:
            worker_counts[worker_id] = max(
                worker_episode, worker_counts.get(worker_id, 0)
            )
    wall_time_s = max(
        (float(row.get("training_wall_time_s", 0.0)) for row in rows), default=0.0
    )
    cfd_episodes_consumed = max(
        (
            int(row.get("cfd_episode_total", index))
            for index, row in enumerate(rows, start=1)
        ),
        default=0,
    )
    return cfd_episodes_consumed, wall_time_s, worker_counts


def validate_resume_action_repeat(output_root: Path, requested: int) -> None:
    manifest_path = output_root / "training_manifest.json"
    if not manifest_path.is_file():
        raise FileNotFoundError(
            f"resume run is missing its training manifest: {manifest_path}"
        )
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    arguments = dict(manifest.get("arguments", {}))
    recorded = int(arguments.get("action_repeat", 1))
    if recorded != requested:
        raise SystemExit(
            "resume action repeat does not match the frozen run: "
            f"recorded {recorded}, requested {requested}"
        )


def validate_resume_observation_history_length(
    output_root: Path, requested: int
) -> None:
    manifest_path = output_root / "training_manifest.json"
    if not manifest_path.is_file():
        raise FileNotFoundError(
            f"resume run is missing its training manifest: {manifest_path}"
        )
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    arguments = dict(manifest.get("arguments", {}))
    recorded = int(arguments.get("observation_history_length", 8))
    if recorded != requested:
        raise SystemExit(
            "resume observation history length does not match the frozen run: "
            f"recorded {recorded}, requested {requested}"
        )


def validate_loaded_model(
    model: PPO, args: argparse.Namespace, gpu_map: list[str]
) -> None:
    actual = {
        "environment_count": model.n_envs,
        "n_steps": model.n_steps,
        "batch_size": model.batch_size,
        "n_epochs": model.n_epochs,
        "gamma": model.gamma,
        "gae_lambda": model.gae_lambda,
        "clip_range": float(model.clip_range(1.0)),
        "target_kl": model.target_kl,
    }
    expected = {
        "environment_count": len(gpu_map),
        "n_steps": args.n_steps,
        "batch_size": args.batch_size,
        "n_epochs": args.n_epochs,
        "gamma": args.gamma,
        "gae_lambda": args.gae_lambda,
        "clip_range": args.clip_range,
        "target_kl": args.target_kl,
    }
    mismatches = {
        name: {"checkpoint": actual[name], "requested": expected[name]}
        for name in expected
        if actual[name] != expected[name]
    }
    if mismatches:
        raise SystemExit(
            "checkpoint PPO settings do not match this resume request: "
            + json.dumps(mismatches, sort_keys=True)
        )


def main() -> None:
    from .train_bc_absolute import main as train
    train()


if __name__ == "__main__":
    main()
