#!/usr/bin/env python3
"""Predeclared acceptance gates for long-distance moving-window runs."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import math
import pathlib

import numpy as np


EXPECTED_POLICY_SHA256 = (
    "b116957dac4228d2d8deb97357ccd350327a3806b3c2f5609ab520de4c7a6f46"
)


def load_json(path: pathlib.Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def load_trajectory(path: pathlib.Path) -> dict[str, np.ndarray]:
    with path.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    if not rows:
        raise ValueError(f"empty trajectory: {path}")
    return {
        key: np.asarray([float(row[key]) for row in rows], dtype=float)
        for key in rows[0]
    }


def sha256(path: pathlib.Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def reconstruction_error(data: dict[str, np.ndarray]) -> float:
    reconstructed = np.column_stack(
        [
            data["local_center_x_L"] + data["frame_origin_x_L"],
            data["local_center_y_L"] + data["frame_origin_y_L"],
        ]
    )
    world = np.column_stack([data["center_x_L"], data["center_y_L"]])
    return float(np.max(np.linalg.norm(reconstructed - world, axis=1)))


def path_length(data: dict[str, np.ndarray]) -> float:
    centers = np.column_stack([data["center_x_L"], data["center_y_L"]])
    return float(np.sum(np.linalg.norm(np.diff(centers, axis=0), axis=1)))


def check_shift_events(summary: dict) -> tuple[bool, list[str]]:
    failures: list[str] = []
    events = summary.get("moving_window_shift_events", [])
    for index, event in enumerate(events):
        origin = event.get("origin_delta_cells", [])
        array = event.get("array_shift_cells", [])
        if len(origin) != 2 or len(array) != 2:
            failures.append(f"event {index}: malformed shift vectors")
            continue
        if any(float(value) != int(value) for value in origin + array):
            failures.append(f"event {index}: non-integer shift")
        if any(int(array[axis]) != -int(origin[axis]) for axis in range(2)):
            failures.append(f"event {index}: array/origin signs do not cancel")
    return not failures, failures


def smoke_report(root: pathlib.Path) -> dict:
    summary = load_json(root / "summary.json")
    data = load_trajectory(root / "trajectory.csv")
    policy_path = pathlib.Path(summary["policy_path"])
    initial = float(summary["initial_distance_L"])
    final = float(summary["final_distance_L"])
    minimum = float(summary["minimum_distance_L"])
    shift_ok, shift_failures = check_shift_events(summary)
    finite = all(np.all(np.isfinite(values)) for values in data.values())
    local_center = np.column_stack(
        [data["local_center_x_L"], data["local_center_y_L"]]
    )
    minimum_local_margin = float(
        np.min(
            np.column_stack(
                [
                    local_center[:, 0],
                    4.0 - local_center[:, 0],
                    local_center[:, 1],
                    3.0 - local_center[:, 1],
                ]
            )
        )
    )
    metrics = {
        "initial_distance_L": initial,
        "final_distance_L": final,
        "minimum_distance_L": minimum,
        "final_distance_reduction_L": initial - final,
        "best_distance_reduction_L": initial - minimum,
        "center_path_length_L": path_length(data),
        "frame_reconstruction_max_L": reconstruction_error(data),
        "minimum_local_center_margin_L": minimum_local_margin,
        "shift_count": int(summary.get("moving_window_shift_count", 0)),
        "policy_sha256_from_summary": summary.get("policy_sha256"),
        "policy_sha256_recomputed": sha256(policy_path),
    }
    gates = {
        "status_ok": summary.get("status") == "ok",
        "completed_scientific_horizon": summary.get("termination") in {"horizon", "capture"},
        "finite_trajectory": finite,
        "exact_retained_policy": (
            metrics["policy_sha256_from_summary"] == EXPECTED_POLICY_SHA256
            and metrics["policy_sha256_recomputed"] == EXPECTED_POLICY_SHA256
        ),
        "long_target_geometry": 12.0 <= initial <= 13.0,
        "meaningful_motion": metrics["center_path_length_L"] >= 0.50,
        "best_target_progress": metrics["best_distance_reduction_L"] >= 0.25,
        "final_target_progress": metrics["final_distance_reduction_L"] >= 0.10,
        "multiple_window_shifts": metrics["shift_count"] >= 8,
        "world_local_reconstruction": metrics["frame_reconstruction_max_L"] <= 2.0e-5,
        "local_center_margin": metrics["minimum_local_center_margin_L"] >= 0.75,
        "integer_shift_ledger": shift_ok,
    }
    return {
        "schema": "dogfish3d.long_distance_moving_window_smoke.v1",
        "root": str(root.resolve()),
        "summary": {
            key: summary.get(key)
            for key in (
                "status",
                "termination",
                "achieved_horizon",
                "steps",
                "runtime_resolution",
                "domain_dims",
                "target_L",
                "fish_initial_center_L",
            )
        },
        "metrics": metrics,
        "shift_ledger_failures": shift_failures,
        "gates": gates,
        "passed": all(gates.values()),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("root", type=pathlib.Path)
    parser.add_argument("output", type=pathlib.Path)
    args = parser.parse_args()
    report = smoke_report(args.root)
    args.output.write_text(
        json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0 if report["passed"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
