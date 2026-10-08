#!/usr/bin/env python3
"""Render the 3D dogfish wake from VTK frames: body surface (BodySDF=0) plus
lambda2 vortex-core isosurfaces, offscreen, stitched to MP4 via ffmpeg.

Usage:
  python3 render_lambda2.py --vtk-dir .../left_L32/vtk --out-dir /tmp/render3d \
      [--lambda2 -0.5] [--every 1] [--fps 10] [--follow]

The lambda2 threshold is in nondimensional units (scaled by (L/U)^2 at write
time); more negative = tighter cores. If omitted, a robust percentile of the
final frame's negative values is used.
"""

import argparse
import csv
import math
import os
import subprocess
import sys

import imageio.v2 as imageio
import numpy as np
import pyvista as pv


def read_manifest(vtk_dir):
    # frame_path in the manifest is absolute on the machine that ran the sim;
    # remap to this vtk_dir so pulled-back copies render without edits.
    rows = []
    manifest = os.path.join(vtk_dir, "frames.csv")
    with open(manifest, newline="") as fh:
        for row in csv.DictReader(fh):
            row["frame_path"] = os.path.join(vtk_dir, os.path.basename(row["frame_path"]))
            rows.append(row)
    return rows


def pick_lambda2_threshold(grid, fallback=-0.1):
    values = np.asarray(grid["Lambda2"])
    negatives = values[values < 0]
    if negatives.size < 100:
        return fallback
    # Show the bulk of the vortex cores, not just the strongest ~2%: a
    # moderately-negative percentile (closer to 0 => more cores shown). The 2nd
    # percentile used before left the isosurface nearly empty (tens of cells).
    return float(np.percentile(negatives, 65.0))


def load_interior(path):
    # Crop the ghost layer: the solver writes interior cells only, so boundary
    # points carry stale scratch values (previous field) that pollute contours.
    grid = pv.read(path)
    if not list(grid.point_data.keys()):
        grid = grid.cell_data_to_point_data()
    nx, ny, nz = grid.dimensions
    return grid.extract_subset(voi=(2, nx - 3, 2, ny - 3, 2, nz - 3))


