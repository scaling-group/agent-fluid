# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver examples are finite captures from the required
  direct-uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. They form two
  matched controller classes. The whole-carrier posterior recovery repeats at
  `23.331013T`, `2.135772L` mean distance, and score `-0.239045`; the stronger
  velocity-quadrature phase-lag allocation repeats at `23.122009T`,
  `2.133413L`, and `-0.237071`. These repeats establish deterministic
  fixed-pose behavior, not held-out robustness.
- The complete top-down sheets show self-propelled S-shaped approaches with an
  alternating red/blue caudal street attached through capture. The phase-lag
  policy is behind at `4T` (`11.450L` versus `11.300L`) but passes the
  whole-carrier policy between `9T` and `12T` and is closer at `20T`
  (`2.029L` versus `2.158L`), so its benefit is a persistent phase/route
  allocation rather than faster startup. Its sampled oblique sheet is a black
  render failure; the matched whole-carrier sheet supplies the complete
  three-dimensional bound and shows discrete Lambda2 structures through
  capture.
- The phase-lag allocation lowers peak normalized force/moment from the
  whole-carrier policy's `0.030861/0.016213` to `0.030360/0.015861`, but mean
  action rises from `59.044` to `60.062` and anterior/posterior exact rate-cap
  occupancy rises from about `11.34/6.27%` to `11.92/7.06%`. During its
  speed-recovery interval, posterior rate-cap occupancy is about `12.1%` over
  `0--2T`, `21.7%` over `2--4T`, and `19.8%` over `4--6T`. The useful
  posterior phase increment is therefore often requested when the tail has no
  remaining rate authority.
- The completed assigned-parent angle-quadrature composition is the most
  informative current negative result. Adding course-qualified posterior
  amplitude to the phase-lag policy preserves capture and a complete coherent
  two-view wake, and lowers mean action to about `58.970`, but capture regresses
  to `23.265013T`, mean distance to `2.137810L`, and score to `-0.241061`,
  while peak normalized force rises to `0.031321`. This falsifies further
  posterior amplitude composition as the answer to the early deficit. The
  inherited instantaneous `lagged_carrier * qd2` qualification likewise
  regresses score to `-0.247507`, so an uncalibrated joint-work proxy should
  not be retried.

## One candidate hypothesis

Use the reproduced phase-lag policy as the base and preserve its through-water
course observation, anterior oscillator recovery, target geometry, anterior
redirect, phase-selective carrier, reactive rudder, and terminal relief. Keep
the evidenced `0.12` velocity-quadrature recovery allocation, but multiply
only that increment by a smooth posterior-rate headroom gate. The gate remains
one below a normalized posterior-rate fraction of `0.95` (`247 deg/T`) and
falls continuously to zero at the fixed episode's `260 deg/T` rate envelope;
the base `0.8` traveling-wave lag, posterior carrier, rudder, and anterior drive
do not unload. This is state-qualified recovery and anti-saturation allocation,
not a scalar change to the recovered gain.

The hypothesis is that commands issued after the posterior actuator has
entered its rate ceiling add effort but cannot add the intended phase delay.
Yielding only the incremental recovery in that narrow state region should
retain the phase-lag policy's later route advantage while reducing cap
occupancy and avoiding the assigned parent's harmful angle-amplitude path. It
uses normalized joint state and body-frame through-water feedback, with no
time, step, coordinate, target identity, route memory, or vortex phase.

Falsify the mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, or the `9--20T` route advantage over
whole-carrier recovery disappears. Also reject it if posterior cap occupancy
does not fall below `7.06%`, mean action materially exceeds `60.062`, peak
normalized force/moment exceed `0.030360/0.015861`, or a complete top-down and
oblique sheet fails to preserve the established alternating 3D wake. A win in
this fixed-pose still-water rollout would establish only actuator-headroom
compatibility, not robustness to changed poses, hydrodynamics, or imposed
wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-delayed traveling bend while scheduling rhythmic recruitment from measured actuator state rather than prescribed time
transferable_invariant: feedback-triggered locomotor recruitment should preserve wave direction and yield when the actuated posterior joint has no remaining rate headroom
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the evidenced through-water speed-gated posterior velocity quadrature, but smoothly remove only its incremental share as normalized posterior rate rises from `0.95` to `1.0` of the fixed rate envelope
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, posterior cap occupancy does not improve, or route, complete two-view wake, action, force, or moment envelopes worsen
