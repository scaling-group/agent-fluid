# Dogfish 3D Moving-Window Target Worker

## Workspace contract

This is one latest-core EvE Phase 2 workspace. Work only inside this workspace.

```text
workspace_root/
├── README.md
├── guidance/                 editable optimizer guidance
├── solver_examples/<id>/     prior solver, score, and evaluation evidence
├── guidance_examples/<id>/   sampled optimizer guidance
├── solver/                   downstream candidate repository
└── logs/optimize/            optional optimization notes
```

The following solver files are editable; all other solver files are read-only:

{editable_files_block}
{editable_folders_block}

The whole `guidance/` tree is editable except these immutable overlays:

{immutable_overlay_block}

Read `guidance/README.md` and `guidance/control_experience.md` before editing.
Review reference evidence at:

- `solver_examples/<id>/score.yaml`
- `solver_examples/<id>/logs/evaluate/agent_observation/wake_observation.md`
- `solver_examples/<id>/logs/evaluate/agent_observation/wake_metrics.csv`
- `solver_examples/<id>/logs/evaluate/agent_observation/wake_keyframes.jpg`

The prefilled `solver/` tree does not contain prior evaluation logs.

## Task

Produce one improved fixed-morphology policy that drives the fish from the
article-aligned upper-right initial pose toward the target in the validated L64
3D moving window in still water with `U_infinity=0` and no cylinders.
Preserve the public `target_policy_params` and `target_policy` contract. The
worker may improve
feedback structure or parameter schema when evidence supports it, but must not
edit morphology, WaterLily, moving-window transport, the episode, geometry,
actuator limits, or scoring code.
Every active propulsion and steering parameter is owned by
`target_policy_params`; the fixed episode configuration cannot replace it.

The configured EvE workers run independently and each produces exactly one
candidate. Do not create sibling candidates in this workspace.

Before changing the policy, write the candidate-specific visual diagnosis and
policy hypothesis to `logs/optimize/wake_policy_notes.md`. Keep transient
reasoning there; logs are provenance and do not create an optimizer child.

Every successful worker must also add or materially revise at least one concise,
evidence-backed, cross-candidate lesson in
`guidance/control_experience.md`. Use the assigned parent guidance, sampled
solver evaluation results, and inherited optimizer logs. State the reusable
control implication and its applicability or falsification boundary. A worker
that finds no improvement must still record a concrete negative lesson: what
was tested, what prior results showed, and what future workers should avoid,
distrust, or test next. A generic no-progress statement is not sufficient.
Do not use timestamps, random IDs, punctuation, whitespace, or other nonce
edits to force a file difference. Merge or prune stale lessons instead of
turning guidance into an iteration diary. The new candidate's CFD evaluation
runs only after this worker exits and becomes evidence for a later generation.
A solver candidate is incomplete until both notes and durable guidance change.

`solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` must exist
and remain non-empty whenever the agent yields, reports progress, or exits.
Never delete or truncate it in one step with the intention of recreating it in
a later step. Replace its contents atomically in one patch, or edit it in
place, so an interrupted rollout always leaves a materializable candidate.

Before stopping, invoke `.codex/agents/check-runner.toml`. Its first check
compares `guidance/control_experience.md` with the assigned parent marked in
the rendered workspace `README.md`, ignoring evidence IDs and cosmetic text
differences. Repair any failure and rerun it until it passes. Do not run formal
CFD yourself; EvE evaluates the candidate after the worker exits. Do not ask
the human for clarification.
The check includes a deterministic parameter-schema guard: every direct
`params.FIELD` reference in the candidate must name a field actually returned
by `target_policy_params()`. Never reference a new parameter before adding it
to that returned parameter object.

## Reference solver examples

{solver_examples_block}
{optimizer_examples_block}

## Score semantics

Higher solver score is better.
