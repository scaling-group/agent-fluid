"""Render panel C from clean distance--time-integral learning curves."""

from __future__ import annotations

import argparse
import csv
from collections import defaultdict
from pathlib import Path
from paths import OUTPUT_DIR, external_output, DERIVED_DIR, INDEX_DIR

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D
from matplotlib.ticker import MaxNLocator


# Fixed manuscript palette.
TRANSFER = "#2166AC"
NAIVE = "#B2182B"
TEXT = "#26313d"
ROOT = DERIVED_DIR / "figure_05"
RELEASE_ROOT = ROOT.parents[2]
DEFAULT_CURVES = ROOT / "data/learning_curves.csv"
DEFAULT_OUTPUT = OUTPUT_DIR / 'evolutionary_adaptation_panel.png'


def read_curves(path: Path) -> dict[str, dict[str, np.ndarray | str]]:
    grouped: dict[str, list[tuple[int, float, str]]] = defaultdict(list)
    with path.open(newline="", encoding="utf-8") as handle:
        for row in csv.DictReader(handle):
            if row["best_distance_integral_score"]:
                grouped[row["replicate_id"]].append(
                    (
                        int(row["iteration"]),
                        float(row["best_distance_integral_score"]),
                        row["condition"],
                    )
                )
    curves = {}
    for internal_id, values in grouped.items():
        values.sort()
        curves[internal_id] = {
            "iteration": np.asarray([value[0] for value in values]),
            "score": np.asarray([value[1] for value in values]),
            "condition": values[0][2],
        }
    return curves


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--curves", type=Path, default=DEFAULT_CURVES)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    args = parser.parse_args()

    mpl.rcParams.update(
        {
            "font.family": "sans-serif",
            "font.sans-serif": ["DejaVu Sans"],
            "font.size": 10.7,
            "axes.linewidth": 0.7,
            "xtick.major.width": 0.7,
            "ytick.major.width": 0.7,
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
            "savefig.facecolor": "white",
            "figure.facecolor": "white",
        }
    )
    curves = read_curves(args.curves)
    figure, axis = plt.subplots(figsize=(4.3, 3.2), dpi=360)
    figure.subplots_adjust(left=0.15, right=0.98, top=0.84, bottom=0.19)

    condition_spec = [
        ("naive_seed", NAIVE, 2),
        ("two_dimensional_champion", TRANSFER, 4),
    ]
    for condition, color, zorder in condition_spec:
        selected = sorted(
            (curve for curve in curves.values() if curve["condition"] == condition),
            key=lambda curve: float(np.asarray(curve["score"])[-1]),
        )
        if len(selected) != 3:
            raise ValueError(f"Expected three independent runs for {condition}")
        iteration = np.asarray(selected[0]["iteration"])
        scores = np.vstack([np.asarray(curve["score"]) for curve in selected])
        mean = scores.mean(axis=0)
        lower = scores.min(axis=0)
        upper = scores.max(axis=0)

        axis.fill_between(
            iteration,
            lower,
            upper,
            step="post",
            color=color,
            alpha=0.11,
            linewidth=0,
            zorder=zorder,
        )
        for curve in selected:
            axis.plot(
                curve["iteration"],
                curve["score"],
                color=color,
                linewidth=0.62,
                alpha=0.50,
                drawstyle="steps-post",
                zorder=zorder + 1,
            )
        axis.plot(
            iteration,
            mean,
            color=color,
            linewidth=1.55,
            drawstyle="steps-post",
            solid_capstyle="round",
            zorder=zorder + 2,
        )

    axis.set_xlim(0, 40)
    all_scores = np.concatenate([np.asarray(curve["score"]) for curve in curves.values()])
    score_span = max(float(np.ptp(all_scores)), 1.0)
    axis.set_ylim(
        float(all_scores.min()) - 0.035 * score_span,
        min(0.0, float(all_scores.max()) + 0.055 * score_span),
    )
    axis.set_xticks([0, 10, 20, 30, 40])
    axis.yaxis.set_major_locator(MaxNLocator(nbins=5))
    axis.set_xlabel("evolution iteration")
    axis.set_ylabel("Score", labelpad=-1.5)
    # Match the physical axes rectangle used by the 24L x 16L trajectory panel.
    axis.set_box_aspect((16.0 + 1.0 / 3.0 - 7.0) / (24.15 - 8.0))
    axis.set_anchor("W")
    header_y = 1.075
    axis.text(
        0.0,
        header_y,
        "Evolutionary adaptation",
        transform=axis.transAxes,
        ha="left",
        va="baseline",
        fontsize=12.2,
        fontweight="normal",
        color=TEXT,
    )
    axis.spines["top"].set_visible(False)
    axis.spines["right"].set_visible(False)
    axis.tick_params(direction="out", length=2.5, width=0.7, pad=2)

    axis.text(
        -0.14,
        header_y,
        "c",
        transform=axis.transAxes,
        ha="left",
        va="baseline",
        fontsize=14.5,
        fontweight="bold",
        color=TEXT,
    )
    legend = [
        Line2D([0], [0], color=TRANSFER, linewidth=1.55, label="2D policy initialization"),
        Line2D([0], [0], color=NAIVE, linewidth=1.55, label="minimal seed"),
    ]
    axis.legend(
        handles=legend,
        loc="lower right",
        frameon=False,
        fontsize=9.9,
        handlelength=2.2,
        borderaxespad=0.25,
    )
    from panels import save_panel
    mpl.rcParams["svg.fonttype"] = "none"
    save_panel(figure, args.output_dir / "figure_05_c")
    plt.close(figure)

if __name__ == "__main__":
    main()
