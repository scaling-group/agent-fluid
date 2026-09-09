"""Render the illustrated 2D VTI fields without the legacy orange trail.

This is a NumPy translation of the archived renderer's scalar colour map,
BodySDF outline and target marker. The publication pipeline reads physical arrays in derived_data and creates
images in memory. Original simulator files are decoded by the extraction stage.
"""
from __future__ import annotations

import argparse
import csv
import gzip
import hashlib
import io
import json
from pathlib import Path
from paths import OUTPUT_DIR, external_output
import tempfile

import numpy as np
from PIL import Image, ImageFilter


def payload(path: Path) -> bytes:
    data = path.read_bytes()
    return gzip.decompress(data) if path.suffix == ".gz" else data


def rows(path: Path) -> list[dict]:
    return list(csv.DictReader(io.StringIO(payload(path).decode("utf-8-sig"))))


def read_field(path: Path):
    from vtkmodules.util.numpy_support import vtk_to_numpy
    from vtkmodules.vtkIOXML import vtkXMLImageDataReader

    with tempfile.TemporaryDirectory(prefix="aqua-vti-") as temporary:
        source = Path(temporary) / "field.vti"
        source.write_bytes(payload(path))
        reader = vtkXMLImageDataReader()
        reader.SetFileName(str(source))
        reader.Update()
        grid = reader.GetOutput()
        width, height, depth = grid.GetDimensions()
        if (width, height, depth) != (1538, 1026, 1):
            raise ValueError("Unexpected illustrated 2D grid")
        arrays = {}
        for name in ("Vorticity", "BodySDF"):
            values = vtk_to_numpy(grid.GetPointData().GetArray(name)).copy()
            if values.dtype != np.dtype("float32") or not np.isfinite(values).all():
                raise ValueError("Expected finite Float32 field: " + name)
            arrays[name] = values.reshape(height, width)
        return arrays, np.asarray(grid.GetOrigin()), np.asarray(grid.GetSpacing())


def pixel(center, origin, spacing, height):
    xy = np.rint((np.asarray(center) - origin[:2]) / spacing[:2]).astype(int)
    return int(xy[0]), int(height - 1 - xy[1])


def disk(rgb, x, y, radius, color, inner=-1):
    height, width = rgb.shape[:2]
    x0, x1 = max(0, x-radius), min(width, x+radius+1)
    y0, y1 = max(0, y-radius), min(height, y+radius+1)
    if x1 <= x0 or y1 <= y0:
        return
    yy, xx = np.ogrid[y0:y1, x0:x1]
    distance = (xx-x)**2 + (yy-y)**2
    mask = (distance <= radius**2) & (distance >= inner**2 if inner >= 0 else True)
    rgb[y0:y1, x0:x1][mask] = color


def line(rgb, x0, y0, x1, y1, color):
    """The archived integer Bresenham convention, including both endpoints."""
    dx, dy = abs(x1-x0), -abs(y1-y0)
    sx, sy = (1 if x0 < x1 else -1), (1 if y0 < y1 else -1)
    error = dx+dy
    height, width = rgb.shape[:2]
    while True:
        if 0 <= x0 < width and 0 <= y0 < height:
            rgb[y0, x0] = color
        if x0 == x1 and y0 == y1:
            break
        twice = 2*error
        if twice >= dy:
            error += dy
            x0 += sx
        if twice <= dx:
            error += dx
            y0 += sy


def target_marker(rgb, center, radius, origin, spacing):
    x, y = pixel(center, origin, spacing, rgb.shape[0])
    radius = max(7, round(radius / min(abs(spacing[:2]))))
    half = max(8, min(14, radius//3))
    white, green = (255,255,255), (0,150,55)
    disk(rgb, x, y, radius+2, white, inner=max(0, radius-4))
    disk(rgb, x, y, radius, green, inner=max(0, radius-3))
    for offset in range(-2,3):
        line(rgb,x-half,y+offset,x+half,y+offset,white)
        line(rgb,x+offset,y-half,x+offset,y+half,white)
    for offset in range(-1,2):
        line(rgb,x-half,y+offset,x+half,y+offset,green)
        line(rgb,x+offset,y-half,x+offset,y+half,green)
    disk(rgb,x,y,4,white)
    disk(rgb,x,y,2,green)


def render(arrays, origin, spacing, frame, history, summary, *, legacy=False):
    vorticity = arrays["Vorticity"]
    height, width = vorticity.shape
    # Match Float32 normalization followed by Float64 RGB interpolation.
    normalized = np.clip(vorticity / np.float32(0.8), -1, 1)[::-1].astype(float)
    weight = np.abs(normalized)[...,None]
    end = np.where((normalized < 0)[...,None], (33,102,172), (178,24,43))
    rgb = np.rint((1-weight)*255 + weight*end).astype(np.uint8)
    center = [float(frame["center_x"]),float(frame["center_y"])]
    cx, cy = pixel(center, origin, spacing, height)
    sy = height-1-cy
    rx, ry = max(32,round(.08*width)), max(16,round(.08*height))
    x0,x1 = max(0,cx-rx),min(width-1,cx+rx+1)
    y0,y1 = max(0,sy-ry),min(height-1,sy+ry+1)
    sdf = arrays["BodySDF"]
    current = sdf[y0:y1,x0:x1] <= 0
    boundary = ((current != (sdf[y0:y1,x0+1:x1+1] <= 0)) |
                (current != (sdf[y0+1:y1+1,x0:x1] <= 0)))
    yy,xx = np.nonzero(boundary)
    black,orange,white = (5,8,8),(255,166,0),(255,255,255)
    rgb[height-1-(yy+y0),xx+x0] = black
    if legacy and history:
        points = [pixel([float(r['center_x']),float(r['center_y'])],origin,spacing,height)
                  for r in history]
        for first,last in zip(points,points[1:]):
            line(rgb,*first,*last,orange)
        disk(rgb,*points[0],3,white)
        disk(rgb,*points[0],2,orange)
    disk(rgb,cx,cy,3,black)
    if legacy:
        disk(rgb,cx,cy,2,orange)
    target_marker(rgb,summary['target'],float(summary['success_radius']),origin,spacing)
    return Image.fromarray(rgb)


def fig2_target(image):
    """Retain the reviewed Figure 2 target colour and marker footprint."""
    a = np.asarray(image).astype(int)
    r,g,b = a[...,0],a[...,1],a[...,2]
    mask = (g>80)&(g>r+25)&(g>b+15)&(r<120)
    roi = np.zeros(mask.shape,dtype=bool)
    roi[340:490,500:650] = True
    mask = Image.fromarray(((mask&roi)*255).astype(np.uint8)).filter(ImageFilter.MaxFilter(5))
    return Image.composite(Image.new('RGB',image.size,(43,138,98)),image,mask)
