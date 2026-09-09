"""Optionally check recorded data and recompute the published results.

No simulator, accelerator, scheduler or network connection is used.
"""
import argparse
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import numpy as np

ROOT = Path(__file__).resolve().parents[2]


def close(actual, expected, name, atol=2e-4):
    assert np.allclose(actual, expected, rtol=2e-6, atol=atol), name


def inspect(record):
    label = record['policy'] + '/' + record['case']
    raw = record['summary']
    path = ROOT / 'raw_data/generalization' / label / 'trajectory.csv.gz'
    data = gzip.decompress(path.read_bytes())
    assert hashlib.sha256(data).hexdigest() == record['trajectory_sha256'], label
    a = np.genfromtxt(io.BytesIO(data), delimiter=',', names=True)
    assert len(a) == raw['steps'] + 1 and all(np.isfinite(a[k]).all() for k in a.dtype.names), label
    assert a['time'][0] == 0 and np.all(np.diff(a['time']) > 0), label
    assert np.max(np.diff(a['time'])) <= raw['max_dimensionless_dt'] + 1e-4, label
    close(a['time'][-1], raw['release_elapsed'], label)
    distance = np.hypot(a['head_x'] - raw['target'][0], a['head_y'] - raw['target'][1])
    close(distance, a['distance'], label + '/head-distance')
    close(distance.min(), raw['min_distance'], label + '/minimum')
    close(distance[-1], raw['final_distance'], label + '/final')
    captures = distance <= raw['success_radius']
    assert bool(captures.any()) == raw['target_reached'], label
    if record['case'] == 'nominal':
        assert captures[-1], label
    force = np.hypot(a['force_x'], a['force_y'])
    speed = np.hypot(a['velocity_x'], a['velocity_y'])
    unstable = (force >= raw['dynamics_force_limit']) | (speed >= raw['dynamics_speed_limit'])
    margin = raw['domain_exit_margin_L'] * raw['L']
    dims = raw['domain_dims']
    boundary = ((a['center_x'] < margin) | (a['center_x'] > dims[0] - margin)
                | (a['center_y'] < margin) | (a['center_y'] > dims[1] - margin))
    head_out = ((a['head_x'] < 0) | (a['head_x'] > dims[0])
                | (a['head_y'] < 0) | (a['head_y'] > dims[1]))
    collision = a['cylinder_clearance'] <= raw['collision_clearance_L'] * raw['L']
    events = boundary | unstable | collision | captures | head_out
    if events.any():
        assert np.flatnonzero(events).tolist() == [len(a) - 1], label
    reason = ('left_domain' if boundary[-1] else 'unstable_dynamics' if unstable[-1]
              else 'collision' if collision[-1] else 'target_reached' if captures[-1]
              else 'left_domain' if head_out[-1] else 'horizon')
    assert reason == raw['termination'], label
    integral = np.trapezoid(a['distance'] / raw['L'], a['time']) / raw['horizon']
    hold = max(0, raw['horizon'] - a['time'][-1]) * a['distance'][-1] / raw['L'] / raw['horizon']
    close(integral, raw['observed_distance_integral_L'], label + '/integral', atol=1e-9)
    close(hold, raw['terminal_hold_integral_L'], label + '/hold', atol=1e-9)
    close(-(integral + hold), raw['distance_integral_score'], label + '/score', atol=1e-9)
    return len(a)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--paper-repo', type=Path, help='Optional comparison with the manuscript moving-window table')
    parser.add_argument('--output', type=Path, help='Optionally save the data consistency report as JSON')
    args = parser.parse_args()
    print('Checking experimental measurements', flush=True)
    records = [json.loads(p.read_bytes()) for p in sorted((ROOT / 'raw_data/generalization').glob('*/*/result.json'))]
    assert len(records) == 130
    expected_cases = {'nominal'} | {f'{k}{i}' for k in 'abcd' for i in range(1, 4)}
    policies = json.loads((ROOT / 'code/generalization/policies/index.json').read_bytes())
    if isinstance(policies, dict):
        policies = policies['policies']
    assert len(policies) == 10
    rows = 0
    for policy in policies:
        selected = [r for r in records if r['policy'] == policy['policy']]
        assert {r['case'] for r in selected} == expected_cases
        assert hashlib.sha256((ROOT / policy['source']).read_bytes()).hexdigest() == policy['sha256']
        if policy['method'] == 'DRL':
            assert all(r['inference'] == policy['inference'] for r in selected)
        rows += sum(inspect(record) for record in selected)
        print('Verified ' + policy['policy'], flush=True)
    physical = ['target_x_L', 'target_y_L', 'flow_speed', 'flow_seed', 'horizon', 'success_radius_L',
                'cylinder_centers_x_L', 'cylinder_centers_y_L', 'cylinder_diameters_L']
    for case in expected_cases:
        selected = [r for r in records if r['case'] == case]
        for record in selected[1:]:
            for key in physical:
                close(record['summary'][key], selected[0]['summary'][key], case + '/' + key)
            assert record['initial_flow_state_sha256'] == selected[0]['initial_flow_state_sha256']
    counts = {method: {condition: sum(r['summary']['target_reached'] for r in records
              if r['method'] == method and (r['case'] == 'nominal') == (condition == 'nominal'))
              for condition in ['nominal', 'transfer']} for method in ['SEAS', 'DRL']}
    assert counts == {'SEAS': {'nominal': 5, 'transfer': 52}, 'DRL': {'nominal': 5, 'transfer': 0}}
    from moving_window_validation import reconstruct, verify_table
    from extract_figure_03 import validate as validate_fields
    from score_3d import audit
    from verify_agent_logs import validate as validate_agent_logs
    from verify_figures import validate as validate_publication_figures
    print('Checking moving-window comparisons, 3D scores and agent logs', flush=True)
    window_rows, _, window = reconstruct(ROOT)
    from tables import build as build_tables
    with tempfile.TemporaryDirectory(prefix='agent-fluid-tables-') as directory:
        table_root = build_tables(Path(directory))
        window['typeset_table'] = verify_table(window_rows, table_root / 'supplementary_table_01_moving_window_validation.tex')
    if args.paper_repo:
        window['manuscript_table'] = verify_table(window_rows, args.paper_repo / 'tables/supplementary_table_01_moving_window_validation.tex')
    result = {'status': 'PASS',
              'evaluations': 130, 'trajectory_rows': rows, 'counts': counts,
              'moving_window_validation': window, 'figure_03': validate_fields(),
              'score_identity': audit()['validation'], 'agent_logs': validate_agent_logs(),
              'publication_figures': validate_publication_figures()}
    with tempfile.TemporaryDirectory(prefix='agent-fluid-extraction-') as directory:
        print('Reconstructing derived data for numerical comparison', flush=True)
        command = [sys.executable, '-B', str(ROOT / 'code/reproduction/extract_derived_data.py'),
                   '--output-dir', directory, '--compare-dir', str(ROOT / 'derived_data')]
        completed = subprocess.run(command,
                                   env={**os.environ, 'PYTHONUTF8': '1', 'PYTHONDONTWRITEBYTECODE': '1'})
        if completed.returncode:
            raise RuntimeError('Raw-to-derived reconstruction failed')
        extracted = json.loads((Path(directory) / 'extraction_report.json').read_bytes())
        assert len(extracted['comparisons']) == extracted['generated_files'], 'Not every derived output was compared'
        result['extraction'] = {'status': extracted['status'], 'generated_files': extracted['generated_files'],
                                'compared_files': len(extracted['comparisons']),
                                'numeric_tolerances': extracted['numeric_tolerances'],
                                'numeric_and_array_comparisons': 'PASS'}
        result['three_dimensional'] = extracted['validation']['three_dimensional']
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(result))
    return 0 if result['status'] == 'PASS' else 1


if __name__ == '__main__':
    raise SystemExit(main())
