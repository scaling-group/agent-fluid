# Dogfish L64 3D Moving-Window Still-Water Policy Guidance

This is the three-dimensional, still-water continuation of the article's
minimal-cue guidance-evolving experiment. It learns a fixed-morphology,
two-joint controller while preserving the same EvE research framework,
Knowledge Bookshelf, persistent optimizer contract, and naive drive-only seed.
The downstream repository is `agent-fluid-testbed`; the only editable solver surface
is `cases/dogfish_3d_shape_policy/candidate_target_policy.jl`.

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

- WaterLily 3D at `L=64`, `Re=1000`, in still water with
  `U_infinity=(0,0,0)` and zero imposed perturbation.
- The inertial virtual task is `24L x 16L`. The initial fish center is
  `(21,14)L`, heading is `29 deg` (head points left and slightly down), and the
  target is `(9,9.5)L`.
- Success is the first planar head crossing of a `0.75L` capture radius, with
  no dwell. The released horizon is `100T`; virtual-boundary termination uses
  a `0.8L` center margin.
- CFD storage is an inertial integer-cell moving window of `4L x 3L x 1.5L`
  (`256 x 192 x 96`). Newly exposed cells receive inertial velocity
  `(0,0,0)`; moving the storage window does not change world coordinates,
  fish/target kinematics, forces, or score.
- The continuous superellipse body and physical caudal fan are used.
  Surge, sway, and yaw are free; heave, roll, and pitch are locked.
- Initial joints are `(8,-8) deg`. Joint hard limits are `45 deg`,
  `260 deg/T`, and `1800 deg/T^2`.
- The flow is initialized directly and uniformly. There are no cylinders, no
  held-fish prewarm, and no reused flow snapshot.
- Formal multimodal evidence contains 101 top-down mid-plane frames and 26
  oblique 3D wake frames.

## Deliberately naive seed

This lineage has no population import. Its 3D seed policy SHA-256 is
`1166612ca4b716bee591ee26917f31bca811271a6cde15c058cab18427df6df3`.
Its executable control expressions are the same as the article's 2D seed; only
comments, formatting, and the downstream file path differ. This is an
intentionally limited propulsion seed, not an imported incumbent.
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

- combined `wake_keyframes.jpg`, with top-down vorticity/body frames and
  oblique 3D body/Lambda2 frames;
- `wake_observation.md`, `wake_metrics.csv`, `wake_diagnostics.json`, and
  summary/trajectory diagnostics.

Use the `read-wake-visual-signals-first` skill before editing. Compare at least
one strong finite example with one informative failure. Cross-check visible
motion, advection, wake formation, and target approach against distance, local
flow, relative crossflow, force, moment, joint saturation, and termination.
Missing keyframes are an evaluation failure, not permission to optimize from a
scalar alone.

Higher score is better, but do not rank policies by raw score alone. Read
success, arrival time, final/mean/minimum distance, clearance, saturation,
command effort, force/moment loads, and trajectory topology together. The
current `0.75L` capture is tight enough that a lower scalar score can still
contain a more useful physical mechanism.

## Knowledge use

Read `control_experience.md` and current multimodal evidence first. The full
cross-domain research shelf is at
`skills/fish-control-primitives/SKILL.md`, with classical source notes and
mechanism translations under its `references/` directory. Its purpose is to
help transfer explanatory mechanisms across species, robots, CFD models, and
control problems—not to copy published gains, trajectories, or task-specific
answers. Current rollout evidence remains the reason for changing the policy.
The worker entrypoint determines whether shelf consultation is organic or
follows a structured protocol.

Use normalized, body-frame signals so later held-out tests can vary inflow,
target position, initial pose, and other hydrodynamic conditions. Record only
durable lessons in `control_experience.md`; put candidate-specific reasoning in
`logs/optimize/wake_policy_notes.md`. If no positive lesson survives the prior
evidence, record the concrete negative result and its future avoid/test
implication instead of claiming generic failure.

Do not infer or recreate prescribed inflow, virtual-boundary geometry, or task
identity from fixed coordinates or elapsed time. Use only the available
normalized observations and completed rollout evidence.
