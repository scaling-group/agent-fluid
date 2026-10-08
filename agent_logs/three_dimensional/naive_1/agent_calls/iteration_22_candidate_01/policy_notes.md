# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported numerical instability. Their top-down
  sheets show continuous self-propelled translation along the inherited
  S-shaped approach, with an alternating red/blue caudal street remaining
  attached to the moving body through capture. Every current combined sheet
  has a black oblique row, however, so these samples provide no new independent
  three-dimensional Lambda2 confirmation; the inherited complete two-view
  speed-recruiting rollout remains the wake-envelope control.
- The assigned-parent composition uses water-relative lateral slip but inertial
  axial speed. It captures at `23.864521T`, with score-metric mean distance
  `2.192138L`, mean action about `57.572`, anterior/posterior rate-cap occupancy
  about `11.75/6.41%`, and peak normalized force/moment about
  `0.029479/0.015344`. Replacing only its locomotor-recovery observation with
  forward body-minus-local-water speed is independently reproduced by
  `solver_c23f2d8df241` and `solver_f90703a6f2af`: both capture at exactly
  `23.424515T`, improve mean distance to `2.184349L`, and retain the same
  visible route and alternating street. Mean action and near-target action rise
  to about `58.289/45.013`, while rate-cap occupancy and peak force/moment stay
  finite near `11.74/6.65%` and `0.029780/0.015287`. This is evidence for the
  water-relative observation semantics, not for increasing recovery gain.
- The distinct adverse-moment sample, `solver_e1bb5f5ea1fa`, keeps the
  assigned parent's inertial axial recovery signal and adds only a bounded
  posterior residual when measured yaw moment opposes the target-side turn. It
  also improves over the parent, capturing at `23.545517T` with mean distance
  `2.188316L`, mean/near-target action about `57.906/44.199`, rate-cap occupancy
  about `12.08/6.49%`, and slightly lower peak force/moment
  `0.029290/0.015223`. Its top-down street and route remain coherent, but it is
  weaker than the through-water axial change and its blank oblique row prevents
  a new 3D-wake claim. The two positives act on separate paths: slow carrier
  energy recruitment versus fast target-signed hydrodynamic load rejection.

## One candidate hypothesis

Use the reproduced through-water-speed policy as the complete carrier, route,
reactive-rudder, and terminal-allocation baseline. Add exactly the sampled
adverse-yaw-moment residual, with its existing dead band, saturation, full
target-error gate, posterior sign calibration, and `3 deg` limit unchanged.
The combined controller preserves every rhythmic carrier half-cycle and asks a
small posterior offset to reject only measured moment whose sign opposes the
current body-frame target-side turn. This is a compact composition of two
independently positive observation mechanisms, not scalar gain tuning, exact
vortex-phase locking, or an open-loop maneuver.

Falsify the composition if capture is lost or later than the reproduced
`23.424515T`, score-metric mean distance exceeds `2.184349L`, the visible
preterminal route changes adversely, or mean/near-target action, rate-cap
occupancy, peak normalized force/moment, or the inherited coherent wake
envelope materially worsens. A better fixed-pose still-water result would show
compatibility only; it cannot establish robustness to an imposed wake, changed
pose, or hydrodynamic perturbation, and a complete oblique rendering is required
before claiming additional 3D-wake evidence.

bookshelf_consulted: true
source_domain: wake-interacting fish and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling rhythmic carrier while separating locomotor recovery from bounded rejection of fast hydrodynamic yaw disturbances
transferable_invariant: use normalized body-water axial speed only to recruit bounded carrier energy under locomotor deficit, and apply a small target-signed posterior residual only when measured yaw moment opposes the slow body-frame route request
nontransferable_details: published gains, dimensional thresholds, species and robot kinematics, exact vortex phases, cylinder geometry, prescribed timing, and task-specific routes
policy_translation: combine the sampled forward `relative_flow_velocity_body_U` recovery signal with the sampled dead-banded `moment_z_L2` posterior rejection residual while preserving the joint-state carrier, target gates, rudder sign, and terminal phase allocation
falsification: reject if capture is lost or later than 23.424515T, mean distance exceeds 2.184349L, or route, wake, action, saturation, force, or moment envelopes worsen
