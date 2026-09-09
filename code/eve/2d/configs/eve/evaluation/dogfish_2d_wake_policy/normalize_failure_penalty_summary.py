#!/usr/bin/env python3
"""Normalize legacy agent-fluid-testbed wake summaries to the registered penalty contract."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import shutil
from collections.abc import Mapping
from pathlib import Path

SEMANTICS_VERSION = "dogfish.wake_failure_penalties.v1"
COMPATIBILITY_MODE = "evaluation_layer_main_legacy_summary.v1"
PENALTY_ENV = {
    "left_domain": ("DOGFISH_WAKE_LEFT_DOMAIN_PENALTY", 0.0),
    "collision": ("DOGFISH_WAKE_COLLISION_PENALTY", 0.0),
    "unstable": ("DOGFISH_WAKE_UNSTABLE_PENALTY", 2.0),
    "horizon_miss": ("DOGFISH_WAKE_HORIZON_MISS_PENALTY", 0.0),
}


def _finite_nonnegative(value: object, label: str) -> float:
    number = float(value)
    if not math.isfinite(number) or number < 0.0:
        raise ValueError(f"{label} must be finite and nonnegative, got {value!r}")
    return number


def _configured_penalties(environment: Mapping[str, str]) -> dict[str, float]:
    return {
        label: _finite_nonnegative(environment.get(name, default), name)
        for label, (name, default) in PENALTY_ENV.items()
    }


def normalize_summary(
    summary: Mapping[str, object], environment: Mapping[str, str]
) -> tuple[dict[str, object], dict[str, object]]:
    """Return an auditable v1 summary without changing native v1 results."""

    normalized = dict(summary)
    native_score = float(normalized["score"])
    if not math.isfinite(native_score):
        raise ValueError(f"non-finite score: {native_score!r}")

    version = normalized.get("failure_penalty_semantics_version")
    if version == SEMANTICS_VERSION:
        return normalized, {
            "schema_version": "dogfish.wake_failure_penalty_normalization.v1",
            "mode": "native_registered_summary",
            "native_score": native_score,
            "effective_score": native_score,
            "compatibility_added_penalty": 0.0,
        }
    if version is not None:
        raise ValueError(f"unsupported failure-penalty semantics: {version!r}")

    termination = str(normalized.get("termination") or "")
    if termination == "wall_time_limit":
        raise ValueError(
            "wake episode reached an infrastructure wall-time limit; rerun it "
            "instead of treating it as a scientific horizon miss"
        )
    task_success = bool(normalized.get("task_success", False))
    configured = _configured_penalties(environment)
    failures = {
        "left_domain": termination == "left_domain",
        "collision": termination == "collision",
        "unstable": termination in {"unstable_dynamics", "nonfinite_state", "solver_error"},
        "horizon_miss": termination == "horizon" and not task_success,
    }
    applied = {label: configured[label] if failures[label] else 0.0 for label in failures}

    # agent-fluid-testbed main already subtracts the unstable penalty. The legacy
    # summary lacks only the unified metadata and the other terminal penalties.
    existing_unstable = _finite_nonnegative(
        normalized.get("unstable_penalty", 0.0), "summary.unstable_penalty"
    )
    if not math.isclose(existing_unstable, applied["unstable"], abs_tol=1e-6):
        raise ValueError(
            "legacy unstable penalty does not match the registered environment: "
            f"summary={existing_unstable!r}, expected={applied['unstable']!r}"
        )
    compatibility_added = applied["left_domain"] + applied["collision"] + applied["horizon_miss"]
    effective_score = native_score - compatibility_added
    total = sum(applied.values())

    normalized.update(
        {
            "score": effective_score,
            "failure_penalty_semantics_version": SEMANTICS_VERSION,
            "failure_penalty_total": total,
            "left_domain_failure": failures["left_domain"],
            "collision_failure": failures["collision"],
            "unstable_failure": failures["unstable"],
            "horizon_miss_failure": failures["horizon_miss"],
            "left_domain_penalty": applied["left_domain"],
            "collision_penalty": applied["collision"],
            "unstable_penalty": applied["unstable"],
            "horizon_miss_penalty": applied["horizon_miss"],
            "configured_left_domain_penalty": configured["left_domain"],
            "configured_collision_penalty": configured["collision"],
            "unstable_dynamics_penalty": configured["unstable"],
            "configured_horizon_miss_penalty": configured["horizon_miss"],
            "failure_penalty_compatibility_source": COMPATIBILITY_MODE,
            "raw_score_before_failure_penalty_compatibility": native_score,
            "failure_penalty_compatibility_added_penalty": compatibility_added,
        }
    )
    provenance = {
        "schema_version": "dogfish.wake_failure_penalty_normalization.v1",
        "mode": COMPATIBILITY_MODE,
        "termination": termination,
        "task_success": task_success,
        "configured_penalties": configured,
        "applied_penalties": applied,
        "native_score": native_score,
        "effective_score": effective_score,
        "compatibility_added_penalty": compatibility_added,
        "legacy_unstable_penalty_already_in_native_score": existing_unstable,
    }
    return normalized, provenance


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _write_atomic(path: Path, payload: Mapping[str, object]) -> None:
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(
        json.dumps(payload, indent=2, sort_keys=True, allow_nan=False) + "\n",
        encoding="utf-8",
    )
    os.replace(temporary, path)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--summary", required=True, type=Path)
    parser.add_argument("--raw-copy", required=True, type=Path)
    parser.add_argument("--provenance", required=True, type=Path)
    args = parser.parse_args()

    summary = json.loads(args.summary.read_bytes())
    normalized, provenance = normalize_summary(summary, os.environ)
    args.raw_copy.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(args.summary, args.raw_copy)
    provenance.update(
        {
            "raw_summary": str(args.raw_copy),
            "raw_summary_sha256": _sha256(args.raw_copy),
            "normalized_summary": str(args.summary),
        }
    )
    _write_atomic(args.summary, normalized)
    provenance["normalized_summary_sha256"] = _sha256(args.summary)
    _write_atomic(args.provenance, provenance)
    print(json.dumps(provenance, sort_keys=True))


if __name__ == "__main__":
    main()
