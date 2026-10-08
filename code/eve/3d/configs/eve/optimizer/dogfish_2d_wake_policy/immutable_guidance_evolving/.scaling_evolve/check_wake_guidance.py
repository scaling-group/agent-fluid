#!/usr/bin/env python3
"""Validate a material control-experience update against the assigned parent."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

EXPERIENCE_PATH = Path("guidance/control_experience.md")
NOTES_PATH = Path("logs/optimize/wake_policy_notes.md")
ASSIGNED_PARENT_RE = re.compile(
    r"`guidance_examples/([^/]+)/`\s*<-\s*prefill\s*\(copied to guidance/\)"
)
ENTRY_ID_RE = re.compile(r"\b(?:solver|optimizer)_[0-9a-z]+\b", re.IGNORECASE)


class GuidanceContractError(ValueError):
    """Raised when a worker's guidance update violates the workspace contract."""


def _tokens(value: str) -> tuple[str, ...]:
    without_ids = ENTRY_ID_RE.sub(" ", value)
    normalized = "".join(char.casefold() if char.isalnum() else " " for char in without_ids)
    return tuple(normalized.split())


def _read_required(path: Path, *, label: str) -> str:
    try:
        value = path.read_text(encoding="utf-8")
    except FileNotFoundError as exc:
        raise GuidanceContractError(f"missing {label}: {path}") from exc
    if not value.strip():
        raise GuidanceContractError(f"{label} is empty: {path}")
    return value


def _markdown_bullets(text: str) -> list[str]:
    bullets: list[list[str]] = []
    current: list[str] | None = None
    for line in text.splitlines():
        if line.startswith("- "):
            if current is not None:
                bullets.append(current)
            current = [line[2:]]
        elif current is not None and (line.startswith("  ") or not line.strip()):
            if line.strip():
                current.append(line.strip())
        elif current is not None:
            bullets.append(current)
            current = None
    if current is not None:
        bullets.append(current)
    return [" ".join(lines) for lines in bullets]


def _assigned_parent_experience(workspace: Path) -> Path:
    readme = _read_required(workspace / "README.md", label="rendered workspace README")
    parent_ids = ASSIGNED_PARENT_RE.findall(readme)
    if len(parent_ids) != 1:
        raise GuidanceContractError(
            "expected exactly one guidance example marked as copied to guidance/; "
            f"found {len(parent_ids)}"
        )
    return (
        workspace
        / "guidance_examples"
        / parent_ids[0]
        / "guidance"
        / "control_experience.md"
    )


def validate_workspace(workspace: Path) -> None:
    workspace = workspace.resolve()
    notes = _read_required(workspace / NOTES_PATH, label="candidate-specific notes")
    if len(_tokens(notes)) < 30:
        raise GuidanceContractError(
            "wake_policy_notes.md must contain at least 30 semantic tokens of diagnosis"
        )

    current = _read_required(workspace / EXPERIENCE_PATH, label="control experience")
    parent = _read_required(
        _assigned_parent_experience(workspace), label="assigned parent control experience"
    )
    parent_fingerprints = {_tokens(bullet) for bullet in _markdown_bullets(parent)}
    new_bullets = [
        bullet
        for bullet in _markdown_bullets(current)
        if _tokens(bullet) not in parent_fingerprints
    ]
    if not new_bullets:
        raise GuidanceContractError(
            "control_experience.md has no new or materially revised bullet; entry IDs, case, "
            "punctuation, and whitespace do not count"
        )
    if not any(len(_tokens(bullet)) >= 16 for bullet in new_bullets):
        raise GuidanceContractError(
            "the new or revised control-experience bullet needs at least 16 semantic tokens"
        )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--workspace-root", type=Path, default=Path("."))
    args = parser.parse_args(argv)
    try:
        validate_workspace(args.workspace_root)
    except GuidanceContractError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 2
    print("PASS: notes exist and control_experience.md has a material reusable update")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
