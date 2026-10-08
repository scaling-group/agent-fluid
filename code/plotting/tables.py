"""Generate the three paper tables from derived values and authored definitions."""
import argparse
import csv
import json
from pathlib import Path
import statistics
from paths import ROOT, DERIVED_DIR, OUTPUT_DIR, external_output


def read_rows(path):
    with path.open(newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))


def tex(text):
    escapes = {"\\": r"\textbackslash{}", "&": r"\&", "%": r"\%", "_": r"\_",
               "#": r"\#", "{": r"\{", "}": r"\}"}
    return "".join(escapes.get(c, c) for c in str(text))


def table(columns, rows, caption, label, spec=None):
    spec = spec or ("l" * len(columns))
    lines = [r"\begin{table}[htbp]", r"\centering\small",
             r"\begin{tabular}{" + spec + "}", r"\hline",
             " & ".join(columns) + r" \\", r"\hline"]
    lines += [" & ".join(row) + r" \\" for row in rows]
    lines += [r"\hline", r"\end{tabular}", r"\caption{" + caption + "}",
              r"\label{" + label + "}", r"\end{table}"]
    return "\n".join(lines) + "\n"


def generalization():
    records = read_rows(DERIVED_DIR / "table_01/data/matrix.csv")
    if len(records) != 13:
        raise ValueError("The generalization table requires all 13 conditions")
    rows = []
    for r in records:
        case = r["case"]
        if case == "nominal":
            setting = "Original configuration"
        elif case.startswith("a"):
            setting = f"Target ({float(r['target_x_L']):g}, {float(r['target_y_L']):g})L"
        elif case.startswith("b"):
            xs, ys = json.loads(r["cylinder_x_L"]), json.loads(r["cylinder_y_L"])
            setting = f"Rear row x={xs[-1]:g}L; y={ys[-2]:g}, {ys[-1]:g}L"
        elif case.startswith("c"):
            points = list(zip(json.loads(r["cylinder_x_L"]), json.loads(r["cylinder_y_L"])))
            original = list(zip(json.loads(records[0]["cylinder_x_L"]), json.loads(records[0]["cylinder_y_L"])))
            retained = ", ".join(str(original.index(point) + 1) for point in points)
            setting = f"{len(points)} cylinders (retained {retained})"
        else:
            setting = f"Flow speed {float(r['flow_speed']):.2f}"
        rows.append([tex(case), tex(setting), r["seas_captures"] + "/" + r["seas_total"],
                     f"{float(r['t_end']):.2f}", f"{float(r['s']):.4f}",
                     r["drl_captures"] + "/" + r["drl_total"]])
    return table(["Test", "Perturbation", "Agent reach", r"$t_{\rm champ}$",
                  r"$s_{\rm champ}$", "DRL reach"], rows,
                 "Fixed-policy generalization. Each perturbation changes one environmental factor. "
                 "Reach counts include all five fixed policies per method; times and scores refer to the shown champion.",
                 "tab:generalization-matrix", "llrrrr")


def moving_window():
    records = read_rows(DERIVED_DIR / "supplementary_table_01/data/paired_releases.csv")
    if len(records) != 5:
        raise ValueError("The moving-window table requires five paired releases")
    keys = ["shift_count", "center_rms_L", "heading_rms_deg", "velocity_rms_U",
            "full_to_moving_ms_per_step_ratio"]
    rows = []
    for record in records:
        values = [float(record[k]) for k in keys]
        rows.append([tex(record["release"]), f"{values[0]:.0f}", f"{values[1]:.3g}",
                     f"{values[2]:.3g}", f"{values[3]:.3g}", f"{values[4]:.1f}"])
    means = [statistics.mean(float(record[k]) for record in records) for k in keys]
    rows.append(["Mean", f"{means[0]:.1f}", f"{means[1]:.3g}", f"{means[2]:.3f}",
                 f"{means[3]:.4f}", f"{means[4]:.1f}"])
    return table(["Release", "Translations", r"RMS$(\Delta r_c)/L$",
                  r"RMS$(\Delta\psi)$ (deg)", r"RMS$(\Delta U_c)/U$", "Time ratio"], rows,
                 "Five-release matched full-field versus moving-window validation. "
                 r"RMS differences use $0\leq t\leq10T$; the time ratio is measured full-field/moving-window wall time per solver step.",
                 "tab:supp-moving-window-verification", "lrrrrr")


def controller_lineage():
    content = json.loads((ROOT / "code/plotting/tables.index.json").read_bytes())["supplementary_table_02"]
    rows = [[tex(r[k]) for k in ("structure", "stage", "interpretation")] for r in content["rows"]]
    if len(rows) != 7:
        raise ValueError("The controller lineage requires seven authored milestones")
    return table(["Control structure", "Policy stage", "Implemented feedback and role"], rows,
                 "Controller-lineage interpretation of the retained executable policies. "
                 "These descriptions are authored structural interpretations, not additional measurements.",
                 "tab:supp-control-lineage", r"p{.23\linewidth}p{.17\linewidth}p{.51\linewidth}")


def build(output):
    output = external_output(output)
    output.mkdir(parents=True, exist_ok=True)
    for name, generate in [("table_01_generalization_matrix", generalization),
                           ("supplementary_table_01_moving_window_validation", moving_window),
                           ("supplementary_table_02_control_lineage", controller_lineage)]:
        (output / (name + ".tex")).write_text(generate(), encoding="utf-8", newline="\n")
    return output


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    print(build(parser.parse_args().output_dir))
