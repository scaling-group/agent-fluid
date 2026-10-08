"""Check that harmless edits pass while changed scientific data are detected."""
import json
from pathlib import Path
import tempfile
import unittest

import numpy as np

from extract_derived_data import compare_file


class DataConsistencyTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix='agent-fluid-data-test-')
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.actual = self.root / 'actual'
        self.reference = self.root / 'reference'
        self.actual.mkdir()
        self.reference.mkdir()

    def test_csv_formatting_column_order_and_roundoff_are_allowed(self):
        (self.actual / 'scores.csv').write_bytes(b'score,run\r\n-1.23456791,naive_1\r\n')
        (self.reference / 'scores.csv').write_bytes(b'run,score\nnaive_1,-1.23456789\n')
        compare_file(self.actual / 'scores.csv', self.reference / 'scores.csv')

    def test_csv_score_and_run_changes_are_detected(self):
        (self.reference / 'scores.csv').write_text('run,score\nnaive_1,-1.23456789\n')
        for row in ('naive_1,-1.24', 'transfer_1,-1.23456789'):
            with self.subTest(row=row):
                (self.actual / 'scores.csv').write_text('run,score\n' + row + '\n')
                with self.assertRaises(ValueError):
                    compare_file(self.actual / 'scores.csv', self.reference / 'scores.csv')

    def test_integer_counts_are_exact_even_when_written_as_float(self):
        (self.actual / 'counts.csv').write_text('steps\n100000001.0\n')
        (self.reference / 'counts.csv').write_text('steps\n100000000\n')
        with self.assertRaises(ValueError):
            compare_file(self.actual / 'counts.csv', self.reference / 'counts.csv')

    def test_json_roundoff_is_allowed_but_counts_and_status_are_exact(self):
        expected = {'score': -1.23456789, 'steps': 100000000, 'captured': True}
        (self.reference / 'result.json').write_text(json.dumps(expected))
        actual = {**expected, 'score': -1.23456791}
        (self.actual / 'result.json').write_text(json.dumps(actual, indent=2))
        compare_file(self.actual / 'result.json', self.reference / 'result.json')
        for key, value in [('steps', 100000001), ('captured', 1)]:
            with self.subTest(key=key):
                (self.actual / 'result.json').write_text(json.dumps({**actual, key: value}))
                with self.assertRaises(ValueError):
                    compare_file(self.actual / 'result.json', self.reference / 'result.json')

    def test_float32_roundoff_is_allowed_but_field_changes_are_detected(self):
        field = np.array([0.0, 1.0, -2.0], dtype=np.float32)
        np.savez_compressed(self.reference / 'field.npz', velocity=field)
        np.savez(self.actual / 'field.npz', velocity=np.nextafter(field, np.float32(1.0)))
        compare_file(self.actual / 'field.npz', self.reference / 'field.npz')
        field[1] += 0.01
        np.savez(self.actual / 'field.npz', velocity=field)
        with self.assertRaisesRegex(ValueError, 'velocity'):
            compare_file(self.actual / 'field.npz', self.reference / 'field.npz')

    def test_mesh_connectivity_and_array_shape_are_exact(self):
        faces = np.array([3, 0, 1, 2], dtype=np.int64)
        np.savez(self.reference / 'mesh.npz', faces=faces)
        for actual in (faces.reshape(2, 2), np.array([3, 0, 1, 3])):
            with self.subTest(shape=actual.shape):
                np.savez(self.actual / 'mesh.npz', faces=actual)
                with self.assertRaises(ValueError):
                    compare_file(self.actual / 'mesh.npz', self.reference / 'mesh.npz')


if __name__ == '__main__':
    unittest.main()
