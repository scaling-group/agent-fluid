#!/usr/bin/env python3
"""Render Figure 2's three-column, four-row controller diagram.

The same nine nodes and nine directed dependencies are retained. The Figure 2
entry point verifies the archived Julia controller and registers locked fonts.
"""
from __future__ import annotations

from io import BytesIO
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.path import Path as MplPath
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

DEFAULT_WIDTH = 284.0
PANEL_HEIGHT = 133.0
NODE_WIDTH = 90.0
COMPACT_NODE_WIDTH = 80.0
NODE_HEIGHT = 20.0
COLUMN_GAP = 8.0
PHASE_OFFSET_X = 40.0
MIXER_OFFSET_X = 24.0
LABEL_SIZE = 7.4
NODE_LINEWIDTH = 0.72
TEXT = "#202831"
INPUT_EDGE = "#989898"
INPUT_FILL = "#EEEEEE"
PROCESS_EDGE = "#6F6F6F"
PROCESS_FILL = "#F5F5F5"


def configure_style() -> None:
    matplotlib.rcParams.update(
        {
            "font.family": "Bitstream Vera Sans",
            "font.sans-serif": [
                "Bitstream Vera Sans",
                "Arial",
                "Helvetica",
                "DejaVu Sans",
                "sans-serif",
            ],
            "font.size": 6.2,
            "text.color": TEXT,
            "axes.labelcolor": TEXT,
            "xtick.color": "#46515A",
            "ytick.color": "#46515A",
            "pdf.fonttype": 42,
            "svg.fonttype": "none",
            "axes.spines.right": False,
            "axes.spines.top": False,
            "axes.unicode_minus": False,
            "path.simplify": False,
        }
    )


def add_node(ax, x, y, w, h, label, *, edge, fill, fontsize, linewidth=NODE_LINEWIDTH):
    node = FancyBboxPatch(
        (x, y),
        w,
        h,
        boxstyle="round,pad=0.0,rounding_size=2.4",
        linewidth=linewidth,
        edgecolor=edge,
        facecolor=fill,
        zorder=3,
    )
    ax.add_patch(node)
    ax.text(
        x + w / 2,
        y + h / 2,
        label,
        ha="center",
        va="center",
        multialignment="center",
        fontsize=fontsize,
        linespacing=1.05,
        color=TEXT,
        zorder=4,
    )


def add_arrow(ax, start, end, *, color, rad=0.0, linewidth=0.72, dashed=False):
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle="-|>",
            connectionstyle=f"arc3,rad={rad}",
            mutation_scale=6.5,
            shrinkA=1.0,
            shrinkB=1.0,
            linewidth=linewidth,
            linestyle=(0, (2.2, 1.7)) if dashed else "solid",
            color=color,
            zorder=2,
        )
    )


def add_poly_arrow(ax, points, *, color, linewidth=0.72, dashed=False):
    path = MplPath(points, [MplPath.MOVETO] + [MplPath.LINETO] * (len(points) - 1))
    ax.add_patch(
        FancyArrowPatch(
            path=path,
            arrowstyle="-|>",
            mutation_scale=6.5,
            linewidth=linewidth,
            linestyle=(0, (2.2, 1.7)) if dashed else "solid",
            color=color,
            zorder=2,
        )
    )


def policy_geometry(width: float) -> dict:
    """Narrow the first two branches equally; retain room for longer labels."""
    margin = 9.0
    column_widths = [COMPACT_NODE_WIDTH, COMPACT_NODE_WIDTH, NODE_WIDTH]
    centers = []
    left = margin
    for column_width in column_widths:
        centers.append(left + column_width / 2)
        left += column_width + COLUMN_GAP
    occupied_width = 2 * margin + sum(column_widths) + 2 * COLUMN_GAP
    if width < occupied_width:
        raise ValueError(f"The compact layout needs at least {occupied_width:g} pt")
    names = ("joint_state", "target_state", "flow_loads", "carrier", "steering",
             "redirect", "phase", "mixer", "output")
    widths = {name: NODE_WIDTH for name in names}
    for name in ("joint_state", "target_state", "carrier", "steering"):
        widths[name] = COMPACT_NODE_WIDTH

    def bounds(name, column, top, shift_x=0.0):
        return [centers[column] - widths[name] / 2 + shift_x,
                top, widths[name], NODE_HEIGHT]

    return {
        "column_centers_pt": centers,
        "column_widths_pt": column_widths,
        "column_gap_pt": COLUMN_GAP,
        "occupied_width_pt": occupied_width,
        "row_tops_pt": [18, 45, 82, 109],
        "phase_offset_x_pt": PHASE_OFFSET_X,
        "mixer_offset_x_pt": MIXER_OFFSET_X,
        "node_widths_pt": widths,
        "nodes_pt": {
            "joint_state": bounds("joint_state", 0, 18),
            "target_state": bounds("target_state", 1, 18),
            "flow_loads": bounds("flow_loads", 2, 18),
            "carrier": bounds("carrier", 0, 45),
            "steering": bounds("steering", 1, 45),
            "redirect": bounds("redirect", 2, 45),
            "phase": bounds("phase", 1, 82, PHASE_OFFSET_X),
            "mixer": bounds("mixer", 0, 82, MIXER_OFFSET_X),
            "output": bounds("output", 1, 109),
        },
    }


