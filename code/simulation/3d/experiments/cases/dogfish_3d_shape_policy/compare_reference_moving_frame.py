#!/usr/bin/env python3
"""Compare the archived inertial replay with a translating-frame replay."""

from __future__ import annotations

import argparse
import csv
import json
import math
import pathlib

import numpy as np


def load_csv(path: pathlib.Path) -> dict[str, np.ndarray]:
    with path.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    if not rows:
        raise ValueError(f"empty trajectory: {path}")
    return {
        key: np.asarray([float(row[key]) for row in rows], dtype=float)
        for key in rows[0]
    }


def load_json(path: pathlib.Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def interp(data: dict[str, np.ndarray], key: str, times: np.ndarray) -> np.ndarray:
    values = data[key]
    if key == "heading_rad":
        values = np.unwrap(values)
    return np.interp(times, data["elapsed"], values)


def scalar_error(
    reference: dict[str, np.ndarray],
    candidate: dict[str, np.ndarray],
    key: str,
    times: np.ndarray,
) -> dict[str, float]:
    delta = interp(candidate, key, times) - interp(reference, key, times)
    return {
        "rms": float(np.sqrt(np.mean(delta * delta))),
        "max_abs": float(np.max(np.abs(delta))),
        "final_abs": float(abs(delta[-1])),
    }


def vector_error(
    reference: dict[str, np.ndarray],
    candidate: dict[str, np.ndarray],
    keys: tuple[str, ...],
    times: np.ndarray,
) -> dict[str, float]:
    delta = np.column_stack(
        [interp(candidate, key, times) - interp(reference, key, times) for key in keys]
    )
    norm = np.linalg.norm(delta, axis=1)
    return {
        "rms_norm": float(np.sqrt(np.mean(norm * norm))),
        "max_norm": float(np.max(norm)),
        "final_norm": float(norm[-1]),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("reference_root", type=pathlib.Path)
    parser.add_argument("candidate_root", type=pathlib.Path)
    parser.add_argument("output", type=pathlib.Path)
    parser.add_argument("--mode", choices=("same_box", "reduced_box"), default="same_box")
    args = parser.parse_args()

    reference = load_csv(args.reference_root / "trajectory.csv")
    candidate = load_csv(args.candidate_root / "trajectory.csv")
    reference_summary = load_json(args.reference_root / "summary.json")
    candidate_summary = load_json(args.candidate_root / "summary.json")

    start = max(reference["elapsed"][0], candidate["elapsed"][0])
    stop = min(reference["elapsed"][-1], candidate["elapsed"][-1])
    if stop <= start:
        raise ValueError("reference and candidate trajectories do not overlap")
    times = np.linspace(start, stop, 2001)

    metrics = {
        "center_L": vector_error(
            reference, candidate, ("center_x_L", "center_y_L"), times
        ),
        "head_L": vector_error(
            reference, candidate, ("head_x_L", "head_y_L"), times
        ),
        "velocity_U": vector_error(
            reference, candidate, ("velocity_x_U", "velocity_y_U"), times
        ),
        "joint_angle_rad": vector_error(
            reference, candidate, ("phi1_rad", "phi2_rad"), times
        ),
        "joint_rate_rad_per_T": vector_error(
            reference, candidate, ("phi_dot1", "phi_dot2"), times
        ),
        "joint_acceleration_rad_per_T2": vector_error(
            reference, candidate, ("phi_ddot1", "phi_ddot2"), times
        ),
        "heading_rad": scalar_error(reference, candidate, "heading_rad", times),
        "target_distance_L": scalar_error(reference, candidate, "distance_L", times),
        "commanded_asymmetry": scalar_error(
            reference, candidate, "commanded_asymmetry", times
        ),
        "applied_asymmetry1": scalar_error(
            reference, candidate, "applied_asymmetry1", times
        ),
        "applied_asymmetry2": scalar_error(
            reference, candidate, "applied_asymmetry2", times
        ),
    }

    reconstructed = np.column_stack(
        [
            candidate["local_center_x_L"] + candidate["frame_origin_x_L"],
            candidate["local_center_y_L"] + candidate["frame_origin_y_L"],
        ]
    )
    world = np.column_stack([candidate["center_x_L"], candidate["center_y_L"]])
    reconstruction_error = np.linalg.norm(reconstructed - world, axis=1)

    reference_capture_time = float(reference_summary["achieved_horizon"])
    candidate_capture_time = float(candidate_summary["achieved_horizon"])
    capture_time_delta = abs(candidate_capture_time - reference_capture_time)
    same_box = args.mode == "same_box"
    thresholds = {
        "center_max_L": 0.05 if same_box else 0.10,
        "head_max_L": 0.06 if same_box else 0.12,
        "heading_max_rad": math.radians(4.0 if same_box else 8.0),
        "velocity_rms_U": 0.05 if same_box else 0.10,
        "joint_angle_max_rad": 0.005,
        "joint_rate_max_rad_per_T": 0.03,
        "joint_acceleration_max_rad_per_T2": 0.20,
        "capture_time_delta_T": 0.25 if same_box else 0.50,
        "final_distance_L": 0.1005,
        "frame_reconstruction_max_L": 2.0e-5,
    }
    gates = {
        "reference_captured": reference_summary["termination"] == "capture",
        "candidate_captured": candidate_summary["termination"] == "capture",
        "center": metrics["center_L"]["max_norm"] <= thresholds["center_max_L"],
        "head": metrics["head_L"]["max_norm"] <= thresholds["head_max_L"],
        "heading": metrics["heading_rad"]["max_abs"] <= thresholds["heading_max_rad"],
        "velocity": metrics["velocity_U"]["rms_norm"] <= thresholds["velocity_rms_U"],
        "joint_angle": metrics["joint_angle_rad"]["max_norm"]
        <= thresholds["joint_angle_max_rad"],
        "joint_rate": metrics["joint_rate_rad_per_T"]["max_norm"]
        <= thresholds["joint_rate_max_rad_per_T"],
        "joint_acceleration": metrics["joint_acceleration_rad_per_T2"]["max_norm"]
        <= thresholds["joint_acceleration_max_rad_per_T2"],
        "capture_time": capture_time_delta <= thresholds["capture_time_delta_T"],
        "final_distance": float(candidate_summary["final_distance_L"])
        <= thresholds["final_distance_L"],
        "frame_reconstruction": float(np.max(reconstruction_error))
        <= thresholds["frame_reconstruction_max_L"],
    }

    report = {
        "schema": "dogfish3d.reference_turn_moving_frame_comparison.v1",
        "mode": args.mode,
        "reference_root": str(args.reference_root.resolve()),
        "candidate_root": str(args.candidate_root.resolve()),
        "comparison_interval_T": [float(start), float(stop)],
        "comparison_sample_count": int(times.size),
        "metrics": metrics,
        "reference": {
            "termination": reference_summary["termination"],
            "capture_time_T": reference_capture_time,
            "final_distance_L": float(reference_summary["final_distance_L"]),
        },
        "candidate": {
            "termination": candidate_summary["termination"],
            "capture_time_T": candidate_capture_time,
            "final_distance_L": float(candidate_summary["final_distance_L"]),
        },
        "capture_time_delta_T": capture_time_delta,
        "frame_reconstruction_max_L": float(np.max(reconstruction_error)),
        "thresholds": thresholds,
        "gates": gates,
        "passed": all(gates.values()),
    }
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0 if report["passed"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
