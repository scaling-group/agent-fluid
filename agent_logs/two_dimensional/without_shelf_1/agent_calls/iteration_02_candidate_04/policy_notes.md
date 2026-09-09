# Wake-policy candidate diagnosis

## Evidence read before editing

- The common prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets; the target is inside the merged wake
  behind the second row. This is shared initial-condition evidence, not a
  candidate response.
- The target-blind `0.55`-period seed is visibly swept into a long downward
  turn and exits the lower boundary. Its metrics agree: the head moves
  `-3.55L` upstream but `-13.30L` laterally, both joint rates and accelerations
  hit their hard caps, command-energy mean is `1496`, and target progress is
  only `0.024`.
- The strongest finite sample uses a `0.90`-period gait and a positive bounded
  bearing bias on the posterior tail tangent. It visibly self-propels into the
  useful wake and reduces distance much more than the other samples
  (`12.42L` initial sampled minimum baseline to `6.34L`, progress `0.132`, and
  `73.39` release-time units in-domain). It then makes a broad upward loop and
  exits. Embedded wake diagnostics support a control overshoot rather than
  passive advection: mean head velocity is upstream while mean local flow is
  nearly zero, but the posterior joint reaches `45 deg`, both rates reach
  `260 deg/time`, both commands reach the `1650 deg/time^2` policy cap, RMS
  lateral force/moment rise to `196/2014`, and maximum target-lateral offset
  reaches `6.04L`.
- Reversing the bearing-to-tail sign while also slowing and weakening the gait
  is a concrete negative comparison. That controller turns sharply away in
  the keyframes, moves `+2.45L` downstream, never gets closer than `12.42L`,
  and exits after `17.26` units despite low effort. This confounded sample does
  not identify an optimal gait, but it does not support reversing the sign.
- Steering the anterior oscillator equilibrium as well as the tail is also a
  negative result here: the sampled fish folds into a tight curl and becomes
  unstable after `3.39` units, with RMS force/moment `56162/580120`. Rate
  damping itself is not isolated by this failure, so it remains testable only
  when steering stays out of the propulsion oscillator.

## Candidate policy hypothesis

Retain the strongest sample's positive bearing-to-posterior-tail convention
and `0.90` period, because that is the only sampled mechanism with meaningful
upstream approach. Keep the anterior oscillator centered at zero. Reduce its
amplitude moderately from `28` to `26 deg`, reduce tail lag and steering limit,
increase posterior damping, and cap commands at `1500 deg/time^2` to lower the
observed saturation/load without dropping to the ineffective `11 deg` gait.

Add a bounded look-ahead correction from `bearing_window_rate` to the bearing
request. When bearing is already converging, the rate term backs off the mean
tail bend before yaw inertia carries the fish through a wide loop; when bearing
is diverging it reinforces the same evidence-supported steering sign. Clamp
the rate contribution before the existing smooth steering saturation so wake
noise cannot reverse or dominate the geometric request.

This candidate is supported only as a falsifiable next test, not as a claimed
improvement before CFD. It should retain upstream displacement and improve on
the `6.34L` minimum distance while surviving beyond `73.39` units with less
posterior angle/rate/command saturation. If it instead loses upstream progress,
later workers should restore the `28 deg` drive before changing the steering
sign; if it still loops with lower saturation, they should increase isolated
rate lead or reduce tail bias rather than offsetting the anterior oscillator.
