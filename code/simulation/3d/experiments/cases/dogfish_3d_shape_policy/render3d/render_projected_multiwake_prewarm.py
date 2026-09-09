#!/usr/bin/env python3
"""Render held-prewarm or moving-policy projected-multiwake 3D VTK frames."""

import argparse
import csv
import hashlib
import json
import math
import re
from pathlib import Path

import imageio.v2 as imageio
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


def load_grid(path: str):
    grid = pv.read(path)
    if not list(grid.point_data.keys()):
        grid = grid.cell_data_to_point_data()
    nx, ny, nz = grid.dimensions
    return grid.extract_subset(voi=(2, nx - 3, 2, ny - 3, 2, nz - 3))


def lambda2_threshold(grid):
    values = np.asarray(grid["Lambda2"])
    negative = values[np.isfinite(values) & (values < 0)]
    if negative.size < 100:
        return -0.05
    return float(np.percentile(negative, 65.0))


def add_domain_box(plotter, dims):
    box = pv.Box(bounds=(0, dims[0], 0, dims[1], 0, dims[2]))
    plotter.add_mesh(box, style="wireframe", color="#7595b8", opacity=0.24, line_width=1)


def add_bodies(plotter, body, fish_center):
    if not body.n_points:
        return
    connected = body.connectivity()
    data = connected.cell_data.get("RegionId")
    association = "cell"
    if data is None:
        data = connected.point_data.get("RegionId")
        association = "point"
    if data is None:
        plotter.add_mesh(body, color="#e8edf5", smooth_shading=True, opacity=0.98)
        return
    regions = []
    for region_id in np.unique(np.asarray(data).astype(int)):
        region = connected.threshold(
            (region_id - 0.25, region_id + 0.25),
            scalars="RegionId",
            preference=association,
        ).extract_surface()
        if region.n_points:
            distance = float(np.linalg.norm(np.asarray(region.center) - fish_center))
            regions.append((distance, region))
    if not regions:
        return
    fish_index = int(np.argmin([item[0] for item in regions]))
    for index, (_, region) in enumerate(regions):
        is_fish = index == fish_index
        plotter.add_mesh(
            region,
            color="#f4a340" if is_fish else "#e8edf5",
            smooth_shading=True,
            specular=0.55 if is_fish else 0.30,
            roughness=0.28 if is_fish else 0.38,
            opacity=1.0 if is_fish else 0.94,
        )


def read_config_list(config_path, key):
    text = Path(config_path).read_text()
    match = re.search(rf"(?m)^\s*{re.escape(key)}\s*=\s*\[([^]]+)\]", text)
    if match is None:
        raise RuntimeError(f"missing {key} in {config_path}")
    return [float(item.strip()) for item in match.group(1).split(",")]


def add_topdown_cylinder_footprints(plotter, report, L):
    config_path = report["config_path"]
    xs = read_config_list(config_path, "cylinder_centers_x_L")
    ys = read_config_list(config_path, "cylinder_centers_y_L")
    diameters = read_config_list(config_path, "cylinder_diameters_L")
    if not (len(xs) == len(ys) == len(diameters) == int(report["cylinder_count"])):
        raise RuntimeError("cylinder geometry does not match report cylinder_count")
    for x, y, diameter in zip(xs, ys, diameters):
        cap = pv.Cylinder(
            center=(x * L, y * L, 1.99 * L),
            direction=(0.0, 0.0, 1.0),
            radius=0.5 * diameter * L,
            height=0.02 * L,
            resolution=64,
            capping=True,
        )
        plotter.add_mesh(
            cap,
            color="#e8edf5",
            smooth_shading=True,
            specular=0.30,
            roughness=0.38,
            opacity=0.94,
        )


def add_flow_scene(plotter, grid, row, report, threshold, show_cores=True):
    plotter.clear()
    plotter.set_background("#06101c", top="#102d49")
    body = grid.contour(isosurfaces=[0.0], scalars="BodySDF")
    cores = grid.contour(isosurfaces=[threshold], scalars="Lambda2") if show_cores else None
    L = float(report["runtime_resolution"])
    if report.get("fish_motion") == "held_fixed":
        fish_center = np.asarray(report["fish_initial_center_L"], dtype=float) * L
    else:
        fish_center = np.asarray(
            [row["center_x"], row["center_y"], row["z_plane"]], dtype=float
        )
    add_bodies(plotter, body, fish_center)
    if cores is not None and cores.n_points:
        cores = cores.sample(grid)
        velocity = np.asarray(cores["Velocity"])
        speed = np.linalg.norm(velocity, axis=1)
        finite_speed = speed[np.isfinite(speed)]
        cores["speed"] = speed
        upper = max(1.0e-6, float(np.percentile(finite_speed, 98)))
        plotter.add_mesh(
            cores,
            scalars="speed",
            cmap="turbo",
            clim=(0.0, upper),
            opacity=0.52,
            smooth_shading=True,
            show_scalar_bar=False,
        )

    dims = report["domain_dims"]
    add_domain_box(plotter, dims)
    target = np.asarray(report["target_L"], dtype=float) * L
    radius = float(report["success_radius_L"]) * L
    plotter.add_mesh(
        pv.Sphere(radius=radius, center=target, theta_resolution=48, phi_resolution=24),
        color="#57ff69",
        opacity=0.16,
    )
    plotter.add_mesh(pv.Sphere(radius=0.07 * L, center=target), color="#57ff69", opacity=0.95)
    return L


