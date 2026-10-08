# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled policies are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-equivalent
  whole-carrier recovery policies reproduce exactly `23.331013T`,
  `0.749672L` crossing distance, score-metric mean distance `2.135772L`, and
  score `-0.239045`; their repeated outcome is determinism evidence rather
  than pose or hydrodynamic robustness.
- The strongest sampled allocation moves the same bounded early posterior
  recovery share from whole-carrier scaling to only the anterior-velocity
  quadrature of the lagged tail target. It advances capture to `23.122009T`,
  lowers mean distance to `2.133413L`, and improves score to `-0.237071`.
  Compared with whole-carrier recovery, peak normalized force/moment fall from
  `0.030861/0.016213` to `0.030360/0.015861`; however, mean action rises from
  `59.044` to `60.062`, and anterior/posterior rate-cap occupancy rises from
  about `11.34/6.27%` to `11.92/7.06%`. Its benefit is therefore a phase and
  route allocation result, not lower actuator effort.
- The complete top-down sheets show both allocations self-propel along the
  established S-shaped approach in still water while an alternating red/blue
  caudal street forms by about `4T` and remains attached through capture. The
  phase-lag policy is behind at `4T` (`11.450L` versus `11.300L`) but crosses
  ahead between `9T` and `12T`, stays closer to the direct target line, and is
  at `2.029L` rather than `2.158L` at `20T`. This agrees with a persistent
  route benefit rather than a faster startup alone. Its oblique row is a black
  render artifact, so only the matched whole-carrier sheet—with discrete
  three-dimensional Lambda2 structures through capture—supplies the current
  complete 3D-wake preservation bound.
- The inherited power-stroke-qualified whole-carrier test is the informative
  negative control. Smoothly suppressing recovery from the instantaneous
  `lagged_carrier * qd2` sign still captures, but its sampled score regresses
  to `-0.247507` from the reproduced whole-carrier `-0.239045`. The available
  inherited log has no complete trajectory diagnostics for that child, so it
  falsifies the proposed instantaneous joint-work proxy, not every possible
  state qualification or energy-feedback mechanism.

## One candidate hypothesis

Use the sampled phase-lag recovery policy as the base. Preserve its
through-water course observation, anterior oscillator recovery, full target
geometry, anterior redirect, phase-selective carrier, reactive rudder, and
terminal relief. Keep the completed `0.12` speed-deficit addition to the
posterior velocity quadrature unchanged. Add one distinct angle-quadrature
share, also bounded by the existing through-water recovery gate, only when the
body-frame course loop requests little steering. The reflection-invariant
gate `1 - turn_request^2` is one at measured course alignment and tends to zero
as the bounded turn request saturates. It multiplies only the centered
anterior carrier angle, so it does not amplify the curvature center, rudder,
or target geometry.

This tests a separation suggested by the matched rollouts: whole-carrier
recovery has the stronger `0--6T` distance trace but the weaker later route,
whereas velocity-quadrature recovery gives up early distance and then captures
`0.209T` sooner. Course-qualified angle recruitment should recover part of
the former's thrust only during aligned portions of the latter's maneuver.
It adds no clock, coordinate, route memory, global direction, load residual,
or exact vortex phase, and it is not scalar-only gain tuning.

Falsify the mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, or the early distance deficit is not reduced
without changing the preterminal S-route adversely. Also reject it if the
alternating top-down/oblique wake fails the complete-sheet bound, mean action
materially exceeds `60.062`, anterior/posterior rate-cap occupancy leaves the
approximately `11.92/7.06%` class, or peak normalized force/moment materially
exceed `0.030360/0.015861`. A fixed-pose still-water improvement would establish
only allocation compatibility, not robustness to imposed wakes, changed
poses, or hydrodynamic perturbations.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a posterior-delayed traveling carrier while separating slow course steering from feedback-triggered locomotor recruitment
transferable_invariant: posterior amplitude may be recruited during measured through-water slowdown only while the normalized body-frame course loop is near alignment, while posterior phase delay remains available throughout the slowdown
nontransferable_details: published gains, dimensional speeds and frequencies, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the sampled speed-gated posterior velocity-quadrature recovery and add a separately bounded centered-angle quadrature multiplied by the smooth reflection-invariant `1 - turn_request^2` course-alignment gate
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, the early deficit persists, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
