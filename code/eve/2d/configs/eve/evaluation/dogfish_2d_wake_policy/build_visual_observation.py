#!/usr/bin/env python3
"""Render standard wake VTK output into EvE multimodal observation artifacts."""

from __future__ import annotations

import argparse
import json
import math
import os
import shutil
import subprocess
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solver-root", required=True, type=Path)
    parser.add_argument("--artifact-root", required=True, type=Path)
    parser.add_argument("--observation-dir", required=True, type=Path)
    parser.add_argument("--mode", choices=("episode", "prewarm"), default="episode")
    parser.add_argument("--sample-count", type=int, default=6)
    parser.add_argument("--clim", default=os.environ.get("DOGFISH_WAKE_WATCH_RENDER_CLIM", "0.8"))
    parser.add_argument("--scale", default=os.environ.get("DOGFISH_WAKE_WATCH_RENDER_SCALE", "1"))
    parser.add_argument("--fps", default=os.environ.get("DOGFISH_WAKE_WATCH_RENDER_FPS", "16"))
    return parser.parse_args()


def select_indices(count: int, sample_count: int) -> list[int]:
    if count <= 0:
        return []
    sample_count = max(1, min(count, sample_count))
    if sample_count == 1:
        return [count - 1]
    return sorted({round(i * (count - 1) / (sample_count - 1)) for i in range(sample_count)})


def load_font(size: int) -> ImageFont.ImageFont:
    for candidate in (
        "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/truetype/liberation2/LiberationSans-Regular.ttf",
    ):
        if Path(candidate).is_file():
            return ImageFont.truetype(candidate, size)
    return ImageFont.load_default()


def draw_target_marker(image: Image.Image, summary: dict[str, object]) -> None:
    target = summary.get("target")
    dims = summary.get("domain_dims")
    if not (
        isinstance(target, list) and len(target) >= 2 and isinstance(dims, list) and len(dims) >= 2
    ):
        return
    domain_w, domain_h = float(dims[0]), float(dims[1])
    if domain_w <= 0 or domain_h <= 0:
        return
    width, height = image.size
    x = float(target[0]) / domain_w * width
    y = (domain_h - float(target[1])) / domain_h * height
    radius_domain = float(summary.get("success_radius") or 0.0)
    radius = max(5.0, radius_domain * min(width / domain_w, height / domain_h))
    draw = ImageDraw.Draw(image, "RGBA")
    green = (0, 150, 55, 235)
    draw.ellipse((x - radius, y - radius, x + radius, y + radius), outline=green, width=4)
    draw.line((x - 14, y, x + 14, y), fill=green, width=4)
    draw.line((x, y - 14, x, y + 14), fill=green, width=4)


def make_sheet(
    frame_paths: list[Path],
    output_path: Path,
    *,
    summary: dict[str, object],
    mode: str,
    sample_count: int,
    draw_target: bool,
) -> None:
    selected = [frame_paths[index] for index in select_indices(len(frame_paths), sample_count)]
    if not selected:
        raise RuntimeError("no rendered frames were selected")

    tile_width = 640
    label_height = 42
    opened: list[Image.Image] = []
    for path in selected:
        image = Image.open(path).convert("RGB")
        ratio = tile_width / image.width
        resized = image.resize(
            (tile_width, max(1, round(image.height * ratio))),
            Image.Resampling.LANCZOS,
        )
        if draw_target:
            draw_target_marker(resized, summary)
        opened.append(resized)

    tile_height = max(image.height for image in opened)
    cols = 2 if len(opened) > 1 else 1
    rows = math.ceil(len(opened) / cols)
    sheet = Image.new("RGB", (cols * tile_width, rows * (tile_height + label_height)), "white")
    font = load_font(18)
    termination = str(summary.get("termination", "unknown"))
    score = summary.get("score")
    score_text = "na" if score is None else f"{float(score):.4f}"
    for position, path in enumerate(selected):
        image = opened[position]
        col = position % cols
        row = position // cols
        x = col * tile_width
        y = row * (tile_height + label_height)
        sheet.paste(ImageOps.pad(image, (tile_width, tile_height), color="white"), (x, y))
        label = (
            f"{mode} flow sample {position + 1}/{len(opened)}  "
            f"source={path.name}  termination={termination}  score={score_text}"
        )
        ImageDraw.Draw(sheet).text((x + 8, y + tile_height + 9), label, fill="black", font=font)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(output_path, format="JPEG", quality=88, optimize=True, progressive=True)


