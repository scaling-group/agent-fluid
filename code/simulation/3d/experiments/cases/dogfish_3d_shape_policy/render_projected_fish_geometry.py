#!/usr/bin/env python3
"""Render the projected 3D dogfish without constructing a CFD simulation.

This review tool mirrors the geometry constants in ``src/geometry3d.jl`` and
``src/caudal_fin3d.jl``.  It deliberately renders both the continuous surface
and the cell-centre negative-SDF mask so an attractive smooth mesh cannot hide
an under-resolved L16 body.
"""

from __future__ import annotations

import argparse
import json
import math
import tomllib
from dataclasses import dataclass
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFont


WIDTH_SAMPLES = np.asarray((0.03, 0.07, 0.06, 0.048, 0.03, 0.019, 0.01))
MODELER_WIDTH_SAMPLES = np.asarray((0.0, 0.0549, 0.0642, 0.0589, 0.0471, 0.0293, 0.0))
MODELER_ZTOP_SAMPLES = np.asarray((0.0, 0.0474, 0.0553, 0.0510, 0.0407, 0.0246, 0.0))
MODELER_ZBOT_SAMPLES = np.asarray((0.0, 0.0326, 0.0401, 0.0376, 0.0297, 0.0176, 0.0))
MODELER_ETOP_SAMPLES = np.asarray((2.0, 2.1458, 2.2667, 2.3406, 2.3583, 2.2885, 2.0))
MODELER_EBOT_SAMPLES = np.asarray((2.0, 1.9698, 1.9083, 1.8563, 1.8417, 1.8865, 2.0))
RHO_HEAD = 0.75
RHO_MAX = 1.05
RHO_SIGMA = 0.18
JOINT_CENTERS = (1.0 / 3.0, 2.0 / 3.0)
JOINT_HALF_WIDTHS = (1.0 / 8.0, 1.0 / 8.0)


def smootherstep(value: np.ndarray | float) -> np.ndarray:
    x = np.clip(value, 0.0, 1.0)
    return x**3 * (x * (x * 6.0 - 15.0) + 10.0)


def profile_values(samples: np.ndarray, s: np.ndarray | float) -> np.ndarray:
    s_array = np.asarray(s, dtype=float)
    scaled = np.clip(s_array, 0.0, 1.0) * (len(samples) - 1)
    lower = np.minimum(np.floor(scaled).astype(int), len(samples) - 2)
    alpha = scaled - lower
    smooth_alpha = alpha * alpha * (3.0 - 2.0 * alpha)
    return samples[lower] + smooth_alpha * (samples[lower + 1] - samples[lower])


def profile_width(s: np.ndarray | float) -> np.ndarray:
    return profile_values(WIDTH_SAMPLES, s)


def height_ratio(s: np.ndarray | float) -> np.ndarray:
    clipped = np.clip(np.asarray(s, dtype=float), 0.0, 1.0)
    return RHO_MAX - (RHO_MAX - RHO_HEAD) * np.exp(-((clipped / RHO_SIGMA) ** 2))


