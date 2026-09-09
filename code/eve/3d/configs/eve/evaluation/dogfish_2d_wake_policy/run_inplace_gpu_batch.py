#!/usr/bin/env python3
"""Coordinate one EvE iteration's CFD evaluations on the outer PBS GPU."""

from __future__ import annotations

import argparse
import fcntl
import json
import os
import re
import signal
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import IO

_STEP_PATTERN = re.compile(r"(?:^|_)step_(\d+)(?:_|$)")


def _positive_int(name: str, default: int) -> int:
    raw = os.environ.get(name, str(default))
    try:
        value = int(raw)
    except ValueError as exc:
        raise SystemExit(f"{name} must be a positive integer, got {raw!r}") from exc
    if value <= 0:
        raise SystemExit(f"{name} must be a positive integer, got {raw!r}")
    return value


def _positive_float(name: str, default: float) -> float:
    raw = os.environ.get(name, str(default))
    try:
        value = float(raw)
    except ValueError as exc:
        raise SystemExit(f"{name} must be positive, got {raw!r}") from exc
    if value <= 0:
        raise SystemExit(f"{name} must be positive, got {raw!r}")
    return value


def _boolean(name: str, default: bool) -> bool:
    raw = os.environ.get(name, "1" if default else "0")
    if raw == "1":
        return True
    if raw == "0":
        return False
    raise SystemExit(f"{name} must be 0 or 1, got {raw!r}")


def _safe_component(value: str) -> str:
    normalized = re.sub(r"[^A-Za-z0-9_.-]+", "_", value).strip("._")
    return normalized or "unknown"


def assigned_cuda_device(
    visible_devices: str | None,
    *,
    slot_index: int,
    max_concurrency: int,
    distribute: bool,
) -> str | None:
    """Return the single CUDA device assigned to a leased worker slot."""
    if not distribute:
        return visible_devices
    devices = [item.strip() for item in (visible_devices or "").split(",") if item.strip()]
    if not devices:
        raise SystemExit(
            "DOGFISH_WAKE_INPLACE_DISTRIBUTE_GPUS=1 requires CUDA_VISIBLE_DEVICES"
        )
    workers_per_gpu = (max_concurrency + len(devices) - 1) // len(devices)
    if workers_per_gpu > 2:
        raise SystemExit(
            "distributed in-place CFD permits at most two workers per GPU; "
            f"got {max_concurrency} workers for {len(devices)} devices"
        )
    return devices[(slot_index - 1) % len(devices)]


def infer_run_root(workspace_root: Path) -> Path:
    workspace_root = workspace_root.resolve()
    if workspace_root.parent.name != "evaluation_workspaces":
        raise SystemExit(
            "in-place GPU batching requires EVE_WORKSPACE_ROOT directly under "
            f"evaluation_workspaces, got {workspace_root}"
        )
    return workspace_root.parent.parent


def infer_batch_key(workspace_name: str) -> tuple[str, bool]:
    match = _STEP_PATTERN.search(workspace_name)
    if match is None:
        return f"single_{_safe_component(workspace_name)}", False
    return f"step_{int(match.group(1))}", True


