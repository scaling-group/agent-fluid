#!/usr/bin/env python3
"""Render the reference turn in the translating CFD frame.

The D3CVOL2 source deliberately stores only three lightweight fields:
dimensionless lambda2, dimensionless z-vorticity, and the runtime body SDF.
It is not full 3-D VTK.  The spatial stride is explicit in every frame.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import math
import os
import pathlib
import struct

os.environ.setdefault("PYVISTA_OFF_SCREEN", "true")

import imageio.v2 as imageio
import numpy as np
from PIL import Image, ImageDraw
import pyvista as pv


MAGIC = b"D3CVOL2\n"
INT_HEADER = struct.Struct("<13i")
FLOAT_HEADER = struct.Struct("<7d")


def sha256(path: pathlib.Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def read_frame(path: pathlib.Path) -> dict:
    with path.open("rb") as stream:
        magic = stream.read(len(MAGIC))
        if magic != MAGIC:
            raise ValueError(f"{path}: bad magic {magic!r}")
        values = INT_HEADER.unpack(stream.read(INT_HEADER.size))
        (
            nx,
            ny,
            nz,
            x0,
            y0,
            z0,
            length_cells,
            stride_x,
            stride_y,
            stride_z,
            full_nx,
            full_ny,
            full_nz,
        ) = values
        (
            elapsed,
            center_x,
            center_y,
            heading,
            domain_x,
            domain_y,
            domain_z,
        ) = FLOAT_HEADER.unpack(stream.read(FLOAT_HEADER.size))
        count = nx * ny * nz
        payload = np.fromfile(stream, dtype="<f4", count=3 * count)
        extra = stream.read(1)
    if payload.size != 3 * count or extra:
        raise ValueError(
            f"{path}: payload size mismatch; got {payload.size}, expected {3 * count}"
        )
    shape = (nx, ny, nz)
    return {
        "path": str(path.resolve()),
        "shape": shape,
        "first_index": (x0, y0, z0),
        "length_cells": length_cells,
        "sample_stride": (stride_x, stride_y, stride_z),
        "full_dims": (full_nx, full_ny, full_nz),
        "domain_L": (domain_x, domain_y, domain_z),
        "elapsed": elapsed,
        "center": (center_x, center_y),
        "heading": heading,
        "lambda2": payload[:count].reshape(shape, order="F"),
        "vorticity_z": payload[count : 2 * count].reshape(shape, order="F"),
        "body_sdf": payload[2 * count :].reshape(shape, order="F"),
    }


def validate_frame_contract(paths: list[pathlib.Path]) -> dict:
    first = read_frame(paths[0])
    expected = {
        "shape": first["shape"],
        "first_index": first["first_index"],
        "length_cells": first["length_cells"],
        "sample_stride": first["sample_stride"],
        "full_dims": first["full_dims"],
        "domain_L": first["domain_L"],
    }
    previous = -math.inf
    for path in paths:
        frame = read_frame(path)
        for key, value in expected.items():
            if frame[key] != value:
                raise ValueError(f"{path}: {key}={frame[key]!r}, expected {value!r}")
        if frame["elapsed"] <= previous:
            raise ValueError(f"{path}: non-increasing elapsed time")
        previous = frame["elapsed"]
    return expected


def robust_levels(
    paths: list[pathlib.Path], requested_lambda2: float | None
) -> tuple[float, float]:
    negative_samples: list[np.ndarray] = []
    vorticity_samples: list[np.ndarray] = []
    for path in paths:
        frame = read_frame(path)
        l2 = frame["lambda2"][::4, ::4, ::3]
        vort = frame["vorticity_z"][::4, ::4, ::3]
        body = frame["body_sdf"][::4, ::4, ::3]
        fluid = body > 0
        negative = l2[(l2 < 0) & fluid & np.isfinite(l2)]
        if negative.size:
            negative_samples.append(negative)
        valid_vort = np.abs(vort[fluid & np.isfinite(vort)])
        if valid_vort.size:
            vorticity_samples.append(valid_vort)
    if negative_samples:
        negative = np.concatenate(negative_samples)
        lambda2_level = (
            float(requested_lambda2)
            if requested_lambda2 is not None
            else float(np.quantile(negative, 0.055))
        )
    else:
        # A quiescent or deliberately naive smoke policy may have no resolved
        # negative lambda2 yet.  Keep the oblique body/trajectory evidence
        # renderable; render_one records vortex_present=false for such frames.
        lambda2_level = (
            float(requested_lambda2)
            if requested_lambda2 is not None
            else -float(np.finfo(np.float32).eps)
        )
    if lambda2_level >= 0:
        raise ValueError("lambda2 iso-level must be negative")
    vorticity_limit = float(np.quantile(np.concatenate(vorticity_samples), 0.992))
    return lambda2_level, max(vorticity_limit, np.finfo(float).eps)


def make_grid(frame: dict) -> pv.ImageData:
    nx, ny, nz = frame["shape"]
    x0, y0, z0 = frame["first_index"]
    sx, sy, sz = frame["sample_stride"]
    length_cells = frame["length_cells"]
    grid = pv.ImageData(
        dimensions=(nx, ny, nz),
        spacing=(sx / length_cells, sy / length_cells, sz / length_cells),
        origin=(
            (x0 - 1) / length_cells,
            (y0 - 1) / length_cells,
            (z0 - 1) / length_cells,
        ),
    )
    lambda2 = frame["lambda2"].copy()
    lambda2[(frame["body_sdf"] <= 0) | ~np.isfinite(lambda2)] = 0
    # Remove numerical boundary sheets while retaining the full physical domain.
    lambda2[[0, -1], :, :] = 0
    lambda2[:, [0, -1], :] = 0
    lambda2[:, :, [0, -1]] = 0
    grid.point_data["lambda2"] = lambda2.ravel(order="F")
    grid.point_data["vorticity_z"] = frame["vorticity_z"].ravel(order="F")
    grid.point_data["body_sdf"] = frame["body_sdf"].ravel(order="F")
    return grid


def load_trajectory(path: pathlib.Path) -> list[dict[str, float]]:
    if not path.is_file():
        return []
    with path.open(newline="") as stream:
        return [
            {key: float(value) for key, value in row.items() if value != ""}
            for row in csv.DictReader(stream)
        ]


def frame_origin_at(trajectory: list[dict[str, float]], elapsed: float) -> tuple[float, float]:
    if not trajectory or "frame_origin_x_L" not in trajectory[0]:
        return (0.0, 0.0)
    times = np.asarray([row["elapsed"] for row in trajectory])
    return (
        float(np.interp(elapsed, times, [row["frame_origin_x_L"] for row in trajectory])),
        float(np.interp(elapsed, times, [row["frame_origin_y_L"] for row in trajectory])),
    )


def stage_label(elapsed: float, mode: str) -> str:
    if mode == "closed_loop":
        return "CLOSED-LOOP TARGETING"
    if elapsed < 5.5:
        return "TURN"
    if elapsed < 7.7:
        return "BRAKE"
    return "RECOVERY"


def camera_position(domain: tuple[float, float, float]):
    dx, dy, dz = domain
    return [
        (0.50 * dx, -0.75 * dy, 7.35 * dz),
        (0.50 * dx, 0.50 * dy, 0.50 * dz),
        (0.0, 0.0, 1.0),
    ]


def render_one(
    source: pathlib.Path,
    destination: pathlib.Path,
    lambda2_level: float,
    vorticity_limit: float,
    width: int,
    height: int,
    target: tuple[float, float, float],
    target_radius: float,
    trajectory: list[dict[str, float]],
    title: str,
    stage_mode: str,
) -> dict:
    frame = read_frame(source)
    grid = make_grid(frame)
    frame_origin = frame_origin_at(trajectory, frame["elapsed"])
    local_target = (
        target[0] - frame_origin[0],
        target[1] - frame_origin[1],
        target[2],
    )
    fluid_l2 = frame["lambda2"][
        (frame["body_sdf"] > 0) & np.isfinite(frame["lambda2"])
    ]
    negative = fluid_l2[fluid_l2 < 0]
    used_level = lambda2_level
    vortex = None
    if negative.size:
        used_level = max(lambda2_level, 0.90 * float(np.min(negative)))
        vortex = grid.contour([used_level], scalars="lambda2")
        if vortex.n_points == 0:
            vortex = None
    body = grid.contour([0.0], scalars="body_sdf")
    if body.n_points == 0:
        raise ValueError(f"{source}: runtime SDF body contour is empty")

    plotter = pv.Plotter(off_screen=True, window_size=(width, height))
    plotter.set_background("#06101d")
    if vortex is not None:
        plotter.add_mesh(
            vortex,
            scalars="vorticity_z",
            cmap="coolwarm",
            clim=(-vorticity_limit, vorticity_limit),
            opacity=0.72,
            smooth_shading=True,
            show_scalar_bar=True,
            scalar_bar_args={
                "title": "omega_z * T",
                "color": "white",
                "title_font_size": 14,
                "label_font_size": 12,
                "position_x": 0.91,
                "position_y": 0.18,
                "width": 0.060,
                "height": 0.46,
            },
        )
    plotter.add_mesh(
        body,
        color="#d7e5ec",
        opacity=0.98,
        smooth_shading=True,
        specular=0.45,
        specular_power=22,
    )

    elapsed_path = [row for row in trajectory if row.get("elapsed", math.inf) <= frame["elapsed"]]
    if len(elapsed_path) >= 2:
        points = np.array(
            [
                (
                    row["head_x_L"] - frame_origin[0],
                    row["head_y_L"] - frame_origin[1],
                    target[2],
                )
                for row in elapsed_path[:: max(1, len(elapsed_path) // 350)]
            ]
        )
        if len(points) >= 2:
            plotter.add_mesh(
                pv.Spline(points, max(2, len(points) * 2)),
                color="#65e6b4",
                line_width=3,
                opacity=0.72,
            )

    target_shell = pv.Sphere(
        radius=target_radius,
        center=local_target,
        theta_resolution=32,
        phi_resolution=20,
    )
    plotter.add_mesh(
        target_shell,
        color="#22e39d",
        style="wireframe",
        line_width=3,
        opacity=0.95,
    )
    domain = frame["domain_L"]
    plotter.add_mesh(
        pv.Box(bounds=(0, domain[0], 0, domain[1], 0, domain[2])),
        color="#55718a",
        style="wireframe",
        line_width=1,
        opacity=0.24,
    )
    plotter.add_text(
        f"{title}\n"
        f"t*={frame['elapsed']:.2f} T   {stage_label(frame['elapsed'], stage_mode)}   "
        f"world target=({target[0]:.2f}, {target[1]:.2f})L",
        position="upper_left",
        font_size=16,
        color="white",
    )
    plotter.camera_position = camera_position(domain)
    plotter.camera.zoom(1.16)
    plotter.show(screenshot=str(destination), auto_close=True)
    return {
        "source": str(source.resolve()),
        "image": str(destination.resolve()),
        "elapsed_T": frame["elapsed"],
        "center_L": frame["center"],
        "frame_origin_L": frame_origin,
        "local_target_L": local_target,
        "heading_rad": frame["heading"],
        "stage": stage_label(frame["elapsed"], stage_mode),
        "lambda2_level_used": used_level if vortex is not None else None,
        "vortex_present": vortex is not None,
        "vortex_points": 0 if vortex is None else int(vortex.n_points),
        "body_points": int(body.n_points),
    }


def contact_sheet(images: list[pathlib.Path], destination: pathlib.Path) -> None:
    selected = sorted(
        set(
            [
                0,
                len(images) // 4,
                len(images) // 2,
                3 * len(images) // 4,
                len(images) - 1,
            ]
        )
    )
    originals = [Image.open(images[index]).convert("RGB") for index in selected]
    thumb_width = 640
    thumbs = [
        image.resize((thumb_width, round(image.height * thumb_width / image.width)))
        for image in originals
    ]
    label_height = 34
    sheet = Image.new(
        "RGB",
        (thumb_width, sum(image.height + label_height for image in thumbs)),
        (6, 16, 29),
    )
    draw = ImageDraw.Draw(sheet)
    cursor = 0
    for index, image in zip(selected, thumbs):
        draw.text((14, cursor + 8), f"frame {index:03d}", fill="white")
        cursor += label_height
        sheet.paste(image, (0, cursor))
        cursor += image.height
    sheet.save(destination, quality=94)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input_root", type=pathlib.Path)
    parser.add_argument("--trajectory", type=pathlib.Path)
    parser.add_argument("--output", type=pathlib.Path, required=True)
    parser.add_argument("--target-x", type=float, default=1.19)
    parser.add_argument("--target-y", type=float, default=3.00)
    parser.add_argument("--target-z", type=float, default=0.75)
    parser.add_argument("--target-radius", type=float, default=0.10)
    parser.add_argument("--lambda2-level", type=float)
    parser.add_argument("--fps", type=int, default=10)
    parser.add_argument("--width", type=int, default=1920)
    parser.add_argument("--height", type=int, default=1080)
    parser.add_argument(
        "--title",
        default="L64 moving-window replay  |  same turn / same policy",
    )
    parser.add_argument(
        "--output-stem",
        default="dogfish3d_l64_reference_turn_moving_frame",
    )
    parser.add_argument(
        "--stage-mode", choices=("turn_brake", "closed_loop"), default="turn_brake"
    )
    args = parser.parse_args()

    frames_csv = args.input_root / "frames.csv"
    with frames_csv.open(newline="") as stream:
        rows = list(csv.DictReader(stream))
    sources = [args.input_root / row["file"] for row in rows]
    if not sources:
        raise ValueError(f"{frames_csv}: no frames")
    missing = [str(path) for path in sources if not path.is_file()]
    if missing:
        raise FileNotFoundError("missing volume frames: " + ", ".join(missing))

    contract = validate_frame_contract(sources)
    lambda2_level, vorticity_limit = robust_levels(sources, args.lambda2_level)
    trajectory_path = args.trajectory or args.input_root.parent / "trajectory.csv"
    trajectory = load_trajectory(trajectory_path)
    args.output.mkdir(parents=True, exist_ok=True)
    frame_dir = args.output / "frames"
    frame_dir.mkdir(exist_ok=True)

    target = (args.target_x, args.target_y, args.target_z)
    rendered: list[dict] = []
    images: list[pathlib.Path] = []
    for index, source in enumerate(sources):
        destination = frame_dir / f"frame_{index:04d}.png"
        rendered.append(
            render_one(
                source,
                destination,
                lambda2_level,
                vorticity_limit,
                args.width,
                args.height,
                target,
                args.target_radius,
                trajectory,
                args.title,
                args.stage_mode,
            )
        )
        images.append(destination)

    video = args.output / f"{args.output_stem}.mp4"
    with imageio.get_writer(
        video,
        fps=args.fps,
        codec="libx264",
        quality=None,
        bitrate="8M",
        macro_block_size=2,
        ffmpeg_params=["-pix_fmt", "yuv420p"],
    ) as writer:
        for path in images:
            writer.append_data(imageio.imread(path))
    keyframes = args.output / f"{args.output_stem}_keyframes.jpg"
    contact_sheet(images, keyframes)
    final_png = args.output / f"{args.output_stem}_final.png"
    Image.open(images[-1]).save(final_png)
    elapsed = [item["elapsed_T"] for item in rendered]
    cadence = np.diff(elapsed)
    manifest = {
        "schema": "dogfish3d.moving_window_hero.v2",
        "title": args.title,
        "stage_mode": args.stage_mode,
        "source_frames_csv": str(frames_csv.resolve()),
        "source_frames_csv_sha256": sha256(frames_csv),
        "source_frame_count": len(sources),
        "source_contract": contract,
        "elapsed_T": [elapsed[0], elapsed[-1]],
        "cadence_T": {
            "minimum": None if not len(cadence) else float(np.min(cadence)),
            "median": None if not len(cadence) else float(np.median(cadence)),
            "maximum": None if not len(cadence) else float(np.max(cadence)),
        },
        "target_L": target,
        "target_radius_L": args.target_radius,
        "camera": {
            "mode": "fixed oblique XY overview",
            "position_focus_view_up": camera_position(contract["domain_L"]),
        },
        "lambda2_level": lambda2_level,
        "vorticity_color_limit": vorticity_limit,
        "window_pixels": [args.width, args.height],
        "fps": args.fps,
        "video": str(video.resolve()),
        "video_sha256": sha256(video),
        "keyframes": str(keyframes.resolve()),
        "final_png": str(final_png.resolve()),
        "frames": rendered,
    }
    (args.output / "render_manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(manifest, sort_keys=True))


if __name__ == "__main__":
    main()
