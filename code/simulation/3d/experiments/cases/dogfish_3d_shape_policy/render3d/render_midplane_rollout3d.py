#!/usr/bin/env python3
"""Render compact moving-window mid-plane diagnostics without full 3D VTK."""

import argparse
import csv
import hashlib
import json
import struct
from collections import deque
from pathlib import Path

import imageio.v2 as imageio
import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
import numpy as np


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_binary(path: Path):
    with path.open("rb") as handle:
        nx, ny, elapsed = struct.unpack("<iid", handle.read(16))
        count = nx * ny
        values = np.fromfile(handle, dtype="<f4", count=2 * count)
    if values.size != 2 * count:
        raise RuntimeError(f"truncated mid-plane frame: {path}")
    omega = values[:count].reshape((nx, ny), order="F")[1:-1, 1:-1]
    occupancy = values[count:].reshape((nx, ny), order="F")[1:-1, 1:-1]
    return elapsed, omega, occupancy


def component_near(solid: np.ndarray, center_index):
    labels = np.zeros(solid.shape, dtype=np.int32)
    count = 0
    components = []
    nx, ny = solid.shape
    for seed in np.argwhere(solid):
        sx, sy = map(int, seed)
        if labels[sx, sy]:
            continue
        count += 1
        labels[sx, sy] = count
        queue = deque([(sx, sy)])
        points = []
        while queue:
            x, y = queue.popleft()
            points.append((x, y))
            for dx in (-1, 0, 1):
                for dy in (-1, 0, 1):
                    if dx == 0 and dy == 0:
                        continue
                    xx, yy = x + dx, y + dy
                    if 0 <= xx < nx and 0 <= yy < ny and solid[xx, yy] and not labels[xx, yy]:
                        labels[xx, yy] = count
                        queue.append((xx, yy))
        components.append(points)
    if not components:
        return np.zeros_like(solid)
    target = np.asarray(center_index, dtype=float)
    selected = min(
        range(len(components)),
        key=lambda index: np.linalg.norm(np.asarray(components[index]).mean(axis=0) - target),
    )
    return labels == selected + 1


def render_frame(path: Path, row, report, plot_clim: float, size):
    elapsed, omega, occupancy = load_binary(Path(row["frame_path"]))
    L = float(report["runtime_resolution"])
    domain_x, domain_y = map(float, report["domain_scale_L"][:2])
    center_L = np.asarray([
        float(row.get("local_center_x_L", row["center_x_L"])),
        float(row.get("local_center_y_L", row["center_y_L"])),
    ])
    center_index = center_L * np.asarray(omega.shape) / np.asarray([domain_x, domain_y])
    solid = occupancy < 0.5
    fish = component_near(solid, center_index)

    dpi = 120
    fig, ax = plt.subplots(figsize=(size[0] / dpi, size[1] / dpi), dpi=dpi)
    ax.imshow(
        (omega * L).T,
        origin="lower",
        extent=(0.0, domain_x, 0.0, domain_y),
        cmap="RdBu",
        vmin=-plot_clim,
        vmax=plot_clim,
        interpolation="bilinear",
        aspect="equal",
    )
    x = (np.arange(omega.shape[0]) + 0.5) * domain_x / omega.shape[0]
    y = (np.arange(omega.shape[1]) + 0.5) * domain_y / omega.shape[1]
    ax.contourf(x, y, solid.T.astype(float), levels=(0.5, 1.5), colors=("#4b5563",), alpha=0.92)
    ax.contourf(x, y, fish.T.astype(float), levels=(0.5, 1.5), colors=("#f5a623",), alpha=0.98)
    ax.contour(x, y, fish.T.astype(float), levels=(0.5,), colors=("#202020",), linewidths=0.7)

    frame_origin = np.asarray([
        float(row.get("frame_origin_x_L", 0.0)),
        float(row.get("frame_origin_y_L", 0.0)),
    ])
    target = np.asarray(report["target_L"][:2], dtype=float) - frame_origin
    if -0.25 <= target[0] <= domain_x + 0.25 and -0.25 <= target[1] <= domain_y + 0.25:
        ax.add_patch(Circle(target, float(report["success_radius_L"]), fill=False, color="#00c853", lw=1.8))
    else:
        delta = target - center_L
        scale = min(
            (domain_x - 0.12 - center_L[0]) / delta[0] if delta[0] > 0 else (0.12 - center_L[0]) / delta[0] if delta[0] < 0 else np.inf,
            (domain_y - 0.12 - center_L[1]) / delta[1] if delta[1] > 0 else (0.12 - center_L[1]) / delta[1] if delta[1] < 0 else np.inf,
        )
        marker = center_L + max(0.0, scale) * delta
        ax.plot(marker[0], marker[1], marker=(3, 0, np.degrees(np.arctan2(delta[1], delta[0])) - 90), ms=10, color="#00c853")
        ax.text(marker[0], marker[1], f" target {np.linalg.norm(delta):.1f}L", color="#007a33", fontsize=8)
    initial = np.asarray(report["fish_initial_center_L"][:2], dtype=float) - frame_origin
    ax.plot(initial[0], initial[1], marker="o", ms=3.5, color="#00c853")
    ax.set(xlim=(0, domain_x), ylim=(0, domain_y), xlabel="x/L", ylabel="y/L")
    ax.set_title(
        f"3D multiwake mid-plane · L={int(L)} · dt*={report['max_dimensionless_dt']:.4g} · "
        f"t*={elapsed:.2f}/{report['horizon']:.2f}"
    )
    fig.tight_layout()
    fig.savefig(path, dpi=dpi)
    plt.close(fig)


