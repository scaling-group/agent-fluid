#!/usr/bin/env python3
"""Render a 3D mid-plane in the light vorticity style used by the 2D case."""

import argparse
import csv
import hashlib
import json
import re
from pathlib import Path

import imageio.v2 as imageio
import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
import numpy as np
import pyvista as pv


def read_rows(vtk_dir: Path):
    with (vtk_dir / "frames.csv").open(newline="") as handle:
        rows = list(csv.DictReader(handle))
    for row in rows:
        row["frame_path"] = str(vtk_dir / Path(row["frame_path"]).name)
    if not rows:
        raise RuntimeError("VTK manifest contains no frames")
    return rows


def read_config_list(config_path, key):
    text = Path(config_path).read_text()
    match = re.search(rf"(?m)^\s*{re.escape(key)}\s*=\s*\[([^]]+)\]", text)
    if match is None:
        raise RuntimeError(f"missing {key} in {config_path}")
    return [float(item.strip()) for item in match.group(1).split(",")]


def reshape_point_field(grid, field):
    values = np.asarray(grid[field])
    if values.ndim == 1:
        return values.reshape(grid.dimensions, order="F")
    return values.reshape((*grid.dimensions, values.shape[1]), order="F")


def midplane_fields(grid, L):
    velocity = reshape_point_field(grid, "Velocity")
    sdf = reshape_point_field(grid, "BodySDF")
    nz = grid.dimensions[2]
    kz = max(1, min(nz - 2, int(round(nz / 2.0)) - 1))
    u = velocity[..., 0]
    v = velocity[..., 1]
    omega_z = np.zeros(u.shape, dtype=np.float32)
    omega_z[1:, 1:, :] = (
        v[1:, 1:, :] - v[:-1, 1:, :]
        - u[1:, 1:, :]
        + u[1:, :-1, :]
    ) * float(L)
    return omega_z[1:-1, 1:-1, kz], sdf[1:-1, 1:-1, kz]


def select_fish_mask(sdf, fish_center):
    solid = sdf <= 0.0
    labels = np.zeros(solid.shape, dtype=np.int32)
    count = 0
    nx, ny = solid.shape
    for seed_x, seed_y in np.argwhere(solid):
        if labels[seed_x, seed_y] != 0:
            continue
        count += 1
        labels[seed_x, seed_y] = count
        stack = [(int(seed_x), int(seed_y))]
        while stack:
            x, y = stack.pop()
            for dx in (-1, 0, 1):
                for dy in (-1, 0, 1):
                    if dx == 0 and dy == 0:
                        continue
                    xx, yy = x + dx, y + dy
                    if 0 <= xx < nx and 0 <= yy < ny and solid[xx, yy] and labels[xx, yy] == 0:
                        labels[xx, yy] = count
                        stack.append((xx, yy))
    if count == 0:
        raise RuntimeError("mid-plane BodySDF contains no solid components")
    best_label = None
    best_distance = float("inf")
    for label_id in range(1, count + 1):
        indices = np.argwhere(labels == label_id)
        if not indices.size:
            continue
        center = indices.mean(axis=0) + 0.5
        distance = float(np.linalg.norm(center - fish_center))
        if distance < best_distance:
            best_distance = distance
            best_label = label_id
    if best_label is None:
        raise RuntimeError("could not identify fish BodySDF component")
    return labels == best_label


