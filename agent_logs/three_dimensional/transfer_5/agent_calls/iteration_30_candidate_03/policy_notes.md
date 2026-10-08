# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver rollouts and the inherited step-27 through step-29
results are finite, direct-uniform still-water evaluations with
`U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and capture
termination. Three sampled policies produce bit-identical trajectories and
combined sheets: the role-separated v37 behavior captures at `23.83702T`,
scores `-0.53501328`, and has scoring mean/final distance
`2.433468/0.746096L`. The v33 comparator captures at `23.84252T` with score
`-0.53509095` and mean/final distance `2.433543/0.746165L`.

I inspected the top-down vorticity and oblique body/Lambda2 rows from release
through capture for the repeated v37 behavior, v33, and the inherited v40
local-crossflow regression. In all three, the fish moves from quiescent water
under its own actuation, forms an ordered alternating wake by the middle
frames, follows the same smooth target-directed arc, and retains compact 3D
wake structures during the terminal bend. There is no passive advection,
wake breakup, collision, virtual-domain exit, or instability. The mechanism
effects are below keyframe resolution, so distance, yaw, target-cross speed,
load, joint, and command histories decide the comparison.

The inherited evidence rejects three consecutive attempts without a semantic
improvement. Displacement-rate phase lead and anterior half-cycle envelope
redistribution retained capture but regressed score and mean/final distance
to `-0.535363/2.433747/0.746448L` and
`-0.536347/2.434528/0.747467L`; both raised peak moment above v37's
`0.013581`. The assigned-parent v40 local-flow gate then regressed score and
mean/final distance to `-0.536241/2.434443/0.747358L`, worsened mean/peak
target-cross speed to `0.23894/0.57061U`, and raised peak moment to
`0.013650`, despite a marginal peak-yaw reduction. Its coherent wake and
unchanged capture step do not rescue the progress/load regression. This
falsifies instantaneous local crossflow as a causal permission gate on the
anterior residual in this still-water topology; it does not justify a smaller
gate gain.

The v37 trajectory does expose a distinct measured-response signal. Inside
`3L`, target-cross body force has mean absolute/peak magnitude
`0.01023/0.02625` in the logged force-coefficient units and correlates
`0.970` with the next-sample derivative of target-cross speed. By contrast,
its zero-lag correlation with target-cross speed is approximately zero. Thus
force is an evidenced short-horizon acceleration cue, not another estimate of
the existing route or slip state. This diagnostic motivates a force lead but
does not establish that the closed-loop intervention will improve CFD.

## Single candidate hypothesis

Retain v37's response-released C-bend carrier, role-separated yaw observers,
target-course brake, phase-selected anterior residual, posterior lag and
amplitude, cadence, and smooth command projection. Within the existing
distance- and speed-gated terminal course brake only, add a small bounded
target-cross force term to the measured course-residual speed before its
smooth projection. The force term predicts the direction of near-future
cross-track velocity; it neither changes target-derived route demand nor
touches the phase-selected residual or posterior traveling wave. Zero or
unavailable force recovers the evaluated v37 course response exactly.

This is a sensor-based lead mechanism rather than a scalar retune of the
rejected local-flow gate. It predicts less terminal cross-track overshoot
without sacrificing radial progress or increasing yaw moment. Falsify it if
CFD loses or delays capture, regresses v37-scale mean/final distance, changes
the coherent alternating wake, fails to improve the mixed cross-track/yaw/load
boundary, or worsens joint and smoothly projected command feasibility.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-disturbance rejection
source_mechanism: preserve a traveling-wave carrier while using measured fluid response as a bounded residual around slow target-course feedback
transferable_invariant: persistent body-frame target geometry should own the route, while a fast normalized force cue may only provide a small short-horizon correction in the response channel it directly predicts
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, cylinder layouts, exact vortex phases, and task-specific routes
policy_translation: project normalized body-frame force across the instantaneous target line, bound it at its observed finite scale, and add it only as a lead term to the existing terminal course-residual speed; preserve the anterior phase residual and posterior traveling wave
falsification: reject if split-baseline capture/progress or wake coherence regresses, terminal cross-track speed and yaw moment do not improve together, or actuator feasibility worsens

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  Its prescribed guidance-materiality check passes after removing the duplicate
  assigned-parent marker from the rendered workspace `README.md`, and its
  solver-boundary check passes.
- The prescribed Julia smoke command was invoked but cannot start because this
  workspace has no Julia executable. A deterministic static audit finds `71`
  unique direct `params.FIELD` references among `73` returned fields, with no
  undeclared reference; only `version` and `control_period` are metadata. The
  policy has no explicit time/step input, random source, file I/O, cylinder
  state, mutable global state, or memorized route.
- Exactly one nonempty `candidate_target_policy.jl` exists. Its SHA-256 is
  `e10369124557a08c8f3c04c9a167d1133637f80ec5f612d2fa0d9847aafa40c2`.
  No formal CFD was run.
