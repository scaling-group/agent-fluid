#!/usr/bin/env python3
"""Render Figure 4 from numerical source data and seven controller sources.

The three NPZ files contain the unchanged pressure, vorticity and body-distance
arrays selected for the published figure. No VTK reader or CFD rerun is needed.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
from pathlib import Path
from paths import OUTPUT_DIR, external_output, DERIVED_DIR, INDEX_DIR
import re

import matplotlib

matplotlib.use("Agg")
import matplotlib.patheffects as pe
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
from matplotlib.patches import Circle
import numpy as np


EXPERIMENT_ROOT = DERIVED_DIR / "figure_04"
DEFAULT_RUN_ROOT = EXPERIMENT_ROOT / "data"
DEFAULT_POLICY_DIR = EXPERIMENT_ROOT / "code"
DEFAULT_OUT_DIR = OUTPUT_DIR
DEFAULT_SOURCE_MANIFEST = INDEX_DIR / "figure_04.index.json"
FINAL_CASE = "iteration_19__phase_0__nominal"
POLICY_RELPATH = "cases/dogfish_2d_shape_policy/candidate_target_policy.jl"
POLICY_MILESTONES = [0, 1, 6, 7, 12, 18, 19]
POLICY_ARTIFACTS = {
    0: "i000_seed.json",
    1: "i001.json",
    6: "i006.json",
    7: "i007.json",
    12: "i012.json",
    18: "i018.json",
    19: "i019_champion.json",
}
BODY_LENGTH_GRID = 64.0
FLOW_SPEED = 0.180000007
TARGET_L = np.array([9.0, 9.5])
CAPTURE_RADIUS_L = 0.75

PRIMARY_BLUE = "#2166AC"
PRIMARY_RED = "#B2182B"
SECONDARY_SLATE = "#66727C"
STAGE_COLORS = [SECONDARY_SLATE, PRIMARY_RED, PRIMARY_BLUE]
PHASE_COLORS = [SECONDARY_SLATE, PRIMARY_RED, PRIMARY_BLUE]
MODULE_COLORS = {
    "bearing": PRIMARY_BLUE,
    "asymmetry": PRIMARY_RED,
    "burst": SECONDARY_SLATE,
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-root", type=Path, default=DEFAULT_RUN_ROOT)
    parser.add_argument("--policy-dir", type=Path, default=DEFAULT_POLICY_DIR)
    parser.add_argument("--out-dir", type=external_output, default=DEFAULT_OUT_DIR)
    parser.add_argument(
        "--input-index", "--source-manifest", dest="source_manifest", type=Path, default=DEFAULT_SOURCE_MANIFEST
    )
    parser.add_argument("--verify-inputs", action="store_true", help="optionally check input file hashes")
    parser.add_argument(
        "--skip-input-verification",
        action="store_true",
        help=argparse.SUPPRESS,
    )
    parser.add_argument(
        "--basename", default="figure_04_physical_mechanisms"
    )
    return parser.parse_args()


def read_csv_numeric(path: Path) -> dict[str, np.ndarray]:
    with path.open(newline="") as handle:
        rows = list(csv.DictReader(handle))
    columns: dict[str, np.ndarray] = {}
    for key in rows[0]:
        values = []
        numeric = True
        for row in rows:
            value = row[key]
            try:
                values.append(float(value))
            except (TypeError, ValueError):
                numeric = False
                break
        if numeric:
            columns[key] = np.asarray(values, dtype=float)
        else:
            columns[key] = np.asarray([row[key] for row in rows], dtype=object)
    return columns


def read_rows(path: Path) -> list[dict[str, str]]:
    with path.open(newline="") as handle:
        return list(csv.DictReader(handle))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def policy_source_metrics(source: str) -> dict[str, object]:
    code_lines = sum(
        1
        for raw_line in source.splitlines()
        if raw_line.strip() and not raw_line.strip().startswith("#")
    )
    parameter_block = re.search(
        r"function\s+target_policy_params\s*\([^)]*\)\s*"
        r"return\s*\((.*?)\)\s*end",
        source,
        flags=re.DOTALL,
    )
    if parameter_block is None:
        raise ValueError("target_policy_params return tuple was not found")
    parameter_names = tuple(
        sorted(
            set(
                re.findall(
                    r"(?m)^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=",
                    parameter_block.group(1),
                )
            )
        )
    )
    state_signals = tuple(
        sorted(set(re.findall(r"\bstate\.([A-Za-z_][A-Za-z0-9_]*)", source)))
    )
    return {
        "code_lines": code_lines,
        "parameter_count": len(parameter_names),
        "state_signal_count": len(state_signals),
        "parameter_names": parameter_names,
        "state_signals": state_signals,
    }


def verify_input_manifest(path: Path) -> None:
    manifest = json.loads(path.read_text(encoding="utf-8"))
    for relative, expected in manifest["inputs"].items():
        artifact = EXPERIMENT_ROOT / relative
        if not artifact.is_file():
            raise FileNotFoundError(f"Fig. 4 input is missing: {artifact}")
        observed_sha = sha256_file(artifact)
        if observed_sha != expected:
            raise ValueError(
                f"Fig. 4 input hash mismatch for {artifact}: "
                f"{observed_sha} != {expected}"
            )


def load_policy_architecture(policy_dir: Path) -> list[dict[str, object]]:
    audit: list[dict[str, object]] = []
    for iteration in POLICY_MILESTONES:
        artifact = policy_dir / f"iteration_{iteration:02}.jl"
        observed_sha = sha256_file(artifact)
        source = artifact.read_text(encoding="utf-8")
        if not isinstance(source, str):
            raise KeyError(f"{POLICY_RELPATH!r} missing from {artifact}")
        audit.append(
            {
                "iteration": iteration,
                "stage": "Seed" if iteration == 0 else f"Iteration {iteration}",
                "policy_artifact": str(artifact),
                "policy_artifact_sha256": observed_sha,
                **policy_source_metrics(source),
            }
        )
    return audit


def write_policy_architecture_audit(
    path: Path, audit: list[dict[str, object]]
) -> None:
    fieldnames = [
        "iteration",
        "stage",
        "policy_artifact",
        "policy_artifact_sha256",
        "code_lines",
        "parameter_count",
        "state_signal_count",
        "parameter_names",
        "state_signals",
    ]
    with path.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames, lineterminator="\n")
        writer.writeheader()
        for row in audit:
            serialized = dict(row)
            serialized["parameter_names"] = ";".join(row["parameter_names"])
            serialized["state_signals"] = ";".join(row["state_signals"])
            writer.writerow(serialized)


def grid_arrays(path):
    with np.load(path, allow_pickle=False) as data:
        return {name: data[name] for name in data.files}


def bilinear(
    array: np.ndarray,
    x_world: np.ndarray,
    y_world: np.ndarray,
    grid: dict[str, np.ndarray | float],
) -> np.ndarray:
    fx = (x_world - float(grid["ox"])) / float(grid["sx"])
    fy = (y_world - float(grid["oy"])) / float(grid["sy"])
    ix = np.floor(fx).astype(int)
    iy = np.floor(fy).astype(int)
    ix = np.clip(ix, 0, array.shape[1] - 2)
    iy = np.clip(iy, 0, array.shape[0] - 2)
    tx = fx - ix
    ty = fy - iy
    return (
        (1 - tx) * (1 - ty) * array[iy, ix]
        + tx * (1 - ty) * array[iy, ix + 1]
        + (1 - tx) * ty * array[iy + 1, ix]
        + tx * ty * array[iy + 1, ix + 1]
    )


def body_aligned_fields(
    grid: dict[str, np.ndarray | float],
    center_grid: np.ndarray,
    heading: float,
    nu: int = 320,
    nv: int = 220,
) -> dict[str, np.ndarray | float]:
    u = np.linspace(-0.78, 0.78, nu)
    v = np.linspace(-0.54, 0.54, nv)
    uu, vv = np.meshgrid(u, v)
    c, s = np.cos(heading), np.sin(heading)
    x_world = center_grid[0] + BODY_LENGTH_GRID * (c * uu - s * vv)
    y_world = center_grid[1] + BODY_LENGTH_GRID * (s * uu + c * vv)
    pressure = bilinear(grid["pressure"], x_world, y_world, grid)
    sdf = bilinear(grid["sdf"], x_world, y_world, grid)
    r = np.hypot(uu, vv)
    reference = np.nanmedian(pressure[(r > 0.58) & (sdf > 2.0)])
    cp = 2.0 * (pressure - reference) / FLOW_SPEED**2
    return {"u": u, "v": v, "uu": uu, "vv": vv, "cp": cp, "sdf": sdf}


def world_centered_pressure_fields(
    grid: dict[str, np.ndarray | float],
    center_grid: np.ndarray,
    nu: int = 360,
    nv: int = 260,
) -> dict[str, np.ndarray | float]:
    """Sample pressure locally without rotating away the swimmer's global pose."""
    u = np.linspace(-0.82, 0.82, nu)
    v = np.linspace(-0.62, 0.62, nv)
    uu, vv = np.meshgrid(u, v)
    x_world = center_grid[0] + BODY_LENGTH_GRID * uu
    y_world = center_grid[1] + BODY_LENGTH_GRID * vv
    pressure = bilinear(grid["pressure"], x_world, y_world, grid)
    sdf = bilinear(grid["sdf"], x_world, y_world, grid)
    r = np.hypot(uu, vv)
    reference = np.nanmedian(pressure[(r > 0.64) & (sdf > 2.0)])
    cp = 2.0 * (pressure - reference) / FLOW_SPEED**2
    return {"u": u, "v": v, "uu": uu, "vv": vv, "cp": cp, "sdf": sdf}


