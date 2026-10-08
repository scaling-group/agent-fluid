#!/usr/bin/env python3
"""Reject dogfish policies that reference undeclared ``params`` fields.

This is a lightweight, non-CFD contract guard.  Julia is used only to include
the candidate and enumerate the fields actually returned by
``target_policy_params()``; the policy is not rolled out.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

PARAM_REFERENCE = re.compile(r"\bparams\s*\.\s*([A-Za-z_]\w*)")
PARAM_SENTINEL = "DOGFISH_PARAM\t"


def _strip_noncode_julia(source: str) -> str:
    """Replace comments and literals with spaces while preserving newlines."""

    out = list(source)
    index = 0
    block_depth = 0
    literal: str | None = None
    triple = False
    escaped = False

    def blank(start: int, stop: int) -> None:
        for offset in range(start, stop):
            if out[offset] != "\n":
                out[offset] = " "

    while index < len(source):
        if block_depth:
            if source.startswith("#=", index):
                blank(index, index + 2)
                block_depth += 1
                index += 2
            elif source.startswith("=#", index):
                blank(index, index + 2)
                block_depth -= 1
                index += 2
            else:
                blank(index, index + 1)
                index += 1
            continue

        if literal is not None:
            if triple and source.startswith(literal * 3, index):
                blank(index, index + 3)
                literal = None
                triple = False
                index += 3
            elif not triple and not escaped and source[index] == literal:
                blank(index, index + 1)
                literal = None
                index += 1
            else:
                escaped = not escaped and source[index] == "\\"
                if source[index] != "\\":
                    escaped = False
                blank(index, index + 1)
                index += 1
            continue

        if source.startswith("#=", index):
            blank(index, index + 2)
            block_depth = 1
            index += 2
        elif source[index] == "#":
            end = source.find("\n", index)
            if end < 0:
                end = len(source)
            blank(index, end)
            index = end
        elif source.startswith('"""', index):
            blank(index, index + 3)
            literal = '"'
            triple = True
            escaped = False
            index += 3
        elif source[index] in {'"', "'", "`"}:
            literal = source[index]
            triple = False
            escaped = False
            blank(index, index + 1)
            index += 1
        else:
            index += 1

    return "".join(out)


def referenced_fields(source: str) -> set[str]:
    return set(PARAM_REFERENCE.findall(_strip_noncode_julia(source)))


def declared_fields_from_julia(policy: Path, julia_bin: str) -> set[str]:
    program = r"""
include(ARGS[1])
isdefined(Main, :target_policy_params) || error("target_policy_params is not defined")
params = target_policy_params()
for field in propertynames(params)
    println("DOGFISH_PARAM\t", String(field))
end
"""
    completed = subprocess.run(
        [julia_bin, "--startup-file=no", "-e", program, str(policy)],
        check=False,
        capture_output=True,
        text=True,
    )
    if completed.returncode != 0:
        raise RuntimeError(
            "Julia could not materialize target_policy_params()\n"
            f"stdout:\n{completed.stdout}\n"
            f"stderr:\n{completed.stderr}"
        )
    fields = {
        line[len(PARAM_SENTINEL) :].strip()
        for line in completed.stdout.splitlines()
        if line.startswith(PARAM_SENTINEL)
    }
    if not fields:
        raise RuntimeError("target_policy_params() returned no auditable properties")
    return fields


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--policy", type=Path, required=True)
    parser.add_argument("--julia-bin", default="julia")
    parser.add_argument(
        "--declared-fields",
        help="Comma-separated test-only override that avoids launching Julia.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    policy = args.policy.resolve()
    if not policy.is_file() or policy.stat().st_size <= 0:
        print(f"candidate policy is missing or empty: {policy}", file=sys.stderr)
        return 2

    source = policy.read_text(encoding="utf-8")
    referenced = referenced_fields(source)
    try:
        if args.declared_fields is None:
            declared = declared_fields_from_julia(policy, args.julia_bin)
        else:
            declared = {field.strip() for field in args.declared_fields.split(",") if field.strip()}
    except (OSError, RuntimeError) as exc:
        print(str(exc), file=sys.stderr)
        return 2

    missing = sorted(referenced - declared)
    certificate = {
        "schema_version": "dogfish.policy_param_contract.v1",
        "policy": str(policy),
        "policy_sha256": hashlib.sha256(policy.read_bytes()).hexdigest(),
        "declared_fields": sorted(declared),
        "referenced_fields": sorted(referenced),
        "missing_fields": missing,
        "valid": not missing,
    }
    print(json.dumps(certificate, sort_keys=True))
    if missing:
        print(
            "candidate references fields absent from target_policy_params(): " + ", ".join(missing),
            file=sys.stderr,
        )
        return 3
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
