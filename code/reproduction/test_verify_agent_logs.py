"""Check candidate files without requiring separate population indices."""
import json
from pathlib import Path
import shutil
import tempfile
import unittest
import yaml

from verify_agent_logs import ROOT, validate_candidate


class CandidateFilesTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix='agent-fluid-log-test-')
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.dimension = 'two_dimensional'
        self.run = 'with_shelf_1'
        self.label = 'iteration_01_candidate_01'
        self.copy_candidate()

    def copy_candidate(self):
        base = Path('agent_logs')/self.dimension/self.run
        paths = [base/'policies'/f'{self.label}.jl']
        if self.dimension == 'two_dimensional':
            paths.append(Path('raw_data/policy_scores')/self.dimension/self.run/f'{self.label}_policy.yaml')
        for directory in [base/'guidance'/self.label, base/'agent_calls'/self.label]:
            paths.extend(p.relative_to(ROOT) for p in (ROOT/directory).rglob('*') if p.is_file())
        for relative in paths:
            target = self.root/relative
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(ROOT/relative, target)

    def validate(self):
        return validate_candidate(self.root, self.dimension, self.run, self.label)

    def test_candidate_passes_without_metadata_directory(self):
        self.assertFalse((self.root/'metadata').exists())
        self.assertEqual(self.validate()[0], 'completed')

    def test_reader_added_files_are_allowed(self):
        (self.root/'notes.md').write_text('Reader annotations')
        self.validate()

    def test_missing_policy_is_detected(self):
        (self.root/'agent_logs'/self.dimension/self.run/'policies'/f'{self.label}.jl').unlink()
        with self.assertRaises(FileNotFoundError):
            self.validate()

    def test_missing_guidance_is_detected(self):
        (self.root/'agent_logs'/self.dimension/self.run/'guidance'/self.label/'control_experience.md').unlink()
        with self.assertRaises(FileNotFoundError):
            self.validate()

    def test_nonfinite_score_is_detected(self):
        path = self.root/'raw_data/policy_scores'/self.dimension/self.run/f'{self.label}_policy.yaml'
        data = yaml.safe_load(path.read_bytes())
        data['score'] = float('nan')
        path.write_text(yaml.safe_dump(data))
        with self.assertRaises(AssertionError):
            self.validate()

    def test_invalid_message_order_is_detected(self):
        path = self.root/'agent_logs'/self.dimension/self.run/'agent_calls'/self.label/'events.jsonl'
        events = [json.loads(line) for line in path.read_bytes().splitlines()]
        next(e for e in events if e['event'] == 'agent_message')['turn'] = 99
        path.write_text('\n'.join(json.dumps(e) for e in events)+'\n')
        with self.assertRaises(AssertionError):
            self.validate()

    def test_three_dimensional_logs_do_not_require_recovered_scorecards(self):
        self.dimension, self.run = 'three_dimensional', 'naive_1'
        self.copy_candidate()
        self.assertFalse((self.root/'raw_data/policy_scores'/self.dimension).exists())
        self.validate()


if __name__ == '__main__':
    unittest.main()
