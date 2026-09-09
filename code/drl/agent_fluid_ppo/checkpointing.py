from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import pickle
import random
import shutil
import uuid
from typing import Any

import numpy as np
import torch as th
from stable_baselines3.common.base_class import BaseAlgorithm
from stable_baselines3.common.vec_env import VecNormalize


CHECKPOINT_SCHEMA = "agent-fluid.ppo-checkpoint.v1"
# Read archived checkpoints without rewriting their recorded metadata or payloads.
READABLE_CHECKPOINT_SCHEMAS = {CHECKPOINT_SCHEMA, "eve-aqua.ppo-checkpoint.v1"}
MODEL_FILE = "model.zip"
VECNORMALIZE_FILE = "vecnormalize.pkl"
RNG_FILE = "rng_state.pkl"
METADATA_FILE = "checkpoint.json"
COMPLETE_FILE = "COMPLETE"


def file_sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def capture_rng_state() -> dict[str, Any]:
    state: dict[str, Any] = {
        "python": random.getstate(),
        "numpy": np.random.get_state(),
        "torch_cpu": th.get_rng_state(),
    }
    if th.cuda.is_available():
        state["torch_cuda"] = th.cuda.get_rng_state_all()
    return state


def restore_rng_state(checkpoint_path: str | Path) -> None:
    path = Path(checkpoint_path)
    with (path / RNG_FILE).open("rb") as handle:
        state = pickle.load(handle)
    random.setstate(state["python"])
    np.random.set_state(state["numpy"])
    th.set_rng_state(state["torch_cpu"])
    if "torch_cuda" in state and th.cuda.is_available():
        th.cuda.set_rng_state_all(state["torch_cuda"])


def save_checkpoint(
    *,
    model: BaseAlgorithm,
    environment: VecNormalize,
    checkpoint_root: str | Path,
    label: str,
    completed_episodes: int,
    cfd_episodes_consumed: int,
    training_wall_time_s: float,
    next_checkpoint_episode: int,
    worker_episode_counts: dict[int, int],
) -> Path:
    root = Path(checkpoint_root)
    root.mkdir(parents=True, exist_ok=True)
    final_path = root / label
    if final_path.exists():
        raise FileExistsError(f"checkpoint already exists: {final_path}")
    staging_path = root / f".{label}.{os.getpid()}.{uuid.uuid4().hex}.tmp"
    staging_path.mkdir()
    try:
        model.save(str(staging_path / MODEL_FILE))
        environment.save(str(staging_path / VECNORMALIZE_FILE))
        with (staging_path / RNG_FILE).open("wb") as handle:
            pickle.dump(capture_rng_state(), handle, protocol=pickle.HIGHEST_PROTOCOL)

        payload_files = (MODEL_FILE, VECNORMALIZE_FILE, RNG_FILE)
        metadata = {
            "schema_version": CHECKPOINT_SCHEMA,
            "label": label,
            "completed_episodes": int(completed_episodes),
            "cfd_episodes_consumed": int(cfd_episodes_consumed),
            "training_wall_time_s": float(training_wall_time_s),
            "next_checkpoint_episode": int(next_checkpoint_episode),
            "training_timesteps": int(model.num_timesteps),
            "worker_episode_counts": {
                str(rank): int(count)
                for rank, count in sorted(worker_episode_counts.items())
            },
            "files": {
                filename: {
                    "bytes": (staging_path / filename).stat().st_size,
                    "sha256": file_sha256(staging_path / filename),
                }
                for filename in payload_files
            },
        }
        metadata_path = staging_path / METADATA_FILE
        metadata_path.write_text(
            json.dumps(metadata, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
        (staging_path / COMPLETE_FILE).write_text(
            file_sha256(metadata_path) + "\n", encoding="ascii"
        )
        os.replace(staging_path, final_path)
    except BaseException:
        shutil.rmtree(staging_path, ignore_errors=True)
        raise
    return final_path


def validate_checkpoint(checkpoint_path: str | Path) -> dict[str, Any]:
    path = Path(checkpoint_path).resolve()
    if not path.is_dir():
        raise FileNotFoundError(f"checkpoint directory not found: {path}")
    complete_path = path / COMPLETE_FILE
    metadata_path = path / METADATA_FILE
    if not complete_path.is_file() or not metadata_path.is_file():
        raise ValueError(f"checkpoint is incomplete: {path}")
    expected_metadata_hash = complete_path.read_text(encoding="ascii").strip()
    if file_sha256(metadata_path) != expected_metadata_hash:
        raise ValueError(f"checkpoint metadata checksum mismatch: {path}")
    metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
    if metadata.get("schema_version") not in READABLE_CHECKPOINT_SCHEMAS:
        raise ValueError(f"unsupported checkpoint schema in {path}")
    for filename, expected in metadata.get("files", {}).items():
        payload_path = path / filename
        if not payload_path.is_file():
            raise ValueError(f"checkpoint payload missing: {payload_path}")
        if payload_path.stat().st_size != int(expected["bytes"]):
            raise ValueError(f"checkpoint payload size mismatch: {payload_path}")
        if file_sha256(payload_path) != expected["sha256"]:
            raise ValueError(f"checkpoint payload checksum mismatch: {payload_path}")
    return metadata
