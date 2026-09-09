#!/usr/bin/env python3
"""Atomically alternate dogfish CFD children across two PBS route queues."""

from __future__ import annotations

import argparse
import json
import os
import re
import time
import uuid
from pathlib import Path

QUEUE_RE = re.compile(r"[A-Za-z0-9_.-]+")


def validate_queue(name: str) -> str:
    if not QUEUE_RE.fullmatch(name):
        raise ValueError(f"invalid PBS route queue: {name!r}")
    return name


def select_queue(
    *,
    primary: str,
    secondary: str | None,
    state_root: Path,
    lock_timeout_s: float = 30.0,
) -> dict[str, object]:
    primary = validate_queue(primary)
    if not secondary:
        return {
            "schema_version": "dogfish.pbs_queue_selection.v1",
            "mode": "single",
            "primary": primary,
            "secondary": None,
            "sequence": None,
            "selected": primary,
        }
    secondary = validate_queue(secondary)
    if secondary == primary:
        raise ValueError("primary and secondary PBS queues must differ")

    state_root.mkdir(parents=True, exist_ok=True)
    lock_dir = state_root / ".dogfish_pbs_queue_shard.lock"
    counter_path = state_root / ".dogfish_pbs_queue_shard.counter"
    deadline = time.monotonic() + lock_timeout_s
    while True:
        try:
            lock_dir.mkdir()
            break
        except (FileExistsError, PermissionError):
            # Windows may report a transient sharing violation while another
            # worker removes/recreates the atomic lock directory. On a
            # POSIX filesystem the equivalent contention is FileExistsError.
            if time.monotonic() >= deadline:
                raise TimeoutError(f"timed out acquiring queue shard lock: {lock_dir}") from None
            time.sleep(0.02)

    try:
        if counter_path.is_file():
            raw_counter = counter_path.read_text(encoding="utf-8").strip()
            if not raw_counter.isdigit():
                raise ValueError(f"invalid queue shard counter: {raw_counter!r}")
            sequence = int(raw_counter)
        else:
            sequence = 0
        selected = primary if sequence % 2 == 0 else secondary
        temporary = state_root / (
            f".dogfish_pbs_queue_shard.counter.{os.getpid()}.{uuid.uuid4().hex}.tmp"
        )
        temporary.write_text(f"{sequence + 1}\n", encoding="utf-8")
        os.replace(temporary, counter_path)
    finally:
        lock_dir.rmdir()

    return {
        "schema_version": "dogfish.pbs_queue_selection.v1",
        "mode": "atomic_round_robin",
        "primary": primary,
        "secondary": secondary,
        "sequence": sequence,
        "selected": selected,
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--primary", required=True)
    parser.add_argument("--secondary")
    parser.add_argument("--state-root", required=True, type=Path)
    parser.add_argument("--audit-path", type=Path)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    result = select_queue(
        primary=args.primary,
        secondary=args.secondary,
        state_root=args.state_root,
    )
    if args.audit_path is not None:
        args.audit_path.parent.mkdir(parents=True, exist_ok=True)
        args.audit_path.write_text(
            json.dumps(result, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
    print(result["selected"])


if __name__ == "__main__":
    main()
