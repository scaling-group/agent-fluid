"""Export readable, de-identified 2D agent records without rewriting messages.

Inputs are an original population archive and its workspace logs. The export
contains selected agent messages, candidate notes and aggregate usage, not a
complete native Codex transcript. Original inputs are never modified.
"""
from pathlib import Path
from collections import Counter
import argparse
import gzip
import hashlib
import json
import re

USAGE_FIELDS = ('agent_turns', 'cache_creation_tokens', 'cache_read_tokens',
                'input_tokens', 'output_tokens', 'wallclock_seconds')


def sanitize(text):
    """Preserve scientific text while replacing machine and identity details."""
    # Keep meaningful workspace-relative suffixes of historical absolute paths.
    absolute = re.compile(r'(?<![A-Za-z0-9_:/])(?:[A-Za-z]:[\\/]|/(?:scratch|home|Users|Project_Storage|mnt|tmp|var)/)[^\s`<>"\)\]]+')
    def relative(match):
        value = match[0].replace('\\', '/')
        workspace = re.search(r'/(?:solver|evaluation)_workspaces/[^/]+/(.*)', value)
        if workspace:
            return workspace[1]
        return '[local-path]'
    text = absolute.sub(relative, text)
    text = re.sub(r'(?:solver|evaluation)_workspaces/(?:\d{8}_\d{6}_)?step_\d+_[0-9a-f]+/', '', text)
    text = re.sub(r'\b\d{8}_\d{6}_step_\d+_[0-9a-f]+\b', '[workspace]', text)
    text = re.sub(r'\b[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}\b', '[session-id]', text, flags=re.I)
    text = re.sub(r'\b\d{4}-\d{2}-\d{2}(?:[T ]\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})?)?\b', '[date]', text)
    text = re.sub(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b', '[email]', text)
    text = re.sub(r'\b(?:[A-Za-z0-9-]+\.)+nus\.edu\.sg\b', '[host]', text, flags=re.I)
    text = re.sub(r'\b(?:boaisun|song\.chen|sammysuntree|pharma00[12]|e\d{7})\b', '[account]', text, flags=re.I)
    text = re.sub(r'\bsk-(?:proj-)?[A-Za-z0-9_-]{20,}\b', '[credential]', text)
    text = re.sub(r'(?i)(Bearer\s+)[A-Za-z0-9._-]{20,}', r'\1[credential]', text)
    return text


def parse_session(text):
    """Read the recorded instruction and numbered agent trace, excluding its
    duplicated final-response section and the identifying session header."""
    instruction = re.search(r'^## Instruction\s*\n(.*?)^## Trace\s*$', text, re.M | re.S)
    events = []
    if instruction:
        events.append({'event': 'instruction', 'content': sanitize(instruction[1].strip())})
    trace = text.split('## Trace', 1)[-1].split('\n## Final Response', 1)[0]
    parts = re.split(r'^### Turn (\d+)\s*$', trace, flags=re.M)
    for i in range(1, len(parts), 2):
        number, body = int(parts[i]), parts[i+1].strip()
        if not body.startswith('**agent**:'):
            raise ValueError('Unexpected recorded trace role')
        events.append({'turn': number, 'event': 'agent_message',
                       'content': sanitize(body[len('**agent**:'):].strip())})
    return events


def live_messages(path):
    rows = [json.loads(line.lstrip(b'\0')) for line in gzip.decompress(path.read_bytes()).split(b'\n')
            if line.strip(b'\0 \r\n')]
    return [r['item']['text'] for r in rows if r.get('type') == 'item.completed'
            and r.get('item', {}).get('type') == 'agent_message']


def identity(path, output, source, extra=None):
    raw = path.read_bytes()
    original = source.read_bytes()
    return {'path': path.relative_to(output).as_posix(), 'bytes': len(raw),
            'sha256': hashlib.sha256(raw).hexdigest(),
            'source_sha256': hashlib.sha256(original).hexdigest(),
            **(extra or {})}


def export(archive, workspaces, output):
    archive, workspaces, output = map(lambda p: Path(p).resolve(), (archive, workspaces, output))
    if output.exists():
        raise ValueError('Choose a new output directory')
    output.mkdir(parents=True)
    populations = []
    counts = Counter()
    for source in sorted((archive/'metadata/agent_logs/two_dimensional').glob('*.json')):
        population = json.loads(source.read_bytes())
        for record in population['candidates']:
            short = re.sub(r'^\d{8}_\d{6}_', '', record['source_workspace'])
            logs = workspaces/population['run']/'solver_workspaces'/short/'logs/optimize'
            folder = output/'agent_logs/two_dimensional'/population['run']/'agent_calls'/record['label']
            folder.mkdir(parents=True)
            live = next(x for x in record['agent_calls'] if x['format'] == 'codex_live_events')
            live_path = archive/live['path']
            messages = live_messages(live_path)
            session = logs/'session.md'
            if session.exists():
                events = parse_session(session.read_text(encoding='utf8'))
                # Recorded Markdown provides readable original Unicode; the
                # native archive supplies an independent message-count check.
                if sum(e['event']=='agent_message' for e in events) != len(messages):
                    raise ValueError('Session/live message count mismatch: '+record['label'])
                event_source = session
            else:
                events = [{'turn': i, 'event': 'agent_message', 'content': sanitize(t)}
                          for i,t in enumerate(messages,1)]
                event_source = live_path
            if record['status'] != 'completed':
                events.append({'event':'termination','status':record['status']})
            if not events:
                raise ValueError('Empty recorded session')
            event_path = folder/'events.jsonl'
            event_path.write_text(''.join(json.dumps(e,ensure_ascii=False)+'\n' for e in events),encoding='utf8', newline='\n')
            file_records = [identity(event_path,output,event_source,
                            {'format':'selected_agent_events','events':len(events),
                             'event_types':dict(Counter(e['event'] for e in events))})]
            counts.update(e['event'] for e in events)
            notes = logs/'wake_policy_notes.md'
            if notes.exists():
                path = folder/'policy_notes.md'
                path.write_text(sanitize(notes.read_text(encoding='utf8')),encoding='utf8', newline='\n')
                file_records.append(identity(path,output,notes,{'format':'candidate_policy_notes'}))
                counts['policy_notes'] += 1
            usage_source = logs/'token_usage.json'
            total = json.loads(usage_source.read_bytes())['total']
            usage = {key:total.get(key) for key in USAGE_FIELDS}
            path = folder/'usage.json'
            path.write_text(json.dumps(usage,indent=2)+'\n',encoding='utf8', newline='\n')
            file_records.append(identity(path,output,usage_source,{'format':'aggregate_usage'}))
            record['agent_calls'] = file_records
            counts['sessions'] += 1
        population['session_format'] = 'Selected original instruction and agent messages, candidate notes and aggregate usage; identifying metadata removed. Not a full native transcript.'
        target = output/source.relative_to(archive)
        target.parent.mkdir(parents=True,exist_ok=True)
        target.write_text(json.dumps(population,ensure_ascii=False,indent=2)+'\n',encoding='utf8', newline='\n')
        populations.append(population)
    if counts['sessions'] != 800:
        raise ValueError('Expected 800 formal candidate sessions')
    return {'counts':dict(counts),'populations':len(populations)}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive',type=Path,required=True,help='Archive root containing population indices and original compressed calls')
    parser.add_argument('--workspaces',type=Path,required=True,help='Original two_dimensional run folders with solver workspace logs')
    parser.add_argument('--output',type=Path,required=True)
    args = parser.parse_args()
    print(json.dumps(export(args.archive,args.workspaces,args.output)))
