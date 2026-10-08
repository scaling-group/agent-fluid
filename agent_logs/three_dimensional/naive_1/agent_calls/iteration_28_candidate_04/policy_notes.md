# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver examples are finite captures from the required
  direct-uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. Three
  executable-identical phase-lag policies reproduce exactly `23.122009T`,
  `0.749507L` crossing distance, score-metric mean distance `2.133413L`, and
  score `-0.237071`; the whole-carrier comparison captures later at
  `23.331013T`, with `2.135772L` mean distance and score `-0.239045`.
- The best complete combined sheet shows self-propulsion rather than
  advection: an alternating red/blue mid-plane street forms behind the caudal
  region by `4T`, remains attached along the S-shaped approach, and corresponds
  to discrete three-dimensional Lambda2 structures through capture. The
  whole-carrier top-down row has the same broad wake topology, but its oblique
  row is a blank render artifact. Numerically, the phase-lag policy is behind
  at `4T` (`11.450L` versus `11.300L`), passes the whole-carrier policy between
  `9T` and `12T`, and is ahead at `20T` (`2.029L` versus `2.158L`). Its benefit
  is therefore later phase/route allocation, not startup thrust or lower
  effort; mean action is `60.062` and anterior/posterior rate-cap occupancy is
  about `11.92/7.06%`.
- The two inherited assigned-parent experiments preserve capture and complete
  two-view wakes but reject further posterior composition. Adding a
  course-qualified angle quadrature captures at `23.265013T` with `2.137810L`
  mean distance and peak normalized force `0.031321`; suppressing only the
  phase-lag increment near the posterior rate cap captures at `23.314514T`
  with `2.136120L` mean distance and score `-0.239352`. The latter still has
  about `6.65%` posterior cap occupancy. Tail amplitude and tail-headroom gates
  are therefore not the current missing mechanism.
- A new cross-check of the best trajectory exposes an observation-allocation
  issue before any actuator change. Regressing measured lateral through-water
  sideslip on normalized anterior joint angle and velocity over `2--22T`
  explains about `88%` of its variance; the velocity-quadrature coefficient is
  approximately `-0.405U`. In shorter intervals the fit explains `93--99%`,
  with velocity coefficients from about `-0.305U` to `-0.533U`. Thus most of
  the instantaneous signal presented to the nominally slow course loop is
  carrier-phase lateral motion. With no compensation, its bounded turn request
  has `0.508` standard deviation over `2--22T` and points opposite the
  persistent target side for about `11.8%` of samples, consistent with the
  visible S-route and finite rate-cap use.

## One candidate hypothesis

Use the reproduced phase-lag policy as the base and preserve its through-water
axial recovery, full target geometry, anterior redirect, phase-selective
carrier, posterior velocity-quadrature recovery, reactive rudder, and terminal
relief. Before constructing only the slow course angle, remove a conservative
`0.15U` estimate of self-generated lateral motion proportional to normalized
anterior joint velocity. This is less than half the smallest interval-fitted
coefficient, so external or slowly varying sideslip remains observable. On the
recorded best trajectory the translation reduces sideslip standard deviation
from `0.247U` to `0.176U` over `2--22T` and the corresponding turn-request
standard deviation from `0.508` to `0.460`, without changing target geometry or
any propulsion, rudder, or terminal actuator path.

The mechanism is state-only and reflection equivariant: lateral sideslip and
anterior joint velocity both reverse sign under reflection. It uses no clock,
step, coordinate, target identity, route memory, imposed vortex phase, force,
or moment residual. Falsify it if capture is lost or later than `23.122009T`,
mean distance exceeds `2.133413L`, or the `9--22T` route advantage disappears.
Also reject it if the S-route or cross-track motion becomes more pronounced,
the alternating top-down and oblique wake fails the complete-sheet bound, mean
action materially exceeds `60.062`, cap occupancy leaves the approximately
`11.92/7.06%` class, or peak normalized force/moment exceed
`0.030360/0.015861`. A fixed-pose still-water improvement would establish only
self-motion/course-observation separation, not imposed-wake or pose
robustness.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate slow persistent target-course feedback from fast rhythmic crossflow before modulating a traveling carrier
transferable_invariant: self-generated beat-synchronous lateral motion should not be interpreted as a slow route error when joint state provides a bounded reflection-equivariant phase signature
nontransferable_details: published gains, dimensional speeds and frequencies, species-specific envelopes, robot calibration, distributed-body kinematics, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: subtract a conservative anterior-velocity-quadrature estimate from measured body-water lateral sideslip only inside the bounded course-angle observation, while preserving every propulsion and steering actuator path
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, course oscillation or the S-route is not reduced, or complete two-view wake, action, saturation, force, or moment envelopes worsen
