"""Verify experimental Agent records and their run/iteration coverage."""
import argparse
from collections import Counter
import gzip
import hashlib
import json
import math
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[2]


def read_payload(path):
    path = Path(path)
    data = path.read_bytes()
    return gzip.decompress(data) if path.suffix == '.gz' else data


def validate_candidate(root, dimension, run, label):
    """Read associated files directly from their shared candidate name."""
    base = root/'agent_logs'/dimension/run
    assert (base/'policies'/f'{label}.jl').read_bytes().strip()
    for name in ('README.md', 'control_experience.md'):
        assert (base/'guidance'/label/name).read_bytes().strip()
    if dimension == 'two_dimensional':
        score_path = root/'raw_data/policy_scores'/dimension/run/f'{label}_policy.yaml'
        score = yaml.safe_load(score_path.read_bytes())
        assert math.isfinite(float(score['score']))
        metrics = score['metrics']
        for key in ('distance_integral_L', 'release_elapsed', 'steps', 'total_horizon'):
            assert math.isfinite(float(metrics[key])), str(score_path) + ': ' + key
        assert metrics['steps'] >= 0 and metrics['total_horizon'] > 0
    if label == 'seed':
        return None, Counter(), Counter()
    calls = base/'agent_calls'/label
    events = [json.loads(line) for line in (calls/'events.jsonl').read_bytes().splitlines()]
    assert events
    counts = Counter(event['event'] for event in events)
    assert set(counts) <= {'instruction', 'agent_message', 'tool_call', 'tool_result', 'termination'}
    assert all(e['content'].strip() for e in events if e['event'] in {'instruction', 'agent_message'})
    status = events[-1]['status'] if events[-1]['event'] == 'termination' else 'completed'
    assert status in {'completed', 'error', 'timeout'}
    if status == 'completed':
        assert counts['instruction'] == 1 and not counts['termination']
    if dimension == 'two_dimensional':
        messages = [e for e in events if e['event'] == 'agent_message']
        assert [e['turn'] for e in messages] == list(range(1, len(messages)+1))
    usage = json.loads((calls/'usage.json').read_bytes())
    assert set(usage) == {'agent_turns', 'cache_creation_tokens', 'cache_read_tokens',
                          'input_tokens', 'output_tokens', 'wallclock_seconds'}
    assert all(v is None or (isinstance(v, (int, float)) and math.isfinite(v) and v >= 0)
               for v in usage.values())
    files = Counter(selected_agent_events=1, aggregate_usage=1)
    notes = calls/'policy_notes.md'
    if notes.is_file():
        assert notes.read_bytes().strip()
        files['candidate_policy_notes'] += 1
    return status, counts, files


def validate():
    index = json.loads((ROOT / 'agent_logs/index.json').read_bytes())
    logs = index['three_dimensional']
    records = logs['records']
    expected = {(run, iteration, session) for run in logs['runs']
                for iteration in range(1, 41) for session in range(1, 5)}
    actual = {(r['replicate_id'], r['iteration'], r['session_index']) for r in records}
    assert len(records) == 960 and actual == expected
    event_counts = Counter()
    file_names = Counter()
    workspace_ids = set()
    for record in records:
        base = ROOT / record['directory']
        workspace = (record['replicate_id'], record['workspace_id'])
        assert workspace not in workspace_ids
        workspace_ids.add(workspace)
        for name, identity in record['files'].items():
            data = (base / name).read_bytes()
            assert len(data) == identity['bytes']
            assert hashlib.sha256(data).hexdigest() == identity['sha256'], str(base / name)
            file_names[name] += 1
        events = [json.loads(line) for line in (base / 'events.jsonl').read_bytes().splitlines()]
        assert events
        event_counts.update(r['event'] for r in events)
        for event in events:
            assert event['event'] in {'instruction', 'agent_message', 'tool_call', 'tool_result', 'termination'}
            if event['event'] == 'tool_result':
                assert event['content'] and event['arguments']['command']
                assert event['exit_code'] is None or isinstance(event['exit_code'], int)
        usage = json.loads((base / 'usage.json').read_bytes())
        if record['status'] == 'timeout':
            assert all(v is None for v in usage.values())
            assert events[-1] == {'event': 'termination', 'status': 'timeout'}
        else:
            assert record['status'] == 'completed'
            assert all(isinstance(v, (int, float)) and v >= 0 for v in usage.values())
    statuses = dict(Counter(r['status'] for r in records))
    assert statuses == {'completed': 947, 'timeout': 13}
    assert dict(event_counts) == logs['event_counts']
    assert event_counts['agent_message'] == 9823
    assert file_names == {'events.jsonl': 960, 'usage.json': 960, 'policy_notes.md': 958}
    for run in logs['runs']:
        validate_candidate(ROOT, 'three_dimensional', run, 'seed')
        for iteration in range(1, 41):
            for candidate in range(1, 5):
                validate_candidate(ROOT, 'three_dimensional', run,
                                   f'iteration_{iteration:02d}_candidate_{candidate:02d}')
    counts = Counter()
    groups = index['two_dimensional']['records']
    assert len(groups) == 10
    two_d = index['two_dimensional']
    expected_runs = {f'{condition}_{run}' for condition in ('with_shelf', 'without_shelf') for run in range(1, 6)}
    assert set(two_d['runs']) == expected_runs and len(two_d['runs']) == 10
    assert two_d['sessions'] == 800 and two_d['iterations_per_run'] == 20 and two_d['sessions_per_iteration'] == 4
    assert {Path(g['directory']).name for g in groups} == expected_runs
    sessions_2d = []
    event_counts_2d, files_2d = Counter(), Counter()
    initial_evaluations = 0
    for group in groups:
        run = f"{group['condition']}_{group['run']}"
        validate_candidate(ROOT, 'two_dimensional', run, 'seed')
        initial = group['initial_evaluation']
        assert (ROOT / initial['configuration']).is_file()
        metrics = yaml.safe_load(read_payload(ROOT / initial['path']))['metrics']
        assert metrics['steps'] > 0 and metrics['release_elapsed'] > 0
        initial_evaluations += 1
        for iteration in range(1, 21):
            for candidate in range(1, 5):
                status, ec, fc = validate_candidate(ROOT, 'two_dimensional', run,
                    f'iteration_{iteration:02d}_candidate_{candidate:02d}')
                event_counts_2d.update(ec)
                files_2d.update(fc)
                counts['solvers'] += 1
                sessions_2d.append(status)
    assert initial_evaluations == 10 and len(sessions_2d) == 800
    statuses_2d = dict(Counter(sessions_2d))
    assert statuses_2d == two_d['session_status'] == {'completed': 795, 'error': 2, 'timeout': 3}
    assert dict(event_counts_2d) == two_d['event_counts']
    assert files_2d['selected_agent_events'] == 800
    assert files_2d['aggregate_usage'] == 800
    return {'status': 'PASS', 'three_dimensional_sessions': len(records),
            'session_status': statuses, 'event_counts': dict(event_counts),
            'two_dimensional_records': dict(counts), 'initial_evaluations': initial_evaluations,
            'two_dimensional_sessions': len(sessions_2d), 'two_dimensional_session_status': statuses_2d,
            'two_dimensional_event_counts': dict(event_counts_2d), 'two_dimensional_files': dict(files_2d)}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.parse_args()
    print(json.dumps(validate()))
