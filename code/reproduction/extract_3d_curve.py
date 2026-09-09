"""Reconstruct all six cumulative learning curves from candidate score records."""
import argparse
from collections import defaultdict
import csv
import gzip
import hashlib
import io
import json
import math
from pathlib import Path
import re
import subprocess
import sys

from score_3d import ENGINE, inverse_score

ROOT = Path(__file__).resolve().parents[2]
RECORDS = 'raw_data/policy_scores/three_dimensional/index.json'
GROUPS = [('naive_1', 'naive_seed'), ('naive_2', 'naive_seed'),
          ('naive_3', 'naive_seed'), ('transfer_1', 'two_dimensional_champion'),
          ('transfer_2', 'two_dimensional_champion'), ('transfer_3', 'two_dimensional_champion')]


def digest(data):
    return hashlib.sha256(data).hexdigest()


def csv_rows(path):
    return list(csv.DictReader(io.StringIO(path.read_text(encoding='utf-8-sig'))))


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n', encoding='utf-8')


def write_csv(path, rows, quoted=False):
    with path.open('w', encoding='utf-8', newline='') as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]), lineterminator='\n',
                                quoting=csv.QUOTE_ALL if quoted else csv.QUOTE_MINIMAL)
        writer.writeheader()
        writer.writerows(rows)


def build(output):
    output = Path(output).resolve()
    if output.exists() or output.is_relative_to(ROOT):
        raise ValueError('Choose a new output directory outside the archived package')
    inputs = {}
    identities = {}

    def payload(relative):
        path = (ROOT / relative).resolve()
        if not path.is_relative_to(ROOT):
            raise ValueError('Input leaves the archive: ' + relative)
        stored = path.read_bytes()
        inputs[relative] = digest(stored)
        data = gzip.decompress(stored) if relative.endswith('.gz') else stored
        if relative in identities and digest(data) != identities[relative]['retained_sha256']:
            raise ValueError('Score record identity mismatch: ' + relative)
        return data

    identities.update(json.loads(payload(RECORDS))['files'])
    for name in ['code/reproduction/extract_3d_curve.py', 'code/reproduction/score_3d.py', ENGINE]:
        payload(name)
    curves, lineage, count, used = [], [], 0, set()
    for replicate, condition in GROUPS:
        prefix = 'raw_data/policy_scores/three_dimensional/' + replicate + '/'
        rounds = defaultdict(list)
        for path in sorted((ROOT / prefix).glob('*.json.gz')):
            if path.name == 'seed.json.gz':
                iteration = 0
            else:
                match = re.fullmatch(r'step_(\d+)_worker_(\d+)(?:_solver_.+)?\.json\.gz', path.name)
                if not match or not 1 <= int(match[1]) <= 40:
                    raise ValueError('Unexpected evaluation record: ' + path.name)
                iteration = int(match[1])
            relative = path.relative_to(ROOT).as_posix()
            if relative not in identities:
                raise ValueError('Unindexed score record: ' + relative)
            metrics = json.loads(payload(relative))
            score = -float(metrics['distance_integral_L'])
            if not math.isfinite(score) or abs(inverse_score(metrics) - score) > 1e-12:
                raise ValueError('Invalid scoring fields: ' + relative)
            rounds[iteration].append((score, relative))
            used.add(relative)
            count += 1
        if set(rounds) != set(range(41)) or len(rounds[0]) != 1:
            raise ValueError('Each run requires a seed and scores for iterations 1–40: ' + replicate)
        best, best_source = -math.inf, None
        for iteration in range(41):
            score, source = max(rounds[iteration])
            if score > best:
                best, best_source = score, source
            curves.append(dict(replicate_id=replicate, condition=condition, iteration=iteration,
                               best_distance_integral_score=best))
            lineage.append(dict(replicate_id=replicate, iteration=iteration, observation_basis='evaluation',
                best_value_source=best_source, current_round_source='policy_scores'))
    if used != set(identities):
        raise ValueError('Indexed evaluations differ from the score records')
    output.mkdir(parents=True)
    candidate_output = output / 'candidate_evaluations'
    subprocess.run([sys.executable, str(ROOT / 'code/reproduction/extract_3d_evaluations.py'), '--output-dir', str(candidate_output)],
                   check=True, stdout=subprocess.PIPE, text=True)
    validation = json.loads((candidate_output / 'validation.json').read_text())
    provenance = json.loads((candidate_output / 'provenance.json').read_text())
    if validation['status'] != 'PASS' or validation['candidates'] != 24:
        raise ValueError('Candidate score validation failed')
    for relative, expected in provenance['inputs'].items():
        payload(relative)
        if inputs[relative] != expected:
            raise ValueError('Input changed during validation: ' + relative)
    candidates = csv_rows(candidate_output / 'candidates.csv')
    endpoints = []
    for replicate, _ in GROUPS:
        points = {row['iteration']:row['best_distance_integral_score'] for row in curves if row['replicate_id'] == replicate}
        selected = [row for row in candidates if row['replicate'] == replicate]
        winner = max(selected, key=lambda row:float(row['plotted_score']))
        measured = float(winner['plotted_score'])
        if points[40] != max(points[39], measured):
            raise ValueError('Candidate table disagrees with the cumulative curve: ' + replicate)
        endpoints.append(dict(replicate_id=replicate, iteration=40, candidate_count=len(selected),
            iteration39_best=points[39], measured_iteration40_max=measured, cumulative_best=points[40],
            improvement_over_iteration39=points[40]-points[39], maximum_candidate_id=winner['id'],
            observation_basis='evaluation'))
    validation = {'schema':'agent-fluid-learning-curves.v1', 'status':'PASS', 'runs':len(GROUPS),
        'iterations_per_run':41, 'score_records':count, 'curve_points':len(curves),
        'aggregation':'Cumulative maximum of all candidate distance-integral scores within each run.'}
    write_csv(output / 'learning_curves.csv', curves, quoted=True)
    write_csv(output / 'iteration40_measured_candidates.csv', candidates)
    write_csv(output / 'iteration40_endpoints.csv', endpoints)
    write_csv(output / 'point_provenance.csv', sorted(lineage, key=lambda row:(row['replicate_id'],row['iteration'])))
    write_json(output / 'validation.json', validation)
    names = ['learning_curves.csv', 'iteration40_measured_candidates.csv', 'iteration40_endpoints.csv', 'point_provenance.csv', 'validation.json']
    provenance = {'schema':'agent-fluid-learning-curve-provenance.v1', 'inputs':dict(sorted(inputs.items())),
        'transformation':validation['aggregation'],
        'outputs':{name:digest((output/name).read_bytes()) for name in names}}
    write_json(output / 'provenance.json', provenance)
    return validation, provenance


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', type=Path, required=True)
    args = parser.parse_args()
    validation, _ = build(args.output_dir)
    print(json.dumps(validation))


if __name__ == '__main__':
    main()
