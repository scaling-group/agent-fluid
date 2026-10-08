# Reject instantaneous terminal course-slip feedback

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical evaluations of the assigned-parent
  v50 geometry-qualified posterior response reproduce the strongest sampled
  result: capture at `17.41299 T`, score `-0.0595203`, total/observed distance
  integrals `1.945327/1.329976 L`, and final distance `0.745094 L`.
- The prefilled v52 terminal course-slip controller is the direct negative
  comparison.  It is exactly identical to v50 through the far and middle
  route and captures at the same logged time, but it worsens total integral
  and score to `1.946671 L` and `-0.0611859`.  Its observed integral is also
  slightly worse (`1.329989 L`), it is `0.000016/0.001810 L` farther away
  at `16/17 T`, and it crosses more shallowly at `0.746705 L`.
- The v52 residual also fails its actuator boundary.  Maximum speed and peak
  normalized planar force/moment remain the same as v50 at
  `0.98310 L/T`, `0.032252`, and `0.016092`, but exact any-joint acceleration-
  limit residence rises from `40.11%` to `40.75%`, almost entirely through
  posterior residence (`5.15%` to `5.72%`).  Thus the added correction consumes
  tail authority without measurable route or arrival benefit.
- I inspected the complete combined and view-specific sheets for the strongest
  v50 rollout and the informative v52 regression, plus the v51 comparator.
  The top-down rows show active self-propulsion on the same smooth target-
  signed arc: compact startup vorticity develops into an organized alternating
  posterior street through capture, without reversal, passive advection,
  collision, boundary exit, or wake collapse.  V52 introduces no visible
  beneficial topology.  The v50 and v52 oblique rows are readable at release,
  `4 T`, `12 T`, `16 T`, and capture and show compact paired caudal Lambda2
  structures; their `8 T` frame is black.  V51's oblique row is entirely black.
  Missing frames remain a rendering/evidence limitation rather than support
  for a three-dimensional improvement.
- The completed v52 test falsifies raw instantaneous body-velocity course slip
  as terminal route authority in this gait.  Its correction is supported only
  inside `2.1 L` while closing, yet the fish's lateral velocity remains coupled
  to the tail beat.  Sending that signal back through the route request adds
  posterior clipping but does not improve radial capture.  The assigned parent
  and inherited logs also show that steeper geometric release, axial-response
  blending, and deadband renormalization fail to beat v50; none supports another
  scalar reshaping of terminal steering.

## One-candidate policy hypothesis

Materialize the completed v50 geometry-qualified posterior-response policy as
the sole candidate.  Preserve its normalized body-frame target sensing,
state-feedback traveling-wave carrier, posterior lag, selective crossflow pose
confidence, route and redirect steering, axis-selective launch residual,
carrier-first spillover, half-cycle steering, proportional geometric
qualification of the small phase-even posterior turn-shape residual, approach
priority, and componentwise acceleration projection.  Remove only v52's
instantaneous course-slip observation and closing/approach-gated route
correction, returning the policy exactly to the twice-reproduced v50 artifact.

The next CFD evaluation should reproduce capture near `17.413 T`, score and
total/observed integrals near `-0.05952` and `1.94533/1.32998 L`, the smooth
target-signed arc, compact alternating two-view wake, and the established
speed/saturation/load envelope.  Falsify this selection if it does not
reproduce, capture or middle/late closure regresses, target-signed curvature
or wake coherence is lost, or speed, acceleration-limit residence, force, or
moment materially exceeds the completed v50 envelope.  A future course
correction should not be retried until completed traces define a de-gaited or
history-consistent direction signal whose authority does not oscillate with
the carrier.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction studies
source_mechanism: preserve a productive propulsive rhythm and separate persistent route error from fast carrier- or flow-correlated lateral motion before adding corrective steering
transferable_invariant: instantaneous lateral motion is not automatically target-course error in an undulatory swimmer; supplementary feedback needs a normalized, response-coherent signal that does not spend authority cancelling the productive gait
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, full-body CPG states, exact vortex phases, cylinder-wake synchronization, and task-specific routes
policy_translation: remove the instantaneous body-velocity course-slip residual and restore the completed v50 two-joint state-feedback policy while retaining its carrier, geometric response arbitration, and actuator projection
falsification: reject the restored candidate if v50 capture and integral performance do not reproduce; revisit course feedback only if a de-gaited or history-consistent signal predicts target-signed correction and bounded posterior residence on completed traces
```

## Evidence boundary

All numerical and visual outcome claims above come from the assigned-parent
guidance, sampled completed solver evidence, and inherited optimizer notes.
The sole candidate is a reproducibility selection of completed CFD evidence;
no same-worker evaluation is claimed.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v50_geometrically_qualified_posterior_response`,
  SHA-256
  `cf9ca6aa2892b1aa4298d75c1359d84c467330129e0ea6167857742403b046ab`;
  it is byte-identical to both completed strongest sampled v50 controllers.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The lightweight Julia policy
  contract, material-guidance check, and solver editable-boundary check pass.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this ChatGPT account.  Its three exact no-CFD checks were run
  locally and separately.  The guidance check first exposed two identical
  assigned-parent markers in the rendered workspace `README.md`; removing the
  duplicate repaired provenance, and the rerun passed.  No formal CFD was run.
