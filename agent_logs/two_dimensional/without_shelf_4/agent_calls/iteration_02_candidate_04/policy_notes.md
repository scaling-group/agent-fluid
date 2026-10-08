# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- The assigned parent is the prefilled `c3dbb22c85f8` policy and guidance. Its
  inherited optimizer note proposed a cap-feasible `0.80`-period, `14 deg`
  oscillator with bounded common-curvature bearing feedback. The current
  evaluation is negative evidence for that proposal: the released keyframes
  show an almost straight fish swept to the downstream/right boundary without
  entering the target wake corridor. It exits after `16.7474` with head
  displacement `(2.172, -0.814)L`, negative progress `-0.1479`, and only
  `0.692` mean command energy. Joint maxima never exceed their initial
  `8 deg` bend, so cap feasibility alone did not preserve useful propulsion.
- The common prewarm sheet shows the same held fish above and downstream of
  the target while all four cylinder streets develop and merge across the
  target corridor. It is an identical initial condition for every candidate,
  not candidate-specific evidence.
- The strongest finite sample is the naive seed (`f236e5345260`). Its released
  sheet shows genuine upstream motion followed by a turn into a steep descent
  and lower-domain exit, never reaching the useful second-row region. Metrics
  agree: head displacement `(-3.545, -13.300)L`, transient minimum distance
  `8.615L` followed by final distance `12.123L`, and only `0.0243` progress.
  Both joints hit exactly the `260 deg/time` and `1800 deg/time^2` caps, with
  `1496.25` mean command energy and `9.007L` maximum lateral target offset.
  Its saturated gait supplies propulsion but not controlled navigation.
- The other finite target-aware sample (`3f6f47644ec3`) supplies the useful
  contrast to the parent. A bounded negative tail-curvature bias plus an
  energy-normalized `18 deg`, `0.80`-period oscillator remains stable and
  reaches approximately `18/21 deg` joint bends without cap contact, but its
  keyframes still show downstream advection and a turn downward on the right
  side. It exits after `16.0984`, with head displacement `(2.575, -2.177)L`,
  negative progress `-0.1582`, and `224.26` mean command energy. Thus its
  target-bearing structure is finite and active, but the gait does not oppose
  the inflow.
- The aggressive sample (`5b26e78fb728`) visibly curls immediately and ends
  after only two keyframes. The `1.9207`-time unstable termination, exact
  anterior angle/rate/acceleration cap contact, RMS relative crossflow `3.70`,
  RMS force `119496`, and RMS moment `1.236e6` rule out using more steering or
  unconstrained drive as a repair.

## Policy hypothesis

Use the finite `3f6f47644ec3` architecture as the stable side of a structured
interpolation toward the seed's only demonstrated upstream mechanism. Keep a
clock-free, energy-normalized anterior oscillator and the sampled negative
body-frame bearing/tail-curvature sign, but move the gait from `18 deg` at
period `0.80` to `19 deg` at period `0.67`. Its anterior sinusoidal scales are
about `178 deg/time` and `1670 deg/time^2`, below the `260/1800` envelope while
substantially above the failed `0.80`-period branch. Move posterior lag and
damping partway from the weak finite controller toward the propulsive seed
(`0.65` lag, `0.80` damping), while retaining the bounded `10 deg` steering
limit and short bearing-rate lookahead. No coordinate, route, target identity,
elapsed time, prescribed inflow, remote wake probe, or target-station flow is
used.

The next CFD result should remain finite beyond the roughly `16`-time
downstream exits, make head x displacement negative, and reduce distance
without the seed's large lateral offset or exact cap contact. This hypothesis
is falsified if x displacement remains positive (the interpolated gait is
still below the propulsion floor), if the fish resumes a steep lower exit
(steering gain/sign or posterior lag is excessive), or if either joint again
spends substantial time at the rate/acceleration envelope (the interpolation
is not dynamically feasible after coupling).

A deterministic joint-only integration at the configured `0.0055` step over
the full `300` horizon found no angle, rate, or acceleration cap contact for
zero bearing, constant `0.15 rad` bearing, or a slowly varying `0.18 rad`
bearing. Across those probes, maxima were approximately `19.0/19.7 deg`,
`178/135 deg/time`, and `1670/1260 deg/time^2` for the two joints. This checks
only the policy/joint envelope; it is not same-worker CFD evidence of thrust,
navigation, or wake stability.
