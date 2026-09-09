from __future__ import annotations

import csv
import json
from collections import deque
from pathlib import Path
from paths import OUTPUT_DIR, external_output, DERIVED_DIR, INDEX_DIR

import matplotlib

matplotlib.use("Agg")
import matplotlib.patheffects as path_effects
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import numpy as np


ROOT = DERIVED_DIR / "supplementary_figure_03/data"
MOVING_ROOT = ROOT / "moving_window4x3"
FULL_ROOT = ROOT / "fullfield24x16"

PLOT_CLIM = 0.8
WINDOW_SIZE_L = np.asarray([4.0, 3.0])


def load_binary(path):
    with np.load(path, allow_pickle=False) as data:
        return float(data['elapsed']), data['omega'], data['occupancy']


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def component_near(solid: np.ndarray, center_index: np.ndarray) -> np.ndarray:
    labels = np.zeros(solid.shape, dtype=np.int32)
    components: list[list[tuple[int, int]]] = []
    nx, ny = solid.shape
    label = 0
    for seed in np.argwhere(solid):
        sx, sy = map(int, seed)
        if labels[sx, sy]:
            continue
        label += 1
        labels[sx, sy] = label
        queue = deque([(sx, sy)])
        points: list[tuple[int, int]] = []
        while queue:
            x, y = queue.popleft()
            points.append((x, y))
            for dx in (-1, 0, 1):
                for dy in (-1, 0, 1):
                    if dx == 0 and dy == 0:
                        continue
                    xx, yy = x + dx, y + dy
                    if (
                        0 <= xx < nx
                        and 0 <= yy < ny
                        and solid[xx, yy]
                        and not labels[xx, yy]
                    ):
                        labels[xx, yy] = label
                        queue.append((xx, yy))
        components.append(points)
    if not components:
        return np.zeros_like(solid)
    selected = min(
        range(len(components)),
        key=lambda index: np.linalg.norm(
            np.asarray(components[index]).mean(axis=0) - center_index
        ),
    )
    return labels == selected + 1


def load_run(root: Path) -> dict[str, object]:
    report = json.loads((root / "summary.json").read_text(encoding="utf-8"))
    frame_rows = read_csv(root / "midplane" / "frames.csv")
    row = frame_rows[-1]
    elapsed, omega, occupancy = load_binary(root / "midplane" / row["file"])
    trajectory_rows = read_csv(root / "trajectory.csv")
    trajectory = {
        "x": np.asarray([float(item["center_x_L"]) for item in trajectory_rows]),
        "y": np.asarray([float(item["center_y_L"]) for item in trajectory_rows]),
        "origin_x": np.asarray(
            [float(item.get("frame_origin_x_L", 0.0)) for item in trajectory_rows]
        ),
        "origin_y": np.asarray(
            [float(item.get("frame_origin_y_L", 0.0)) for item in trajectory_rows]
        ),
    }
    domain = np.asarray(report["domain_scale_L"][:2], dtype=float)
    origin = np.asarray(
        [float(row.get("frame_origin_x_L", 0.0)), float(row.get("frame_origin_y_L", 0.0))]
    )
    local_center = np.asarray(
        [
            float(row.get("local_center_x_L", row["center_x_L"])),
            float(row.get("local_center_y_L", row["center_y_L"])),
        ]
    )
    center_index = local_center * np.asarray(omega.shape) / domain
    solid = occupancy < 0.5
    fish = component_near(solid, center_index)
    return {
        "report": report,
        "elapsed": elapsed,
        "omega": omega,
        "solid": solid,
        "fish": fish,
        "domain": domain,
        "origin": origin,
        "trajectory": trajectory,
    }


moving = load_run(MOVING_ROOT)
full = load_run(FULL_ROOT)

# Preserve the earlier 3:2 panel proportion while limiting both panels to the
# portion of the virtual world relevant to the moving-window traversal.
x_limits = (3.25, 11.75)
y_mid = 0.5 * (2.5 + 5.875)
y_span = (x_limits[1] - x_limits[0]) / 1.5
y_limits = (y_mid - 0.5 * y_span, y_mid + 0.5 * y_span)

plt.rcParams.update(
    {
        "font.family": "DejaVu Sans",
        "font.size": 8.5,
        "axes.titlesize": 9.5,
        "axes.labelsize": 9.0,
        "axes.linewidth": 0.8,
        "xtick.labelsize": 8.0,
        "ytick.labelsize": 8.0,
        "axes.edgecolor": "#263442",
        "axes.labelcolor": "#263442",
        "xtick.color": "#263442",
        "ytick.color": "#263442",
        "xtick.major.width": 0.8,
        "ytick.major.width": 0.8,
        "xtick.major.size": 3.0,
        "ytick.major.size": 3.0,
    }
)


