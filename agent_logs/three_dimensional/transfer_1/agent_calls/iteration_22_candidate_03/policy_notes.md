# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent replay satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and active moving-window shifts. Their wakes are released-swimmer
  behavior rather than background advection.
- The two current exact `dogfish3d_intercept_guarded_speed_reserve_v1`
  samples captured at `0.7466--0.7494L` after `18.3205--18.6010T`. Inherited
  guidance records at least three exact captures for this controller and an
  earlier four-repeat sample set with no semantic failure. Its combined
  top-down and oblique sheets show self-propulsion through capture, an
  organized alternating mid-plane street, and compact three-dimensional
  Lambda2 structures; the carrier remains active at arrival.
- The two current exact
  `dogfish3d_speed_reserve_posterior_wave_shape_v1` samples also captured, at
  `0.7480--0.7492L` after `18.1995--18.4690T`, with visually comparable active
  wakes and actuator/load metrics overlapping the baseline envelope. The
  inherited notes therefore treated the small tail pulse as compatible but
  explicitly required an exact replay and said to reject it after any miss.
- The assigned parent's exact-byte posterior replay is the key falsification.
  It missed below at `1.2589L`, kept self-propelling, and exited the lower
  boundary at `32.945T` with final distance `10.7282L`. The wake remained
  organized in both the top-down and oblique rows well after closest pass, so
  the failure is terminal path geometry, not propulsion loss, advection,
  prewarm, numerical instability, or scalar cadence.
- Earlier inherited failures already rule out route gain, cadence relief,
  carrier suppression, total-command speed governors, half-cycle reallocation,
  projected-miss replacement, and terminal yaw damping as generic fixes for
  this topology.

## One candidate hypothesis

Restore the exact evaluated `dogfish3d_intercept_guarded_speed_reserve_v1`
policy bytes from the sampled baseline. This keeps the achieved-course route
error, projected-corridor intercept veto, state-feedback traveling bend,
additive steering, and conditional outward-carrier reserve, while removing the
posterior phase-dependent tail residual that failed on exact replay. No gain,
cadence, route threshold, or actuator allocation is retuned.

Expected test: recover the repeat-backed capture and the same coherent far-field
and terminal wake structure, without changing the established force, moment,
clipping, or speed-limit envelope.

Falsification: if the exact baseline replay itself misses or weakens the wake
envelope, then the rollback is no longer the right default and the next worker
should test one new mechanism at a time against that repeat-backed baseline;
do not retune or re-add the posterior pulse after its exact lower-exit failure.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a lagged propulsive traveling bend while bounded body-frame target feedback supplies subordinate steering
transferable_invariant: terminal steering must not replace or phase-distort an active posteriorly lagged propulsive wave without repeat evidence of better interception
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact vortex phase, world-frame routes, and task-specific coordinates
policy_translation: remove the falsified phase-dependent tail residual and restore the exact normalized body-frame achieved-course controller with its evaluated two-joint traveling bend and intercept guard
falsification: reject the rollback if an exact replay loses capture, weakens either wake view, changes far-field closure, or leaves the established actuator and load envelope