def contour_segments(
    u: np.ndarray, v: np.ndarray, sdf: np.ndarray
) -> list[np.ndarray]:
    fig, ax = plt.subplots(figsize=(1, 1))
    cs = ax.contour(u, v, sdf, levels=[0.0])
    segments = [segment.copy() for segment in cs.allsegs[0] if len(segment) > 3]
    plt.close(fig)
    return segments


def regular_grid_sample(
    values: np.ndarray, u: np.ndarray, v: np.ndarray, xy: np.ndarray
) -> np.ndarray:
    fx = (xy[:, 0] - u[0]) / (u[1] - u[0])
    fy = (xy[:, 1] - v[0]) / (v[1] - v[0])
    ix = np.clip(np.floor(fx).astype(int), 0, len(u) - 2)
    iy = np.clip(np.floor(fy).astype(int), 0, len(v) - 2)
    tx, ty = fx - ix, fy - iy
    return (
        (1 - tx) * (1 - ty) * values[iy, ix]
        + tx * (1 - ty) * values[iy, ix + 1]
        + (1 - tx) * ty * values[iy + 1, ix]
        + tx * ty * values[iy + 1, ix + 1]
    )


def resample_closed_curve(path: np.ndarray, count: int) -> np.ndarray:
    if np.linalg.norm(path[0] - path[-1]) > 1e-6:
        path = np.vstack([path, path[0]])
    increments = np.linalg.norm(np.diff(path, axis=0), axis=1)
    arclength = np.concatenate([[0.0], np.cumsum(increments)])
    targets = np.linspace(0.0, arclength[-1], count, endpoint=False)
    return np.column_stack(
        [
            np.interp(targets, arclength, path[:, 0]),
            np.interp(targets, arclength, path[:, 1]),
        ]
    )