def add_topdown_core_slice(plotter, grid, threshold, L):
    midplane = grid.slice(normal=(0.0, 0.0, 1.0), origin=(8.0 * L, 8.0 * L, 1.0 * L))
    core_plane = midplane.threshold(
        value=threshold,
        scalars="Lambda2",
        invert=True,
        preference="point",
    )
    if not core_plane.n_points:
        return
    velocity = np.asarray(core_plane["Velocity"])
    speed = np.linalg.norm(velocity, axis=1)
    finite_speed = speed[np.isfinite(speed)]
    if not finite_speed.size:
        return
    core_plane["speed"] = speed
    upper = max(1.0e-6, float(np.percentile(finite_speed, 98)))
    plotter.add_mesh(
        core_plane,
        scalars="speed",
        cmap="turbo",
        clim=(0.0, upper),
        opacity=0.82,
        lighting=False,
        show_scalar_bar=False,
    )


def render_oblique_frame(plotter, grid, row, report, threshold, size):
    L = add_flow_scene(plotter, grid, row, report, threshold)
    domain = tuple(float(value) for value in report["domain_scale_L"])

    focus = (0.5 * domain[0] * L, 0.5 * domain[1] * L, 0.5 * domain[2] * L)
    distance = 1.5 * max(domain) * L
    azimuth = math.radians(-132.0)
    elevation = math.radians(27.0)
    camera = (
        focus[0] + distance * math.cos(elevation) * math.cos(azimuth),
        focus[1] + distance * math.cos(elevation) * math.sin(azimuth),
        focus[2] + distance * math.sin(elevation),
    )
    plotter.camera_position = [camera, focus, (0.0, 0.0, 1.0)]
    plotter.camera.view_angle = 35.0
    motion_label = (
        "held-fish prewarm" if report.get("fish_motion") == "held_fixed" else
        "prescribed straight-gait free swim" if report.get("control_mode") == "prescribed_straight_gait" else
        "seed-policy free swim"
    )
    frame_time = float(row["sim_time"]) - float(report.get("start_dimensionless_time", 0.0))
    plotter.add_text(
        f"Current 3D four-cylinder {motion_label}\n"
        f"t*={frame_time:.1f} / {float(report['horizon']):.0f}   "
        f"L={int(L)}   domain={domain[0]:g}L x {domain[1]:g}L x {domain[2]:g}L\n"
        "latest modeler body + caudal only | U=0.18 | Re=1000 | dt*=0.0055",
        position="upper_left",
        font_size=11,
        color="white",
    )
    plotter.renderer.reset_camera_clipping_range()
    return plotter.screenshot(return_img=True, window_size=size)


