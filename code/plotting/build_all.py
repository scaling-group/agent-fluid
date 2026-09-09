"""Generate every manuscript subpanel and table from derived data, offline."""
import argparse
import json
import os
import subprocess
import sys
import time
from pathlib import Path
from catalog import load_catalog
from paths import ROOT, OUTPUT_DIR, external_output

STEPS = {
    "1": [("figure_01.py", "--output-dir")],
    "2": [("figure_02_evolution_target_capture.py", "--output-dir")],
    "3": [("figure_03.py", "--output-dir")],
    "4": [("figure_04.py", "--out-dir")],
    "5": [("figure_05.py", "--output-dir"), ("figure_05_learning.py", "--output-dir")],
    "S1": [("supplementary_figure_01.py", "--output-dir")],
    "S2": [("supplementary_figure_02.py", "--output-dir")],
    "S3": [("supplementary_figure_03.py", "--output-dir")],
}

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    parser.add_argument("--figure", action="append", choices=list(STEPS))
    parser.add_argument("--list", action="store_true")
    args = parser.parse_args()
    catalog = load_catalog()
    if args.list:
        for figure in catalog["figures"]:
            panels = [p["id"] for p in figure["panels"] if p.get("output_stem")]
            print(figure["display_label"], ": ", ", ".join(panels) if panels else "conceptual schematics; excluded", sep="")
        return
    args.output_dir.mkdir(parents=True, exist_ok=True)
    env = {**os.environ, "PYTHONUTF8": "1", "PYTHONDONTWRITEBYTECODE": "1", "MPLBACKEND": "Agg"}
    started = time.perf_counter()
    for key in args.figure or STEPS:
        for script, option in STEPS[key]:
            command = [sys.executable, "-B", str(Path(__file__).parent / script), option, str(args.output_dir)]
            subprocess.run(command, check=True, cwd=ROOT, env=env)
        print("Built panels for " + key, flush=True)
    subprocess.run([sys.executable, "-B", str(Path(__file__).with_name("tables.py")),
                    "--output-dir", str(args.output_dir)], check=True, cwd=ROOT, env=env)
    from verify import verify_outputs
    report = verify_outputs(args.output_dir, args.figure)
    report["elapsed_seconds"] = round(time.perf_counter() - started, 1)
    (args.output_dir / "verification.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key:value for key,value in report.items() if key!='outputs'}))

if __name__ == "__main__":
    main()
