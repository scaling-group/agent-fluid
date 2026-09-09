# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- The only sampled solver is the common naive drive-only seed. Its rollout is
  valid for this lane: `uniform_direct`, `U_infinity=[0,0,0]`, no prewarm, and
  34 moving-window shifts.
- The top-down row shows a visible alternating red/blue wake that lengthens as
  the fish moves left, while the oblique row shows coherent three-dimensional
  Lambda2 structures behind the body. This is self-propulsion, not advection
  by a background current. The oscillator therefore supplies a useful
  traveling bend and should be preserved.
- The useful finite point occurs at `t=6.3635T`, where distance briefly falls
  from `12.3277L` to `12.0638L`. It is not sustained: heading spans about
  `+0.602` to `-1.171 rad`, the trajectory bends toward increasing world `y`,
  and the fish exits the left boundary at `t=8.6130T` with distance
  `12.3510L` and score `-14.7918`. Joint angles remain far inside their hard
  limit (observed maxima about `26.3/26.6 deg`), but at least one joint touches
  the `260 deg/T` velocity limit on `4.0%` of rows and a raw acceleration
  command exceeds `1800 deg/T^2` on `52.6%` of rows. Thus the immediate missing
  capability is target-directed mean turning rather than absent propulsion,
  while the actuator-heavy base remains a falsification risk rather than an
  efficiency result.
- No inherited optimizer log exists in this fresh workspace. The assigned
  parent guidance says to preserve evidenced propulsion and add bounded,
  normalized body-frame feedback rather than a coordinate route.

## Policy hypothesis

Retain the state-feedback oscillator and posterior lag exactly at zero turn
request. Convert body-frame bearing plus its recent windowed rate into one
bounded turn request, then shift both oscillator equilibria by the same bounded
mean curvature, capped at `8 deg` so its nominal addition to the observed
`~26 deg` oscillation retains angle headroom. A positive bearing uses the
testbed's evidenced positive-bend
to negative-yaw sign. Centering the oscillatory coordinates on the requested
bias should preserve the alternating propulsive wave better than adding an
unbounded acceleration offset. Bearing-rate damping should release curvature
as alignment improves and reverse it after an overshoot.

Falsification: reject this mechanism if the next rollout lacks a coherent
alternating wake, persistently approaches the `45 deg` joint limit, turns in
the wrong direction, worsens velocity/acceleration saturation, or repeats
`left_domain` without materially improving minimum/final distance or
trajectory alignment. If turn direction is correct but propulsion collapses,
test half-cycle asymmetry rather than increasing the mean-bend scale.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and fish body-bending turns
source_mechanism: sensor-modulated rhythmic motion with bounded mean-curvature bias
transferable_invariant: preserve the propulsive rhythm while a persistent body-frame target error shifts its mean curvature; reduce the shift when observed alignment response appears
nontransferable_details: published CPG gains, robot morphology, species kinematics, dimensional beat settings, world-frame routes, and exact vortex phases
policy_translation: map normalized body-frame bearing and windowed bearing rate to a bounded request; center both two-joint state-feedback oscillations on a joint-safe mean bend
falsification: wrong-sign turn, lost coherent propulsion, persistent joint-limit contact, or no semantic/distance improvement over the seed left-domain trajectory
