# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are valid direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot,
finite dynamics, and capture termination. They reduce to two deterministic
trajectories. The repeated split-observer baseline captures at `23.83702T`
with score `-0.53501328`, scoring mean distance `2.433468L`, and final
distance `0.746096L`; v33 captures at `23.84252T` with `-0.53509095`,
`2.433543L`, and `0.746165L`. Differently named implementations of the split
algebra produce byte-identical trajectories, so the split observer—not its
names—is the assigned behavior to preserve.

I inspected the combined sheets for the strongest repeated split baseline,
v33, and the inherited v38-v40 regressions, including both the top-down
mid-plane-vorticity and oblique body/Lambda2 rows from quiescent release to
capture. Every rollout self-propels along the same smooth target-directed arc,
develops a coherent alternating wake, and retains compact three-dimensional
vortices through the final bend. There is no passive advection, wake breakup,
collision, boundary exit, or instability. The differences are below visual
resolution, so the distance, yaw, cross-track, moment, joint, and command
histories decide the mechanism comparison.

Three completed descendants now close edits to the phase-selected anterior
residual as the immediate search axis. Relative to the split baseline, the
v38 displacement-rate phase lead regressed score/mean/final distance to
`-0.535363/2.433747/0.746448L` and raised peak moment from `0.013581` to
`0.013888`; v39 anterior half-cycle envelope redistribution regressed them to
`-0.536347/2.434528/0.747467L` and raised peak moment to `0.013790`; and v40
local-crossflow gating regressed them to
`-0.536241/2.434443/0.747358L`. V40 also worsened inside-`3L` mean/peak
cross-track speed from `0.23868/0.56914U` to `0.23894/0.57061U` and peak
moment to `0.013650`, despite a small peak-yaw reduction from `3.19386` to
`3.19158 rad/T`. All three still capture at the same `23.83702T` step and
retain the same visible wake, showing that attenuating, retiming, or
redistributing the existing residual perturbs the terminal crossing without a
progress/load improvement.

The baseline instead exposes a middle-approach route cue that precedes that
terminal burden. Its carrier-rejected target-cross-track velocity changes
from about `-0.164U` at `6L` to `+0.050U` at `4-3L`, then grows to `+0.282U`
near `1L`; over `6-3L` its mean absolute value is `0.112U`. This is a
target-relative translational drift, not a wake-phase or joint-phase signal.
It supports a distinct interception test before the established terminal
controller begins, while preserving the sampled carrier and all v37-scale
near-target feedback.

## Single candidate hypothesis

Retain the response-released C-bend, posterior traveling-wave target, cadence,
role-separated course/phase observer, phase-selected anterior residual, and
smooth command projection exactly. Add one bounded middle-approach
interception bias to the anterior oscillator center. The new signal is the
existing carrier-rejected body-frame collision-line drift divided by positive
closing speed, which estimates the lateral miss per unit forward approach.
A continuous distance window rises from zero at `6L` to full at the existing
`3L` terminal boundary and falls to zero at the existing `2.1L` approach
boundary. A positive-closing gate disables it while receding or nearly
stationary. Thus it corrects accumulated lateral drift before the near-target
controller dominates, introduces no clock or route state, and never changes
posterior propulsion or the successful anterior terminal residual.

The prediction is smaller cross-track growth on entry to `3L`, with retained
split-baseline capture, mean/final distance, coherent wake, yaw/load balance,
and command feasibility. Falsify the mechanism if CFD delays or loses capture,
worsens `2.433468/0.746096L` mean/final distance, changes the alternating wake,
fails to reduce middle/terminal cross-track motion, raises yaw or moment, or
increases joint/command-limit exposure.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: separate a bounded target-vector-to-mean-curvature correction in the middle approach from the established near-target yaw/slip controller
transferable_invariant: normalize target-relative lateral drift by usable closing motion and apply a small anterior steering bias before accumulated miss demands a larger terminal correction
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional approach distances, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame collision-line drift and positive closing speed in a continuous `6L`-to-`2.1L` window to shift only the anterior oscillator center; preserve posterior lag/amplitude and all split-observer terminal algebra
falsification: reject if split-baseline capture/progress or wake coherence regresses, middle/terminal cross-track motion does not fall, yaw or moment worsens, or actuator feasibility changes

## Non-CFD validation

- Offline replay of the baseline trajectory (diagnostic only, without claiming
  closed-loop dynamics) activates the new middle-distance signal for `1128`
  samples. Its normalized range is `[-0.478, 0.321]`, corresponding to less
  than `0.957 deg` peak added anterior-center bias under the owned `2 deg`
  bound; it is exactly zero outside the continuous `6L` to `2.1L` window.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting files. Its prescribed guidance-materiality and solver-boundary
  commands were run locally and pass after removing the duplicated assigned-
  parent marker from the rendered workspace `README.md`.
- The Julia smoke command cannot start because no Julia executable is
  installed. The deterministic static schema audit finds `73` unique direct
  `params.FIELD` references among `75` returned fields with no undeclared
  reference; only `version` and `control_period` are metadata. Exactly one
  nonempty candidate exists, with SHA-256
  `09bc7be540fbe10e7783db0172c2b503ebe7d16b2e3c0f0dcb8ca1c9a1d1d6b6`.
  The policy contains no explicit time/step input, random source, file I/O,
  cylinder state, mutable global state, or memorized route. No formal CFD was
  run.