@dataclass(frozen=True)
class Geometry:
    resolution: int
    phi1: float
    phi2: float
    fin_x_start: float
    fin_x_end: float
    fin_height: float
    nominal_fin_half_thickness: float
    fin_model: str = "legacy-fan"
    fin_upper_height: float = 0.13
    fin_lower_height: float = 0.09
    fin_lower_tip_fraction: float = 0.78
    body_model: str = "revolution"

    @property
    def fin_half_thickness(self) -> float:
        # caudal_fin3d.jl clamps to at least one grid cell per side.
        return max(self.nominal_fin_half_thickness, 1.0 / self.resolution)

    def bend_angle(self, s: np.ndarray | float) -> np.ndarray:
        s_array = np.asarray(s, dtype=float)
        result = np.zeros_like(s_array)
        for phi, center, half_width in zip(
            (self.phi1, self.phi2), JOINT_CENTERS, JOINT_HALF_WIDTHS
        ):
            z = (s_array - (center - half_width)) / (2.0 * half_width)
            result += phi * smootherstep(z)
        return result

    def centerline(self, s: np.ndarray | float) -> np.ndarray:
        values = np.atleast_1d(np.asarray(s, dtype=float))
        result = np.zeros((len(values), 3), dtype=float)
        # Match the midpoint arc quadrature used by kinematics.jl.
        for row, value in enumerate(values):
            clipped = float(np.clip(value, 0.0, 1.0))
            ds = clipped / 32.0
            samples = (np.arange(32, dtype=float) + 0.5) * ds
            angles = self.bend_angle(samples)
            result[row, 0] = np.sum(np.cos(angles)) * ds
            result[row, 1] = np.sum(np.sin(angles)) * ds
        return result if np.ndim(s) else result[0]

    def frame(self, s: np.ndarray) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
        angle = self.bend_angle(s)
        tangent = np.stack((np.cos(angle), np.sin(angle), np.zeros_like(angle)), axis=-1)
        normal = np.stack((-np.sin(angle), np.cos(angle), np.zeros_like(angle)), axis=-1)
        vertical = np.zeros_like(tangent)
        vertical[:, 2] = 1.0
        return tangent, normal, vertical

    def map_reference(self, xyz: np.ndarray) -> np.ndarray:
        """Forward-map spine reference coordinates to the deformed fish."""
        x = xyz[:, 0]
        s = np.clip(x, 0.0, 1.0)
        centers = self.centerline(s)
        tangent, normal, vertical = self.frame(s)
        axial = x - s
        return (
            centers
            + axial[:, None] * tangent
            + xyz[:, 1, None] * normal
            + xyz[:, 2, None] * vertical
        )

    def inverse_reference(self, xyz: np.ndarray) -> np.ndarray:
        """Mirror closest_spine_reference_coordinate for SDF sampling."""
        q = np.asarray(xyz, dtype=float)
        s = np.clip(q[:, 0], 0.0, 1.0)
        for _ in range(6):
            center = self.centerline(s)
            tangent, _, _ = self.frame(s)
            tangent_offset = np.sum((q - center) * tangent, axis=1)
            s = np.clip(s + tangent_offset, 0.0, 1.0)
        center = self.centerline(s)
        tangent, normal, _ = self.frame(s)
        delta = q - center
        return np.stack(
            (
                s + np.sum(delta * tangent, axis=1),
                np.sum(delta * normal, axis=1),
                delta[:, 2],
            ),
            axis=1,
        )

    @property
    def fin_root_upper(self) -> float:
        if self.body_model == "modeler-superellipse":
            return float(profile_values(MODELER_ZTOP_SAMPLES, self.fin_x_start))
        return float(profile_width(self.fin_x_start) * height_ratio(self.fin_x_start))

    @property
    def fin_root_lower(self) -> float:
        if self.body_model == "modeler-superellipse":
            return float(profile_values(MODELER_ZBOT_SAMPLES, self.fin_x_start))
        return self.fin_root_upper

    def modeler_surface_coordinates(self, u, v):
        root_z = (1.0 - u) * self.fin_root_upper - u * self.fin_root_lower
        lower_tip = self.fin_x_start + (
            self.fin_x_end - self.fin_x_start
        ) * self.fin_lower_tip_fraction
        tip_x = (1.0 - u) * self.fin_x_end + u * lower_tip
        tip_z = (1.0 - u) * self.fin_upper_height - u * self.fin_lower_height
        x = (1.0 - v) * self.fin_x_start + v * tip_x
        z = (1.0 - v) * root_z + v * tip_z
        return x, z

    def modeler_surface_jacobian(self, u, v):
        root_upper = self.fin_root_upper
        root_lower = self.fin_root_lower
        lower_tip = self.fin_x_start + (
            self.fin_x_end - self.fin_x_start
        ) * self.fin_lower_tip_fraction
        root_dz_du = -(root_upper + root_lower)
        tip_dx_du = lower_tip - self.fin_x_end
        tip_dz_du = -(self.fin_upper_height + self.fin_lower_height)
        root_z = (1.0 - u) * root_upper - u * root_lower
        tip_x = (1.0 - u) * self.fin_x_end + u * lower_tip
        tip_z = (1.0 - u) * self.fin_upper_height - u * self.fin_lower_height
        return (
            v * tip_dx_du,
            (1.0 - v) * root_dz_du + v * tip_dz_du,
            tip_x - self.fin_x_start,
            tip_z - root_z,
        )

    def modeler_uv(self, px, pz):
        root_span = self.fin_root_upper + self.fin_root_lower
        u = np.clip((self.fin_root_upper - pz) / root_span, 0.0, 1.0)
        lower_tip = self.fin_x_start + (
            self.fin_x_end - self.fin_x_start
        ) * self.fin_lower_tip_fraction
        tip_x = (1.0 - u) * self.fin_x_end + u * lower_tip
        v = np.clip(
            (px - self.fin_x_start) / np.maximum(tip_x - self.fin_x_start, 1e-12),
            0.0,
            1.0,
        )
        for _ in range(4):
            sx, sz = self.modeler_surface_coordinates(u, v)
            dx_du, dz_du, dx_dv, dz_dv = self.modeler_surface_jacobian(u, v)
            rx, rz = sx - px, sz - pz
            determinant = dx_du * dz_dv - dz_du * dx_dv
            safe = np.abs(determinant) > np.finfo(float).eps
            delta_u = np.where(safe, (rx * dz_dv - rz * dx_dv) / determinant, 0.0)
            delta_v = np.where(safe, (dx_du * rz - dz_du * rx) / determinant, 0.0)
            u = np.clip(u - delta_u, -0.25, 1.25)
            v = np.clip(v - delta_v, -0.25, 1.25)
        return np.clip(u, 0.0, 1.0), np.clip(v, 0.0, 1.0)

    def modeler_thickness(self, u, v):
        span_taper = np.maximum(0.0, 1.0 - v) ** 0.85
        chord_position = 2.0 * u - 1.0
        chord_taper = 0.16 + 0.84 * np.sqrt(
            np.maximum(0.0, 1.0 - chord_position * chord_position)
        )
        return self.fin_half_thickness * span_taper * chord_taper

    def sdf(self, xyz: np.ndarray) -> np.ndarray:
        ref = self.inverse_reference(xyz)
        s = np.clip(ref[:, 0], 0.0, 1.0)
        dx = ref[:, 0] - s
        if self.body_model == "modeler-superellipse":
            axial = np.maximum(-ref[:, 0], ref[:, 0] - 1.0)
            width = np.maximum(profile_values(MODELER_WIDTH_SAMPLES, s), 1e-4)
            dorsal = ref[:, 2] >= 0.0
            zscale = np.maximum(
                np.where(
                    dorsal,
                    profile_values(MODELER_ZTOP_SAMPLES, s),
                    profile_values(MODELER_ZBOT_SAMPLES, s),
                ),
                1e-4,
            )
            exponent = np.where(
                dorsal,
                profile_values(MODELER_ETOP_SAMPLES, s),
                profile_values(MODELER_EBOT_SAMPLES, s),
            )
            radial = np.hypot(ref[:, 1], ref[:, 2])
            safe_radial = np.maximum(radial, 1e-12)
            cphi = ref[:, 1] / safe_radial
            sphi = ref[:, 2] / safe_radial
            inv_t = (np.abs(cphi) / width) ** exponent + (
                np.abs(sphi) / zscale
            ) ** exponent
            cross = radial - inv_t ** (-1.0 / exponent)
            cross = np.where(radial < 1e-4, -np.minimum(width, zscale), cross)
            body = np.minimum(np.maximum(cross, axial), 0.0) + np.hypot(
                np.maximum(cross, 0.0), np.maximum(axial, 0.0)
            )
        else:
            radius = profile_width(s)
            body = np.sqrt(
                dx * dx
                + ref[:, 1] * ref[:, 1]
                + (ref[:, 2] / height_ratio(s)) ** 2
            ) - radius
        if self.fin_model == "modeler-tapered":
            px, pz = ref[:, 0], ref[:, 2]
            u, v = self.modeler_uv(px, pz)
            x0, z0 = self.fin_x_start, self.fin_root_upper
            x1, z1 = self.fin_x_end, self.fin_upper_height
            x2 = self.fin_x_start + (
                self.fin_x_end - self.fin_x_start
            ) * self.fin_lower_tip_fraction
            z2 = -self.fin_lower_height
            x3, z3 = self.fin_x_start, -self.fin_root_lower

            def edge_distance(ax, az, bx, bz):
                ex, ez = bx - ax, bz - az
                return (ex * (pz - az) - ez * (px - ax)) / math.hypot(ex, ez)

            planar = np.maximum.reduce(
                (
                    edge_distance(x0, z0, x1, z1),
                    edge_distance(x1, z1, x2, z2),
                    edge_distance(x2, z2, x3, z3),
                    edge_distance(x3, z3, x0, z0),
                )
            )
            fin = np.maximum(planar, np.abs(ref[:, 1]) - self.modeler_thickness(u, v))
        else:
            u = (ref[:, 0] - self.fin_x_start) / max(
                self.fin_x_end - self.fin_x_start, np.finfo(float).eps
            )
            height = self.fin_height * smootherstep(u)
            fin = np.maximum.reduce(
                (
                    np.abs(ref[:, 2]) - height,
                    self.fin_x_start - ref[:, 0],
                    ref[:, 0] - self.fin_x_end,
                    np.abs(ref[:, 1]) - self.fin_half_thickness,
                )
            )
        return np.minimum(body, fin)


