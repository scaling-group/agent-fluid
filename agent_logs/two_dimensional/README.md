# EvE population archives

Population records for *Self-Evolving Scientific Agent Designs Physically Reasoned White-Box Fluid Control*.

Each 2D run contains 20 iterations with four candidate workspaces per iteration.

- `guidance/`: full guidance folders, including the initial seed and evolved control experience.
- `policies/`: the corresponding Julia controller files.
- `agent_calls/iteration_XX_candidate_YY/`: readable agent records using the same file types as the 3D sessions. `events.jsonl` preserves the recorded task instruction and ordered agent messages; `policy_notes.md` contains the candidate's original design notes when available; `usage.json` contains aggregate turns, tokens and runtime.

Policy evaluation records are in [`raw_data/policy_scores/two_dimensional/`](../../raw_data/policy_scores/two_dimensional/), grouped by run.

File names share the same iteration and candidate identifiers across guidance, policies, agent calls and policy scores. Initial seed files are named `seed`.

Session records contain the task instruction, ordered agent messages, candidate design notes and aggregate usage. The export code is `code/reproduction/export_2d_agent_sessions.py`.

Historical relative paths within conversations and score records refer to the original execution.

The extraction script reads `raw_data/policy_scores/two_dimensional/<run>/*_policy.yaml` directly to reconstruct learning curves and CFD cost comparisons. `score` is the original online objective; `metrics.distance_integral_L` supplies the navigation score, and `metrics.steps` supplies the CFD work count. Seed evaluation values come from `seed_policy.yaml` in the same raw-data run folder. `derived_data/extraction_report.json` records which original files were used for each output.
