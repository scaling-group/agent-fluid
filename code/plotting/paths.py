"""Locations shared by the self-contained publication figure tools."""
from pathlib import Path
import os

ROOT = Path(__file__).resolve().parents[2]
OUTPUT_DIR = ROOT.parent / (ROOT.name + "-figures")
DERIVED_DIR = Path(os.environ.get("AGENT_FLUID_DERIVED_DATA", ROOT / "derived_data")).resolve()
INDEX_DIR = Path(__file__).resolve().parent


def external_output(value: str | Path) -> Path:
    """Keep generated files outside the archive and its ancestor directories."""
    path = Path(value).expanduser().resolve()
    if path == ROOT or path.is_relative_to(ROOT) or ROOT.is_relative_to(path):
        raise ValueError("Choose an output path outside the agent-fluid repository and its ancestors")
    return path
