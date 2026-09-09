"""Read scientific panel mappings; verify data without requiring artwork."""
import hashlib
import json
from pathlib import Path
from paths import ROOT, DERIVED_DIR

def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def load_catalog(*, verify_inputs=False):
    release = json.loads((ROOT / "code/plotting/index.json").read_bytes())
    result = {"figures": [], "tables": []}
    for display in release["displays"]:
        path = ROOT / display["index"]
        index = json.loads(path.read_bytes())
        if index["schema"] != "agent-fluid.scientific-display.v1":
            raise ValueError("Unsupported display index: " + str(path))
        labels = [panel["id"] for panel in index["panels"]]
        if not labels or len(labels) != len(set(labels)):
            raise ValueError("Missing or duplicate panels: " + str(path))
        directory = DERIVED_DIR / display["id"]
        mapped = {item for panel in index["panels"] for item in panel["inputs"]}
        if not mapped.issubset(index["inputs"]):
            raise ValueError("Panel input mapping is incomplete: " + str(path))
        for source, expected in index["inputs"].items():
            target = (directory / source).resolve()
            if not target.is_relative_to(directory.resolve()):
                raise ValueError("Derived input leaves its display directory")
            if verify_inputs and digest(target) != expected:
                raise ValueError("Derived input changed: " + str(target))
        for source in index.get("scientific_sources", []):
            target = DERIVED_DIR / source.removeprefix("derived_data/") if source.startswith("derived_data/") else ROOT / source
            if not target.is_file():
                raise ValueError("Scientific source is missing: " + source)
        entry = {**index, "directory": directory, "index": display["index"]}
        result["tables" if display["kind"] == "table" else "figures"].append(entry)
    if len(result["figures"]) != 9 or len(result["tables"]) != 3:
        raise ValueError("Expected nine figure groups and three tables")
    if sum(len(item["panels"]) for item in result["figures"]) != 26:
        raise ValueError("Expected all 26 manuscript panels")
    return result