def body_mesh(geometry: Geometry, n_s: int = 150, n_theta: int = 36):
    s = np.linspace(0.0, 1.0, n_s)
    theta = np.linspace(0.0, 2.0 * math.pi, n_theta, endpoint=False)
    centers = geometry.centerline(s)
    _, normal, vertical = geometry.frame(s)
    cosine = np.cos(theta)[None, :]
    sine = np.sin(theta)[None, :]
    if geometry.body_model == "modeler-superellipse":
        width = profile_values(MODELER_WIDTH_SAMPLES, s)[:, None]
        dorsal = sine >= 0.0
        zscale = np.where(
            dorsal,
            profile_values(MODELER_ZTOP_SAMPLES, s)[:, None],
            profile_values(MODELER_ZBOT_SAMPLES, s)[:, None],
        )
        exponent = np.where(
            dorsal,
            profile_values(MODELER_ETOP_SAMPLES, s)[:, None],
            profile_values(MODELER_EBOT_SAMPLES, s)[:, None],
        )
        lateral = width * np.sign(cosine) * np.abs(cosine) ** (2.0 / exponent)
        height = zscale * np.sign(sine) * np.abs(sine) ** (2.0 / exponent)
        vertices = (
            centers[:, None, :]
            + lateral[:, :, None] * normal[:, None, :]
            + height[:, :, None] * vertical[:, None, :]
        ).reshape(-1, 3)
    else:
        radius = profile_width(s)
        height = radius * height_ratio(s)
        vertices = (
            centers[:, None, :]
            + radius[:, None, None] * cosine[:, :, None] * normal[:, None, :]
            + height[:, None, None] * sine[:, :, None] * vertical[:, None, :]
        ).reshape(-1, 3)
    faces = []
    for i in range(n_s - 1):
        for j in range(n_theta):
            a = i * n_theta + j
            b = i * n_theta + (j + 1) % n_theta
            c = (i + 1) * n_theta + (j + 1) % n_theta
            d = (i + 1) * n_theta + j
            faces.extend(((a, b, c), (a, c, d)))
    return vertices, np.asarray(faces, dtype=int)