def add_surface_pressure_vectors(
    ax: plt.Axes,
    fields: dict[str, np.ndarray | float],
    cp_limit: float,
    count: int = 78,
) -> None:
    u = fields["u"]
    v = fields["v"]
    cp = fields["cp"]
    sdf = fields["sdf"]
    path = max(contour_segments(u, v, sdf), key=lambda curve: len(curve))
    points = resample_closed_curve(path, count)
    tangents = np.roll(points, -3, axis=0) - np.roll(points, 3, axis=0)
    tangents /= np.linalg.norm(tangents, axis=1)[:, np.newaxis]
    normals = np.column_stack([-tangents[:, 1], tangents[:, 0]])

    # Choose the normal that points from the body into the positive-SDF fluid.
    probe = 0.026
    sdf_plus = regular_grid_sample(sdf, u, v, points + probe * normals)
    sdf_minus = regular_grid_sample(sdf, u, v, points - probe * normals)
    normals[sdf_plus < sdf_minus] *= -1.0

    surface_cp = regular_grid_sample(cp, u, v, points + probe * normals)
    smoothing_kernel = np.array([1, 2, 3, 4, 5, 4, 3, 2, 1], dtype=float)
    smoothing_kernel /= smoothing_kernel.sum()
    surface_cp = np.convolve(
        np.pad(surface_cp, (4, 4), mode="wrap"),
        smoothing_kernel,
        mode="valid",
    )
    signed_magnitude = np.clip(surface_cp / cp_limit, -1.0, 1.0)
    vector_length = 0.215 * signed_magnitude
    ax.fill(
        path[:, 0],
        path[:, 1],
        facecolor="#f7f7f7",
        edgecolor="#858585",
        linewidth=0.40,
        zorder=2,
    )
    colors = np.where(surface_cp >= 0.0, PRIMARY_RED, PRIMARY_BLUE)
    quiver_style = {
        "angles": "xy",
        "scale_units": "xy",
        "scale": 1.0,
        "width": 0.0030,
        "headwidth": 4.2,
        "headlength": 5.2,
        "headaxislength": 4.3,
        "pivot": "tail",
        "alpha": 1.0,
        "zorder": 3,
    }
    ax.quiver(
        points[:, 0],
        points[:, 1],
        normals[:, 0] * vector_length,
        normals[:, 1] * vector_length,
        color=colors,
        **quiver_style,
    )