def main() -> None:
    os.umask(0o002)
    args = parse_args()
    solver_root = args.solver_root.resolve()
    artifact_root = args.artifact_root.resolve()
    observation_dir = args.observation_dir.resolve()
    summary_path = artifact_root / "summary.json"
    if not summary_path.is_file():
        raise FileNotFoundError(f"wake summary missing: {summary_path}")
    summary = json.loads(summary_path.read_text(encoding="utf-8"))
    summary_vtk_enabled = summary.get("vtk_enabled")
    if summary_vtk_enabled is False or (summary_vtk_enabled is None and args.mode != "prewarm"):
        raise RuntimeError("wake rollout did not enable the required VTK visual stream")

    latest_value = summary.get("vtk_latest_frame")
    if latest_value:
        latest_path = Path(str(latest_value))
    elif args.mode == "prewarm":
        # The prewarm-only summary intentionally contains snapshot metadata only.
        # Validate the same latest-frame contract consumed by the standard watcher.
        latest_path = artifact_root / "vtk" / "latest_frame.json"
    else:
        raise RuntimeError("wake summary did not report vtk_latest_frame")
    if not latest_path.is_absolute():
        latest_path = artifact_root / latest_path
    if not latest_path.is_file():
        raise FileNotFoundError(f"wake VTK latest-frame manifest missing: {latest_path}")

    latest = json.loads(latest_path.read_text(encoding="utf-8"))
    if latest.get("status") != "ready":
        raise RuntimeError(f"wake VTK latest-frame manifest is not ready: {latest_path}")
    vtk_fields = {
        str(value).lower() for value in summary.get("vtk_fields", latest.get("fields", []))
    }
    if not {"vorticity", "body"}.issubset(vtk_fields):
        raise RuntimeError(f"wake VTK fields missing vorticity/body: {sorted(vtk_fields)}")
    frame_path = Path(str(latest.get("frame_path", "")))
    if not frame_path.is_absolute():
        frame_path = latest_path.parent / frame_path
    if not frame_path.is_file():
        raise FileNotFoundError(f"wake VTK frame missing: {frame_path}")

    watcher = solver_root / "cases" / "dogfish_2d_shape_policy" / "free_swim_vtk_watch_render.jl"
    if not watcher.is_file():
        raise FileNotFoundError(f"standard wake watcher missing: {watcher}")
    render_tag = (
        f"watch_render_scale{args.scale}_rwb_clim{args.clim.replace('.', 'p')}_fps{args.fps}"
    )
    render_dir = artifact_root / render_tag
    render_dir.mkdir(parents=True, exist_ok=True)
    runtime_dir = artifact_root / "runtime"
    runtime_dir.mkdir(parents=True, exist_ok=True)
    render_log = runtime_dir / f"{args.mode}_visual_render.log"
    ffmpeg_shim = Path(__file__).resolve().parent / "ffmpeg"
    if not ffmpeg_shim.is_file() or not os.access(ffmpeg_shim, os.X_OK):
        raise FileNotFoundError(f"repository ffmpeg shim is not executable: {ffmpeg_shim}")
    render_env = os.environ.copy()
    render_env["PATH"] = os.pathsep.join(
        (str(ffmpeg_shim.parent), render_env.get("PATH", ""))
    )
    julia_bin = os.environ.get("JULIA_BIN", "julia")
    command = [
        julia_bin,
        "--project=.",
        "--startup-file=no",
        str(watcher),
        "--latest",
        str(latest_path),
        "--render-existing",
        "--output-root",
        str(render_dir),
        "--clim",
        str(args.clim),
        "--scale",
        str(args.scale),
        "--encode-mp4",
        "--fps",
        str(args.fps),
    ]
    with render_log.open("w", encoding="utf-8") as handle:
        subprocess.run(
            command,
            cwd=solver_root,
            env=render_env,
            stdout=handle,
            stderr=subprocess.STDOUT,
            check=True,
        )

    render_summary_path = render_dir / "render_summary.json"
    if not render_summary_path.is_file():
        raise FileNotFoundError(f"standard wake watcher summary missing: {render_summary_path}")
    render_summary = json.loads(render_summary_path.read_text(encoding="utf-8"))
    target_marker = render_summary.get("target_marker")
    target_marker_drawn = isinstance(target_marker, dict)

    frame_paths = sorted(render_dir.glob("frame_*.bmp"))
    if not frame_paths:
        frame_paths = sorted(render_dir.glob("frame_*.png"))
    if not frame_paths:
        raise RuntimeError(f"standard wake watcher rendered no frames under {render_dir}")
    video_path = render_dir / "watch_render.mp4"
    if not video_path.is_file() or video_path.stat().st_size <= 0:
        raise RuntimeError(f"standard wake watcher did not encode a non-empty MP4: {video_path}")

    observation_dir.mkdir(parents=True, exist_ok=True)
    keyframe_name = "prewarm_keyframes.jpg" if args.mode == "prewarm" else "wake_keyframes.jpg"
    keyframe_path = observation_dir / keyframe_name
    make_sheet(
        frame_paths,
        keyframe_path,
        summary=summary,
        mode=args.mode,
        sample_count=args.sample_count,
        draw_target=not target_marker_drawn,
    )

    shared_prewarm = None
    if args.mode == "episode":
        shared_value = os.environ.get("DOGFISH_WAKE_PREWARM_KEYFRAMES", "").strip()
        if shared_value:
            source = Path(shared_value)
            if not source.is_file() or source.stat().st_size <= 0:
                raise FileNotFoundError(f"shared prewarm keyframes missing: {source}")
            shared_prewarm = observation_dir / "shared_prewarm_keyframes.jpg"
            shutil.copy2(source, shared_prewarm)

    manifest_name = (
        "prewarm_visual_manifest.json" if args.mode == "prewarm" else "visual_manifest.json"
    )
    manifest_path = observation_dir / manifest_name
    manifest = {
        "schema_version": "dogfish.wake_visual_observation.v1",
        "mode": args.mode,
        "vtk_latest_frame": str(latest_path),
        "vtk_fields": sorted(vtk_fields),
        "render_dir": str(render_dir),
        "render_log": str(render_log),
        "video": str(video_path),
        "keyframes": str(keyframe_path),
        "keyframes_relative": keyframe_path.name,
        "shared_prewarm_keyframes": str(shared_prewarm) if shared_prewarm else None,
        "shared_prewarm_keyframes_relative": shared_prewarm.name if shared_prewarm else None,
        "rendered_frame_count": len(frame_paths),
        "target_marker": target_marker,
        "target_marker_drawn_in_frames": target_marker_drawn,
        "selected_source_frames": [
            frame_paths[index].name for index in select_indices(len(frame_paths), args.sample_count)
        ],
    }
    manifest_path.write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(json.dumps(manifest, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
