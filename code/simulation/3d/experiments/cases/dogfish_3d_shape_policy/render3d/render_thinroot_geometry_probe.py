#!/usr/bin/env python3
"""Render the actual rasterized fish component from a thin-root VTK probe."""

import argparse
import json
from pathlib import Path

import numpy as np
import pyvista as pv


def fish_surface(grid, fish_center):
    connected = grid.contour([0.0], scalars="BodySDF").connectivity()
    ids = np.unique(np.asarray(connected.cell_data["RegionId"]).astype(int))
    regions = []
    for region_id in ids:
        region = connected.threshold(
            (region_id - 0.25, region_id + 0.25),
            scalars="RegionId",
            preference="cell",
        ).extract_surface()
        if region.n_points:
            regions.append(region)
    return min(regions, key=lambda region: np.linalg.norm(np.asarray(region.center) - fish_center))


def add_fish(plotter, fish):
    plotter.set_background("#eef3f7")
    plotter.add_mesh(
        fish,
        color="#e99828",
        smooth_shading=True,
        show_edges=True,
        edge_color="#663913",
        line_width=1.0,
        specular=0.25,
    )
    plotter.enable_parallel_projection()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-dir", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    run_dir = Path(args.run_dir)
    report = json.loads((run_dir / "prewarm_report.json").read_text())
    frame = sorted((run_dir / "vtk").glob("*.vti"))[0]
    grid = pv.read(frame)
    L = float(report["runtime_resolution"])
    center = np.asarray(report["fish_initial_center_L"], dtype=float) * L
    fish = fish_surface(grid, center)

    pv.OFF_SCREEN = True
    plotter = pv.Plotter(shape=(1, 2), off_screen=True, window_size=(1600, 760))
    plotter.subplot(0, 0)
    add_fish(plotter, fish)
    plotter.camera_position = [center + np.asarray((0.0, 0.0, 4.0 * L)), center, (0.0, 1.0, 0.0)]
    plotter.camera.parallel_scale = 0.72 * L
    resolution = int(round(L))
    plotter.add_text(
        f"Actual L{resolution} BodySDF=0 — strict top",
        font_size=12,
        color="#142536",
    )
    plotter.renderer.reset_camera_clipping_range()

    plotter.subplot(0, 1)
    add_fish(plotter, fish)
    plotter.camera_position = [
        center + np.asarray((-2.0 * L, -2.8 * L, 1.6 * L)),
        center,
        (0.0, 0.0, 1.0),
    ]
    plotter.camera.parallel_scale = 0.72 * L
    plotter.add_text(
        f"Actual L{resolution} BodySDF=0 — oblique",
        font_size=12,
        color="#142536",
    )
    plotter.renderer.reset_camera_clipping_range()
    plotter.screenshot(args.output)
    plotter.close()


if __name__ == "__main__":
    main()
