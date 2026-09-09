"""Decompress selected VTI fields into one directory per figure and case."""
import argparse
import csv
import gzip
import io
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def read(path):
    data = path.read_bytes()
    return gzip.decompress(data) if path.suffix == '.gz' else data


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', required=True, type=Path)
    parser.add_argument('--figure', action='append')
    args = parser.parse_args()
    output = args.output_dir.resolve()
    if output == ROOT or output.is_relative_to(ROOT):
        parser.error('Choose an output directory outside the archive')
    frames = json.loads((ROOT / 'code/reproduction/keyframes.index.json').read_bytes())['retained']
    groups = {}
    selected = [r for r in frames if not args.figure or r['figure'] in args.figure]
    for record in selected:
        source = ROOT / record['path']
        data = read(source)
        group = record['figure'] + ('/' + record['case'] if 'case' in record else
                                    '/' + record['stage'] if 'stage' in record else '')
        destination = output / group
        destination.mkdir(parents=True, exist_ok=True)
        name = source.stem if source.suffix == '.gz' else source.name
        (destination / name).write_bytes(data)
        index = source.parent / 'frames.csv'
        if not index.exists():
            index = source.parent / 'frames.csv.gz'
        rows = list(csv.DictReader(io.StringIO(read(index).decode())))
        row = rows[-1] if 'stage' in record else next(
            r for r in rows if int(r['frame_index']) == record['frame_index'])
        groups.setdefault(group, []).append(dict(row, frame_path=name))
    for group, rows in groups.items():
        with (output / group / 'frames.csv').open('w', newline='', encoding='utf-8') as stream:
            writer = csv.DictWriter(stream, list(rows[0]), lineterminator='\n')
            writer.writeheader()
            writer.writerows(rows)
    print(f'Materialized {len(selected)} selected fields.')


if __name__ == '__main__':
    main()
