# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled policies are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three independently
  materialized velocity-quadrature phase-lag policies reproduce exactly
  `23.122009T`, `0.749507L` crossing distance, scored mean distance
  `2.133413L`, and score `-0.237071`; the prefilled whole-carrier posterior
  recovery captures later at `23.331013T`, with `2.135772L` scored mean
  distance and score `-0.239045`. The repeats establish deterministic
  fixed-pose behavior, not robustness.
- Both allocations self-propel along the established S-shaped capture route in
  the complete top-down sheets. An alternating red/blue caudal street forms by
  about `4T` and remains attached through capture, with no visible wake
  collapse or passive-advection explanation. The phase-lag policy is initially
  behind (`11.447L` versus `11.297L` at `4T`) but crosses ahead between `8T`
  and `12T` and is closer at `20T` (`2.026L` versus `2.155L`). Its benefit is
  therefore a later traveling-bend/route allocation rather than a stronger
  startup burst.
- Every current phase-lag oblique row is a black render artifact, so it supplies
  no independent three-dimensional wake claim. The inspected inherited
  course-qualified angle-recovery child has a complete oblique row with
  discrete Lambda2 structures from `4T` through capture and supplies the
  applicable two-view wake bound. That child is also the informative negative:
  it retains capture and the visible wake class but regresses arrival to
  `23.265013T`, scored mean distance to `2.137810L`, and score to `-0.241061`.
  Reduced mean action (`58.970` versus `60.062`) does not rescue an angle-
  quadrature composition that worsens route performance and raises peak
  normalized force from `0.030360` to `0.031321`.
- Relative to whole-carrier recovery, the useful raw phase-lag allocation
  lowers peak normalized force/moment from `0.030861/0.016213` to
  `0.030360/0.015861`, but raises mean action from `59.044` to `60.062` and
  anterior/posterior exact rate-cap occupancy from about `11.46/6.27%` to
  `11.96/7.09%`. The current formula changes the coefficient of the velocity
  quadrature without renormalizing the angle/velocity pair, so the test called
  phase-lag recovery also increases the posterior target envelope. The matched
  results support preserving the phase change while testing whether that
  incidental amplitude and saturation cost is necessary.

## One candidate hypothesis

Use the repeatedly successful phase-lag policy as the base, not the prefilled
whole-carrier policy. Preserve its through-water course observation, anterior
oscillator recovery, full target geometry, anterior redirect, phase-selective
carrier, reactive-rudder sign, and terminal response-plus-stroke relief. Keep
the evidenced `0.12` speed-deficit change in the posterior velocity-to-angle
ratio, but normalize the angle/velocity coefficient pair to the base carrier's
Euclidean envelope. This makes the bounded recovery a constant-envelope phase
rotation rather than an amplitude increase. It does not add a gain, clock,
coordinate, route memory, load residual, actuator-state gate, or exact vortex
phase.

The hypothesis is that the later route benefit comes from posterior delay,
whereas the higher action and rate-cap occupancy come partly from the
unintended larger tail-target envelope. A true phase-only translation should
retain the `9--20T` route advantage while lowering posterior demand. Falsify it
if capture is lost or later than `23.122009T`, scored mean distance exceeds
`2.133413L`, or the approach reverts toward the whole-carrier trace. Also reject
it if mean action does not fall below `60.062`, posterior exact rate-cap
occupancy does not fall below about `7.09%`, peak normalized force/moment
exceed `0.030360/0.015861`, or complete top-down and oblique evidence fails to
preserve the established alternating three-dimensional wake. A fixed-pose
still-water improvement would establish phase/envelope allocation only, not
robustness to changed pose, hydrodynamics, inflow, or organized wakes.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-delayed traveling bend while modulating phase and amplitude as distinct low-dimensional carrier coordinates
transferable_invariant: measured through-water slowdown may rotate the normalized joint-state carrier toward greater posterior delay without increasing its bounded oscillation envelope
nontransferable_details: published gains, dimensional speeds and frequencies, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: start from the sampled speed-gated posterior velocity-quadrature recovery and normalize its angle/velocity coefficient norm to the unrecovered tail carrier so only the phase ratio changes
falsification: reject if capture is later than 23.122009T or lost, scored mean distance exceeds 2.133413L, posterior effort or saturation fails to improve, or route, complete two-view wake, force, or moment envelopes worsen
