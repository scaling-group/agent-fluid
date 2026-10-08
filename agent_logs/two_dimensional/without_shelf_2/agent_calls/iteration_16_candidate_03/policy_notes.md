# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered cylinder streets develop and merge
  around the second-row target. It is common initial-condition evidence, not
  support for a coordinate-, route-, clock-, or wake-phase-specific command.
- All four current sampled rollouts reach the target without collision, domain
  exit, horizon miss, or instability. The three executable
  `tail_steering_gain=0.65` examples reproduce exactly (`72.1599` release
  time, `2.46383L` mean distance, `0.06732` upstream-relative x speed,
  `51284` total command energy, and `25.32/420.32` RMS force/moment), so they
  count as one deterministic same-snapshot anchor rather than three distinct
  response points.
- Their released sheets show a bounded initial down-left turn, sustained
  propulsive beating, entry into the developed interacting wake, and a compact
  lower-to-target correction. The route is self-propelled rather than passive
  advection: mean world x velocity is `-0.15180` against mean local-flow x
  `-0.08448`, yielding `0.06732` upstream-relative speed. Both acceleration
  commands touch the controller's `28 rad/time^2` guard, but joint motion and
  loads remain finite.
- The score-leading `tail_steering_gain=0.70` sample retains the same compact
  diagonal topology and finite target crossing. Relative to `0.65`, it
  improves mean distance from `2.46383L` to `2.45409L`, RMS crossflow from
  `0.13603` to `0.13063`, and RMS force/moment from `25.32/420.32` to
  `23.85/408.89`. Peak anterior angle/speed also fall from `0.5144/3.1247` to
  `0.4996/3.0862`, while posterior angle changes only from `0.4357` to
  `0.4378` and posterior speed falls from `3.3666` to `3.2925`.
- The `0.70` continuation falsifies the assigned parent's expectation of a
  monotone arrival improvement: release time slows by `0.2970` to `72.4569`,
  upstream-relative x speed falls to `0.06620`, and total command energy rises
  by `558` to `51842`, even though mean command energy changes only from
  `710.70` to `715.49`. Posterior sharing is therefore a route/load tradeoff,
  not established as a monotone speed or effort control.
- No current sampled sheet is a semantic failure. The most informative failed
  optimization comparator in the inherited parent log remains the static
  restoration midpoint `2.075`: it selected a visibly deeper lower route and
  regressed to `77.264` arrival, `2.551L` mean distance, `53643` energy, and
  `31.45/454.27` RMS force/moment. Together with the inherited non-monotone
  gain, guard, and damping results, this argues for one isolated equal-step
  probe rather than interpolation or a multi-parameter schedule.

## Single candidate hypothesis

Preserve the evaluated `0.75` period, `22 deg` oscillator, static `2.1`
restoration, pure-bearing `0.75/10 deg` anterior steering, `0.55` posterior
lag, `0.65` damping, and common `28/28 rad/time^2` command guard. Change only
`tail_steering_gain` from `0.70` to `0.75`, one more bounded `0.05` step in the
sampled posterior-share direction. At saturated bearing this adds at most
`0.5 deg` of posterior mean-curvature target; it introduces no observation,
route, coordinate, clock, remote wake probe, or switching surface.

Later CFD should accept this continuation only if it preserves finite capture
and the compact diagonal corridor while clarifying the observed Pareto trend:
mean distance and load should improve enough to offset any additional loss in
arrival, upstream-relative propulsion, or effort. Reject it if it selects a
deeper detour, loses capture, materially exceeds the `0.70` load envelope,
raises posterior motion toward saturation, or worsens both closure and effort.
The result will remain specific to the certified common prewarm until held-out
wake phase, inflow, geometry, or target placement reproduces it; no outcome for
this unevaluated candidate is claimed here.
