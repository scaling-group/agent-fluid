#!/usr/bin/env python3
"""Predeclared acceptance gates for the 3x fish3dtarget continuation."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import pathlib

import numpy as np


EXPECTED_POLICY_SHA256 = (
    "96010931ee4552e37a3127abc2471e86e350af90619dd672fa9e1ecb48d6ab4d"
)
REFERENCE_VIDEO_SHA256 = (
    "26dfda789ad1363c8371691e5cdf7fac9088b3d0d095488198b166bd90b09b4a"
)
REFERENCE_INITIAL_DISTANCE_L = 3.9407200813293457


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


def path_length(data: dict[str, np.ndarray]) -> float:
    centers = np.column_stack([data["center_x_L"], data["center_y_L"]])
    return float(np.sum(np.linalg.norm(np.diff(centers, axis=0), axis=1)))


def reconstruction_error(data: dict[str, np.ndarray]) -> float:
    reconstructed = np.column_stack(
        [
            data["local_center_x_L"] + data["frame_origin_x_L"],
            data["local_center_y_L"] + data["frame_origin_y_L"],
        ]
    )
    world = np.column_stack([data["center_x_L"], data["center_y_L"]])
    return float(np.max(np.linalg.norm(reconstructed - world, axis=1)))


def check_shift_events(summary: dict) -> tuple[bool, list[str]]:
    failures: list[str] = []
    for index, event in enumerate(summary.get("moving_window_shift_events", [])):
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


def close(value: float, expected: float, tolerance: float = 1.0e-12) -> bool:
    return abs(float(value) - expected) <= tolerance


def build_report(root: pathlib.Path) -> dict:
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
    heading = summary.get("heading_controller") or {}
    schedule = heading.get("turn_brake_schedule") or {}
    gait = summary.get("straight_gait") or {}
    policy_hash = sha256(policy_path)
    metrics = {
        "reference_initial_distance_L": REFERENCE_INITIAL_DISTANCE_L,
        "initial_distance_L": initial,
        "distance_scale": initial / REFERENCE_INITIAL_DISTANCE_L,
        "final_distance_L": final,
        "minimum_distance_L": minimum,
        "final_distance_reduction_L": initial - final,
        "best_distance_reduction_L": initial - minimum,
        "center_path_length_L": path_length(data),
        "frame_reconstruction_max_L": reconstruction_error(data),
        "minimum_local_center_margin_L": minimum_local_margin,
        "shift_count": int(summary.get("moving_window_shift_count", 0)),
        "policy_sha256_from_summary": summary.get("policy_sha256"),
        "policy_sha256_recomputed": policy_hash,
    }
    exact_schedule = (
        schedule.get("turn_command") == 0.8
        and schedule.get("brake_command") == -0.8
        and schedule.get("post_neutral_command") == -0.04
        and close(schedule.get("turn_start_T", -1), 0.0)
        and close(schedule.get("brake_start_T", -1), 5.5)
        and close(schedule.get("neutral_start_T", -1), 7.7)
        and gait.get("carrier_mode") == "analytic_sine"
        and gait.get("analytic_steering_mode") == "smooth_harmonic"
        and gait.get("analytic_steering_amplitudes_deg") == [10.5, -3.0]
        and gait.get("amplitudes_deg") == [20.0, 26.0]
        and close(gait.get("period", -1), 1.1)
        and close(gait.get("phase_lag_deg", -1), 85.0)
    )
    gates = {
        "status_ok": summary.get("status") == "ok",
        "captured": summary.get("termination") == "capture",
        "finite_trajectory": finite,
        "exact_reference_policy": (
            summary.get("policy_sha256") == EXPECTED_POLICY_SHA256
            and policy_hash == EXPECTED_POLICY_SHA256
        ),
        "exact_reference_controller_schedule": exact_schedule,
        "exact_l64_june13_body": (
            summary.get("runtime_resolution") == 64
            and summary.get("body_geometry") == "june13_superellipse_fan"
            and summary.get("reference_model") == "actual_superellipse_centroid"
        ),
        "quiescent_obstacle_free": (
            summary.get("cylinder_count") == 0
            and all(abs(float(v)) <= 1.0e-12 for v in summary.get("flow_velocity_L", [0, 0, 0]))
        ),
        "three_to_four_times_reference_distance": 3.0 <= metrics["distance_scale"] <= 4.0,
        "strict_original_capture_radius": final <= 0.1005,
        "long_world_path": metrics["center_path_length_L"] >= 10.0,
        "long_target_progress": metrics["final_distance_reduction_L"] >= 11.0,
        "many_window_shifts": metrics["shift_count"] >= 150,
        "world_local_reconstruction": metrics["frame_reconstruction_max_L"] <= 2.0e-5,
        "local_center_margin": metrics["minimum_local_center_margin_L"] >= 1.35,
        "integer_shift_ledger": shift_ok,
    }
    return {
        "schema": "dogfish3d.fish3dtarget_long3x_moving_window.v1",
        "root": str(root.resolve()),
        "reference_video_sha256": REFERENCE_VIDEO_SHA256,
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
    report = build_report(args.root)
    args.output.write_text(
        json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0 if report["passed"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