def render_frame(path, row, threshold, plotter, follow_center, window):
    grid = load_interior(path)

    body = grid.contour(isosurfaces=[0.0], scalars="BodySDF")
    cores = grid.contour(isosurfaces=[threshold], scalars="Lambda2")

    plotter.clear()
    if body.n_points:
        plotter.add_mesh(body, color="#555555", specular=0.6, smooth_shading=True)
    if cores.n_points:
        speed = None
        if "Velocity" in grid.point_data:
            cores = cores.sample(grid)
            vel = np.asarray(cores["Velocity"])
            speed = np.linalg.norm(vel, axis=1)
            cores["speed"] = speed
        if speed is not None and len(speed):
            plotter.add_mesh(
                cores,
                scalars="speed",
                cmap="turbo",
                opacity=0.55,
                clim=[0.0, max(1e-6, float(np.percentile(speed, 98)))],
                show_scalar_bar=False,
                smooth_shading=True,
            )
        else:
            plotter.add_mesh(cores, color="#1f77b4", opacity=0.5, smooth_shading=True)

    cx, cy = float(row["center_x"]), float(row["center_y"])
    cz = float(row["z_plane"])
    if follow_center:
        focus = (cx, cy, cz)
    else:
        focus = window["static_focus"]
    distance = window["distance"]
    azimuth = math.radians(window["azimuth_deg"])
    elevation = math.radians(window["elevation_deg"])
    cam = (
        focus[0] + distance * math.cos(elevation) * math.cos(azimuth),
        focus[1] + distance * math.cos(elevation) * math.sin(azimuth),
        focus[2] + distance * math.sin(elevation),
    )
    plotter.camera_position = [cam, focus, (0.0, 0.0, 1.0)]
    plotter.add_text(
        f"tU/L = {float(row['sim_time']):.2f}   lambda2 = {threshold:.3g}",
        font_size=10,
        color="black",
    )
    return plotter.screenshot(return_img=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--vtk-dir", required=True)
    parser.add_argument("--out-dir", required=True)
    parser.add_argument("--lambda2", type=float, default=None)
    parser.add_argument("--every", type=int, default=1)
    parser.add_argument("--fps", type=int, default=10)
    parser.add_argument("--width", type=int, default=1280)
    parser.add_argument("--height", type=int, default=720)
    parser.add_argument("--distance", type=float, default=None)
    parser.add_argument("--azimuth-deg", type=float, default=-150.0)
    parser.add_argument("--elevation-deg", type=float, default=28.0)
    parser.add_argument("--follow", action="store_true", help="camera follows the fish center")
    parser.add_argument("--name", default="dogfish3d_lambda2")
    args = parser.parse_args()

    all_rows = read_manifest(args.vtk_dir)
    rows = all_rows[:: max(1, args.every)]
    if not rows:
        sys.exit("no frames in manifest")

    os.makedirs(args.out_dir, exist_ok=True)
    frame_dir = os.path.join(args.out_dir, "frames")
    os.makedirs(frame_dir, exist_ok=True)

    # Threshold always comes from the final (most developed) frame of the full
    # series, independent of frame subsampling.
    last_grid = load_interior(all_rows[-1]["frame_path"])
    threshold = args.lambda2 if args.lambda2 is not None else pick_lambda2_threshold(last_grid)

    # Frame the FISH, not the whole domain: size the camera distance from the
    # body extent so the swimmer + near wake fill the view (the domain span made
    # the fish a tiny dot in the center).
    body_ref = last_grid.contour(isosurfaces=[0.0], scalars="BodySDF")
    ref_bounds = body_ref.bounds if body_ref.n_points else last_grid.bounds
    span = max(ref_bounds[1] - ref_bounds[0], ref_bounds[3] - ref_bounds[2], ref_bounds[5] - ref_bounds[4])
    distance = args.distance if args.distance is not None else 3.0 * span
    centers = np.array([[float(r["center_x"]), float(r["center_y"])] for r in rows])
    window = {
        "distance": distance,
        "azimuth_deg": args.azimuth_deg,
        "elevation_deg": args.elevation_deg,
        "static_focus": (
            float(centers[:, 0].mean()),
            float(centers[:, 1].mean()),
            float(rows[0]["z_plane"]),
        ),
    }

    pv.OFF_SCREEN = True
    plotter = pv.Plotter(off_screen=True, window_size=(args.width, args.height))
    plotter.set_background("white")

    print(f"rendering {len(rows)} frames, lambda2 iso = {threshold:.4g}")
    for index, row in enumerate(rows):
        image = render_frame(row["frame_path"], row, threshold, plotter, args.follow, window)
        out_path = os.path.join(frame_dir, f"frame_{index:04d}.png")
        imageio.imwrite(out_path, image)
        print(f"  [{index + 1}/{len(rows)}] {os.path.basename(row['frame_path'])}")
    plotter.close()

    mp4_path = os.path.join(args.out_dir, f"{args.name}.mp4")
    # Prefer imageio + bundled imageio-ffmpeg (no system ffmpeg needed); fall
    # back to a system ffmpeg if imageio's writer is unavailable.
    try:
        writer = imageio.get_writer(
            mp4_path, fps=args.fps, codec="libx264", quality=8,
            macro_block_size=2, ffmpeg_log_level="error",
        )
        for index in range(len(rows)):
            writer.append_data(imageio.imread(os.path.join(frame_dir, f"frame_{index:04d}.png")))
        writer.close()
    except Exception:
        subprocess.run(
            [
                "ffmpeg", "-y", "-loglevel", "error",
                "-framerate", str(args.fps),
                "-i", os.path.join(frame_dir, "frame_%04d.png"),
                "-vf", "pad=ceil(iw/2)*2:ceil(ih/2)*2",
                "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "20",
                mp4_path,
            ],
            check=True,
        )
    print(f"wrote {mp4_path}")


if __name__ == "__main__":
    main()
