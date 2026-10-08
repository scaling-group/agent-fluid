#!/usr/bin/env python3
"""Generate the five Figure 2 panels from observations and controller code."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from paths import OUTPUT_DIR, external_output, DERIVED_DIR, INDEX_DIR

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib import font_manager
from matplotlib.lines import Line2D
import numpy as np
import pandas as pd
import reportlab

from figure_02_policy_structure import DEFAULT_WIDTH as POLICY_WIDTH
from figure_02_policy_structure import PANEL_HEIGHT, policy_geometry, build_policy_figure


ROOT = Path(__file__).resolve().parents[2]
DATA = DERIVED_DIR / "figure_02"
STEM = "figure_02_evolution_target_capture"
CONDITIONS = ("with_shelf", "without_shelf")
COLORS = ("#2166AC", "#B2182B")
DRL_COLOR = "#66727D"
RUN_ALPHA = 0.22
RUN_LINEWIDTH = 0.65
B_TIME_SCALE = "linear"
B_TIME_LIMITS = (20, 240)
B_TIME_TICKS = (20, 60, 120, 180, 240)
B_RUN_ENDPOINT_SIZE = 1.6
B_RUN_ENDPOINT_ALPHA = 0.60
DRL_DATA = "data/figure_02_drl_comparison.csv"
LABELS = ("With Knowledge Shelf", "Without Knowledge Shelf")
PANEL_STEMS = {"a": "figure_02a_navigation_score", "b": "figure_02b_target_reach_time"}
TEXT_COLOR = "#202831"
AXIS_COLOR = "#46515A"
LEGEND_COLOR = "#505B66"
# Quantitative panel geometry remains local to its drawing implementation.
HALF_WIDTH = 255.12
TOP_ROW_HEIGHT = 186.0
PANEL_RECTS = {"a": (0, 0, HALF_WIDTH, TOP_ROW_HEIGHT),
               "b": (HALF_WIDTH, 0, HALF_WIDTH*2, TOP_ROW_HEIGHT)}
AXIS_RECTS = {"a": (38, 34, HALF_WIDTH-10, 157),
              "b": (HALF_WIDTH+38, 34, HALF_WIDTH*2-10, 157)}
FONT_DIR = Path(reportlab.__file__).parent / "fonts"


def configure_fonts() -> None:
    for name in ("Vera.ttf", "VeraBd.ttf", "VeraIt.ttf"):
        font_manager.fontManager.addfont(FONT_DIR / name)

def load_candidates() -> pd.DataFrame:
    data = pd.read_csv(DATA / "data/figure_02_ab_candidates.csv", float_precision="round_trip")
    keys = ["condition", "run", "iteration", "worker", "candidate"]
    if len(data) != 800 or data.duplicated(keys).any() or set(data.condition) != set(CONDITIONS):
        raise ValueError("Expected all 800 uniquely identified candidates")
    for condition in CONDITIONS:
        group = data.loc[data.condition.eq(condition)]
        if set(group.run) != set(range(1, 6)) or len(group) != 400:
            raise ValueError("Expected five complete runs per condition")
        for _, run in group.groupby("run"):
            run = run.sort_values("candidate")
            np.testing.assert_array_equal(run.candidate, np.arange(1, 81))
            np.testing.assert_array_equal(run.iteration, np.repeat(np.arange(1, 21), 4))
            np.testing.assert_array_equal(run.worker, np.tile(np.arange(4), 20))
    numeric = data[["navigation_score", "distance_integral_L", "release_elapsed", "total_horizon"]]
    if not np.isfinite(numeric).all().all() or not data.navigation_score.lt(0).all():
        raise ValueError("Scores must be finite, strictly negative distance-time integrals")
    np.testing.assert_allclose(data.navigation_score, -data.distance_integral_L, rtol=0, atol=1e-12)
    if data.success.dtype != bool or int(data.success.sum()) != 532:
        raise ValueError("Unexpected success flags")
    if not data.total_horizon.eq(300).all() or not data.release_elapsed.between(0, 300).all():
        raise ValueError("Unexpected elapsed time or episode horizon")
    return data


def candidate_run_curves(data: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Keep each run's running-best score and conditional capture-time median."""
    a = data.groupby(["condition", "run", "iteration"], as_index=False).agg(
        score=("navigation_score", "max"))
    a = a.sort_values(["condition", "run", "iteration"])
    a["score"] = a.groupby(["condition", "run"]).score.cummax()
    successful = data.loc[data.success]
    b = successful.groupby(["condition", "run", "iteration"], as_index=False).agg(
        reach_time=("release_elapsed", "median"))
    return a, b


