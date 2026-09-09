"""Check that the manuscript data inputs and their raw sources are available."""
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "code/plotting"))
from catalog import load_catalog
from paths import DERIVED_DIR

def validate():
    # Values are compared with a fresh extraction by verify.py. Byte hashes of
    # derived files or extraction code are not a numerical consistency check.
    catalog = load_catalog(verify_inputs=False)
    expected = json.loads((ROOT / "code/reproduction/index.json").read_bytes())["required_derived_data"]
    report = json.loads((DERIVED_DIR / "extraction_report.json").read_bytes())
    if report["status"] != "PASS" or not set(expected).issubset(report["provenance"]):
        raise ValueError("Derived data coverage is incomplete")
    sources = set()
    for name in expected:
        if not (DERIVED_DIR / name).is_file():
            raise ValueError("Derived data is missing: " + name)
        sources.update(report["provenance"][name]["inputs"])
    for source in sources:
        if not (ROOT / source).is_file():
            raise ValueError("Extraction source is missing: " + source)
    for item in catalog["figures"] + catalog["tables"]:
        for source in item["inputs"]:
            if not (item["directory"] / source).is_file():
                raise ValueError("Panel or table input is missing: " + str(item["directory"] / source))
    generated = sum(bool(panel.get("output_stem")) for item in catalog["figures"] for panel in item["panels"])
    return {"status": "PASS", "figure_groups": len(catalog["figures"]), "generated_panels": generated,
            "conceptual_illustrations_excluded": ["Extended Data Figure 1a", "Extended Data Figure 1b"], "tables": len(catalog["tables"]),
            "derived_files": len(expected), "available_source_files": len(sources)}


if __name__ == "__main__":
    print(json.dumps(validate(), indent=2))
