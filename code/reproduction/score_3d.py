"""Recover the plotted 3D score from original evaluation fields, offline."""
import argparse
import gzip
import hashlib
import json
import math
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
ENGINE = 'code/simulation/3d/experiments/cases/dogfish_3d_shape_policy/projected_multiwake_policy_smoke3d_hero_v3_moving_window.jl'
UNSTABLE = {'nonfinite_state', 'solver_error', 'max_steps'}
FORMULA = 's = online_score + 0.2*final_distance_L - 0.2*elapsed_fraction - 2*captured + 2*unstable'


def inverse_score(metrics):
    """Require real scoring inputs; never use wall time or steps as CFD time."""
    for key in ['score', 'final_distance_L', 'elapsed_fraction']:
        if not math.isfinite(float(metrics[key])):
            raise ValueError('Nonfinite scoring input: ' + key)
    fraction = float(metrics['elapsed_fraction'])
    if not 0 <= fraction <= 1 or float(metrics['final_distance_L']) < 0:
        raise ValueError('Invalid final distance or elapsed fraction')
    if type(metrics['captured']) is not bool or type(metrics['unstable']) is not bool:
        raise ValueError('Termination indicators must be booleans')
    return (float(metrics['score']) + 0.2*float(metrics['final_distance_L'])
            - 0.2*fraction - 2*metrics['captured'] + 2*metrics['unstable'])


def audit():
    errors = []
    for path in sorted((ROOT/'raw_data/policy_scores/three_dimensional').rglob('*.json.gz')):
        record = json.loads(gzip.decompress(path.read_bytes()))
        metrics = record.get("score_metrics", record)
        error = abs(inverse_score(metrics) + float(metrics['distance_integral_L']))
        if error > 1e-12:
            raise ValueError('Inverse disagrees with original distance integral: ' + str(path))
        errors.append(error)
    return {'schema':'agent-fluid-3d-score-identity.v1', 'formula':FORMULA,
            'formula_source':ENGINE, 'formula_source_sha256':hashlib.sha256((ROOT/ENGINE).read_bytes()).hexdigest(),
            'validation':{'status':'PASS','records':len(errors),'max_absolute_error':max(errors)}}



def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = audit()
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({key:result[key] for key in ['formula','validation']}, indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
