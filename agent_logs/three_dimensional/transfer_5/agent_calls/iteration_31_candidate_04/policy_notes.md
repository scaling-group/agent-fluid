# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They reduce to one replicated split-course/phase
trajectory despite two source texts: all capture at `23.83702T`, score
`-0.53501328`, and have scoring mean/final distance
`2.433468/0.746096L`. This equivalence supports preserving the behavior rather
than treating policy names or algebraic spelling as independent evidence.

I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2 rows
from quiescent release through capture for the replicated split baseline and
the weaker inherited middle-intercept rollout. Both are visibly self-propelled,
follow the same smooth target-directed arc, shed an ordered alternating wake,
and retain compact three-dimensional vortices through the terminal bend. No
sheet shows passive advection, wake collapse, collision, boundary exit, or
instability. The control differences are below keyframe resolution, so the
distance, yaw, cross-track, moment, joint, and command histories decide the
comparison.

The inherited results close route-velocity transformations as the immediate
search branch. Closing-normalized middle-approach interception delayed capture
to `23.85352T` and regressed score/mean/final distance to
`-0.536326/2.434376/0.748282L`; it reduced terminal yaw but worsened target-
cross-track speed and peak moment. Replacing the terminal total-speed cue with
a positive-closing collision cone also delayed capture by two steps and
regressed to `-0.535108/2.433569/0.746175L`. These outcomes join the inherited
phase-lead, half-cycle-envelope, and instantaneous-flow-gate regressions: a
plausible offline signal transform that retains the same visible path is not a
useful mechanism unless CFD preserves progress and load balance.

The replicated baseline instead exposes an unresolved actuation symptom. Inside
`3L`, anterior/posterior joint rates are above `99%` of the `260 deg/T` cap for
about `13.1%/10.0%` of samples, and the smoothly projected accelerations are
above `99%` of the `1800 deg/T^2` cap for about `17.5%/38.9%`. The terminal
bins remain fast (`0.69-0.78U` mean swimmer speed) and exhibit substantial yaw
rather than entering a lower-effort approach regime. Because previous one-sided
envelope relief and posterior phase-lag damping perturbed steering or wave shape
and regressed, the remaining distinct test is a phase-neutral cadence/headroom
layer that leaves the evaluated observer and mean-curvature allocation intact.

## Single candidate hypothesis

Retain the replicated split observer's response-released C-bend, continuous
anterior-only course response, distributed joint-rate cue only for phase
classification, anterior phase-selected residual, posterior traveling wave,
steering gains, and component-wise smooth command projection. Add one bounded
terminal rate-headroom governor: from the existing `3L` terminal boundary
toward capture, continuously detect the maximum absolute two-joint rate as a
fraction of the known actuator envelope and reduce cadence only as that rate
enters the final `8%` of the envelope. At full rate pressure the reduction is
limited to `10%`; below the guard band or outside `3L`, it is exactly zero.

This is state feedback with no clock, route state, world coordinate, or mutable
memory. Distance only schedules the already-established approach regime, while
normalized joint rate supplies the intervention. Unlike one-sided amplitude
relief, it preserves oscillator centers, relative posterior emphasis, lag,
steering polarity, and cycle symmetry. The prediction is retained split-
baseline capture and coherent wake with less joint-speed/acceleration-limit
exposure and no worsening of the terminal yaw/moment balance. Reject it if
capture is lost or materially delayed, mean/final distance regresses, the wake
loses coherence, yaw or moment worsens, or the measured limit exposure does not
fall.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal approach scheduling
source_mechanism: modulate rhythmic angular velocity with observed actuator state while preserving the traveling-wave carrier and continuously reducing excess drive near a target
transferable_invariant: separate target-course feedback from a bounded near-target cadence governor driven by normalized joint-rate headroom
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, clock phase, exact vortex phases, and task-specific routes
policy_translation: within the existing normalized `3L` approach band, use the maximum two-joint rate divided by an owned actuator-rate reference to reduce only oscillator cadence near the rate cap; preserve all steering observations and posterior-wave geometry
falsification: reject if replicated still-water CFD loses or delays capture, regresses mean or final distance, changes wake coherence, worsens yaw or moment, or fails to materially reduce joint-rate and projected-command exposure

## Non-CFD validation

- Offline replay of the completed baseline trajectory is used only to verify
  scale and scope, not to claim closed-loop improvement. The governor is
  exactly inactive for all `3733` samples outside `3L`. It is active for
  `41.43%` of the `601` samples inside `3L`, with mean pressure `0.1437` and a
  bounded cadence multiplier of `0.9076-1.0`; inside `1.5L` it is active for
  `31.79%` of samples. Closed-loop CFD must determine whether that pressure
  actually reduces limit exposure without trading away capture.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before file
  inspection. Running its prescribed commands locally found and repaired a
  duplicated assigned-parent marker in the rendered `README.md`; the guidance
  materiality check then passed. The solver boundary check passes with exactly
  one nonempty `candidate_target_policy.jl`.
- Julia is not installed, so the prescribed lightweight runtime smoke cannot
  launch. A deterministic static audit finds `72` unique direct
  `params.FIELD` references among `74` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit time/step input, random source, file I/O, cylinder state, mutable
  global state, or memorized route. No formal CFD was run.