def rolling_mean(time: np.ndarray, values: np.ndarray, width_T: float = 0.20) -> np.ndarray:
    if len(time) < 3:
        return values
    dt = np.nanmedian(np.diff(time))
    window = max(1, int(round(width_T / dt)))
    kernel = np.ones(window) / window
    return np.convolve(values, kernel, mode="same")


def module_magnitude(data: dict[str, np.ndarray], prefix: str) -> np.ndarray:
    a1 = data[f"{prefix}_clipped_effect_a1"]
    a2 = data[f"{prefix}_clipped_effect_a2"]
    return np.hypot(a1, a2)


def add_panel_label(ax: plt.Axes, label: str, x: float = -0.10, y: float = 1.06) -> None:
    ax.text(
        x,
        y,
        label,
        transform=ax.transAxes,
        fontsize=10,
        fontweight="bold",
        ha="left",
        va="bottom",
    )


def style_axis(ax: plt.Axes) -> None:
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.tick_params(direction="out", length=2.5, width=0.7, pad=2)


def main() -> None:
    args = parse_args()
    if args.verify_inputs and not args.skip_input_verification:
        verify_input_manifest(args.source_manifest)
    results = args.run_root
    architecture = load_policy_architecture(args.policy_dir)
    case_dir = results
    diagnostics = read_csv_numeric(case_dir / "phase_0.csv")
    frames = read_rows(case_dir / "frames.csv")
    frame_ids = [0, 1, 2]
    stage_names = ["release", "redirect", "capture"]
    stage_times = [float(frames[i]["sim_time"]) - 200.0 for i in frame_ids]
    stage_centers = [
        np.array([float(frames[i]["center_x"]), float(frames[i]["center_y"])])
        for i in frame_ids
    ]
    stage_headings = [float(frames[i]["heading"]) for i in frame_ids]
    frame_paths = []
    for i in frame_ids:
        archived_path = Path(frames[i]["frame_path"])
        local_path = case_dir / archived_path.name
        frame_paths.append(archived_path if archived_path.is_file() else local_path)
    stage_grids = [grid_arrays(path) for path in frame_paths]
    local_fields = [
        body_aligned_fields(grid, center, heading)
        for grid, center, heading in zip(stage_grids, stage_centers, stage_headings)
    ]
    pressure_fields = [
        world_centered_pressure_fields(grid, center)
        for grid, center in zip(stage_grids, stage_centers)
    ]

    cp_values = []
    for fields in pressure_fields:
        fluid = (fields["sdf"] > 0.0) & np.isfinite(fields["cp"])
        cp_values.append(np.abs(fields["cp"][fluid]))
    cp_limit = float(np.nanpercentile(np.concatenate(cp_values), 98.0))
    cp_limit = max(5.0, cp_limit)
    plt.rcParams.update(
        {
            "font.family": "sans-serif",
            "font.sans-serif": ["DejaVu Sans", "Arial", "Helvetica"],
            "font.size": 7.3,
            "axes.linewidth": 0.7,
            "xtick.major.width": 0.7,
            "ytick.major.width": 0.7,
            "svg.fonttype": "none",
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )
    fig = plt.figure(figsize=(7.2, 7.4), constrained_layout=False)
    outer = fig.add_gridspec(
        7,
        3,
        # Explicit spacer rows make the C--D gap independently adjustable.
        # The other two gaps retain the previous visual breathing room.
        height_ratios=[2.35, 0.34, 1.50, 0.22, 1.98, 0.82, 1.28],
        hspace=0.00,
        wspace=0.38,
        left=0.105,
        right=0.935,
        top=0.965,
        bottom=0.062,
    )

    top_spec = outer[0, :].subgridspec(1, 2, wspace=0.30)

    # a | Direct source-level growth across the archived milestone policies.
    ax_growth = fig.add_subplot(top_spec[0, 0])
    milestone_x = np.arange(len(architecture), dtype=float)
    seed = architecture[0]
    architecture_series = [
        ("code_lines", "code lines", PRIMARY_BLUE, "o"),
        ("parameter_count", "parameters", PRIMARY_RED, "s"),
        ("state_signal_count", "signals", SECONDARY_SLATE, "^"),
    ]
    for field, label, color, marker in architecture_series:
        values = np.asarray([float(row[field]) for row in architecture])
        ratios = values / float(seed[field])
        ax_growth.plot(
            milestone_x,
            ratios,
            color=color,
            marker=marker,
            markerfacecolor="white",
            markeredgecolor=color,
            markeredgewidth=0.75,
            markersize=3.2,
            linewidth=1.15,
            label=label,
            zorder=3,
        )
        ax_growth.text(
            milestone_x[-1] + 0.10,
            ratios[-1],
            f"{ratios[-1]:.1f}$\\times$",
            color=color,
            fontsize=6.1,
            ha="left",
            va="center",
        )
    ax_growth.set_xticks(milestone_x, ["Seed", "1", "6", "7", "12", "18", "19"])
    ax_growth.set_yticks([1, 3, 5, 7])
    ax_growth.set(
        xlim=(-0.25, len(architecture) - 0.32),
        ylim=(0.72, 7.75),
        xlabel="evolution iteration",
        ylabel="count / Seed",
    )
    ax_growth.set_box_aspect(0.60)
    style_axis(ax_growth)
    ax_growth.set_title(
        "Policy complexity",
        fontsize=8.2,
        loc="left",
        pad=4,
    )
    growth_legend = ax_growth.legend(
        frameon=False,
        ncol=3,
        loc="upper left",
        bbox_to_anchor=(0.01, 0.985),
        borderaxespad=0.2,
        handlelength=1.35,
        columnspacing=0.75,
        fontsize=5.8,
    )
    # Blue review text marks the revised terminology without changing the data.
    growth_legend.get_texts()[0].set_color(PRIMARY_BLUE)
    add_panel_label(ax_growth, "a", x=-0.14, y=1.01)

    # b | A single mature policy navigating the unsteady cylinder wake.
    ax_a = fig.add_subplot(top_spec[0, 1])
    release_grid = stage_grids[0]
    redirect_grid = stage_grids[1]
    capture_grid = stage_grids[2]
    release_vort = release_grid["vorticity"]
    redirect_vort = redirect_grid["vorticity"]
    capture_vort = capture_grid["vorticity"]
    release_sdf = release_grid["sdf"]
    redirect_sdf = redirect_grid["sdf"]
    capture_sdf = capture_grid["sdf"]
    x_L = redirect_grid["x"] / BODY_LENGTH_GRID
    y_L = redirect_grid["y"] / BODY_LENGTH_GRID
    xlim = (7.5, 22.25)
    # Preserve the original panel height after shortening its width.  With an
    # equal spatial scale, the taller field of view therefore includes more of
    # the cross-stream domain instead of compressing the original crop.
    ylim = (6.80, 16.00)
    xmask = (x_L >= xlim[0]) & (x_L <= xlim[1])
    ymask = (y_L >= ylim[0]) & (y_L <= ylim[1])
    release_crop = release_vort[np.ix_(ymask, xmask)]
    redirect_crop = redirect_vort[np.ix_(ymask, xmask)]
    capture_crop = capture_vort[np.ix_(ymask, xmask)]
    release_sdf_crop = release_sdf[np.ix_(ymask, xmask)]
    redirect_sdf_crop = redirect_sdf[np.ix_(ymask, xmask)]
    capture_sdf_crop = capture_sdf[np.ix_(ymask, xmask)]
    crop_x_L = x_L[xmask]
    crop_y_L = y_L[ymask]

    # Use the capture-time field upstream of a visible splice and the
    # redirect-time field downstream.  Reserve the compact upper-right region
    # for the release frame so that it shows the swimmer's own nascent wake
    # without importing the larger structures passing below it.
    splice_x_L = xlim[0] + 0.70 * (xlim[1] - xlim[0])
    splice_y_L = 13.20
    capture_side = crop_x_L < splice_x_L
    composite_vort = np.where(
        capture_side[np.newaxis, :], capture_crop, redirect_crop
    )
    composite_sdf = np.where(
        capture_side[np.newaxis, :], capture_sdf_crop, redirect_sdf_crop
    )
    release_region = (
        (crop_y_L[:, np.newaxis] >= splice_y_L)
        & (crop_x_L[np.newaxis, :] >= splice_x_L)
    )
    composite_vort = np.where(release_region, release_crop, composite_vort)
    composite_sdf = np.where(release_region, release_sdf_crop, composite_sdf)
    vertical_gap = np.abs(crop_x_L - splice_x_L) < 0.035
    horizontal_gap = (
        (np.abs(crop_y_L[:, np.newaxis] - splice_y_L) < 0.035)
        & (crop_x_L[np.newaxis, :] >= splice_x_L)
    )
    composite_mask = (
        (composite_sdf <= 0.0)
        | vertical_gap[np.newaxis, :]
        | horizontal_gap
    )

    vort_limit = 0.8
    # Match the original Aqua watch renderer's colour interpolation exactly:
    # white to blue for negative vorticity and white to red for positive
    # vorticity, using the same fixed raw-vorticity range as Figures 2 and 3.
    fig2_flow_cmap = matplotlib.colors.LinearSegmentedColormap.from_list(
        "blue_white_red_zero_white",
        ["#2166AC", "#FFFFFF", "#B2182B"],
    )
    image = ax_a.imshow(
        np.ma.masked_where(composite_mask, composite_vort),
        extent=(x_L[xmask][0], x_L[xmask][-1], y_L[ymask][0], y_L[ymask][-1]),
        origin="lower",
        cmap=fig2_flow_cmap,
        vmin=-vort_limit,
        vmax=vort_limit,
        interpolation="bilinear",
        rasterized=True,
        alpha=1.0,
    )
    trajectory_x = diagnostics["center_x_L"]
    trajectory_y = diagnostics["center_y_L"]
    trajectory_line = ax_a.plot(
        trajectory_x,
        trajectory_y,
        color="#151515",
        linewidth=1.05,
        zorder=8,
    )[0]
    trajectory_line.set_path_effects(
        [pe.Stroke(linewidth=1.55, foreground="white"), pe.Normal()]
    )
    ax_a.axvline(splice_x_L, color="white", linewidth=1.15, zorder=7)
    ax_a.hlines(
        splice_y_L,
        splice_x_L,
        xlim[1],
        color="white",
        linewidth=1.15,
        zorder=7,
    )
    ax_a.add_patch(
        Circle(
            TARGET_L,
            CAPTURE_RADIUS_L,
            facecolor="none",
            edgecolor="#202020",
            linewidth=1.2,
            linestyle=(0, (4, 2)),
            zorder=7,
        )
    )
    ax_a.scatter(*TARGET_L, s=18, marker="*", color="#202020", zorder=8)

    pose_label_offsets = [(-0.50, 0.55), (-0.90, 0.55), (0.35, 0.45)]
    for idx, (name, center, heading, fields, label_offset) in enumerate(
        zip(
            stage_names,
            stage_centers,
            stage_headings,
            local_fields,
            pose_label_offsets,
        )
    ):
        for path in contour_segments(fields["u"], fields["v"], fields["sdf"]):
            c, s = np.cos(heading), np.sin(heading)
            world_x = center[0] / BODY_LENGTH_GRID + c * path[:, 0] - s * path[:, 1]
            world_y = center[1] / BODY_LENGTH_GRID + s * path[:, 0] + c * path[:, 1]
            ax_a.fill(
                world_x,
                world_y,
                facecolor="white",
                edgecolor="#202020",
                linewidth=0.55,
                joinstyle="round",
                zorder=9,
            )
        label_x = center[0] / BODY_LENGTH_GRID + label_offset[0]
        label_y = center[1] / BODY_LENGTH_GRID + label_offset[1]
        pose_label = ax_a.text(
            label_x,
            label_y,
            name,
            color=STAGE_COLORS[idx],
            fontsize=6.6,
            fontweight="bold",
            ha="right" if label_offset[0] < 0 else "left",
            va="center",
            zorder=10,
        )
        pose_label.set_path_effects(
            [pe.Stroke(linewidth=2.4, foreground="white"), pe.Normal()]
        )
    ax_a.set(xlim=xlim, ylim=ylim)
    ax_a.set_aspect("equal", adjustable="box")
    ax_a.set_xticks([])
    ax_a.set_yticks([])
    ax_a.tick_params(bottom=False, left=False, labelbottom=False, labelleft=False)
    ax_a.set_title(
        "Final policy in the unsteady wake",
        fontsize=8.2,
        loc="left",
        pad=4,
    )
    cbar_a = fig.colorbar(image, ax=ax_a, fraction=0.022, pad=0.012)
    cbar_a.set_ticks([-vort_limit, 0.0, vort_limit])
    cbar_a.ax.set_title(r"$\omega$", fontsize=7.0, pad=2.0)
    add_panel_label(ax_a, "b", x=-0.12, y=1.01)

    # c | Body-normal surface-pressure vectors at the same three stages.
    pressure_spec = outer[2, :].subgridspec(
        2,
        3,
        height_ratios=[0.13, 1.0],
        hspace=-0.02,
        wspace=0.04,
    )
    pressure_header = fig.add_subplot(pressure_spec[0, :])
    pressure_header.axis("off")
    pressure_header.text(
        -0.06,
        0.55,
        "c",
        transform=pressure_header.transAxes,
        fontsize=10,
        fontweight="bold",
        ha="left",
        va="center",
    )
    pressure_header.text(
        0.00,
        0.55,
        "Surface-pressure loading during navigation",
        transform=pressure_header.transAxes,
        fontsize=8.2,
        ha="left",
        va="center",
    )
    pressure_axes = []
    for idx, (fields, name, time_T) in enumerate(
        zip(pressure_fields, stage_names, stage_times)
    ):
        ax = fig.add_subplot(pressure_spec[1, idx])
        pressure_axes.append(ax)
        add_surface_pressure_vectors(ax, fields, cp_limit)
        ax.text(
            0.50,
            0.025,
            f"{name}  " + rf"$t={time_T:.1f}$",
            transform=ax.transAxes,
            fontsize=7.0,
            ha="center",
            va="bottom",
        )
        ax.set(xlim=(-0.57, 0.57), ylim=(-0.31, 0.37))
        ax.set_aspect("equal", adjustable="box")
        ax.axis("off")

    # d--e | Dedicated heading row keeps panel letters and titles on one
    # baseline and prevents the headings from drifting into panel c.
    mechanism_spec = outer[4, :].subgridspec(
        2,
        3,
        height_ratios=[0.30, 1.0],
        hspace=0.00,
        wspace=0.38,
    )
    trace_header = fig.add_subplot(mechanism_spec[0, :2])
    trace_header.axis("off")
    trace_header.text(
        -0.09,
        0.72,
        "d",
        transform=trace_header.transAxes,
        fontsize=10,
        fontweight="bold",
        ha="left",
        va="center",
    )
    trace_header.text(
        0.00,
        0.72,
        "Module-removal counterfactuals and hydrodynamic tuning",
        transform=trace_header.transAxes,
        fontsize=8.2,
        ha="left",
        va="center",
    )
    trace_header.legend(
        handles=[
            Line2D([0], [0], color=MODULE_COLORS["bearing"], lw=1.15, label="bearing"),
            Line2D([0], [0], color=MODULE_COLORS["asymmetry"], lw=1.15, label="half-cycle asym."),
            Line2D([0], [0], color=MODULE_COLORS["burst"], lw=1.15, label="redirect burst"),
        ],
        frameon=False,
        ncol=3,
        loc="lower center",
        bbox_to_anchor=(0.57, -0.06),
        handlelength=1.6,
        columnspacing=0.9,
    )
    robustness_header = fig.add_subplot(mechanism_spec[0, 2])
    robustness_header.axis("off")
    robustness_header.text(
        -0.20,
        0.58,
        "e",
        transform=robustness_header.transAxes,
        fontsize=10,
        fontweight="bold",
        ha="left",
        va="center",
    )
    robustness_header.text(
        0.50,
        0.58,
        "Wake-phase robustness\nof one frozen policy",
        transform=robustness_header.transAxes,
        fontsize=8.2,
        ha="center",
        va="center",
    )

    # d | Time-resolved control-to-loading chain during redirection.
    trace_spec = mechanism_spec[1, :2].subgridspec(2, 1, hspace=0.10)
    trace_axes = [fig.add_subplot(trace_spec[i, 0]) for i in range(2)]
    time = diagnostics["episode_time_T"]
    window = (time >= 6.0) & (time <= 16.0)
    for prefix, label, color in [
        ("bearing_steering", "bearing", MODULE_COLORS["bearing"]),
        ("phase_asymmetry", "half-cycle asym.", MODULE_COLORS["asymmetry"]),
        ("response_burst", "redirect burst", MODULE_COLORS["burst"]),
    ]:
        magnitude = rolling_mean(time, module_magnitude(diagnostics, prefix))
        trace_axes[0].plot(time[window], magnitude[window], color=color, lw=1.15, label=label)
    trace_axes[0].set_ylabel("module\noutput")
    trace_axes[1].plot(time[window], diagnostics["yaw_moment_z_L2"][window], color=PRIMARY_BLUE, lw=1.0)
    trace_axes[1].axhline(0, color="#777777", lw=0.45)
    trace_axes[1].set(
        ylabel="yaw moment",
        xlabel="episode time, $t$",
        yticks=[-3, 0, 3],
    )
    for idx, ax in enumerate(trace_axes):
        ax.set_xlim(6, 16)
        style_axis(ax)
        if idx < 1:
            ax.set_xticklabels([])

    # e | Same frozen policy captures under three instantaneous wake states.
    ax_d = fig.add_subplot(mechanism_spec[1, 2])
    for phase_index in range(3):
        data = read_csv_numeric(
            results / f"phase_{phase_index}.csv"
        )
        t = data["episode_time_T"]
        distance = data["distance_L"]
        ax_d.plot(t, distance, color=PHASE_COLORS[phase_index], lw=1.25, label=f"wake state {phase_index + 1}")
    ax_d.axhline(CAPTURE_RADIUS_L, color="#333333", lw=0.8, linestyle=(0, (4, 2)))
    ax_d.text(1.0, CAPTURE_RADIUS_L + 0.38, "capture radius", fontsize=6.2, color="#333333")
    ax_d.set(xlabel="episode time, $t$", ylabel="distance to target / $L$", xlim=(0, 38), ylim=(0, 13.0))
    ax_d.legend(frameon=False, loc="upper right", fontsize=6.4, handlelength=1.6)
    style_axis(ax_d)
    # f | One-family-at-a-time ablations of the final policy.
    ax_e = fig.add_subplot(outer[6, :])
    rows = read_rows(results / "ablation.csv")
    order = [
        ("bearing_steering", "bearing steering"),
        ("phase_asymmetry", "half-cycle asymmetry"),
        ("response_burst", "redirect burst"),
        ("crossflow_force_assistance", "crossflow/force term"),
        ("moment_assistance", "moment term"),
        ("speed_release", "speed-release term"),
    ]
    y_positions = np.arange(len(order))[::-1]
    for y, (key, label) in zip(y_positions, order):
        group = [row for row in rows if row["ablation"] == key]
        if key == "bearing_steering":
            ax_e.scatter([14.2], [y], marker="X", s=42, color="#b12c2c", zorder=4)
            ax_e.text(13.75, y, "capture lost (0/3)", ha="right", va="center", color="#8d2020", fontsize=6.8)
            continue
        values = np.array([float(row["delta_time_to_capture_T"]) for row in group])
        jitter = np.linspace(-0.12, 0.12, len(values))
        ax_e.scatter(values, y + jitter, s=19, facecolor="white", edgecolor="#3b3b3b", linewidth=0.7, zorder=3)
        ax_e.scatter([values.mean()], [y], marker="D", s=28, color="#202020", zorder=4)
        ax_e.plot([values.min(), values.max()], [y, y], color="#777777", lw=0.75, zorder=2)
        if abs(values.mean()) < 0.5:
            ax_e.text(0.55, y, f"mean {values.mean():+.2f}", ha="left", va="center", fontsize=6.2)
        else:
            ax_e.text(
                values.mean() + (0.25 if values.mean() >= 0 else -0.25),
                y - 0.32,
                f"mean {values.mean():+.2f}",
                ha="left" if values.mean() >= 0 else "right",
                va="top",
                fontsize=6.2,
            )
    ax_e.axvline(0, color="#555555", lw=0.8)
    ax_e.set_yticks(y_positions, [])
    ax_e.set(
        xlim=(-4.0, 15.3),
        xlabel=r"change in capture time after removal, $\Delta t_{\mathrm{cap}}$",
    )
    for y, (key, label) in zip(y_positions, order):
        label_x = -0.80 if key == "speed_release" else -0.55
        ax_e.text(label_x, y, label, ha="right", va="center", fontsize=7.0)
    # Long category and value labels occupy the plotting field; vertical grid
    # lines would run through them and reduce readability at final size.
    ax_e.grid(False)
    ax_e.set_axisbelow(True)
    style_axis(ax_e)
    add_panel_label(ax_e, "f", x=-0.055, y=1.04)
    ax_e.set_title("Paired final-policy ablations across three matched wake releases", fontsize=8.2, pad=5)
    ax_e.legend(
        handles=[
            Line2D([0], [0], marker="o", color="none", markerfacecolor="white", markeredgecolor="#3b3b3b", label="individual release"),
            Line2D([0], [0], marker="D", color="none", markerfacecolor="#202020", markeredgecolor="#202020", label="mean"),
        ],
        loc="lower right",
        frameon=False,
        ncol=2,
        fontsize=6.4,
    )

    from panels import save_panel
    groups = {
        "a": [ax_growth],
        "b": [ax_a, cbar_a.ax],
        "c": [pressure_header, *pressure_axes],
        "d": [trace_header, *trace_axes],
        "e": [robustness_header, ax_d],
        "f": [ax_e],
    }
    for label, axes in groups.items():
        save_panel(fig, args.out_dir / ("figure_04_" + label), axes=axes)
    plt.close(fig)
    print("Generated all six Figure 4 panels.")

if __name__ == "__main__":
    main()