def fin_mesh(geometry: Geometry, n_x: int = 90):
    if geometry.fin_model == "modeler-tapered":
        n_u, n_v = 44, 58
        u_values = np.linspace(0.0, 1.0, n_u)
        v_values = np.linspace(0.0, 1.0, n_v)
        uu, vv = np.meshgrid(u_values, v_values, indexing="ij")
        xx, zz = geometry.modeler_surface_coordinates(uu, vv)
        half_t = geometry.modeler_thickness(uu, vv)
        vertices = []
        for sign in (-1.0, 1.0):
            reference = np.stack((xx, sign * half_t, zz), axis=-1).reshape(-1, 3)
            vertices.append(geometry.map_reference(reference))
        vertices = np.concatenate(vertices, axis=0)
        side_stride = n_u * n_v
        faces = []
        for side in range(2):
            offset = side * side_stride
            for iu in range(n_u - 1):
                for iv in range(n_v - 1):
                    a = offset + iu * n_v + iv
                    b = a + 1
                    d = offset + (iu + 1) * n_v + iv
                    c = d + 1
                    faces.extend(((a, b, c), (a, c, d)))
        # Join all four tapered perimeter edges.
        loops = (
            [iu * n_v for iu in range(n_u)],
            [iu * n_v + n_v - 1 for iu in range(n_u)],
            list(range(n_v)),
            [(n_u - 1) * n_v + iv for iv in range(n_v)],
        )
        for loop in loops:
            for first, second in zip(loop[:-1], loop[1:]):
                faces.extend(
                    (
                        (first, second, side_stride + second),
                        (first, side_stride + second, side_stride + first),
                    )
                )
        return vertices, np.asarray(faces, dtype=int)

    x = np.linspace(geometry.fin_x_start, geometry.fin_x_end, n_x)
    u = (x - geometry.fin_x_start) / (geometry.fin_x_end - geometry.fin_x_start)
    height = geometry.fin_height * smootherstep(u)
    half_t = geometry.fin_half_thickness
    vertices = []
    # Two broad x-z faces at y=+-thickness.
    for y in (-half_t, half_t):
        for xx, hh in zip(x, height):
            vertices.extend(((xx, y, -hh), (xx, y, hh)))
    vertices = geometry.map_reference(np.asarray(vertices, dtype=float))
    faces = []
    face_stride = 2 * n_x
    for side in range(2):
        offset = side * face_stride
        for i in range(n_x - 1):
            a, b = offset + 2 * i, offset + 2 * i + 1
            c, d = offset + 2 * (i + 1) + 1, offset + 2 * (i + 1)
            faces.extend(((a, b, c), (a, c, d)))
    # Join the upper/lower and trailing edges so the effective thickness reads.
    for i in range(n_x - 1):
        for edge in (0, 1):
            a = 2 * i + edge
            b = 2 * (i + 1) + edge
            c = face_stride + 2 * (i + 1) + edge
            d = face_stride + 2 * i + edge
            faces.extend(((a, b, c), (a, c, d)))
    a, b = 2 * (n_x - 1), 2 * (n_x - 1) + 1
    c, d = face_stride + 2 * (n_x - 1) + 1, face_stride + 2 * (n_x - 1)
    faces.extend(((a, b, c), (a, c, d)))
    return vertices, np.asarray(faces, dtype=int)


