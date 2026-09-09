"""Extract exact swimmer masks for solid black bodies above the flow and paths.

The optional extraction uses the pinned BodySDF fields at every shown time. Normal
figure builds need only the small portable masks and existing field PNGs.
"""
from __future__ import annotations

import argparse
from collections import deque
import hashlib
import json
from pathlib import Path
from paths import OUTPUT_DIR, external_output
import re
import struct
from xml.etree import ElementTree
import zlib

import numpy as np
from PIL import Image

from raw_2d_frames import disk, fig2_target, payload, pixel, render, rows


ROOT = Path(__file__).resolve().parents[2]
DISPLAY_CROP = (0, 0, 1538, 864)


def read_field(path: Path):
    """Read the two archived raw-appended Float32 VTI encodings without VTK."""
    data = payload(path)
    match = re.search(rb'<AppendedData\s+encoding="raw">\s*_', data)
    if match is None:
        raise ValueError("Expected raw-appended VTI")
    tree = ElementTree.fromstring(data[:match.start()] + b"</VTKFile>")
    if (tree.get("byte_order"), tree.get("header_type")) != ("LittleEndian", "UInt64"):
        raise ValueError("Unexpected VTI byte/header convention")
    grid = tree.find("ImageData")
    if grid.get("WholeExtent") != "0 1537 0 1025 0 0":
        raise ValueError("Unexpected illustrated grid")
    origin = np.fromstring(grid.get("Origin"), sep=" ")
    spacing = np.fromstring(grid.get("Spacing"), sep=" ")
    arrays = {}
    for name in ("Vorticity", "BodySDF"):
        record = grid.find(f".//DataArray[@Name='{name}']")
        if (record.get("type"), record.get("format"), record.get("NumberOfComponents")) != (
            "Float32", "appended", "1"
        ):
            raise ValueError("Unexpected scalar array encoding")
        offset = match.end() + int(record.get("offset"))
        if tree.get("compressor") == "vtkZLibDataCompressor":
            count, block_size, last_size = struct.unpack_from("<QQQ", data, offset)
            sizes = struct.unpack_from("<" + "Q" * count, data, offset + 24)
            offset += 8 * (3 + count)
            blocks = []
            for index, size in enumerate(sizes):
                block = zlib.decompress(data[offset:offset + size])
                expected = last_size if index == count - 1 else block_size
                if len(block) != expected:
                    raise ValueError("Unexpected decompressed array length")
                blocks.append(block)
                offset += size
            raw = b"".join(blocks)
        elif tree.get("compressor") is None:
            size, = struct.unpack_from("<Q", data, offset)
            raw = data[offset + 8:offset + 8 + size]
        else:
            raise ValueError("Unsupported VTI compressor")
        values = np.frombuffer(raw, dtype="<f4").reshape(1026, 1538)
        if not np.isfinite(values).all():
            raise ValueError("Non-finite archived scalar field")
        arrays[name] = values
    return arrays, origin, spacing


def swimmer_mask(arrays, origin, spacing, frame):
    """Use the original renderer's body interior, outline and centre marker."""
    sdf = arrays["BodySDF"]
    height, width = sdf.shape
    cx, cy = pixel([float(frame["center_x"]), float(frame["center_y"])],
                   origin, spacing, height)
    sy = height - 1 - cy
    rx, ry = max(32, round(.08 * width)), max(16, round(.08 * height))
    x0, x1 = max(0, cx - rx), min(width - 1, cx + rx + 1)
    y0, y1 = max(0, sy - ry), min(height - 1, sy + ry + 1)
    inside = sdf[y0:y1, x0:x1] <= 0
    yy, xx = np.nonzero(inside)
    if not len(xx):
        raise ValueError("Empty swimmer neighbourhood")
    nearest = np.argmin((xx + x0 - cx) ** 2 + (yy + y0 - sy) ** 2)
    selected = np.zeros_like(inside)
    pending = deque([(int(yy[nearest]), int(xx[nearest]))])
    while pending:
        y, x = pending.popleft()
        if not (0 <= y < inside.shape[0] and 0 <= x < inside.shape[1]):
            continue
        if selected[y, x] or not inside[y, x]:
            continue
        selected[y, x] = True
        pending.extend((y + dy, x + dx) for dy in (-1, 0, 1) for dx in (-1, 0, 1)
                       if dy or dx)
    yy, xx = np.nonzero(selected)
    # The swimmer is 64 cells long. Reject an ROI containing a distant obstacle.
    if not len(xx) or np.max(np.hypot(xx + x0 - cx, yy + y0 - sy)) > 64:
        raise ValueError("Body ROI is empty or includes non-swimmer geometry")
    body = np.zeros((height, width), dtype=bool)
    body[y0:y1, x0:x1] = selected
    boundary = np.zeros_like(body)
    boundary[:-1, :-1] = ((body[:-1, :-1] != body[:-1, 1:]) |
                          (body[:-1, :-1] != body[1:, :-1]))
    mask = ((body | boundary)[::-1] * 255).astype(np.uint8)
    disk(mask, cx, cy, 3, 255)
    return Image.fromarray(mask).crop(DISPLAY_CROP)


def foreground_patch(frame: Image.Image, body_mask: Image.Image):
    """Draw the silhouette computed from BodySDF, above the trajectory path."""
    with body_mask.copy() as source:
        if source.size != DISPLAY_CROP[2:]:
            raise ValueError("Unexpected swimmer mask dimensions")
        mask = source.convert("L")
    if mask.size != frame.size:
        mask = mask.resize(frame.size, Image.Resampling.LANCZOS)
    bbox = mask.getbbox()
    if bbox is None:  # The seed has already left the displayed lower crop.
        return None
    foreground = Image.new("RGBA", (bbox[2] - bbox[0], bbox[3] - bbox[1]), (0, 0, 0, 255))
    foreground.putalpha(mask.crop(bbox))
    return foreground, bbox
