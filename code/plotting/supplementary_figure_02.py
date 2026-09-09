#!/usr/bin/env python3
"""Replot the frozen oscillating-cylinder validation data for the paper.

This script only reads the archived convergence CSV; it does not run CFD.
"""

from __future__ import annotations

import argparse
import json
import csv
from pathlib import Path
from paths import OUTPUT_DIR, external_output, DERIVED_DIR, INDEX_DIR

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


BLUE = "#2166AC"
RED = "#B2182B"
GRAY = "#66727C"
INK = "#26313d"
WATERLILY_CP = -4.39
EXPERIMENT_CP = -4.52


def read_columns(path: Path) -> dict[str, np.ndarray]:
    with path.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    return {
        key: np.asarray([float(row[key]) for row in rows], dtype=float)
        for key in ("n", "mean_CP", "cycle_95_halfwidth_CP")
    }


def main() -> None:
    script_path = Path(__file__).resolve()
    provenance_dir = DERIVED_DIR / "supplementary_figure_02/data"
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--input",
        type=Path,
        default=provenance_dir / "oscillating_cylinder_resolution_convergence.csv",
    )
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    data = read_columns(args.input)
    resolution_levels = np.arange(data["n"].size)

    plt.rcParams.update(
        {
            "font.family": "DejaVu Sans",
            "font.size": 8.5,
            "axes.titlesize": 9.5,
            "axes.labelsize": 9.0,
            "axes.linewidth": 0.8,
            "xtick.labelsize": 8.0,
            "ytick.labelsize": 8.0,
            "legend.fontsize": 7.8,
            "legend.handlelength": 2.2,
            "pdf.fonttype": 42,
            "ps.fonttype": 42, "svg.fonttype": "none",
        }
    )

    fig, ax = plt.subplots(figsize=(3.7, 2.7))
    fig.subplots_adjust(left=0.17, right=0.98, bottom=0.22, top=0.82)
    (simulation,) = ax.plot(
        resolution_levels,
        data["mean_CP"],
        color=BLUE,
        marker="D",
        markersize=4.2,
        markeredgecolor=BLUE,
        markeredgewidth=1.0,
        linewidth=1.8,
        label="Present",
        zorder=3,
    )
    paper = ax.axhline(
        WATERLILY_CP,
        color=RED,
        linestyle="-",
        linewidth=1.4,
        label="Weymouth et al. (2025)",
        zorder=1,
    )
    experiment = ax.axhline(
        EXPERIMENT_CP,
        color=GRAY,
        linestyle="--",
        linewidth=1.4,
        label="Experiment",
        zorder=1,
    )

    ax.set_xlim(-0.5, resolution_levels[-1] + 0.5)
    ax.set_ylim(-5.82, -4.12)
    ax.set_xticks(resolution_levels, labels=data["n"].astype(int))
    ax.set_xlabel(r"grid resolution, $n$")
    ax.set_ylabel(r"mean signed power, $\overline{C}_P$")
    ax.set_title(
        "3D oscillating-cylinder validation",
        loc="left",
        pad=10,
        color=INK,
        fontweight="normal",
    )
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.tick_params(direction="out", length=3.0, width=0.8, pad=2.5)
    ax.legend(
        [simulation, experiment, paper],
        [simulation.get_label(), experiment.get_label(), paper.get_label()],
        loc="lower right",
        frameon=False,
        borderaxespad=0.2,
    )

    from panels import save_panel
    save_panel(fig, args.output_dir / "supplementary_figure_02")
    plt.close(fig)


if __name__ == "__main__":
    main()