def draw_field(axis, run: dict[str, object], show_window: bool) -> None:
    omega = run["omega"]
    solid = run["solid"]
    fish = run["fish"]
    domain = run["domain"]
    origin = run["origin"]
    extent = (
        origin[0],
        origin[0] + domain[0],
        origin[1],
        origin[1] + domain[1],
    )
    axis.imshow(
        (omega * float(run["report"]["runtime_resolution"])).T,
        origin="lower",
        extent=extent,
        cmap="RdBu",
        vmin=-PLOT_CLIM,
        vmax=PLOT_CLIM,
        interpolation="bilinear",
        aspect="equal",
        zorder=1,
    )
    x = origin[0] + (np.arange(omega.shape[0]) + 0.5) * domain[0] / omega.shape[0]
    y = origin[1] + (np.arange(omega.shape[1]) + 0.5) * domain[1] / omega.shape[1]
    axis.contourf(
        x,
        y,
        solid.T.astype(float),
        levels=(0.5, 1.5),
        colors=("#4b5563",),
        alpha=0.92,
        zorder=2,
    )
    axis.contourf(
        x,
        y,
        fish.T.astype(float),
        levels=(0.5, 1.5),
        colors=("#f5a623",),
        alpha=0.98,
        zorder=5,
    )
    axis.contour(
        x,
        y,
        fish.T.astype(float),
        levels=(0.5,),
        colors=("#202020",),
        linewidths=0.7,
        zorder=6,
    )

    trajectory = run["trajectory"]
    if show_window:
        origins = np.column_stack((trajectory["origin_x"], trajectory["origin_y"]))
        unique_origins = np.unique(origins, axis=0)
        unique_origins = unique_origins[np.argsort(unique_origins[:, 0])]
        ghost_indices = np.unique(
            np.round(np.asarray([0.05, 0.37, 0.69]) * (len(unique_origins) - 1)).astype(int)
        )
        for ghost_index, alpha in zip(ghost_indices, (0.16, 0.25, 0.36), strict=False):
            ghost_origin = unique_origins[ghost_index]
            axis.add_patch(
                Rectangle(
                    ghost_origin,
                    domain[0],
                    domain[1],
                    fill=False,
                    edgecolor="#6f8290",
                    linewidth=0.75,
                    linestyle=(0, (3, 3)),
                    alpha=alpha,
                    zorder=3,
                )
            )

    axis.plot(
        trajectory["x"],
        trajectory["y"],
        color="#354553",
        linewidth=1.15,
        zorder=4,
        path_effects=[
            path_effects.Stroke(linewidth=2.5, foreground="white"),
            path_effects.Normal(),
        ],
    )

    if show_window:
        axis.add_patch(
            Rectangle(
                origin,
                domain[0],
                domain[1],
                fill=False,
                edgecolor="#526473",
                linewidth=0.9,
                linestyle=(0, (4, 3)),
                zorder=7,
            )
        )


figure, axes = plt.subplots(1, 2, figsize=(7.2, 2.75), constrained_layout=True)
titles = ("Moving window", "Full field")
runs = (moving, full)
for index, (axis, title, run) in enumerate(zip(axes, titles, runs, strict=True)):
    axis.set_facecolor("white")
    draw_field(axis, run, show_window=index == 0)
    axis.set_xlim(x_limits)
    axis.set_ylim(y_limits)
    axis.set_aspect("equal", adjustable="box")
    axis.set_xlabel(r"$x/L$")
    axis.set_ylabel(r"$y/L$")
    axis.set_title(
        title,
        loc="left",
        pad=10,
        color="#263442",
        fontweight="normal",
    )
    axis.text(
        -0.05,
        1.06,
        "ab"[index],
        transform=axis.transAxes,
        fontsize=10,
        fontweight="bold",
        color="#263442",
        ha="left",
        va="bottom",
    )
    axis.spines["top"].set_visible(False)
    axis.spines["right"].set_visible(False)

import argparse
from panels import save_panel
parser = argparse.ArgumentParser()
parser.add_argument("--output-dir", type=external_output, default=OUTPUT_DIR)
output = parser.parse_args().output_dir
figure.canvas.draw()
figure.set_layout_engine(None)
for letter, axis in zip("ab", axes):
    save_panel(figure, output / ("supplementary_figure_03_" + letter), axes=[axis])
plt.close(figure)
print("Generated both moving-window comparison panels.")