def summarize(data: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Validate the unchanged historical summaries, independently of styling."""
    a, b = candidate_run_curves(data)
    sa = a.groupby(["condition", "iteration"], as_index=False).score.agg(
        center="mean", lower="min", upper="max", run_count="count")
    sa.insert(0, "panel", "a")
    sb = b.groupby(["condition", "iteration"], as_index=False).reach_time.agg(
        center="median", lower=lambda x: x.quantile(0.25),
        upper=lambda x: x.quantile(0.75), run_count="count")
    sb.insert(0, "panel", "b")
    actual = pd.concat([sa, sb], ignore_index=True).sort_values(["panel", "condition", "iteration"])
    reference = pd.read_csv(DATA / "data/figure_02_ab_reference_summary.csv", float_precision="round_trip")
    reference = reference.sort_values(["panel", "condition", "iteration"])
    if len(actual) != 80 or len(b) != 154:
        raise ValueError("Unexpected number of score/time summaries")
    pd.testing.assert_frame_equal(actual.reset_index(drop=True), reference.reset_index(drop=True),
                                  check_dtype=False, check_exact=False, atol=1e-12, rtol=0)
    if not sa.run_count.eq(5).all() or not sa.center.between(-10, -1.5).all():
        raise ValueError("The approved score display no longer contains all means")
    return sa, sb


def load_drl_runs() -> pd.DataFrame:
    """Use the author's amended five-run cohort and original training histories."""
    cohort = json.loads((DATA / "data/figure_02_drl_cohort.json").read_bytes())
    if (len(cohort["runs"]) != 5 or {r["run"] for r in cohort["runs"]} != set(range(1, 6))
            or len({r["run_label"] for r in cohort["runs"]}) != 5
            or any(r["original_training_episodes"] != 600 for r in cohort["runs"])):
        raise ValueError("Expected five identified original 600-episode training runs")
    source = pd.read_csv(DATA / DRL_DATA, float_precision="round_trip")
    data = source.loc[source.view.eq("episode") & source.method.eq("BC-PPO")].copy()
    if len(data) != 3000 or set(data.run) != set(range(1, 6)):
        raise ValueError("Expected five complete DRL histories and all 3000 episodes")
    fields = data[["episode", "score", "best_score", "distance_integral_score"]]
    if not np.isfinite(fields).all().all() or not data.score.lt(0).all():
        raise ValueError("DRL scores must be recorded, strictly negative navigation scores")
    np.testing.assert_allclose(data.score, data.distance_integral_score, rtol=0, atol=1e-12)
    for _, run in data.groupby("run"):
        run = run.sort_values("episode")
        np.testing.assert_array_equal(run.episode, np.arange(1, 601))
        np.testing.assert_allclose(run.score.cummax(), run.best_score, rtol=0, atol=1e-12)
    return data


def drl_progress_summary(data: pd.DataFrame | None = None) -> pd.DataFrame:
    if data is None:
        data = load_drl_runs()
    result = data.groupby("episode", as_index=False).best_score.agg(
        center="mean", lower="min", upper="max", run_count="count")
    result = result.rename(columns={"episode": "iteration"})
    result.insert(0, "condition", "bc_ppo")
    result.insert(0, "panel", "a")
    if not result.run_count.eq(5).all() or not result.center.between(-10, -1.5).all():
        raise ValueError("The DRL display must include all five-run means")
    return result


def run_curves(data: pd.DataFrame, drl: pd.DataFrame) -> pd.DataFrame:
    a, _ = candidate_run_curves(data)
    a = a.rename(columns={"score": "value"}).assign(panel="a")
    # The shortest successful candidate time found up to each iteration.
    # Carry the incumbent forward even if a later iteration has no captures.
    index = pd.MultiIndex.from_product(
        [CONDITIONS, range(1, 6), range(1, 21)], names=["condition", "run", "iteration"])
    best_times = data.loc[data.success].groupby(
        ["condition", "run", "iteration"]).release_elapsed.min().reindex(index)
    b = best_times.rename("value").reset_index()
    b["value"] = b.groupby(["condition", "run"]).value.transform(lambda x: x.cummin().ffill())
    b = b.assign(panel="b")
    comparison = drl[["run", "episode", "best_score"]].rename(
        columns={"episode": "iteration", "best_score": "value"})
    comparison = comparison.assign(panel="a", condition="bc_ppo")
    columns = ["panel", "condition", "run", "iteration", "value"]
    curves = pd.concat([a[columns], b[columns], comparison[columns]], ignore_index=True)
    if len(curves) != 3400 or curves.duplicated(columns[:-1]).any():
        raise ValueError("Expected 200 SEAS score, 200 best-time and 3000 DRL run positions")
    return curves.sort_values(columns[:-1]).reset_index(drop=True)


def final_run_ranking(panel: str, condition: str, curves: pd.DataFrame) -> pd.DataFrame:
    """Rank only the final iteration; no earlier result breaks ties or gaps.

    A missing final best-so-far reach time means no successful candidate in
    the whole search. Rank such a run after captures, without imputing a time.
    Equal endpoints use the portable run number as a deterministic tie-break.
    """
    last_iteration = 600 if condition == "bc_ppo" else 20
    values = curves.loc[curves.panel.eq(panel) & curves.condition.eq(condition)]
    if set(values.run) != set(range(1, 6)):
        raise ValueError("The representative must be selected from all five runs")
    final = values.loc[values.iteration.eq(last_iteration)].set_index("run").value
    final = final.reindex(range(1, 6)).rename("final_value").rename_axis("run").reset_index()
    if panel == "a" and final.final_value.isna().any():
        raise ValueError("Every score curve must include its final iteration")
    final = final.sort_values(["final_value", "run"], ascending=[panel == "b", True],
                             na_position="last").reset_index(drop=True)
    if pd.isna(final.iloc[2].final_value):
        raise ValueError("The middle-ranked run has no final capture-time observation")
    return final


def representative_runs(curves: pd.DataFrame) -> dict:
    selected = {}
    for (panel, condition), _ in curves.groupby(["panel", "condition"]):
        ranking = final_run_ranking(panel, condition, curves)
        middle = ranking.iloc[2]
        selected.setdefault(panel, {})[condition] = {
            "run": int(middle.run), "final_iteration": 600 if condition == "bc_ppo" else 20,
            "final_value": float(middle.final_value),
            "ranked_runs_best_to_worst": [int(run) for run in ranking.run],
            "runs_without_final_capture": [int(run) for run in ranking.loc[
                ranking.final_value.isna(), "run"]],
        }
    return selected


def visible_score_trace(x: np.ndarray, y: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    """Clip the increasing score path at the existing -10 display boundary.

    Compute the boundary intersection in log-x display coordinates so the
    visible ordinary segments are unchanged. This keeps off-axis PDF strokes
    out of tick-label geometry; it does not change the source or selection.
    """
    if not (np.diff(y) >= 0).all() or not (y <= -1.5).all():
        raise ValueError("Expected non-decreasing scores below the upper display bound")
    visible = np.flatnonzero(y >= -10.0)
    if not len(visible):
        return x[:0], y[:0]
    first = int(visible[0])
    if first == 0:
        return x, y
    fraction = (-10.0 - y[first - 1]) / (y[first] - y[first - 1])
    boundary_x = np.exp(np.log(x[first - 1]) + fraction * np.log(x[first] / x[first - 1]))
    return np.r_[boundary_x, x[first:]], np.r_[-10.0, y[first:]]


def visible_time_trace(x: np.ndarray, y: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    """Clip a decreasing time path to the upper linear-axis boundary.

    Intersect the existing ordinary segment with the boundary; do not assign
    capped values or alter the underlying best-time observations.
    """
    known = y[np.isfinite(y)]
    if not (np.diff(known) <= 0).all():
        raise ValueError("Best-so-far successful capture times must not increase")
    visible = np.flatnonzero(np.isfinite(y) & (y <= B_TIME_LIMITS[1]))
    if not len(visible):
        return x, np.full_like(y, np.nan)
    first = int(visible[0])
    if first == 0 or not np.isfinite(y[first - 1]):
        return x, y
    fraction = (B_TIME_LIMITS[1] - y[first - 1]) / (y[first] - y[first - 1])
    boundary_x = x[first - 1] + fraction * (x[first] - x[first - 1])
    return np.r_[boundary_x, x[first:]], np.r_[B_TIME_LIMITS[1], y[first:]]


def plot_panel(panel: str, curves: pd.DataFrame):
    configure_fonts()
    matplotlib.rcParams.update({
        "font.family": "Bitstream Vera Sans", "font.size": 7.6,
        "axes.labelsize": 8.4, "axes.titlesize": 8.8,
        "axes.linewidth": 0.58, "axes.edgecolor": AXIS_COLOR,
        "text.color": TEXT_COLOR, "axes.labelcolor": TEXT_COLOR,
        "xtick.color": AXIS_COLOR, "ytick.color": AXIS_COLOR,
        "xtick.labelsize": 7.6, "ytick.labelsize": 7.6,
        "pdf.fonttype": 42, "svg.fonttype": "none", "svg.hashsalt": STEM,
        "axes.spines.right": False, "axes.spines.top": False,
        "axes.unicode_minus": False, "path.simplify": False,
    })
    panel_left, panel_top, panel_right, panel_bottom = PANEL_RECTS[panel]
    width, height = panel_right - panel_left, panel_bottom - panel_top
    left, top, right, bottom = AXIS_RECTS[panel]
    left, right = left - panel_left, right - panel_left
    fig = plt.figure(figsize=(width / 72, height / 72))
    ax = fig.add_axes((left / width, (panel_bottom - bottom) / height,
                       (right - left) / width, (bottom - top) / height))

    def text(x, y, value, size, **kwargs):
        return fig.text(x / width, (panel_bottom - y) / height, value,
                        fontsize=size, va="baseline", **kwargs)

    conditions = CONDITIONS + (("bc_ppo",) if panel == "a" else ())
    colors = COLORS + ((DRL_COLOR,) if panel == "a" else ())
    highlights = []
    for condition, color in zip(conditions, colors):
        values = curves.loc[curves.panel.eq(panel) & curves.condition.eq(condition)]
        ranking = final_run_ranking(panel, condition, curves)
        selected_run = int(ranking.iloc[2].run)
        end = 601 if condition == "bc_ppo" else 21
        x = np.arange(1 if panel == "a" else 2, end)
        if not (x > 0).all() or not (np.diff(x) > 0).all():
            raise ValueError("The logarithmic progress axis requires increasing positive coordinates")
        for run in range(1, 6):
            y = values.loc[values.run.eq(run)].set_index("iteration").value.reindex(x).to_numpy()
            if panel == "a" and not np.isfinite(y).all():
                raise ValueError("A complete running-best score trace is required")
            if panel == "b":
                # NaNs remain only before the first capture, or for a run
                # that never captured the target throughout the search.
                if not (y[np.isfinite(y)] > 0).all():
                    raise ValueError("Successful reach times must be positive")
            plot_x, y = visible_score_trace(x, y) if panel == "a" else visible_time_trace(x, y)
            finite = np.isfinite(y)
            isolated = finite & ~np.r_[False, finite[:-1]] & ~np.r_[finite[1:], False]
            ax.plot(plot_x, y, color=color, alpha=RUN_ALPHA, linewidth=RUN_LINEWIDTH,
                    solid_capstyle="round", solid_joinstyle="round", zorder=1)
            if isolated.any():
                ax.plot(plot_x[isolated], y[isolated], linestyle="none", marker="o", markersize=1.3,
                        markeredgewidth=0, color=color, alpha=RUN_ALPHA, zorder=1)
            if panel == "b" and run != selected_run and np.isfinite(y[-1]):
                ax.plot(plot_x[-1:], y[-1:], linestyle="none", marker="o",
                        markersize=B_RUN_ENDPOINT_SIZE, markeredgewidth=0,
                        color=color, alpha=B_RUN_ENDPOINT_ALPHA, zorder=2,
                        gid=f"{condition}-run-{run}-final-time")
            if run == selected_run:
                highlights.append((plot_x, y, isolated, color, condition))
    # Put every selected run above all translucent traces, preserving its whole history.
    for x, y, isolated, color, condition in highlights:
        zorder = 2 if condition == "bc_ppo" else (4 if panel == "a" else 3)
        linewidth = 0.9 if panel == "b" and condition == "without_shelf" else 1.15
        ax.plot(x, y, color=color, alpha=1.0, linewidth=linewidth, solid_capstyle="round",
                solid_joinstyle="round", zorder=zorder)
        if isolated.any():
            ax.plot(x[isolated], y[isolated], linestyle="none", marker="o", markersize=1.5,
                    markeredgewidth=0, color=color, zorder=zorder)
        if panel == "b":
            first_capture = int(np.flatnonzero(np.isfinite(y))[0])
            if first_capture > 0:
                # A retrospective continuity guide at the first measured
                # height, not numerical arrival times before the first capture.
                first_x = x[first_capture]
                ax.plot([x[0], first_x], [y[first_capture], y[first_capture]],
                        color=color, alpha=0.38, linewidth=linewidth,
                        linestyle=(0, (3.2, 2.1)),
                        dash_capstyle="butt", dash_joinstyle="miter",
                        clip_on=False, zorder=zorder,
                        gid=f"{condition}-highlight-pre-capture-state")
                ax.annotate("No capture yet", ((x[0] + first_x) / 2, y[first_capture]),
                            xytext=(0, 2), textcoords="offset points",
                            fontsize=7.2, color=color, alpha=0.65,
                            ha="center", va="bottom", annotation_clip=False,
                            zorder=zorder,
                            gid=f"{condition}-highlight-pre-capture-label")
            ax.plot(x[-1:], y[-1:], linestyle="none", marker="o", markersize=2.3,
                    markeredgewidth=0, color=color, zorder=zorder + 1)
    ax.set_yscale("linear")
    if panel == "a":
        ax.set_xscale("log")
        ax.set(xlim=(0.9, 1000), ylim=(-10, -1.5))
        xticks, yticks = [1, 10, 100, 1000], [-10, -8, -6, -4, -2]
        xlabel = "Evolution iteration / Episode"
        ylabel = "Score"
        title = "Navigation score"
    else:
        ax.set_yscale(B_TIME_SCALE)
        ax.set(xlim=(1.75, 20.25), ylim=B_TIME_LIMITS)
        xticks, yticks = [2, 5, 10, 15, 20], B_TIME_TICKS
        xlabel = "Evolution iteration"
        ylabel = "Reach time"
        title = "Target-reach time"
        # A categorical status mark in axes coordinates, not a numeric time.
        for condition, color in zip(CONDITIONS, COLORS):
            status = final_run_ranking(panel, condition, curves)
            no_capture_count = int(status.final_value.isna().sum())
            if no_capture_count:
                ax.plot([0.98], [0.94], transform=ax.transAxes, linestyle="none",
                        marker="x", markersize=3.8, markeredgewidth=0.65,
                        color=color, alpha=0.55, clip_on=False, zorder=5)
                ax.text(0.94, 0.94, f"{no_capture_count}/{len(status)} No capture",
                        transform=ax.transAxes,
                        fontsize=7.2, color=color, alpha=0.72,
                        ha="right", va="center")
    ax.set_xticks(xticks)
    ax.set_yticks(yticks)
    ax.tick_params(length=2.2, width=0.42, direction="out",
                   labelbottom=False, labelleft=False)
    if panel == "a":
        ax.tick_params(axis="x", which="minor", length=1.2, width=0.3, labelbottom=False)
    else:
        ax.tick_params(axis="y", which="minor", length=0, labelleft=False)
    # Match the original fixed text baselines instead of Matplotlib's padding.
    xmin, xmax = ax.get_xlim()
    ymin, ymax = ax.get_ylim()
    for value in xticks:
        if panel == "a":
            x = left + np.log(value / xmin) / np.log(xmax / xmin) * (right - left)
            # Exponents remain above 5 pt after placement in the manuscript.
            text(x - 6.8, bottom + 12.0, "10", 7.6)
            text(x + 3.0, bottom + 10.0, str(int(np.log10(value))), 7.2)
        else:
            x = left + (value - xmin) / (xmax - xmin) * (right - left)
            text(x, bottom + 12.0, str(value), 7.6, ha="center")
    for value in yticks:
        fraction = (np.log(value / ymin) / np.log(ymax / ymin)
                    if panel == "b" and B_TIME_SCALE == "log"
                    else (value - ymin) / (ymax - ymin))
        y = bottom - fraction * (bottom - top)
        text(left - 4, y + 2.2, str(value), 7.6, ha="right")
    text(12.5, (top + bottom) / 2, ylabel, 8.4, ha="center",
         rotation=90, rotation_mode="anchor")
    text((left + right) / 2, bottom + 24.0, xlabel, 8.4, ha="center")
    text(9, panel_top + 11, panel, 9.8, fontweight="bold")
    text(26, panel_top + 10.9, title, 8.8)
    # A single method key is drawn above both quantitative panels.
    return fig


def main() -> None:
    from panels import save_panel, save_document
    from scientific_panels import trajectory_2d, flows_2d
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    configure_fonts()
    data = load_candidates()
    summarize(data)
    drl = load_drl_runs()
    drl_progress_summary(drl)
    curves = run_curves(data, drl)
    selected = representative_runs(curves)
    index = json.loads((INDEX_DIR / "figure_02.index.json").read_bytes())
    if selected != index["render"]["representative_runs"]:
        raise ValueError("Final-iteration representative runs differ")
    if args.check:
        print("PASS: 800 SEAS candidates, 80 summaries, 3000 DRL episodes and median-run selections")
        return
    args.output_dir.mkdir(parents=True, exist_ok=True)
    for panel in ("a", "b"):
        fig = plot_panel(panel, curves)
        labels = LABELS + (("DRL (BC-PPO)",) if panel == "a" else ())
        colors = COLORS + ((DRL_COLOR,) if panel == "a" else ())
        fig.legend([Line2D([], [], color=c, lw=1.2) for c in colors], labels,
                   loc="upper center", bbox_to_anchor=(.5, -.015), frameon=False,
                   fontsize=7.4, ncol=1)
        save_panel(fig, args.output_dir / PANEL_STEMS[panel])
        plt.close(fig)
    fig = build_policy_figure(POLICY_WIDTH, panel_letter="c")
    save_panel(fig, args.output_dir / "figure_02c_champion_policy")
    plt.close(fig)
    save_document(trajectory_2d(340, 230), args.output_dir / "figure_02d_policy_trajectories")
    save_document(flows_2d(510.24, 135), args.output_dir / "figure_02e_flow_fields")
    print("Generated all five Figure 2 panels.")

if __name__ == "__main__":
    main()
