"""Reconstruct Supplementary Table 1 from five matched trajectory pairs."""
from __future__ import annotations

import gzip
import hashlib
import io
import json
import math
from pathlib import Path
import re

import numpy as np

ROOT = Path(__file__).resolve().parents[2]
CASES = ('southwest', 'southeast', 'northwest', 'northeast', 'west')
FIELDS = ('case_id release shift_count center_rms_L heading_rms_deg '
          'velocity_rms_U full_to_moving_ms_per_step_ratio '
          'center_maximum_L heading_maximum_deg').split()
MATCHED_FIELDS = (
    'runtime_resolution', 'Re', 'policy_sha256', 'policy_params',
    'body_geometry_source_sha256', 'geometry_sha256', 'caudal_fin_enabled',
    'fish_initial_center_L', 'fish_initial_heading_deg',
    'fish_initial_joint_angles_deg', 'fish_initial_yaw_rate_rad_per_T',
    'target_L', 'success_radius_L', 'flow_velocity_L_per_T',
    'direct_quiescent_init', 'initialization_mode', 'max_dimensionless_dt',
    'free_dofs', 'locked_dofs', 'horizon',
)


def require(condition, message):
    if not condition:
        raise ValueError(message)


def reconstruct(root=ROOT):
    """Return numerical rows and their inputs, without reading manuscript values."""
    index_path = root / 'raw_data/moving_window_validation/index.json'
    index = json.loads(index_path.read_bytes())
    require([p['case_id'] for p in index['pairs']] ==
            [case + '_to_center' for case in CASES], 'Five release pairs required')
    policy = root / index['policy']
    policy_hash = hashlib.sha256(policy.read_bytes()).hexdigest()
    sources = [index_path, policy]
    rows = []
    total_samples = 0
    for pair in index['pairs']:
        label = pair['case_id']
        summaries, trajectories = {}, {}
        for mode, dims in [('moving_window4x3', [256, 192, 96]),
                           ('fullfield24x16', [1536, 1024, 96])]:
            base = root / pair[mode]
            summary_path = base / 'summary.json'
            trajectory_path = base / 'trajectory.csv.gz'
            sources.extend([summary_path, trajectory_path])
            s = json.loads(summary_path.read_bytes())
            a = np.genfromtxt(io.BytesIO(gzip.decompress(trajectory_path.read_bytes())),
                              delimiter=',', names=True)
            require(s['domain_dims'] == dims, label + '/domain dimensions')
            require(s['moving_window'] == (mode == 'moving_window4x3'), label + '/domain mode')
            require(s['status'] == 'ok' and s['termination'] == 'horizon', label + '/completion')
            require(s['horizon'] == s['achieved_horizon'] == 10.0, label + '/10T horizon')
            require(s['policy_sha256'] == policy_hash, label + '/frozen policy')
            # These simulator CSVs record each completed CFD update, including
            # the first step at dt; they do not contain an extra t=0 row.
            require(len(a) == s['steps'], label + '/step count')
            require(0 < a['elapsed'][0] <= s['max_dimensionless_dt'] and a['elapsed'][-1] == 10 and
                    np.all(np.diff(a['elapsed']) > 0), label + '/time coverage')
            require(np.max(np.diff(a['elapsed'])) <= s['max_dimensionless_dt'] + 1e-5,
                    label + '/timestep')
            require(math.isclose(s['ms_per_step'], 1000 * s['wall_seconds'] / s['steps'],
                                 rel_tol=1e-12), label + '/measured step cost')
            require(len(s['moving_window_shift_events']) == s['moving_window_shift_count'],
                    label + '/translation count')
            summaries[mode], trajectories[mode] = s, a
            total_samples += len(a)
        moving, full = (summaries[m] for m in ('moving_window4x3', 'fullfield24x16'))
        for field in MATCHED_FIELDS:
            require(moving[field] == full[field], label + '/matched ' + field)
        require(moving['target_L'] == [12.0, 8.0] and
                moving['flow_velocity_L_per_T'] == [0.0, 0.0, 0.0] and
                moving['direct_quiescent_init'] is True and moving['Re'] == 1000 and
                moving['runtime_resolution'] == 64, label + '/stationary target and fluid')
        require(moving['fish_initial_center_L'] == pair['initial_center_L'] and
                moving['fish_initial_heading_deg'] == pair['initial_heading_deg'],
                label + '/release identity')
        require(math.prod(moving['domain_dims']) / math.prod(full['domain_dims']) == 1 / 32,
                label + '/cell ratio')
        require(full['moving_window_shift_count'] == 0, label + '/fixed field')
        a, b = (trajectories[m] for m in ('moving_window4x3', 'fullfield24x16'))
        time = a['elapsed']
        columns = ('center_x_L', 'center_y_L', 'velocity_x_U', 'velocity_y_U', 'heading_rad')
        for data in (a, b):
            require(all(np.isfinite(data[k]).all() for k in columns), label + '/finite states')
        # The original comparison samples on the moving-window solver times.
        # Full-field samples are linearly interpolated onto those same times.
        def difference(names):
            delta = np.column_stack([a[k] - np.interp(time, b['elapsed'], b[k]) for k in names])
            return np.linalg.norm(delta, axis=1)
        position = difference(('center_x_L', 'center_y_L'))
        velocity = difference(('velocity_x_U', 'velocity_y_U'))
        heading = np.unwrap(a['heading_rad']) - np.interp(time, b['elapsed'], np.unwrap(b['heading_rad']))
        heading = np.arctan2(np.sin(heading), np.cos(heading))
        def rms(values):
            return float(np.sqrt(np.mean(np.square(values))))
        rows.append(dict(case_id=label, release=pair['release'],
                         shift_count=moving['moving_window_shift_count'],
                         center_rms_L=rms(position), heading_rms_deg=math.degrees(rms(heading)),
                         velocity_rms_U=rms(velocity),
                         full_to_moving_ms_per_step_ratio=full['ms_per_step'] / moving['ms_per_step'],
                         center_maximum_L=float(np.max(position)),
                         heading_maximum_deg=math.degrees(float(np.max(np.abs(heading))))))
    report = dict(pairs=len(rows), simulations=2 * len(rows), trajectory_rows=total_samples,
                  target='stationary', interval_T=[0.0, 10.0],
                  maximum_position_difference_L=max(r['center_maximum_L'] for r in rows),
                  maximum_heading_difference_rad=math.radians(max(r['heading_maximum_deg'] for r in rows)))
    return rows, sources, report


def verify_table(rows, table):
    """Check all 30 displayed numerical cells, including the five means."""
    source = re.sub(r'\\textbf\{([^{}]*)\}', r'\1', table.read_text(encoding='utf-8'))
    source = source.replace('\n', ' ')
    columns = ['shift_count', 'center_rms_L', 'heading_rms_deg',
               'velocity_rms_U', 'full_to_moving_ms_per_step_ratio']
    expected = [(r['release'], [r[k] for k in columns]) for r in rows]
    expected.append(('Mean', [float(np.mean([r[k] for r in rows])) for k in columns]))
    for release, values in expected:
        match = re.search(r'\b' + re.escape(release) + r'\s*&([^\\]+)\\\\', source)
        require(match is not None, 'Missing table row: ' + release)
        cells = [cell.strip() for cell in match[1].split('&')]
        require(len(cells) == len(columns), 'Table columns: ' + release)
        for cell, value, column in zip(cells, values, columns):
            places = len(cell.split('.')[1]) if '.' in cell else 0
            require(f'{value:.{places}f}' == cell, f'Table cell {release}/{column}: {cell} != {value}')
    return {'status': 'PASS', 'rows': 6, 'numeric_cells': 30}
