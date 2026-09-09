"""Read original final-iteration scoring metrics."""
import argparse
import csv
import gzip
import hashlib
import json
import math
from pathlib import Path

from score_3d import ENGINE, inverse_score

ROOT = Path(__file__).resolve().parents[2]
SCORES = 'raw_data/policy_scores/three_dimensional'
INPUTS = {}


def payload(relative):
    path = (ROOT / relative).resolve()
    if not path.is_relative_to(ROOT):
        raise ValueError('Input path leaves the archived package')
    data = path.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    INPUTS[relative] = digest
    return gzip.decompress(data) if relative.endswith('.gz') else data


def read_json(relative):
    return json.loads(payload(relative))


def close(actual, expected, name, tolerance=1e-10):
    if not math.isfinite(actual) or not math.isfinite(expected) or abs(actual - expected) > tolerance:
        raise ValueError(name + ': observed values disagree')


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n', encoding='utf-8')


def write_csv(path, rows):
    with path.open('w', encoding='utf-8', newline='') as handle:
        writer = csv.DictWriter(handle, list(rows[0]), lineterminator='\n')
        writer.writeheader()
        writer.writerows(rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', type=Path, required=True)
    args = parser.parse_args()
    output = args.output_dir.resolve()
    if output.exists() or output.is_relative_to(ROOT):
        parser.error('Choose a new output directory outside the archived package')
    groups = [f'{condition}_{i}' for condition in ['naive', 'transfer'] for i in range(1, 4)]
    records = {}
    for group in groups:
        for number in range(1, 5):
            metrics = read_json(f'{SCORES}/{group}/step_40_worker_{number}.json.gz')
            record = {'id': f'3d_{group}_c{number}_cuda124', 'run': group,
                      'replicate_id': group, 'candidate_index': number}
            record['metrics'] = metrics
            records[record['id']] = record
    if len(records) != 24 or {(r['replicate_id'], r['candidate_index']) for r in records.values()} != {
            (group, number) for group in groups for number in range(1, 5)}:
        raise ValueError('Four candidate records per replicate are required')
    for name in ['code/reproduction/extract_3d_evaluations.py', 'code/reproduction/score_3d.py', ENGINE]:
        payload(name)
    candidates, checks = [], []
    for name, record in sorted(records.items()):
        metrics = record['metrics']
        integral = float(metrics['distance_integral_L'])
        component_integral = float(metrics['observed_distance_integral_L']) + float(metrics['terminal_hold_integral_L'])
        close(component_integral, integral, name + '/distance integral')
        close(inverse_score(metrics), -integral, name + '/online score')
        if type(metrics['captured']) is not bool or type(metrics['unstable']) is not bool:
            raise ValueError('Invalid outcome indicators: ' + name)
        candidates.append({'id': name, 'run': record['run'], 'replicate': record['replicate_id'],
            'candidate_index': record['candidate_index'],
            'online_score': metrics['score'], 'plotted_score': -integral,
            'elapsed_fraction': metrics['elapsed_fraction'],
            'final_distance_L': metrics['final_distance_L'],
            'captured': metrics['captured'], 'unstable': metrics['unstable']})
        checks.append({'id': name, 'score_fields': len(metrics), 'status': 'PASS',
            'component_integral_residual': component_integral - integral,
            'inverse_score_residual': inverse_score(metrics) + integral})
    validation = {'schema': 'agent-fluid-3d-evaluations.v1', 'status': 'PASS',
        'candidates': len(candidates), 'score_records': len(checks), 'checks': checks}
    output.mkdir(parents=True)
    write_csv(output / 'candidates.csv', candidates)
    write_json(output / 'validation.json', validation)
    write_json(output / 'provenance.json', {'schema': 'agent-fluid-evaluation-provenance.v1',
        'inputs': dict(sorted(INPUTS.items())),
        'transformation': 'Read original scoring metrics; verify distance-integral components, outcome indicators and the online-score identity.',
        'outputs': {name: hashlib.sha256((output / name).read_bytes()).hexdigest()
                    for name in ['candidates.csv', 'validation.json']}})
    print(json.dumps({key: validation[key] for key in ['status', 'candidates', 'score_records']}))


if __name__ == '__main__':
    main()