def contact_sheet(frame_paths, output: Path):
    indices = np.unique(np.linspace(0, len(frame_paths) - 1, min(6, len(frame_paths))).round().astype(int))
    images = [imageio.imread(frame_paths[index]) for index in indices]
    thumb_width = 480
    thumbs = []
    for image in images:
        if image.ndim == 3 and image.shape[2] == 4:
            image = image[:, :, :3]
        scale = thumb_width / image.shape[1]
        height = max(1, int(round(image.shape[0] * scale)))
        from PIL import Image

        thumbs.append(np.asarray(Image.fromarray(image).resize((thumb_width, height))))
    rows = []
    for start in range(0, len(thumbs), 3):
        row = thumbs[start : start + 3]
        while len(row) < 3:
            row.append(np.full_like(thumbs[0], 255))
        rows.append(np.concatenate(row, axis=1))
    imageio.imwrite(output, np.concatenate(rows, axis=0), quality=92)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-dir", required=True)
    parser.add_argument("--fps", type=float, default=4.0)
    parser.add_argument("--plot-clim", type=float, default=0.8)
    parser.add_argument("--width", type=int, default=960)
    parser.add_argument("--height", type=int, default=960)
    args = parser.parse_args()

    run_dir = Path(args.run_dir).resolve()
    report = json.loads((run_dir / "summary.json").read_text(encoding="utf-8"))
    midplane = run_dir / "midplane"
    with (midplane / "frames.csv").open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError("mid-plane manifest contains no frames")
    for row in rows:
        row["frame_path"] = str(midplane / row["file"])

    render_dir = run_dir / "render_midplane"
    frames_dir = render_dir / "frames"
    frames_dir.mkdir(parents=True, exist_ok=True)
    frame_paths = []
    for index, row in enumerate(rows):
        frame_path = frames_dir / f"frame_{index:04d}.png"
        render_frame(frame_path, row, report, args.plot_clim, (args.width, args.height))
        frame_paths.append(frame_path)

    runtime_L = int(report["runtime_resolution"])
    video = render_dir / f"projected_multiwake_target3d_topdown_L{runtime_L}.mp4"
    with imageio.get_writer(video, fps=args.fps, codec="libx264", quality=8, macro_block_size=None) as writer:
        for frame_path in frame_paths:
            writer.append_data(imageio.imread(frame_path))
    keyframes = render_dir / "projected_multiwake_target3d_keyframes.jpg"
    contact_sheet(frame_paths, keyframes)
    final_png = render_dir / "projected_multiwake_target3d_final.png"
    final_png.write_bytes(frame_paths[-1].read_bytes())

    manifest = {
        "schema": "dogfish.projected_multiwake_target3d.visual.v1",
        "source_summary": str(run_dir / "summary.json"),
        "frame_count": len(frame_paths),
        "representation": "z=L vorticity-z and BDIM occupancy from the full 3D solver",
        "video": str(video),
        "video_sha256": sha256(video),
        "keyframes": str(keyframes),
        "keyframes_sha256": sha256(keyframes),
        "final_png": str(final_png),
        "final_png_sha256": sha256(final_png),
    }
    (render_dir / "visual_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(manifest))


if __name__ == "__main__":
    main()