def _font(size: int, bold: bool = False):
    candidates = (
        "C:/Windows/Fonts/arialbd.ttf" if bold else "C:/Windows/Fonts/arial.ttf",
        "DejaVuSans-Bold.ttf" if bold else "DejaVuSans.ttf",
    )
    for candidate in candidates:
        try:
            return ImageFont.truetype(candidate, size)
        except OSError:
            pass
    return ImageFont.load_default()


def render_mesh_panel(
    meshes,
    camera,
    target,
    up,
    title,
    subtitle,
    size=(820, 570),
    bounds=None,
):
    width, height = size
    image = Image.new("RGB", size, "#eef3f7")
    draw = ImageDraw.Draw(image)
    camera = np.asarray(camera, dtype=float)
    target = np.asarray(target, dtype=float)
    forward = target - camera
    forward /= np.linalg.norm(forward)
    right = np.cross(forward, np.asarray(up, dtype=float))
    right /= np.linalg.norm(right)
    true_up = np.cross(right, forward)

    all_vertices = np.concatenate([mesh[0] for mesh in meshes], axis=0)
    centered = all_vertices - target
    sx = centered @ right
    sy = centered @ true_up
    if bounds is None:
        pad_x = max(np.ptp(sx) * 0.10, 0.02)
        pad_y = max(np.ptp(sy) * 0.16, 0.02)
        bounds = (sx.min() - pad_x, sx.max() + pad_x, sy.min() - pad_y, sy.max() + pad_y)
    xmin, xmax, ymin, ymax = bounds
    plot_top = 82
    plot_bottom = height - 30
    scale = min((width - 44) / (xmax - xmin), (plot_bottom - plot_top) / (ymax - ymin))
    xmid, ymid = (xmin + xmax) / 2.0, (ymin + ymax) / 2.0

    def project(vertices):
        relative = vertices - target
        px = width / 2.0 + (relative @ right - xmid) * scale
        py = (plot_top + plot_bottom) / 2.0 - (relative @ true_up - ymid) * scale
        depth = relative @ forward
        return np.stack((px, py, depth), axis=1)

    light = np.asarray((-0.3, -0.55, 0.78), dtype=float)
    light /= np.linalg.norm(light)
    triangles = []
    for vertices, faces, base_color in meshes:
        projected = project(vertices)
        rgb = np.asarray(base_color, dtype=float)
        for face in faces:
            points = vertices[face]
            normal = np.cross(points[1] - points[0], points[2] - points[0])
            norm = np.linalg.norm(normal)
            if norm < 1e-12:
                continue
            normal /= norm
            intensity = 0.50 + 0.50 * abs(float(normal @ light))
            color = tuple(np.clip(rgb * intensity, 0, 255).astype(int))
            poly = [(float(projected[i, 0]), float(projected[i, 1])) for i in face]
            triangles.append((float(np.mean(projected[face, 2])), poly, color))
    for _, polygon, color in sorted(triangles, key=lambda item: item[0], reverse=True):
        draw.polygon(polygon, fill=color)

    draw.text((22, 15), title, fill="#142536", font=_font(25, bold=True))
    draw.text((22, 48), subtitle, fill="#526675", font=_font(15))
    return image


