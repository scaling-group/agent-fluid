# Cadence-recovery rejection and reproduced intercept candidate

## Evidence and visual diagnosis before the policy edit

- The four sampled solver rollouts are byte-identical evaluations of the
  `v29` center-translation intercept policy. Each satisfies the Phase-2
  contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics through 268
  moving-window shifts, and capture from `12.327720 L` at `25.118523 T`.
  They reproduce score `-0.5280772274`, mean distance `2.429087214 L`, and
  final distance `0.746135294 L`; this is replication of one action law, not
  four distinct mechanisms.
- I inspected the complete combined sheets for a reproduced `v29` rollout,
  the inherited `v31` head-point regression, and the assigned parent's `v32`
  cadence-recovery regression. This covered every top-down mid-plane
  vorticity panel and every oblique body/Lambda2 panel from release to
  termination. All three fish visibly self-propel from quiescent water along
  the same compact target-directed arc, leave a coherent alternating planar
  wake with finite three-dimensional vortex packets, and enter a quiet
  held-bend glide before capture. None shows passive advection, a loop,
  collision, boundary-exit precursor, terminal thrashing, out-of-plane
  instability, or wake collapse. No terminated failure sheet is present in
  the supplied evidence, so the two completed regressions are the strongest
  available visual negative contrasts and are not mislabeled as failures.
- Telemetry resolves differences hidden at sheet resolution. Replacing the
  center-course predictor with head range/line-of-sight kinematics (`v31`)
  retained the capture step but regressed to score `-0.5281959396`, mean
  distance `2.429180928 L`, and final distance `0.746260285 L`. The assigned
  parent then preserved the center predictor but restored up to `3%` of only
  the below-nominal redirected cadence under the existing late intercept,
  closure, crossflow, proximity, and settled-response gates (`v32`). It also
  retained the capture step but regressed to score `-0.5281246771`, mean
  distance `2.429124662 L`, and final distance `0.746185303 L`.
- The cadence mechanism was not dormant: the inherited replay found it active
  on 160 of 226 states below `1.6 L`, with an average normalized cadence
  increment near `0.00413` and exact outer noninterference. Coupled CFD
  nevertheless reduced below-`1.6 L` mean speed from about `0.649624` to
  `0.649608 L/T` and final speed from about `0.654015` to `0.653974 L/T`.
  Final command magnitudes fell from about `0.09772/0.24610` to
  `0.09643/0.24160 rad/T^2`, but peak force norm in that band rose from about
  `0.002193` to `0.002248`. Lower acceleration here is therefore not evidence
  of better propulsion, and a frequency-side restoration is not equivalent to
  preserving useful terminal translation.

## Policy hypothesis

Promote the reproduced `v29` center-translation intercept action law as the
single candidate and identify it as the post-cadence-recovery baseline.
Preserve its joint-state oscillator, posterior lag, target-angle redirect,
closure preview, shared two-joint mean-curvature equilibrium,
helpful-crossflow and settled-response gates, constant-velocity center-course
miss corridor, `3.5%` coupled carrier release, and command limits. Remove the
assigned parent's cadence-recovery branch rather than stacking another
terminal mechanism: repeated CFD shows that the small frequency restoration
does not improve speed, distance, arrival class, loads, or the two-view wake.

This is a mechanism-level negative selection, not scalar-only gain tuning.
The candidate intentionally restores the best reproduced action law; apart
from its provenance label, it is behaviorally identical to the four sampled
`v29` policies. Falsify the selection if its next independent rollout fails
to reproduce capture and the compact wake-supported path. A later propulsion
test should use a genuinely different, independently bounded actuator
mechanism and must improve distance or arrival without changing the outer
trajectory, stable mean bend, terminal load envelope, or wake coherence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve an established coordinated traveling rhythm, and relax or restore rhythmic authority only when observed target-relative response demonstrates a benefit
transferable_invariant: normalized body-frame target geometry and translation can gate bounded two-joint rhythmic allocation, but a response gate does not validate a cadence actuator when measured speed and distance regress
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: retain the evaluated center-velocity intercept corridor and coupled terminal carrier release while removing the separately tested frequency-recovery branch; do not replace it with another scalar cadence adjustment
falsification: reject on non-reproduction, delayed or lost capture, worse distance or miss, changed outer motion, altered mean bend, renewed terminal oscillation or joint stops, load growth, instability, or wake degradation

The promoted candidate's CFD evaluation occurs only after this worker exits
and is not claimed as evidence here.

## Non-CFD validation

- The prescribed check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. I therefore ran its
  three configured commands directly and separately, without CFD.
- The guidance semantic/schema check passes, the lightweight Julia contract
  returns two finite accelerations with `params.L == 64.0`, and the solver
  boundary check passes.
- A direct diff against the reproduced `v29` policy is limited to the
  descriptive header and version label; the action-producing code and every
  active propulsion and steering parameter are unchanged. This establishes
  deliberate behavioral reversion from the evaluated `v32` parent, not a new
  coupled-flow result.
