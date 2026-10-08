# Three-dimensional EvE runs

The archive contains five runs initialized from a minimal seed (`naive_1` to
`naive_5`) and five initialized from a two-dimensional controller (`transfer_1`
to `transfer_5`). Each run has 40 iterations with four candidates per iteration.

Each run uses the same layout as the two-dimensional archive:

- `agent_calls/iteration_XX_candidate_YY/`: task instructions, ordered agent messages, candidate design notes and aggregate usage.
- `guidance/iteration_XX_candidate_YY/`: experiment guidance, control experience, reference skills and the policy checker definition.
- `policies/iteration_XX_candidate_YY.jl`: the corresponding Julia controller.

Initial guidance and policies are named `seed`. Candidate numbers associate
these records within the same run and iteration.

Policy evaluation records are in
[`raw_data/policy_scores/three_dimensional/`](../../raw_data/policy_scores/three_dimensional/),
grouped by run with the same `seed_policy.yaml` and
`iteration_XX_candidate_YY_policy.yaml` names as the two-dimensional archive.
Each YAML record contains `score`, `summary`, `metrics` and `artifacts`.
Metrics retain the recorded three-dimensional CFD measurements; evaluations
without CFD metrics retain their original failure score and an empty `metrics` mapping.