def _atomic_write_json(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.{os.getpid()}.tmp")
    temporary.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    temporary.replace(path)


@dataclass
class SlotLease:
    index: int
    handle: IO[str]

    def release(self) -> None:
        fcntl.flock(self.handle.fileno(), fcntl.LOCK_UN)
        self.handle.close()


def acquire_slot(
    *,
    slot_root: Path,
    max_concurrency: int,
    poll_seconds: float,
    timeout_seconds: float,
) -> SlotLease:
    slot_root.mkdir(parents=True, exist_ok=True)
    deadline = time.monotonic() + timeout_seconds
    while time.monotonic() < deadline:
        for index in range(1, max_concurrency + 1):
            handle = (slot_root / f"slot_{index}.lock").open(
                "a+", encoding="utf-8"
            )
            try:
                fcntl.flock(handle.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
            except BlockingIOError:
                handle.close()
                continue
            return SlotLease(index=index, handle=handle)
        time.sleep(poll_seconds)
    raise SystemExit(
        "timed out waiting for an in-place GPU slot after "
        f"{timeout_seconds:.1f}s"
    )


def _registration_count(ready_root: Path) -> int:
    return sum(1 for path in ready_root.glob("*.json") if path.is_file())


def wait_for_batch(
    *,
    ready_root: Path,
    expected_members: int,
    poll_seconds: float,
    timeout_seconds: float,
) -> tuple[int, bool, float]:
    started = time.monotonic()
    deadline = started + timeout_seconds
    while True:
        count = _registration_count(ready_root)
        if count >= expected_members:
            return count, False, time.monotonic() - started
        if time.monotonic() >= deadline:
            return count, True, time.monotonic() - started
        time.sleep(poll_seconds)


def _parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--workspace-root", required=True, type=Path)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args(argv)
    if args.command and args.command[0] == "--":
        args.command = args.command[1:]
    if not args.command:
        parser.error("a command is required after --")
    return args


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(list(argv or sys.argv[1:]))
    workspace_root = args.workspace_root.resolve()
    run_root = infer_run_root(workspace_root)
    batch_key, is_iteration = infer_batch_key(workspace_root.name)

    batch_size = _positive_int("DOGFISH_WAKE_INPLACE_BATCH_SIZE", 4)
    max_concurrency = _positive_int("DOGFISH_WAKE_INPLACE_MAX_CONCURRENCY", 1)
    wait_for_all = _boolean("DOGFISH_WAKE_INPLACE_WAIT_FOR_BATCH", True)
    distribute_gpus = _boolean("DOGFISH_WAKE_INPLACE_DISTRIBUTE_GPUS", False)
    elastic_pbs = _boolean("DOGFISH_WAKE_ELASTIC_PBS", False)
    if max_concurrency > batch_size:
        raise SystemExit(
            "DOGFISH_WAKE_INPLACE_MAX_CONCURRENCY cannot exceed "
            "DOGFISH_WAKE_INPLACE_BATCH_SIZE"
        )
    expected_members = batch_size if is_iteration and wait_for_all else 1
    poll_seconds = _positive_float("DOGFISH_WAKE_INPLACE_POLL_S", 0.5)
    barrier_timeout = _positive_float(
        "DOGFISH_WAKE_INPLACE_BARRIER_TIMEOUT_S", 2100.0
    )
    slot_timeout = _positive_float(
        "DOGFISH_WAKE_INPLACE_SLOT_TIMEOUT_S", 14400.0
    )

    invocation_source = os.environ.get("DOGFISH_WAKE_INPLACE_INVOCATION_ID")
    if not invocation_source:
        invocation_source = os.environ.get("PBS_JOBID") or f"ppid_{os.getppid()}"
    invocation_id = _safe_component(invocation_source)
    coordination_root = run_root / ".wake_inplace_gpu" / invocation_id
    batch_root = coordination_root / "batches" / batch_key
    ready_root = batch_root / "ready"
    ready_root.mkdir(parents=True, exist_ok=True)

    registration = {
        "schema": "dogfish.wake_inplace_gpu.registration.v1",
        "workspace_root": str(workspace_root),
        "workspace_name": workspace_root.name,
        "batch_key": batch_key,
        "batch_size": batch_size,
        "expected_members": expected_members,
        "wait_for_batch": wait_for_all,
        "max_concurrency": max_concurrency,
        "invocation_id": invocation_id,
        "pid": os.getpid(),
        "registered_unix_s": time.time(),
    }
    registration_path = ready_root / f"{_safe_component(workspace_root.name)}.json"
    _atomic_write_json(registration_path, registration)

    ready_count, barrier_timed_out, barrier_wait_s = wait_for_batch(
        ready_root=ready_root,
        expected_members=expected_members,
        poll_seconds=poll_seconds,
        timeout_seconds=barrier_timeout,
    )
    lease = acquire_slot(
        slot_root=coordination_root / "slots",
        max_concurrency=max_concurrency,
        poll_seconds=poll_seconds,
        timeout_seconds=slot_timeout,
    )

    audit_artifact = _safe_component(
        os.environ.get("DOGFISH_WAKE_INPLACE_AUDIT_ARTIFACT", "wake_episode")
    )
    audit_path = (
        workspace_root
        / "artifacts"
        / audit_artifact
        / "runtime"
        / "inplace_gpu_batch.json"
    )
    started_unix_s = time.time()
    outer_cuda_visible_devices = os.environ.get("CUDA_VISIBLE_DEVICES")
    allocated_devices = [
        item.strip()
        for item in (outer_cuda_visible_devices or "").split(",")
        if item.strip()
    ]
    if elastic_pbs and not allocated_devices:
        raise SystemExit("DOGFISH_WAKE_ELASTIC_PBS=1 requires at least one allocated GPU")
    execution_role = (
        "pbs_child"
        if elastic_pbs and lease.index > len(allocated_devices)
        else "local_gpu"
    )
    if elastic_pbs and execution_role == "local_gpu":
        child_cuda_visible_devices = allocated_devices[lease.index - 1]
    elif elastic_pbs:
        child_cuda_visible_devices = outer_cuda_visible_devices
    else:
        child_cuda_visible_devices = assigned_cuda_device(
            outer_cuda_visible_devices,
            slot_index=lease.index,
            max_concurrency=max_concurrency,
            distribute=distribute_gpus,
        )
    audit: dict[str, object] = {
        **registration,
        "ready_count_at_release": ready_count,
        "barrier_timed_out": barrier_timed_out,
        "barrier_wait_s": barrier_wait_s,
        "slot_index": lease.index,
        "slot_acquired_unix_s": started_unix_s,
        "command": args.command,
        "distribute_gpus": distribute_gpus,
        "elastic_pbs": elastic_pbs,
        "allocated_gpu_count": len(allocated_devices),
        "execution_role": execution_role,
        "outer_cuda_visible_devices": outer_cuda_visible_devices,
        "child_cuda_visible_devices": child_cuda_visible_devices,
    }
    _atomic_write_json(audit_path, audit)

    child: subprocess.Popen[bytes] | None = None

    def forward_signal(signum: int, _frame: object) -> None:
        if child is not None and child.poll() is None:
            child.send_signal(signum)

    old_handlers = {
        signum: signal.signal(signum, forward_signal)
        for signum in (signal.SIGINT, signal.SIGTERM)
    }
    env = {
        **os.environ,
        "DOGFISH_WAKE_INPLACE_SLOT_INDEX": str(lease.index),
        "DOGFISH_WAKE_PBS_EVAL": "0",
    }
    if child_cuda_visible_devices is not None:
        env["CUDA_VISIBLE_DEVICES"] = child_cuda_visible_devices
    if elastic_pbs:
        env["DOGFISH3D_MOVING_WINDOW_PBS_EVAL"] = (
            "1" if execution_role == "pbs_child" else "0"
        )
        env["DOGFISH3D_MOVING_WINDOW_PBS_CHILD"] = "0"
    try:
        child = subprocess.Popen(args.command, env=env)
        return_code = child.wait()
    finally:
        for signum, handler in old_handlers.items():
            signal.signal(signum, handler)
        lease.release()

    audit.update(
        {
            "finished_unix_s": time.time(),
            "elapsed_s": time.time() - started_unix_s,
            "return_code": return_code,
        }
    )
    _atomic_write_json(audit_path, audit)
    return return_code


if __name__ == "__main__":
    raise SystemExit(main())