def render_topdown_frame(plotter, grid, row, report, threshold, size):
    L = add_flow_scene(plotter, grid, row, report, threshold, show_cores=False)
    domain = tuple(float(value) for value in report["domain_scale_L"])
    add_topdown_core_slice(plotter, grid, threshold, L)
    add_topdown_cylinder_footprints(plotter, report, L)
    focus = (0.5 * domain[0] * L, 0.5 * domain[1] * L, 0.5 * domain[2] * L)
    camera = (focus[0], focus[1], 1.5 * max(domain) * L)
    plotter.camera_position = [camera, focus, (0.0, 1.0, 0.0)]
    plotter.enable_parallel_projection()
    plotter.camera.parallel_scale = 0.54 * max(domain[:2]) * L
    motion_label = (
        "held-fish prewarm" if report.get("fish_motion") == "held_fixed" else
        "prescribed straight-gait free swim" if report.get("control_mode") == "prescribed_straight_gait" else
        "seed-policy free swim"
    )
    frame_time = float(row["sim_time"]) - float(report.get("start_dimensionless_time", 0.0))
    plotter.add_text(
        f"Current 3D four-cylinder {motion_label} — strict top-down\n"
        f"t*={frame_time:.1f} / {float(report['horizon']):.0f}   "
        f"L={int(L)}   domain={domain[0]:g}L x {domain[1]:g}L x {domain[2]:g}L\n"
        "z=L midplane lambda2 cores, fixed threshold | U=0.18 | Re=1000 | dt*=0.0055",
        position="upper_left",
        font_size=11,
        color="white",
    )
    plotter.renderer.reset_camera_clipping_range()
    return plotter.screenshot(return_img=True, window_size=size)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-dir", required=True)
    parser.add_argument("--fps", type=int, default=4)
    parser.add_argument("--width", type=int, default=1440)
    parser.add_argument("--height", type=int, default=900)
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
    if is_held and float(report["achieved_horizon"]) + 1.0e-6 < float(report["horizon"]):
        raise RuntimeError("prewarm did not reach its requested horizon")

    required = {"Velocity", "Lambda2", "BodySDF"}
    vtk_dir = run_dir / "vtk"
    rows = read_rows(vtk_dir)
    final_grid = load_grid(rows[-1]["frame_path"])
    missing = required - set(final_grid.point_data.keys())
    if missing:
        raise RuntimeError(f"final VTK frame is missing required fields: {sorted(missing)}")
    threshold = lambda2_threshold(final_grid)

    render_dir = run_dir / "render3d"
    oblique_frames_dir = render_dir / "frames_oblique"
    topdown_frames_dir = render_dir / "frames_topdown"
    oblique_frames_dir.mkdir(parents=True, exist_ok=True)
    topdown_frames_dir.mkdir(parents=True, exist_ok=True)
    pv.OFF_SCREEN = True
    oblique_plotter = pv.Plotter(off_screen=True, window_size=(args.width, args.height))
    topdown_plotter = pv.Plotter(off_screen=True, window_size=(args.width, args.height))
    oblique_plotter.enable_anti_aliasing("fxaa")
    topdown_plotter.enable_anti_aliasing("fxaa")
    oblique_frame_paths = []
    topdown_frame_paths = []
    for index, row in enumerate(rows):
        grid = load_grid(row["frame_path"])
        oblique_image = render_oblique_frame(
            oblique_plotter, grid, row, report, threshold, (args.width, args.height)
        )
        topdown_image = render_topdown_frame(
            topdown_plotter, grid, row, report, threshold, (args.width, args.height)
        )
        oblique_frame_path = oblique_frames_dir / f"frame_{index:04d}.png"
        topdown_frame_path = topdown_frames_dir / f"frame_{index:04d}.png"
        imageio.imwrite(oblique_frame_path, oblique_image)
        imageio.imwrite(topdown_frame_path, topdown_image)
        oblique_frame_paths.append(oblique_frame_path)
        topdown_frame_paths.append(topdown_frame_path)
        print(
            f"rendered paired views {index + 1}/{len(rows)}: {Path(row['frame_path']).name}",
            flush=True,
        )
    oblique_plotter.close()
    topdown_plotter.close()

    artifact_stem = (
        "projected_multiwake_prewarm3d_current" if is_held else
        "projected_multiwake_straight_swim3d" if report.get("control_mode") == "prescribed_straight_gait" else
        "projected_multiwake_seed_policy3d"
    )
    oblique_mp4 = render_dir / f"{artifact_stem}_oblique_L{int(report['runtime_resolution'])}.mp4"
    with imageio.get_writer(
        oblique_mp4,
        fps=args.fps,
        codec="libx264",
        quality=8,
        macro_block_size=2,
        ffmpeg_log_level="error",
    ) as writer:
        for frame_path in oblique_frame_paths:
            writer.append_data(imageio.imread(frame_path))
    topdown_mp4 = render_dir / f"{artifact_stem}_topdown_L{int(report['runtime_resolution'])}.mp4"
    with imageio.get_writer(
        topdown_mp4,
        fps=args.fps,
        codec="libx264",
        quality=8,
        macro_block_size=2,
        ffmpeg_log_level="error",
    ) as writer:
        for frame_path in topdown_frame_paths:
            writer.append_data(imageio.imread(frame_path))
    oblique_final_png = render_dir / f"{artifact_stem}_oblique_final.png"
    topdown_final_png = render_dir / f"{artifact_stem}_topdown_final.png"
    oblique_final_png.write_bytes(oblique_frame_paths[-1].read_bytes())
    topdown_final_png.write_bytes(topdown_frame_paths[-1].read_bytes())
    render_summary = {
        "schema_version": "dogfish.projected_multiwake_prewarm3d.render.v1",
        "renderer_path": str(Path(__file__).resolve()),
        "renderer_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "source_report": str(report_path),
        "required_fields": sorted(required),
        "lambda2_threshold": threshold,
        "views": ["oblique", "strict_topdown"],
        "topdown_representation": "z=L midplane Lambda2 below the shared fixed threshold",
        "frame_count": len(oblique_frame_paths),
        "first_sim_time": float(rows[0]["sim_time"]),
        "final_sim_time": float(rows[-1]["sim_time"]),
        "fps": args.fps,
        "mp4": str(oblique_mp4),
        "final_png": str(oblique_final_png),
        "oblique_mp4": str(oblique_mp4),
        "topdown_mp4": str(topdown_mp4),
        "oblique_final_png": str(oblique_final_png),
        "topdown_final_png": str(topdown_final_png),
    }
    (render_dir / "render_summary.json").write_text(json.dumps(render_summary, indent=2) + "\n")
    print(f"wrote {oblique_mp4}")
    print(f"wrote {topdown_mp4}")


if __name__ == "__main__":
    main()
