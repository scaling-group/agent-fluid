# Dogfish L64 Second-Row Wake-Policy Guidance

This guidance is shared by the matched 2-, 3-, and 4-worker EvE experiments
that learn a fixed-morphology two-joint controller in a four-cylinder wake.
The downstream repository is `aqua-testbed`; the only editable solver surface
is the candidate target policy.

## Persistent guidance contract

`guidance/` is the editable optimizer state inherited by a child agent. Every
worker must use its assigned parent guidance, sampled solver evaluation results,
and available inherited optimizer logs to add or materially revise at least one
reusable lesson in `control_experience.md`. Positive findings, concrete negative
results, and sharper applicability or falsification boundaries are all valid.
Generic no-progress statements and nonce changes such as IDs, timestamps,
punctuation, or whitespace are not.

The current candidate is formally evaluated only after its worker exits. Its
new CFD outcome is stored in solver/optimizer logs and must be distilled by a
later sampled worker; it must not be claimed as same-worker evidence.

Guidance files have distinct durable roles:

- `README.md` owns stable task strategy and the optimizer update contract;
- `control_experience.md` is the curated evidence-to-control experience bank;
- `skills/*/SKILL.md` owns reusable evidence-reading and analysis procedures;
- additional files may represent genuinely distinct durable concerns, but not
  per-iteration diaries.

These files may evolve and are stored in the child optimizer artifact. Runtime
immutable overlays under `guidance/agents/codex/` are excluded from that
artifact and must not be used as mutable experience storage.

The policy contract is:

```julia
target_policy_params()
target_policy(state, params) -> (phi_ddot=(joint1_accel, joint2_accel),)
```

`target_policy_params` must own every active controller parameter. Do not edit
the environment, morphology, scoring, actuator limits, or simulation code.

## Frozen experiment

- Resolution: `L=64`.
- Domain: `24L x 16L`.
- Four cylinders: `(3,8.5)`, `(3,11)`, `(6,7.25)`, `(6,9.75)L`.
- Initial fish pose: `(21,14)L`, heading `29 deg`.
- Target: `(9,9.5)L`, one row-spacing behind the second cylinder row.
- Success: first crossing of a `0.75L` capture radius, with no dwell.
- Inflow: `U=0.18`, `Re=1000`, perturbation seed `20260714`.
- Held-fish prewarm: `200` nondimensional time units.
- Released horizon: `300` nondimensional time units.
- Joint hard limits: `45 deg`, `260 deg/time`, `1800 deg/time^2`.
- Failure ordering: domain exit `1`, collision `2`, unstable/nonfinite `3`;
  an ordinary horizon miss retains continuous distance/progress gradients.

All workers use the same certified held-fish prewarm snapshot. Treat it as a
common initial condition, not candidate-specific evidence.

## Deliberately naive seed

This lineage has no population import. Its seed policy SHA-256 is
`511b898cd3be991fff977679bafb58050e3428809fd88da18d04d654ec5052fd`.
This is an intentionally limited propulsion seed, not an imported incumbent.
It contains a state-feedback oscillator and a lagged second-joint target. It
reads only joint angle and joint velocity. It does not read the task target,
flow, force, moment, world position, route, or any external phase signal, and
it is not intended to complete the task.

Inspect the seed rollout, diagnostics, available observations, and inherited
evidence before deciding what capability the current controller lacks. Preserve
behavior that the evidence shows is useful. Prefer feedback changes that use
normalized body-frame quantities, remain bounded, and state a falsifiable
expectation that the evaluation can test.

Do not hard-code a global-direction command, coordinates, target identity,
elapsed time, step count, or a case-specific route.

## Evidence contract

Each sampled solver example contains compact multimodal evidence under
`solver_examples/<id>/logs/evaluate/agent_observation/`:

- `shared_prewarm_keyframes.jpg`;
- `wake_keyframes.jpg`;
- `wake_observation.md`, `wake_metrics.csv`, and JSON diagnostics.

Use the `read-wake-visual-signals-first` skill before editing. Compare at least
one strong finite example with one informative failure. Cross-check visible
motion, advection, collision, and target approach against distance, local
flow, relative crossflow, force, moment, joint saturation, and termination.
Missing keyframes are an evaluation failure, not permission to optimize from a
scalar alone.

Higher score is better, but do not rank policies by raw score alone. Read
success, arrival time, final/mean/minimum distance, clearance, saturation,
command effort, force/moment loads, and trajectory topology together. The
current `0.75L` capture is tight enough that a lower scalar score can still
contain a more useful physical mechanism.

## Evidence-only mechanism development

Read `control_experience.md` and current multimodal evidence first. This
no-Bookshelf ablation intentionally provides no cross-domain research shelf.
Form controller proposals only from the task contract, inherited guidance,
sampled solver results and logs, and current rollout evidence. Do not search
for or reconstruct the omitted shelf from neighboring configurations or
repository history.

Use normalized, body-frame signals so later held-out tests can vary wake phase,
inflow, cylinder locations, and target position. Record only durable lessons in
`control_experience.md`; put candidate-specific reasoning in
`logs/optimize/wake_policy_notes.md`. If no positive lesson survives the prior
evidence, record the concrete negative result and its future avoid/test
implication instead of claiming generic failure.

The mainline policy boundary does not expose prescribed inflow
(`inflow_velocity_body*`), remote cylinder-wake probes
(`cylinder_wake_probe_*` and derived components), or target-station
flow/vorticity (`station_flow_*`, `station_vorticity`). These may remain in
offline CFD diagnostics, but workers must not infer or recreate them from
fixed coordinates or elapsed time.
