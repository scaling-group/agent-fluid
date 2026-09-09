# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent failures use direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. Their translation and wakes are released-swimmer behavior,
  not ambient advection or stored-flow artifacts.
- The current samples contain two exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` captures at
  `0.7480--0.7494L` after `18.205--18.601T` and two exact
  `dogfish3d_speed_reserve_posterior_wave_shape_v1` captures at
  `0.7480--0.7492L` after `18.199--18.469T`. Both top-down rows show a
  persistent alternating vortex street from release through capture, and both
  oblique rows show compact bilateral Lambda2 structures. The fish are
  self-propelled, continue beating at arrival, and show no carrier collapse or
  instability. Scores and distance integrals overlap, so these four threshold
  captures do not establish superiority of the posterior pulse.
- The inherited optimizer logs supply the informative failures absent from
  the four current sheets. An exact posterior-pulse replay missed below at
  `1.2589L`; an exact speed-reserve replay missed below at `1.7276L`; and the
  assigned parent's new low-bandwidth mean-curvature state servo missed below
  at `1.8818L`, exited at `31.119T`, and ended `9.7529L` away. I inspected the
  mean-curvature failure's combined sheet: it retains the same alternating
  top-down street and active three-dimensional wake through closest pass and
  exit. Its failure is terminal path geometry, not insufficient propulsion,
  background transport, or numerical instability.
- The parent trace shows that the mean-curvature residual becomes active below
  `4L`, but the route controller still interprets instantaneous body-frame
  lateral velocity as achieved course. Across the four sampled captures and
  the mean-curvature failure, terminal lateral velocity has correlation
  `-0.937` to `-0.961` with anterior joint speed. Regressing it on anterior
  speed normalized by the `260 deg/T` limit gives a consistent carrier-sway
  scale of `-0.378` to `-0.473 U`; removing that one phase-correlated component
  reduces terminal lateral-velocity standard deviation from about
  `0.225--0.336 U` to `0.062--0.117 U`. This supports an observation problem:
  fast gait sway is masquerading as slow course error and can reverse the
  target turn request within a beat.
- Inherited evidence already rejects scalar route-gain or cadence tuning,
  carrier suppression, total-command governors, half-cycle allocation,
  projected-miss replacement, posterior phase shaping, terminal yaw damping,
  and now direct mean-curvature tracking as repairs for this coherent topology.

## One candidate hypothesis

Restore the repeat-supported speed-reserve actuation and replace the falsified
posterior pulse with a terminal phase-compensated achieved-course observation.
Inside the existing `4.0L` terminal-response gate only, subtract a bounded
estimate of gait-synchronous sway from body-frame lateral velocity using
anterior joint speed normalized by its actuator limit. Use the compensated
lateral component only to form the route course angle. Keep raw body velocity
for speed gating, projected closest-pass distance, approach alignment, and LOS
rate so the intercept guard cannot mistake an estimated velocity for physical
geometry. The carrier, cadence, additive steering, response release, and sparse
outward-carrier reserve remain unchanged.

The rollout-derived compensation amplitude is `0.42 U`, centered within the
five observed `0.378--0.473 U` slopes and hard-bounded by normalized joint
speed. It is a new state-observer mechanism, not scalar tuning of route gain or
propulsion. Expected test: match the established far-field path exactly until
`4L`, retain the active two-view wake and capture-class speed, and reduce
within-beat terminal course-command reversal enough to avoid the inherited
lower branch.

Falsification: reject the phase-compensated course observer and restore the
exact speed-reserve baseline if it changes motion outside `4L`, produces
another lower pass, weakens either wake view, reduces distance closure, or
moves clipping, speed-limit residence, force, or yaw moment outside the
repeat-supported baseline envelope. Do not answer failure by tuning only the
`0.42 U` scale or stacking the failed posterior, yaw-brake, projected-miss, or
mean-curvature mechanisms.

## Non-CFD implementation cross-check

Replaying only the new observation equation over the four sampled traces and
the inherited mean-curvature failure reduces terminal route-error total
variation from `10.30--13.60` to `5.45--6.82` while preserving the recorded raw
velocity used by the intercept guard. The compensation gate is identically
zero at and beyond `4L`; this is a recorded-trace contract check, not a claim
about the unevaluated candidate's CFD outcome.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-control separation of rhythmic lateral motion from persistent route error
source_mechanism: preserve a posteriorly lagged propulsive wave while preventing fast carrier-synchronous sway from masquerading as a slow steering request
transferable_invariant: rhythmic locomotion and route regulation should use distinct observable signatures, with gait-correlated motion removed from the achieved-course signal before bounded target feedback acts
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, task coordinates, and memorized routes
policy_translation: below the existing normalized body-frame terminal gate, use bounded anterior joint speed as a clock-free phase cue to compensate only body-frame lateral course velocity while retaining raw velocity for interception geometry and commanding both joints through the unchanged traveling-bend controller
falsification: reject if far-field closure changes, capture is lost, either wake view weakens, the lower-exit topology remains, or actuator and load metrics leave the evaluated speed-reserve envelope
