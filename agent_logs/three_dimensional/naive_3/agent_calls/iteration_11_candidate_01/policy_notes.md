# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled solver evaluations, and the completed
  inherited sibling evaluations report direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm
  snapshot. Their finite displacement and alternating wakes are therefore
  self-propulsion, not advection or inherited-flow contamination.
- I inspected the combined sheets from release through termination, including
  both the top-down mid-plane vorticity row and oblique body/Lambda2 row. The
  `2.443L` alignment-gated carrier, `2.494L` full-direction gate, assigned
  parent's `2.601L` same-sign redirect, evaluated `2.477L` geometry-persistent
  counterbend, and inherited `2.179L` course-conditioned approach hold all
  preserve a coherent planar street and compact three-dimensional vortex
  chain. None collides or becomes unstable. All pass below the target and
  remain powered to the lower virtual boundary, so wake collapse is not the
  limiting failure.
- The newly completed geometry-persistent counterbend is a concrete negative
  result: versus the carrier it worsens minimum distance from `2.443L` to
  `2.477L`, rotates the body farther in the unhelpful direction at minimum
  (`0.771` versus `0.622 rad`), and retains nearly identical command residence
  (`0.745/0.339` versus `0.746/0.354`) and the same lower exit. Thus normalized
  lateral target error alone is not a valid persistence signal for the useful
  posterior S-bend.
- The inherited sibling that combines the previously best bounded target-ray
  counterbend with a course/closure-conditioned posterior-wave hold reaches
  `2.179L`, but still exits low and worsens score-integral mean/final distance
  to `8.700/9.717L`. At its minimum the center-velocity projection reports
  `0.304 L/T` closure even though head distance is at its turning point,
  showing that center translation alone is not a reliable terminal response
  measure when yaw moves the head. More geometry-only equilibrium persistence
  or propulsion attenuation is therefore not supported.

## Policy hypothesis

Preserve the assigned parent's alignment-gated oscillator, posterior lag,
bounded approach/direction/closure trigger, and command envelope. Change one
controller mechanism: allocate the triggered posterior equilibrium opposite
the anterior mean curvature, matching the only inherited actuator sign that
improved closest approach, and release it using the measured bearing trend
rather than recent yaw alone. Use the adapter's head-distance closing signal
instead of projecting center velocity onto the target ray. This produces a
response-gated terminal S-bend: it persists while the large body-frame target
error is not shrinking, but releases when target geometry demonstrates
correction.

Expected evidence is unchanged cruise progress and wake coherence, followed
by a correct-side terminal redirect with lower bearing error. Capture, a new
useful termination, or improvement beyond the inherited `2.011L` minimum
without its mean/final-distance regression would support the mechanism.
Falsify it on altered far-field motion, a short-wake curl, materially higher
posterior limit/load residence, premature release while bearing grows, or the
same powered lower exit without a useful minimum or integral improvement.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish turning around a rhythmic carrier
source_mechanism: apply a bounded target-error-driven redirect while corrective response is absent, then release continuously once observed direction error improves
transferable_invariant: separate the propulsive rhythm from a state-triggered steering residual whose persistence is governed by target-relative geometric response rather than elapsed time or fixed burst duration
nontransferable_details: published gains, dimensional frequencies, species-specific body waves, robot duty ratios, exact vortex phases, burst durations, fixed approach distances, and task-specific routes
policy_translation: normalized body-frame target direction and head-distance closure activate an opposite-sign posterior equilibrium residual; normalized bearing-window rate releases it when bearing magnitude decreases, within the unchanged two-joint state-feedback carrier
falsification: reject on degraded cruise, lost wake coherence, a tight curl, greater actuator/load residence, release while bearing error grows, no improvement beyond the 2.011L inherited benchmark, or persistence of the powered lower exit
```

## Evaluation boundary

The completed rollout evidence above belongs to assigned, sampled, and
inherited candidates. The current candidate has no CFD result yet; deterministic
contract and replay checks below will establish implementation behavior only.

## Implemented candidate and pre-CFD checks

The candidate preserves every carrier value and the assigned parent's bounded
approach/direction trigger. It replaces the same-sign posterior redirect with
an opposite-sign equilibrium residual, reads `closing_speed_L` for head-distance
closure, and uses `bearing_window_rate` to release the residual on demonstrated
geometric correction. All active scales, thresholds, and bounds remain owned
by `target_policy_params`.

Replay on completed trajectories is a gating diagnostic, not new hydrodynamic
evidence. On the assigned-parent trace, mean redirect weight is `0.00484`
outside `4L` and `0.529` inside `3L`; at its minimum the gate requests about
`5.01 deg` of opposite posterior bias because head-distance closure is only
`0.006 L/T` and bearing error is growing. On the unmodified carrier trace the
corresponding values are `0.00491`, `0.552`, and `5.35 deg`. Thus the proposed
residual leaves cruise effectively unchanged, activates in the intended
approach state, and releases measurably when bearing correction appears.

The mandated guidance-semantic, Julia policy-contract, parameter-schema, and
solver-boundary checks all pass after repairing the rendered workspace's
duplicate assigned-parent marker. Direct probes pass reflection equivariance,
response release, finite outputs, and configured command bounds. All `324`
repository non-CFD assertions pass. Formal CFD remains deferred to EvE.
