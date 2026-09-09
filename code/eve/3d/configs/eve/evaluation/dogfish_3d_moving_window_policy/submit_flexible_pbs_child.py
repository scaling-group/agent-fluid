#!/usr/bin/env python3
"""Start one GPU child without leaving it blocked on a single PBS route."""

from __future__ import annotations

import argparse
import fcntl
import json
import os
import re
import subprocess
import time
from pathlib import Path

PBS_BIN = Path(os.environ.get("EVE_PBS_BIN", ""))


def _run(args: list[str], *, check: bool = False) -> subprocess.CompletedProcess[str]:
    return subprocess.run(args, text=True, capture_output=True, check=check)


def _job_state(job_id: str) -> str | None:
    result = _run([str(PBS_BIN / "qstat"), "-f", job_id])
    if result.returncode != 0:
        return None
    match = re.search(r"(?m)^\s*job_state\s*=\s*(\S+)", result.stdout)
    return match.group(1) if match else None


def _active_user_jobs(user: str) -> int:
    result = _run([str(PBS_BIN / "qstat"), "-u", user])
    return sum(
        1
        for line in result.stdout.splitlines()
        if re.match(r"^\d+(?:\[\d+\])?\.", line.strip())
    )


def _atomic_json(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.{os.getpid()}.tmp")
    temporary.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")
    temporary.replace(path)


def _parse_candidate(raw: str) -> tuple[str, str, int]:
    parts = [item.strip() for item in raw.split(",")]
    try:
        queue, model = parts[:2]
        gpu_count = int(parts[2]) if len(parts) == 3 else 1
    except (ValueError, IndexError) as exc:
        raise argparse.ArgumentTypeError(
            "candidate must be QUEUE,GPU_MODEL[,GPU_COUNT]"
        ) from exc
    if len(parts) not in {2, 3} or not queue or (model and not re.fullmatch(r"[A-Za-z0-9_.-]+", model)) or not 1 <= gpu_count <= 4:
        raise argparse.ArgumentTypeError(f"invalid candidate {raw!r}")
    return queue, model, gpu_count


def _args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--script", required=True, type=Path)
    parser.add_argument("--audit", required=True, type=Path)
    parser.add_argument("--job-id-path", required=True, type=Path)
    parser.add_argument("--job-name", required=True)
    parser.add_argument("--project", required=True)
    parser.add_argument("--walltime", default="02:00:00")
    parser.add_argument("--max-user-jobs", type=int, default=5)
    parser.add_argument("--queue-wait-seconds", type=float, default=30.0)
    parser.add_argument("--poll-seconds", type=float, default=3.0)
    parser.add_argument("--overall-timeout-seconds", type=float, default=7200.0)
    parser.add_argument("--output-path", type=Path)
    parser.add_argument("--env", action="append", default=[])
    parser.add_argument(
        "--lock",
        type=Path,
        default=Path(
            f"/tmp/dogfish3d-pbs-submit-{os.environ.get('USER', 'unknown')}.lock"
        ),
    )
    parser.add_argument("--candidate", action="append", type=_parse_candidate)
    args = parser.parse_args()
    if not args.candidate:
        queue = os.environ.get("EVE_EVAL_PBS_QUEUE")
        if not queue:
            parser.error("Set EVE_EVAL_PBS_QUEUE or pass --candidate QUEUE,GPU_MODEL[,GPU_COUNT]")
        args.candidate = [_parse_candidate(
            f"{queue},{os.environ.get('EVE_EVAL_PBS_GPU_MODEL', '')},{os.environ.get('EVE_EVAL_PBS_GPUS', '1')}"
        )]
    return args


def main() -> int:
    args = _args()
    args.lock.parent.mkdir(parents=True, exist_ok=True)
    audit: dict[str, object] = {
        "schema": "dogfish3d.flexible_pbs_child.v1",
        "script": str(args.script),
        "candidates": [list(item) for item in args.candidate],
        "queue_wait_seconds": args.queue_wait_seconds,
        "attempts": [],
    }
    attempts: list[dict[str, object]] = audit["attempts"]  # type: ignore[assignment]
    deadline = time.monotonic() + args.overall_timeout_seconds
    candidate_index = 0
    user = os.environ["USER"]

    while time.monotonic() < deadline:
        queue, model, gpu_count = args.candidate[candidate_index % len(args.candidate)]
        candidate_index += 1
        select = f"select=1:ncpus=16:mem=225gb:ngpus={gpu_count}"
        if model:
            select += f":gpu_model={model}"
        with args.lock.open("a+", encoding="utf-8") as lock_handle:
            fcntl.flock(lock_handle.fileno(), fcntl.LOCK_EX)
            active = _active_user_jobs(user)
            if active >= args.max_user_jobs:
                fcntl.flock(lock_handle.fileno(), fcntl.LOCK_UN)
                time.sleep(args.poll_seconds)
                continue
            submitted = time.time()
            qsub_args = [
                    str(PBS_BIN / "qsub"),
                    "-P", args.project,
                    "-q", queue,
                    "-N", args.job_name,
                    "-l", select,
                    "-l", f"walltime={args.walltime}",
                ]
            if args.output_path is not None:
                args.output_path.parent.mkdir(parents=True, exist_ok=True)
                qsub_args.extend(["-o", str(args.output_path)])
            if args.env:
                if any("," in item or "=" not in item for item in args.env):
                    raise SystemExit("--env values must be NAME=VALUE without commas")
                qsub_args.extend(["-v", ",".join(args.env)])
            qsub_args.append(str(args.script))
            result = _run(qsub_args)
            fcntl.flock(lock_handle.fileno(), fcntl.LOCK_UN)
        attempt: dict[str, object] = {
            "queue": queue,
            "gpu_model": model,
            "gpu_count": gpu_count,
            "select": select,
            "submitted_unix_s": submitted,
            "qsub_returncode": result.returncode,
            "qsub_stderr": result.stderr.strip(),
        }
        attempts.append(attempt)
        if result.returncode != 0 or not result.stdout.strip():
            attempt["outcome"] = "qsub_failed"
            _atomic_json(args.audit, audit)
            time.sleep(args.poll_seconds)
            continue

        job_id = result.stdout.strip().splitlines()[-1]
        attempt["job_id"] = job_id
        queue_deadline = time.monotonic() + args.queue_wait_seconds
        while time.monotonic() < queue_deadline:
            state = _job_state(job_id)
            attempt["last_state"] = state
            if state in {"R", "E"}:
                attempt["outcome"] = "running"
                attempt["started_after_seconds"] = time.time() - submitted
                audit["selected_job_id"] = job_id
                audit["selected_queue"] = queue
                audit["selected_gpu_model"] = model
                audit["selected_gpu_count"] = gpu_count
                _atomic_json(args.audit, audit)
                args.job_id_path.write_text(job_id + "\n", encoding="utf-8")
                print(job_id)
                return 0
            if state is None or state == "F":
                attempt["outcome"] = "finished_before_running_observed"
                break
            time.sleep(args.poll_seconds)
        else:
            state = _job_state(job_id)
            attempt["last_state"] = state
            if state in {"R", "E"}:
                attempt["outcome"] = "running"
                audit["selected_job_id"] = job_id
                audit["selected_queue"] = queue
                audit["selected_gpu_model"] = model
                audit["selected_gpu_count"] = gpu_count
                _atomic_json(args.audit, audit)
                args.job_id_path.write_text(job_id + "\n", encoding="utf-8")
                print(job_id)
                return 0
            if state in {"Q", "H", "W", "T"}:
                # Rotate queued children across the configured resource candidates.
                delete = _run([str(PBS_BIN / "qdel"), job_id])
                attempt["outcome"] = "rotated_queued_job"
                attempt["qdel_returncode"] = delete.returncode
            else:
                attempt["outcome"] = "finished_before_running_observed"
        _atomic_json(args.audit, audit)

    audit["failure"] = "overall flexible PBS submission timeout"
    _atomic_json(args.audit, audit)
    raise SystemExit(audit["failure"])


if __name__ == "__main__":
    raise SystemExit(main())