def occupancy_projection(geometry: Geometry, axis: str):
    cell = 1.0 / geometry.resolution
    x_values = np.arange(-0.12, 1.16 + cell, cell)
    y_values = np.arange(-0.20, 0.20 + cell, cell)
    z_values = np.arange(-0.20, 0.20 + cell, cell)
    xx, yy, zz = np.meshgrid(x_values, y_values, z_values, indexing="ij")
    points = np.stack((xx.ravel(), yy.ravel(), zz.ravel()), axis=1)
    occupied = (geometry.sdf(points) <= 0.0).reshape(xx.shape)
    if axis == "top":
        return x_values, y_values, np.any(occupied, axis=2).T
    if axis == "side":
        return x_values, z_values, np.any(occupied, axis=1).T
    raise ValueError(axis)


def render_grid_panel(geometry: Geometry, axis: str, size=(820, 350)):
    width, height = size
    image = Image.new("RGB", size, "#f7fafc")
    draw = ImageDraw.Draw(image)
    x_values, transverse, mask = occupancy_projection(geometry, axis)
    left, right, top, bottom = 40, width - 20, 75, height - 34
    cell_px = min((right - left) / len(x_values), (bottom - top) / len(transverse))
    plot_w, plot_h = len(x_values) * cell_px, len(transverse) * cell_px
    x0 = (width - plot_w) / 2.0
    y0 = top + ((bottom - top) - plot_h) / 2.0
    for row in range(mask.shape[0]):
        for col in range(mask.shape[1]):
            if not mask[row, col]:
                continue
            px0 = x0 + col * cell_px
            py0 = y0 + (mask.shape[0] - 1 - row) * cell_px
            draw.rectangle(
                (px0, py0, px0 + cell_px, py0 + cell_px),
                fill="#4f7189",
                outline="#263f51",
                width=max(1, int(cell_px * 0.06)),
            )
    title = f"L{geometry.resolution} {axis} projection: negative-SDF cell centres"
    draw.text((22, 15), title, fill="#142536", font=_font(22, bold=True))
    draw.text(
        (22, 45),
        "Each square is one solver cell; BDIM adds a smooth interface band.",
        fill="#526675",
        font=_font(14),
    )
    return image


def labelled_sheet(images, title, output):
    margin, gap = 30, 22
    sheet_width = max(image.width for image in images) * 2 + gap + 2 * margin
    rows = math.ceil(len(images) / 2)
    row_height = max(image.height for image in images)
    sheet_height = 92 + rows * row_height + (rows - 1) * gap + margin
    sheet = Image.new("RGB", (sheet_width, sheet_height), "#dce6ed")
    draw = ImageDraw.Draw(sheet)
    draw.text((margin, 20), title, fill="#102433", font=_font(31, bold=True))
    for index, image in enumerate(images):
        row, col = divmod(index, 2)
        x = margin + col * (max(i.width for i in images) + gap)
        y = 78 + row * (row_height + gap)
        sheet.paste(image, (x, y))
    sheet.save(output, quality=95)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=Path, required=True)
    parser.add_argument("--resolution", type=int, default=16)
    parser.add_argument("--compare-resolution", type=int, default=32)
    parser.add_argument(
        "--fin-model",
        choices=("legacy-fan", "modeler-tapered"),
        default="legacy-fan",
    )
    parser.add_argument(
        "--body-model",
        choices=("revolution", "modeler-superellipse"),
        default="revolution",
    )
    parser.add_argument("--output-dir", type=Path, required=True)
    return parser.parse_args()


def geometry_from_config(
    config: dict, resolution: int, fin_model: str, body_model: str
) -> Geometry:
    projected = config["projected_multiwake_3d"]
    return Geometry(
        resolution=resolution,
        phi1=math.radians(float(projected["initial_phi1_deg"])),
        phi2=math.radians(float(projected["initial_phi2_deg"])),
        fin_x_start=float(projected["fin_x_start"]),
        fin_x_end=float(projected["fin_x_end"]),
        fin_height=float(projected["fin_height"]),
        nominal_fin_half_thickness=float(projected["fin_half_thickness"]),
        fin_model=fin_model,
        body_model=body_model,
    )