def build_policy_figure(width: float = DEFAULT_WIDTH, *, panel_letter: str = "e") -> plt.Figure:
    """Transpose the three evidence/mechanism branches without changing their logic."""
    configure_style()
    fig = plt.figure(figsize=(width / 72, PANEL_HEIGHT / 72), facecolor="white")
    ax = fig.add_axes((0, 0, 1, 1))
    ax.set_xlim(0, width)
    ax.set_ylim(PANEL_HEIGHT, 0)
    ax.axis("off")
    ax.text(9, 12.4, panel_letter, fontsize=9.8, fontweight="bold", va="baseline")
    ax.text(26, 12.3, "Executable champion policy", fontsize=8.8, va="baseline")
    geometry = policy_geometry(width)
    nodes = geometry["nodes_pt"]
    labels = {
        "joint_state": "Joint angles\nand rates",
        "target_state": "Target bearing and\nbody-frame velocity",
        "flow_loads": "Crossflow, lateral force\nand yaw moment",
        "carrier": "Body-wave\ncarrier",
        "steering": "Bounded steering\nrequest",
        "redirect": "Response-gated\nextra redirect burst",
        "phase": "Phase-selective\nsteering",
        "mixer": "Reserve steering\nand bound commands",
        "output": "Angular acceleration\ncommands (two joints)",
    }
    for name, bounds in nodes.items():
        if name in {"joint_state", "target_state", "flow_loads"}:
            edge, fill = INPUT_EDGE, INPUT_FILL
        else:
            edge = PROCESS_EDGE
            fill = "white" if name == "output" else PROCESS_FILL
        add_node(ax, *bounds, labels[name], edge=edge, fill=fill, fontsize=LABEL_SIZE)

    def port(name, side):
        x, y, w, h = nodes[name]
        return {"top": (x+w/2, y), "bottom": (x+w/2, y+h),
                "left": (x, y+h/2), "right": (x+w, y+h/2)}[side]

    for source, target in (("joint_state", "carrier"),
                           ("target_state", "steering"), ("flow_loads", "redirect")):
        add_arrow(ax, port(source, "bottom"), port(target, "top"), color=PROCESS_EDGE)

    # Keep the carrier input vertical while the mixer remains shifted right.
    # The arrow lands off-centre on the mixer's top edge.
    carrier_bottom = port("carrier", "bottom")
    mixer_top = (carrier_bottom[0], nodes["mixer"][1])
    add_arrow(ax, carrier_bottom, mixer_top, color=PROCESS_EDGE)

    # Exit through the narrow column gutter, leaving the full-size feedback
    # annotation clear while keeping the two phase-selection inputs separate.
    steering_right = port("steering", "right")
    steering_route_x = steering_right[0] + COLUMN_GAP / 2
    phase_top = (steering_route_x, nodes["phase"][1])
    add_poly_arrow(ax, [steering_right, (steering_route_x, steering_right[1]), phase_top],
                   color=PROCESS_EDGE)

    # Phase selection and bounded mixing remain distinct, adjacent operations.
    add_arrow(ax, port("phase", "left"), port("mixer", "right"), color=PROCESS_EDGE)
    mixer = port("mixer", "bottom")
    output = port("output", "left")
    add_poly_arrow(ax, [mixer, (mixer[0], output[1]), output], color=PROCESS_EDGE)
    redirect = port("redirect", "bottom")
    phase_right = port("phase", "right")
    add_poly_arrow(ax, [redirect, (redirect[0], phase_right[1]), phase_right], color=PROCESS_EDGE)

    # Joint phase is a direct feedback input to phase selection, routed through
    # the gutter between the first two columns rather than through either node.
    joint = port("joint_state", "right")
    route_x = (joint[0] + nodes["steering"][0]) / 2
    feedback_y = nodes["phase"][1] - 3.0
    # Approach the upper part of the left edge diagonally, separating this
    # feedback input from the steering input on top and the mixer output below.
    feedback_target = (nodes["phase"][0], nodes["phase"][1] + 5)
    diagonal_start = (feedback_target[0] - 10, feedback_y)
    add_poly_arrow(ax, [joint, (route_x, joint[1]), (route_x, feedback_y),
                        diagonal_start, feedback_target],
                   color=PROCESS_EDGE, linewidth=0.70, dashed=True)
    ax.text(route_x + 5, feedback_y - 7, "Joint-phase feedback", ha="left", va="center",
            fontsize=LABEL_SIZE, color=TEXT)
    return fig



def policy_panel(width: float = DEFAULT_WIDTH) -> bytes:
    """Return the vector panel at the requested width without resizing text."""
    fig = build_policy_figure(width)
    stream = BytesIO()
    fig.savefig(stream, format="pdf", metadata={"CreationDate": None, "ModDate": None})
    plt.close(fig)
    return stream.getvalue()
