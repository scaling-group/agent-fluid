# Wake-Policy Candidate Notes

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four cylinder streets develop and overlap around the
  target. This is common initial-condition evidence, not a controller effect.
  Every released sample remains to the right of the useful cylinder-wake
  corridor, so the available evidence identifies a far-field propulsion and
  course-retention problem rather than a demonstrated wake-capture mechanism.
- The unguarded positive-bearing controller is the informative instability.
  Its released sheet shows genuine upstream motion with little net lateral
  displacement until the terminal frame folds sharply near the anterior
  joint. Metrics confirm `(-3.59,+0.15)L` head travel and `0.259` progress,
  but both action caps were reached, anterior angle/rate rose to
  `38.1 deg`/`260 deg/time`, and RMS force/moment exploded to
  `20024/314391`. The visible fold, rather than a dramatic wake vortex,
  immediately precedes its unstable termination.
- The `12 deg` ceiling, fixed `0.04` recent-turn damping, and local guards form
  the strongest finite sample. Its sheet shows active nearly horizontal
  upstream travel followed by a broad upper turn and top exit before useful
  wake entry. Head travel `(-4.08,+1.80)L`, mean x velocity/local flow
  `-0.0673/-0.0457`, `6.71L` minimum range, and RMS force/moment `66.5/958`
  establish useful low-load self-propulsion, not passive advection. However,
  anterior rate still reached `249.9 deg/time` above its `200 deg/time` guard
  while posterior rate stayed at `191.2 deg/time`; the active guard did not
  keep the anterior joint far from the `260 deg/time` hard cap.
- The current `14 deg` parent repeats the same upper-turn topology earlier.
  It exits after `51.57` time, moves only `(-2.46,+1.77)L`, and reaches
  `8.85L` rather than the anchor's `6.71L`; anterior rate again reaches about
  `249.8 deg/time`. The inherited isolated `10 deg` ceiling also retained the
  upper exit while reducing head-x travel to `-1.43L` and worsening minimum
  range to `9.00L`. Static saturation changes on both sides of `12 deg` are
  therefore negative evidence, not a reason to interpolate again.
- Inherited optimizer logs close the nearby derivative-gain route as well.
  Uniform `0.045` damping exited upward with only `-0.15L` head-x travel and
  `9.59L` minimum range; uniform `0.05` crossed into a lower flow-following
  return with `(+0.33,-13.31)L` head travel. A range-gated increase toward
  `0.06` also degraded the approach. These results support preserving the
  exact `12 deg`/`0.04` steering law and isolating a joint-local protection
  change rather than another course-gain mutation.

## Candidate hypothesis

Restore the strongest finite controller's `12 deg` steering ceiling and fixed
`0.04` turn damping. Keep its oscillator, posterior lag, angle guards, smooth
action bound, and posterior overspeed damping unchanged. Add a policy-owned
`4.0` anterior overspeed-damping boost, so only joint one receives effective
damping `10.0` after exceeding the existing `200 deg/time` guard; below the
guard the demonstrated gait and steering commands are exactly unchanged.

This is a controlled test of whether the recurrent near-cap anterior burst is
part of the route into the broad terminal turn. The rollout supports the
hypothesis only if anterior peak rate falls materially below the anchor's
`249.9 deg/time` while meaningful upstream-relative motion and finite low
loads are retained. Strong support would preserve or improve the `6.71L`
minimum range and delay or eliminate the `65.47`-time upper exit. It is
falsified if head-x travel collapses toward the failed gain variants, the same
upper loop is unchanged despite lower anterior rate, posterior motion or loads
worsen, or a hard joint/action cap is touched. No outcome is claimed for this
unevaluated candidate.
