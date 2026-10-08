# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the held fish at the upper-right release pose
  while four developed cylinder streets overlap across the target corridor.
  This is a common initial condition, not a candidate effect. None of the four
  released samples reaches the wake corridor, so the present decision concerns
  far-field propulsion, course control, and stability rather than wake capture.
- The target-blind `0.55`-period seed visibly propels left at first, then rotates
  into a nearly vertical descent and leaves the lower boundary. Its head moves
  `(-3.55,-13.30)L`; mean y velocity `-0.263` nearly equals local-flow y
  `-0.241`, its `8.61L` minimum range rebounds to `12.12L`, and both joint-rate
  and acceleration caps are touched. Zero target steering therefore permits
  far too much downward advection and course loss.
- The unguarded positive-bearing, angle-only oscillator is the useful but
  unstable contrast. Its keyframes show a sustained upstream body wave with
  little net lateral motion, followed immediately by a sharply folded body.
  Head displacement `(-3.59,+0.15)L` and mean x velocity `-0.149` versus local
  flow `-0.0774` confirm self-propulsion, while joint-one speed and both commands
  hit their caps and RMS force/moment rise to `20024/314391` before instability.
- The inherited parent then restored that gait and added only terminal guards.
  Its now sampled rollout remains finite and self-propelled (`-2.45L` head x;
  mean x velocity `-0.0542` versus local flow `-0.0309`), but turns upward and
  exits after `47.35` time with `+1.73L` head y. Its maximum joint-one angle,
  speed, and command are `35.28 deg`, `243.5 deg/time`, and
  `1698.7 deg/time^2`; RMS force/moment `350/5007` are far below the folded
  failure but still elevated.
- The strongest current sample combines the same `0.75`-period angle-only gait
  with a `12 deg`, gain-`0.60` bearing request, `0.04` opposing recent-turn-rate
  damping, and slightly earlier guards. The released sheet shows a clean
  horizontal upstream leg and no folded terminal body, then a broad upward
  turn and top exit. It improves minimum range to `6.71L`, head x to `-4.08L`,
  and finite duration to `65.47`, with RMS force/moment reduced to `66.5/958`.
  Yet head y is again `+1.80L`, maximum lateral target offset grows to `6.10L`,
  and the range rebounds to `9.73L`; it still never enters the useful wake.
- Thus localized guards plus bounded turn damping preserve more of the
  progress-producing gait than the inherited full-orbit radial regulators,
  which were finite but moved about `+2.25L` downstream. The latest comparison
  does not isolate turn damping because gain, limit, posterior damping, and
  guard thresholds also differ, but it does establish the guarded
  angle-only/turn-damped policy as the finite propulsion anchor. Both guarded
  descendants fail on the same upper-boundary course error, so another load,
  rate, or oscillator architecture change would confound the next test.

## One candidate hypothesis

Copy the strongest finite sample exactly and change only
`steering_gain` from `0.60` to `0.45`. At the initial body-frame bearing of
about `8.4 deg`, the bounded proportional contribution falls from roughly
`4.8 deg` to `3.7 deg`, while the `12 deg` limit remains available for large
errors. This is an evidence-directed interpolation: no target steering produced
the seed's excessive downward exit, whereas both gain-`0.75` and gain-`0.60`
guarded policies moved upward by about `1.8L` and left the top boundary.

Keep the demonstrated `0.75`-period propulsion rhythm, posterior lag, opposing
`0.04` turn-rate damping, local angle/speed guards, and smooth
`1600 deg/time^2` action bound unchanged. Every active constant remains owned
by `target_policy_params`; the law uses only body-frame bearing, recent turn
rate, and joint state, with no coordinates, target identity, route, clock,
prescribed inflow, remote probes, or omitted research shelf.

The next CFD rollout supports this candidate only if it preserves negative head
x and finite low-load motion beyond the original `33.06` instability while
changing net y from upward to moderately downward, improving on the `6.71L`
minimum without a top or bottom exit. It is falsified if upstream propulsion is
lost, the fish still loops upward, the reduced gain restores the seed's plunge,
or the same joint/load growth returns. No result for this unevaluated candidate
is claimed here.
