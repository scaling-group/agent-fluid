# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three velocity-quadrature
  phase-lag candidates reproduce the exact `23.122009T` capture,
  `0.749507L` crossing, `2.133413L` scored mean distance, and `-0.237071`
  score. The whole-carrier comparison captures later at `23.331013T`, with
  `2.135772L` mean distance and `-0.239045` score. This is deterministic
  fixed-pose evidence, not held-out robustness.
- The strongest sampled combined sheet shows self-propulsion rather than
  advection. Its top-down row retains the established S-shaped route and an
  attached alternating red/blue mid-plane street from about `4T` through
  capture; its oblique row shows discrete three-dimensional Lambda2 structures
  behind the caudal region through capture. The whole-carrier sample and the
  assigned-parent child have blank oblique rows, which are render failures and
  cannot support additional three-dimensional wake claims.
- The assigned parent's speed crossfade is a concrete negative result. Moving
  the same `0.12` posterior recovery share from whole-carrier amplitude below
  `0.20U` to velocity-quadrature lag by `0.35U` improves early distance
  (`8.704L` rather than `8.826L` at `8T`) but loses the sampled phase-lag route
  advantage by `10T`. It captures at `23.215511T`, raises scored mean distance
  to `2.146268L`, and regresses score to `-0.249630`; by `20T` it is at
  `2.218L` rather than `2.029L`. Through-water speed is therefore useful for
  bounded recovery activation but is not an evidenced selector between
  posterior amplitude and phase allocations.
- The best trace still exposes a target-line response that is separate from
  beat yaw. Over `2--22T`, the raw short-window bearing rate has about
  `1.700 rad/T` standard deviation. With the policy's negative-body-x head
  convention, subtracting `turn_rate_recent` cancels the rhythmic body
  rotation and leaves a bounded line-of-sight rate with mean
  `0.075 rad/T`, standard deviation `0.078 rad/T`, and maximum magnitude
  `0.443 rad/T`. From `9--22T` this residual is target-side for every sample
  and averages `0.108 rad/T`, while visible distance progress remains monotone.
  That is evidence for a slow pursuit lead, not a reason to rewrite the
  established sideslip course observation or add another propulsion gain.

## One candidate hypothesis

Preserve the reproduced phase-lag policy's through-water course observation,
anterior oscillator recovery, full target geometry, anterior redirect,
phase-selective carrier, posterior velocity-quadrature recovery, posterior
rudder sign and limit, and terminal relief. Add one bounded response mechanism:
form a reflection-equivariant line-of-sight rate from
`bearing_window_rate - turn_rate_recent`, clamp it to the observed
`0.5 rad/T` envelope, and project the full target error one carrier cycle
forward only when evaluating the existing posterior-rudder error gate. Keep
the current lateral target sign for the rudder itself.

This is not a route replay or a rudder-gain increase. The existing distance
gate makes the new path inactive during launch and early propulsion; once the
fish is inside `8L`, a target line that is translating farther to the requested
side recruits the already bounded rudder slightly earlier, while opposite
drift releases it. On the sampled trace the mean `9--22T` look-ahead is about
`0.060 rad`, and the clamp limits it to `0.275 rad`. The controller keeps no
hidden clock or history beyond the provided normalized observations.

Falsify the mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, or the `9--22T` route advantage disappears.
Also reject it if the established alternating top-down and oblique wake is not
retained, mean action materially exceeds `60.062`, anterior/posterior rate-cap
occupancy exceeds about `11.92/7.06%`, or peak normalized force/moment exceed
`0.030360/0.015861`. A fixed-pose win would establish only compatibility of
line-of-sight lead with this carrier, not robustness to pose, inflow, wakes, or
hydrodynamic changes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: separate persistent target-line motion from fast rhythmic body yaw before scheduling a bounded steering response
transferable_invariant: target-bearing change and measured body turn can be combined into a reflection-equivariant line-of-sight rate that anticipates persistent target-side drift without changing the traveling carrier
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot calibration, prescribed routes, fixed coordinates, exact vortex phases, and source-task look-ahead horizons
policy_translation: preserve the sampled two-joint carrier and use a clamped normalized `bearing_window_rate - turn_rate_recent` to project only the distance-gated posterior-rudder error one carrier cycle forward, without changing rudder sign or maximum magnitude
falsification: reject if capture is later than `23.122009T` or lost, mean distance exceeds `2.133413L`, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
