#!/usr/bin/env python3
"""Build the combined two-panel Lagopoulos validation figure.

This script only replots the frozen transition and grid/time-refinement data;
it does not run CFD.
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
SLATE = "#66727C"
INK = "#26313d"


def read_numeric_csv(path: Path) -> dict[str, np.ndarray]:
    with path.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    return {
        key: np.asarray([float(row[key]) for row in rows], dtype=float)
        for key in rows[0]
        if key != "source" and not key.endswith("_summary")
    }


def style_axis(ax: plt.Axes, *, keep_right: bool = False) -> None:
    ax.spines["top"].set_visible(False)
    if not keep_right:
        ax.spines["right"].set_visible(False)
    ax.tick_params(direction="out", length=3.0, width=0.8, pad=2.5)


def add_panel_heading(ax: plt.Axes, label: str, title: str) -> None:
    ax.text(
        -0.17,
        1.06,
        label,
        transform=ax.transAxes,
        fontsize=10,
        fontweight="bold",
        color=INK,
        ha="left",
        va="bottom",
    )
    ax.set_title(title, loc="left", pad=10, color=INK, fontweight="normal")


def main() -> None:
    script_path = Path(__file__).resolve()
    provenance_dir = DERIVED_DIR / "supplementary_figure_01/data"
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-dir", type=Path, default=provenance_dir)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=True)

    transition = read_numeric_csv(
        args.data_dir / "lagopoulos_transition_summary_7sr.csv"
    )
    refinement = read_numeric_csv(
        args.data_dir / "lagopoulos_grid_ct_eta_convergence.csv"
    )

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

    fig, (ax_transition, ax_ct) = plt.subplots(1, 2, figsize=(7.4, 3.2))
    fig.subplots_adjust(left=0.085, right=0.925, bottom=0.19, top=0.82, wspace=0.42)

    sr_fit = np.linspace(0.15, 0.355, 400)
    ad_fit = 0.1236 * sr_fit ** (-1.139) + 0.09983
    ax_transition.plot(
        sr_fit,
        ad_fit,
        color=BLUE,
        linewidth=1.8,
        label="Lagopoulos et al. (2019)",
        zorder=2,
    )
    ax_transition.errorbar(
        transition["Sr"],
        transition["interpolated_A_D"],
        yerr=0.05,
        color=RED,
        ecolor=SLATE,
        marker="D",
        markersize=4.6,
        markeredgecolor=RED,
        markeredgewidth=1.0,
        linewidth=0,
        elinewidth=1.0,
        capsize=3.0,
        capthick=1.0,
        label=r"WaterLily ($N_c=64$)",
        zorder=3,
    )
    ax_transition.set_xlim(0.145, 0.355)
    ax_transition.set_ylim(0.46, 1.23)
    ax_transition.set_xticks([0.15, 0.20, 0.25, 0.30, 0.35])
    ax_transition.set_xlabel(r"Strouhal number, $Sr$")
    ax_transition.set_ylabel(r"trailing-edge amplitude, $A_D$")
    ax_transition.legend(loc="upper right", frameon=False, borderaxespad=0.2)
    add_panel_heading(ax_transition, "a", "Wake-transition boundary")
    style_axis(ax_transition)

    ax_eta = ax_ct.twinx()
    nc = refinement["N_c"]
    ct_line, = ax_ct.plot(
        nc,
        refinement["mean_C_T"],
        color=BLUE,
        marker="o",
        markersize=4.0,
        linewidth=1.7,
        label=r"mean thrust, $\overline{C}_T$",
        zorder=3,
    )
    eta_line, = ax_eta.plot(
        nc,
        refinement["eta"],
        color=RED,
        marker="D",
        markersize=3.8,
        linewidth=1.7,
        label=r"efficiency, $\eta$",
        zorder=3,
    )
    ax_ct.set_xlim(12, 132)
    ax_ct.set_ylim(0.055, 0.121)
    ax_eta.set_ylim(0.08, 0.39)
    ax_ct.set_xticks(nc)
    ax_ct.set_xlabel(r"grid resolution, $N_c$")
    ax_ct.set_ylabel(r"mean thrust, $\overline{C}_T$", color=BLUE)
    ax_eta.set_ylabel(r"efficiency, $\eta$", color=RED)
    ax_ct.tick_params(axis="y", colors=BLUE)
    ax_eta.tick_params(axis="y", colors=RED)
    ax_ct.legend(
        [ct_line, eta_line],
        [ct_line.get_label(), eta_line.get_label()],
        loc="upper right",
        frameon=False,
        borderaxespad=0.2,
    )
    add_panel_heading(ax_ct, "b", "Grid/time refinement")
    style_axis(ax_ct, keep_right=True)
    ax_eta.spines["top"].set_visible(False)
    ax_eta.tick_params(direction="out", length=3.0, width=0.8, pad=2.5)

    from panels import save_panel
    save_panel(fig, args.output_dir / "supplementary_figure_01_a", axes=[ax_transition])
    save_panel(fig, args.output_dir / "supplementary_figure_01_b", axes=[ax_ct, ax_eta])
    plt.close(fig)


if __name__ == "__main__":
    main()
