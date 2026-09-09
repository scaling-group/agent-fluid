"""Check panel coverage, editable PDF labels, and nonempty generated outputs."""
import argparse
import hashlib
import json
import numpy as np
import pymupdf
from PIL import Image
from catalog import load_catalog
from paths import OUTPUT_DIR, external_output

def verify_outputs(output, selected=None):
    output = external_output(output)
    catalog = load_catalog()
    outputs = {}
    count = 0
    for figure in catalog["figures"]:
        if selected and figure.get("build_id") not in selected:
            continue
        for panel in figure["panels"]:
            if "output_stem" not in panel:
                continue
            stem = output / panel["output_stem"]
            for extension in ("pdf", "svg", "png"):
                path = stem.with_suffix("." + extension)
                if not path.is_file() or path.stat().st_size < 200:
                    raise ValueError("Missing or empty panel: " + str(path))
                outputs[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
            with pymupdf.open(stem.with_suffix(".pdf")) as pdf:
                if len(pdf) != 1 or len(pdf[0].get_text().strip()) < 1:
                    raise ValueError("Panel PDF must have one page with editable labels: " + str(stem))
            with Image.open(stem.with_suffix(".png")) as image:
                pixels = np.asarray(image.convert("RGB"))
                if min(image.size) < 200 or np.count_nonzero(pixels.min(axis=2) < 240) < 1000:
                    raise ValueError("Panel is empty or undersized: " + str(stem))
            count += 1
    for table in catalog["tables"]:
        path = output / (table["output_stem"] + ".tex")
        contents = path.read_text(encoding="utf-8")
        if "\\begin{tabular" not in contents or "\\end{tabular" not in contents:
            raise ValueError("Incomplete generated table: " + str(path))
        outputs[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
    return {"status": "PASS", "panels": count, "tables": 3,
            "checks": ["panel coverage", "editable PDF labels", "nonempty rasters"],
            "outputs": outputs}

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    parser.add_argument("--figure", action="append")
    args = parser.parse_args()
    print(json.dumps(verify_outputs(args.output_dir, args.figure), indent=2))
