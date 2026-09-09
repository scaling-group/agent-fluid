"""Validate the four Figure 3 trajectories and all 24 selected VTI fields."""
import argparse
import csv
import gzip
import hashlib
import io
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def read(path):
    data = path.read_bytes()
    return gzip.decompress(data) if path.suffix == '.gz' else data


def validate():
    frames = json.loads((ROOT / 'code/reproduction/keyframes.index.json').read_bytes())['retained']
    frames = [r for r in frames if r['figure'] == 'figure_03']
    assert len(frames) == 24
    cases = []
    for case in ('a1', 'b3', 'c1', 'd3'):
        base = ROOT / 'raw_data/illustrated_generalization' / case / 'simulation'
        task = json.loads((base / 'task.json').read_bytes())
        assert hashlib.sha256((base / 'controller.jl').read_bytes()).hexdigest() == task['policy_sha256']
        assert hashlib.sha256((base / 'config.toml').read_bytes()).hexdigest() == task['config_sha256']
        trace = read(base / 'episode/trajectory.csv.gz')
        assert trace == read(ROOT / 'raw_data/generalization/SEAS_1' / case / 'trajectory.csv.gz')
        history = {int(r['frame_index']): r for r in csv.DictReader(io.StringIO(
            read(base / 'episode/vtk/frames.csv.gz').decode()))}
        selected = [r for r in frames if r['case'] == case]
        assert len(selected) == 6
        for frame in selected:
            payload = read(ROOT / frame['path'])
            assert payload, frame['path']
            assert float(history[frame['frame_index']]['sim_time']) == frame['actual_sim_time']
        cases.append({'case': case, 'selected_fields': 6, 'trajectory_agreement': 'PASS',
                      'trajectory_sha256': hashlib.sha256(trace).hexdigest()})
    return {'status': 'PASS', 'fields': 24, 'cases': cases}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', required=True, type=Path)
    args = parser.parse_args()
    output = args.output_dir.resolve()
    if output == ROOT or output.is_relative_to(ROOT):
        parser.error('Choose an output directory outside the archive')
    report = validate()
    output.mkdir(parents=True, exist_ok=True)
    (output / 'validation.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