def main():
    args = parse_args()
    with args.config.open("rb") as handle:
        config = tomllib.load(handle)
    args.output_dir.mkdir(parents=True, exist_ok=True)
    primary = geometry_from_config(
        config, args.resolution, args.fin_model, args.body_model
    )
    comparison = geometry_from_config(
        config, args.compare_resolution, args.fin_model, args.body_model
    )
    body = body_mesh(primary)
    fin = fin_mesh(primary)
    meshes = (
        (body[0], body[1], (115, 146, 164)),
        (fin[0], fin[1], (67, 103, 128)),
    )
    target = (0.54, 0.0, 0.0)
    oblique = render_mesh_panel(
        meshes,
        camera=(-1.0, -2.8, 1.55),
        target=target,
        up=(0.0, 0.0, 1.0),
        title=f"L{primary.resolution} effective geometry - oblique",
        subtitle="Initial joints: +8 deg / -8 deg; one-cell-per-side fin clamp applied",
    )
    top = render_mesh_panel(
        meshes,
        camera=(0.54, 0.0, 5.0),
        target=target,
        up=(0.0, 1.0, 0.0),
        title=f"L{primary.resolution} effective geometry - strict top",
        subtitle="This is the control-plane silhouette used in the 2D-to-3D projection.",
    )
    side = render_mesh_panel(
        meshes,
        camera=(0.54, -5.0, 0.0),
        target=target,
        up=(0.0, 0.0, 1.0),
        title=f"L{primary.resolution} effective geometry - lateral",
        subtitle="Hero fan is vertical; its trailing-edge full span is 0.22 L.",
    )
    hero_path = args.output_dir / f"projected_dogfish_L{primary.resolution}_hero.png"
    labelled_sheet(
        [oblique, top, side, render_grid_panel(primary, "top")],
        f"Final projected 3D dogfish - {primary.body_model} + {primary.fin_model} (no CFD)",
        hero_path,
    )
    diagnostic_path = args.output_dir / (
        f"projected_dogfish_L{primary.resolution}_L{comparison.resolution}_grid_review.png"
    )
    labelled_sheet(
        [
            render_grid_panel(primary, "top"),
            render_grid_panel(primary, "side"),
            render_grid_panel(comparison, "top"),
            render_grid_panel(comparison, "side"),
        ],
        "Resolution audit - solver-cell silhouettes",
        diagnostic_path,
    )
    metadata = {
        "simulation_created": False,
        "config": str(args.config.resolve()),
        "config_resolution": int(config["free_swim"]["L"]),
        "preview_resolutions": [primary.resolution, comparison.resolution],
        "fin_model": primary.fin_model,
        "body_model": primary.body_model,
        "initial_joint_degrees": [
            math.degrees(primary.phi1),
            math.degrees(primary.phi2),
        ],
        "maximum_body_full_width_L": float(
            2.0
            * np.max(
                MODELER_WIDTH_SAMPLES
                if primary.body_model == "modeler-superellipse"
                else WIDTH_SAMPLES
            )
        ),
        "maximum_body_full_width_cells": {
            str(item.resolution): float(
                2.0
                * np.max(
                    MODELER_WIDTH_SAMPLES
                    if item.body_model == "modeler-superellipse"
                    else WIDTH_SAMPLES
                )
                * item.resolution
            )
            for item in (primary, comparison)
        },
        "nominal_fin_full_thickness_L": 2.0 * primary.nominal_fin_half_thickness,
        "effective_fin_full_thickness_L": {
            str(item.resolution): 2.0 * item.fin_half_thickness
            for item in (primary, comparison)
        },
        "effective_fin_full_thickness_cells": {
            str(item.resolution): 2.0 * item.fin_half_thickness * item.resolution
            for item in (primary, comparison)
        },
        "outputs": [str(hero_path.resolve()), str(diagnostic_path.resolve())],
    }
    metadata_path = args.output_dir / "projected_dogfish_geometry_review.json"
    metadata_path.write_text(json.dumps(metadata, indent=2), encoding="utf-8")
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    main()
