"""Check privacy boundaries and faithful selection of recorded messages."""
import unittest
from export_2d_agent_sessions import parse_session, sanitize


class PublicSessionTests(unittest.TestCase):
    def test_scientific_urls_and_numbers_are_preserved(self):
        text = 'https://doi.org/10.1234/example score=-0.18857; elapsed=36.4T'
        self.assertEqual(sanitize(text), text)

    def test_workspace_paths_become_relative_and_identity_is_removed(self):
        text = ('/scratch/example/solver_workspaces/20260805_203641_step_1_abcdef/solver/policy.jl '
                'someone@example.org 2026-08-05T20:36:45.118Z '
                '019fd3a4-8ed3-7023-ad59-5eff858927dc C:\\Users\\example\\notes.txt')
        result = sanitize(text)
        self.assertIn('solver/policy.jl', result)
        for value in ('scratch', 'someone@', '2026-08-05', '019fd3a4', 'C:\\Users'):
            self.assertNotIn(value, result)

    def test_instruction_and_messages_survive_without_header_or_duplicate(self):
        original = ('# Session\nprivate header\n## Instruction\n\nRead evidence.\n\n'
                    '## Trace\n\n### Turn 1\n\n**agent**:\n\nObserved failure.\n\n'
                    '### Turn 2\n\n**agent**:\n\nChanged policy.\n\n'
                    '## Final Response\n\nChanged policy.\n')
        events = parse_session(original)
        self.assertEqual([e['content'] for e in events],
                         ['Read evidence.', 'Observed failure.', 'Changed policy.'])
        self.assertEqual([e['turn'] for e in events[1:]], [1, 2])

    def test_unknown_trace_role_is_not_silently_dropped(self):
        with self.assertRaises(ValueError):
            parse_session('## Trace\n### Turn 1\n**tool**:\nresult')


if __name__ == '__main__':
    unittest.main()