def render_frame(grid, row, report, cylinder_geometry, plot_clim, size):
    L = float(report["runtime_resolution"])
    omega, sdf = midplane_fields(grid, L)
    nx, ny = omega.shape
    if report.get("fish_motion") == "held_fixed":
        fish_center = np.asarray(report["fish_initial_center_L"][:2], dtype=float) * L
    else:
        fish_center = np.asarray([row["center_x"], row["center_y"]], dtype=float)
    fish_mask = select_fish_mask(sdf, fish_center)

    dpi = 120
    fig, ax = plt.subplots(figsize=(size[0] / dpi, size[1] / dpi), dpi=dpi)
    ax.imshow(
        omega.T,
        origin="lower",
        extent=(0.0, float(nx), 0.0, float(ny)),
        cmap="RdBu",
        vmin=-plot_clim,
        vmax=plot_clim,
        interpolation="bilinear",
        aspect="equal",
    )
    ax.contourf(
        np.arange(nx, dtype=float) + 0.5,
        np.arange(ny, dtype=float) + 0.5,
        fish_mask.T.astype(float),
        levels=(0.5, 1.5),
        colors=("#f5a623",),
        alpha=0.88,
    )
    ax.contour(
        np.arange(nx, dtype=float) + 0.5,
        np.arange(ny, dtype=float) + 0.5,
        fish_mask.T.astype(float),
        levels=(0.5,),
        colors=("white",),
        linewidths=0.8,
    )

    xs, ys, diameters = cylinder_geometry
    for x, y, diameter in zip(xs, ys, diameters):
        ax.add_patch(
            Circle(
                (x * L, y * L),
                radius=0.5 * diameter * L,
                facecolor="#333333",
                edgecolor="white",
                linewidth=0.8,
                zorder=5,
            )
        )

    target = np.asarray(report["target_L"][:2], dtype=float) * L
    target_radius = float(report["success_radius_L"]) * L
    ax.add_patch(
        Circle(
            target,
            radius=target_radius,
            fill=False,
            edgecolor="#00ee22",
            linewidth=1.5,
            zorder=6,
        )
    )
    ax.scatter(
        [target[0]],
        [target[1]],
        s=10,
        facecolor="#00ee22",
        edgecolor="black",
        linewidth=0.6,
        zorder=7,
    )
    ax.set_xlim(0.0, float(nx))
    ax.set_ylim(0.0, float(ny))
    ax.set_aspect("equal", adjustable="box")
    motion_label = (
        "held prewarm" if report.get("fish_motion") == "held_fixed" else
        "prescribed straight-gait free swim" if report.get("control_mode") == "prescribed_straight_gait" else
        "seed-policy free swim"
    )
    frame_time = float(row["sim_time"]) - float(report.get("start_dimensionless_time", 0.0))
    ax.set_title(
        "3D multiwake mid-plane · "
        f"L={int(L)} · z=L · {motion_label} "
        f"{frame_time:.2f} / {float(report['horizon']):.2f} t*",
        fontsize=15,
    )
    fig.tight_layout(pad=0.8)
    fig.canvas.draw()
    image = np.asarray(fig.canvas.buffer_rgba())[..., :3].copy()
    plt.close(fig)
    return image


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-dir", required=True)
    parser.add_argument("--fps", type=int, default=4)
    parser.add_argument("--plot-clim", type=float, default=0.8)
    parser.add_argument("--width", type=int, default=1152)
    parser.add_argument("--height", type=int, default=1152)
    args = parser.parse_args()

    run_dir = Path(args.run_dir).resolve()
    report_path = run_dir / "prewarm_report.json"
    if not report_path.is_file():
        report_path = run_dir / "policy_smoke_report.json"
    report = json.loads(report_path.read_text())
    is_held = report.get("fish_motion") == "held_fixed"
    if is_held and (report.get("status") != "ok" or report.get("termination") != "horizon"):
        raise RuntimeError("refusing to render an incomplete prewarm")
    if not report.get("fish_present"):
        raise RuntimeError("report does not contain a fish")
    required = {"Velocity", "BodySDF"}
    rows = read_rows(run_dir / "vtk")
    final_grid = pv.read(rows[-1]["frame_path"])
    missing = required - set(final_grid.point_data.keys())
    if missing:
        raise RuntimeError(f"final VTK frame is missing required fields: {sorted(missing)}")

    config_path = report["config_path"]
    cylinder_geometry = (
        read_config_list(config_path, "cylinder_centers_x_L"),
        read_config_list(config_path, "cylinder_centers_y_L"),
        read_config_list(config_path, "cylinder_diameters_L"),
    )
    if any(len(values) != int(report["cylinder_count"]) for values in cylinder_geometry):
        raise RuntimeError("cylinder geometry does not match report cylinder_count")

    render_dir = run_dir / "render3d" / "topdown_2d_style"
    frames_dir = render_dir / "frames"
    frames_dir.mkdir(parents=True, exist_ok=True)
    frame_paths = []
    for index, row in enumerate(rows):
        grid = pv.read(row["frame_path"])
        image = render_frame(
            grid,
            row,
            report,
            cylinder_geometry,
            args.plot_clim,
            (args.width, args.height),
        )
        frame_path = frames_dir / f"frame_{index:04d}.png"
        imageio.imwrite(frame_path, image)
        frame_paths.append(frame_path)
        print(f"rendered 2D-style top-down {index + 1}/{len(rows)}", flush=True)

    artifact_stem = (
        "projected_multiwake_prewarm3d_current" if is_held else
        "projected_multiwake_straight_swim3d" if report.get("control_mode") == "prescribed_straight_gait" else
        "projected_multiwake_seed_policy3d"
    )
    mp4_path = render_dir / f"{artifact_stem}_topdown_2d_style_L{int(report['runtime_resolution'])}.mp4"
    with imageio.get_writer(
        mp4_path,
        fps=args.fps,
        codec="libx264",
        quality=8,
        macro_block_size=2,
        ffmpeg_log_level="error",
    ) as writer:
        for frame_path in frame_paths:
            writer.append_data(imageio.imread(frame_path))
    final_png = render_dir / f"{artifact_stem}_topdown_2d_style_final.png"
    final_png.write_bytes(frame_paths[-1].read_bytes())
    summary = {
        "schema_version": "dogfish.projected_multiwake_prewarm3d.topdown_2d_style.v1",
        "renderer_path": str(Path(__file__).resolve()),
        "renderer_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "source_report": str(report_path),
        "representation": "z=L WaterLily-compatible vorticity-z reconstructed from 3D Velocity",
        "vorticity_scale": "L/U with simulation U=1",
        "plot_clim": [-args.plot_clim, args.plot_clim],
        "colormap": "RdBu",
        "frame_count": len(frame_paths),
        "first_sim_time": float(rows[0]["sim_time"]),
        "final_sim_time": float(rows[-1]["sim_time"]),
        "fps": args.fps,
        "width": args.width,
        "height": args.height,
        "mp4": str(mp4_path),
        "final_png": str(final_png),
    }
    (render_dir / "render_summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(f"wrote {mp4_path}")


if __name__ == "__main__":
    main()
