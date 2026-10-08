# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheet shows the fish held high and downstream of
  the target while four staggered cylinder streets grow into one asymmetric,
  interacting wake. This is the certified common initial condition, not a
  candidate ranking signal.
- All four current solver samples are semantically identical replicas of the
  `20.25 deg`, `0.67`-period, constant-`0.25` bearing-rate-lead anchor. Their
  released sheets show self-propulsion rather than passive advection: after a
  broad down/up loop and several right-side reversals, the fish enters the
  central developed wake and approaches the target nearly horizontally. Each
  captures at `244.547` with mean/final distance `6.452/0.750L`, head travel
  `(-10.916,-4.187)L`, and no collision, exit, or instability. Mean head-x
  velocity is `-0.04443` against mean local-flow x `-0.03649`, leaving
  `0.00793` controller-relative upstream transport.
- The anchor's propulsion margin is exhausted for this local test. Maximum
  anterior acceleration is `31.055 rad/time^2` against the `31.2` policy guard
  and approximately `31.416` episode cap. Its maximum lateral target offset is
  `4.293L`; RMS relative crossflow, lateral force, and moment are
  `0.13437`, `18.263`, and `362.214`. The gait shell, posterior lag/damping,
  static bearing response, and guards therefore remain fixed.
- The assigned parent's turn-away-only heading correction is informative even
  though its scalar score is worse. Its sheet still shows a broad right-side
  loop but reaches the central wake and target at `238.557`, `5.990` earlier
  than the anchor. It also increases mean distance to `7.077L`, crossflow to
  `0.13453`, and lateral force to `18.354`, while reducing moment slightly to
  `360.851`. Maximum lateral offset remains `4.293L`, and relative upstream
  transport drops to `0.00476`. Thus `bearing * heading_rate < 0` contains
  useful turn-timing information, but the parent's smooth gate acts too
  broadly to improve the route-integrated objective.
- The inherited bearing-divergence gate is the failure boundary. Its released
  sheet turns repeatedly but never retains the productive central corridor;
  it ends `3.632L` away at the horizon after a `3.290L` minimum. Diagnostics
  show only `-0.02667` mean upstream velocity, `4.703L` maximum lateral offset,
  and unchanged feasible anterior acceleration, with no collision, exit, or
  instability. Weakening bearing-rate anticipation during divergence is
  therefore not a safe substitute for preserving the anchor response.

## Single candidate hypothesis

Preserve the replicated anchor's `20.25 deg` propulsion shell, `0.67` period,
`0.65/0.80` posterior lag/damping, `10 deg` steering limit, `0.30` bearing
scale, `0.25` bearing-rate lead, and existing guards. Retain the assigned
parent's bounded `0.05` heading-rate correction only while measured body
rotation is away from the target, but square its normalized `tanh` gate. The
squared gate is strictly no larger than the evaluated parent gate, suppresses
weak and moderate turn-away corrections, and approaches the parent's response
only for strong turn-away events. It adds no coordinate, route, clock, or
remote wake signal and remains exactly the anchor during stationary or
targetward body rotation.

This one candidate tests whether the parent's earlier arrival can survive
without its larger distance integral. Improvement requires target capture with
mean distance below `6.452L` and arrival no later than `244.547`, or a material
load reduction at otherwise anchor-like route metrics. Falsify it on later or
lost capture, larger mean/lateral distance, lower controller-relative upstream
transport, higher crossflow/load, guard contact, or visible switching. Such a
result would exhaust turn-away gate shaping with the available aggregate
evidence and favor restoring the plain anchor until a separately scaled
body-frame corridor observation has time-resolved support.
