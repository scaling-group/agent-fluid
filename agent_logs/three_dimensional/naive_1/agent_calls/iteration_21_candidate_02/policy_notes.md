# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from direct uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no
  reported instability. The top-down rows show self-propelled curved motion
  behind an alternating red/blue wake rather than imposed advection. The
  complete sheet for `solver_56888ac0e1b7` also shows discrete oblique
  three-dimensional Lambda2 structures from formation through capture. The
  oblique rows of the three faster samples are blank render artifacts, so they
  support numerical and top-down repeatability but not three additional 3D
  wake confirmations.
- The assigned-parent composition is reproduced byte for byte by
  `solver_1fcbc36bb25f`, `solver_4f671efd576e`, and
  `solver_8ea427e35cb4`: capture at `23.864521T`, crossing at `0.749310L`,
  score-metric mean distance `2.192138L`, and score `-0.294271`. It therefore
  verifies compatibility between forward-speed-deficit carrier recovery and
  water-relative route sensing, improving the separate speed-recovery result
  at `23.985519T/2.202000L` and the separate water-relative result at
  `24.018509T/2.206025L`. This is fixed-pose determinism, not robustness to a
  changed pose or hydrodynamic condition.
- The most informative current regression is `solver_56888ac0e1b7`, which
  differs in the slow route loop by using inertial body-lateral speed instead
  of local-water-relative sideslip. It retains the complete coherent two-view
  wake and the same capture topology but arrives `0.121T` later, has mean
  distance `2.202000L`, and has higher near-target mean action (about `43.33`
  versus `41.56`). The successful composition also slightly lowers peak
  normalized force from about `0.02977` to `0.02948`; posterior rate-cap
  occupancy remains about `6.4%`. No sampled rollout has a failing termination,
  so this matched mechanism regression is the available informative failure.
- The faster trace still carries strong alternating whole-body yaw while the
  target remains on one side: at integer samples around `7T`, `10T`, and
  `21T`, target error is positive while heading rate is about `-2.12`,
  `-1.99`, and `-1.95 rad/T`; normalized yaw moment is simultaneously
  negative at about `-0.0053`, `-0.0038`, and `-0.0055`. Useful opposite
  half-cycles and the coherent carrier must remain intact. Inherited evidence
  rules out more terminal-gate tuning and carrier-wide recent-yaw unloading,
  but it has not tested a small posterior residual qualified by measured
  adverse hydrodynamic moment.

## One candidate hypothesis

Preserve the complete assigned-parent carrier, water-relative curvature loop,
reactive-rudder sign, and terminal phase allocation. Add one compact
load-rejection mechanism to the posterior target: only when full target error
is large and the measured normalized yaw moment points opposite the target-side
turn, add a smooth bounded posterior offset with the moment's sign. The
established actuator-sign calibration implies that this offset should oppose
the adverse yaw torque, while zeroing the residual for target-helping moments
leaves productive carrier half-cycles unchanged. The limit is small relative
to the `16 deg` reactive rudder and is scaled from the observed adverse-moment
range, not from a published gain.

The reflex is normalized, body-frame, bounded, reflection equivariant, and
uses no clock, coordinates, route memory, or exact vortex phase. Falsify it if
capture is lost or later than `23.864521T`, mean distance exceeds `2.192138L`,
the preterminal route changes adversely, or mean action, `11.78/6.41%`
anterior/posterior rate-cap occupancy, `0.02948` peak force, `0.01534` peak
moment, or the coherent wake envelope materially worsens. A fixed-pose gain
cannot establish robustness; later pose or hydrodynamic evidence must test
that boundary.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: preserve a traveling propulsive carrier while using measured hydrodynamic load to reject only disturbances that oppose the persistent target-directed turn
transferable_invariant: separate the rhythmic carrier from a small bounded load residual, qualify the residual by body-frame target-side geometry, and leave target-helping load cycles untouched
nontransferable_details: published gains, species or robot geometry, dimensional moment scales, prescribed vortex phase, cylinder layout, maneuver timing, and task-specific routes
policy_translation: retain the evidenced two-joint carrier and all route and terminal paths, then add a capped posterior target offset only for normalized yaw moment whose sign opposes the full body-frame target request
falsification: reject if capture is lost or later than 23.864521T, mean distance exceeds 2.192138L, or route, wake, saturation, action, force, or moment envelopes worsen

## Static implementation audit

Replaying only the new algebra on the assigned parent's recorded states (not a
CFD rollout) activates the residual on `36.28%` of samples, with a mean active
offset of `1.10 deg` and a maximum of `2.75 deg`, below its `3 deg` cap.
Mirrored synthetic states produce exactly sign-reversed joint accelerations,
and aligned or target-helping moment states produce no residual. Formal CFD
evidence for the candidate remains pending after this worker exits.
