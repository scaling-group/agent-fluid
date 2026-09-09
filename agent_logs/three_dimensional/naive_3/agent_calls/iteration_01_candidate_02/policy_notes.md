# Candidate wake-policy notes

## Evidence diagnosis

- The assigned parent guidance is the fresh common-naive lineage. No inherited
  optimizer log is present in this workspace, so the only completed CFD result
  available for candidate-specific inference is sampled solver
  `solver_35fea652543a`.
- The sampled result is a valid direct-uniform still-water rollout
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm artifact). It is a finite
  failure: score `-14.810882`, `left_domain` at `8.602T`, minimum distance
  `12.0701L`, and final distance `12.3677L` from `12.3277L` initially.
- In the combined keyframe sheet, the top-down row shows a propulsive wake
  becoming increasingly curved while the fish bends upward rather than holding
  its initially target-side heading. The oblique row confirms a coherent 3D
  alternating wake, rather than passive advection, followed by a large turn.
  The trace agrees: the center travels about `1.52L` in quiescent fluid, but
  heading error grows to `1.252 rad`; closest approach occurs at `6.358T`, then
  distance increases until the head crosses the upper virtual boundary.
- Both joint speeds reach the `260 deg/T` envelope, so the carrier already has
  ample activity. The missing semantic capability is target-relative steering,
  not a larger scalar drive gain. The one sampled rollout provides an
  informative failure but no successful comparator; claims about capture or
  optimal authority must await later CFD evidence.

## Policy hypothesis

Preserve the sampled Van der Pol anterior oscillator and lagged posterior
propulsion. Add one bounded target-geometry mechanism: map normalized
body-frame bearing to a mean-curvature request and oppose measured recent body
turn rate. Split that curvature between the anterior oscillator center and the
posterior lag target so steering changes the mean bend without erasing the
traveling wave. This should keep the first useful target-directed portion of
the trajectory, prevent the unopposed upward turn, and survive well beyond
`8.602T` with continued distance reduction. A wrong-sign initial response,
another upper-boundary exit with growing bearing, collapsed wake/thrust, or
persistent joint-limit residence falsifies the translation.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and fish mean-curvature steering
source_mechanism: bounded target-error feedback biases the average bend of an otherwise propulsive rhythm
transferable_invariant: persistent body-frame target error should create bounded signed curvature while measured turn rate damps overshoot
nontransferable_details: published gains, clock-driven phases, robot geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: tanh-bounded bearing plus recent-turn-rate feedback shifts the anterior oscillator center and posterior lag target under the existing two-joint state-feedback contract
falsification: reject if the first turn has the wrong sign, the fish again exits the upper boundary near 8.6T, target distance does not decrease beyond the seed minimum, or propulsion and actuator histories materially deteriorate
```
