# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four asymmetric, interacting vortex streets develop
  around the target in the second-row wake. This is common initial-condition
  evidence and does not support a candidate-specific phase or memorized route.
- All four current sampled policies are semantically identical static
  `oscillator_energy_gain=2.1` controllers. Their released keyframe sheets and
  compact metrics are exact duplicates apart from wall time, so they establish
  deterministic same-snapshot reproducibility, not robustness to a changed
  wake. The fish makes a bounded down-left turn, sustains productive lateral
  beating, enters the developed wake on a compact diagonal, and crosses the
  target from the right without collision, domain exit, coiling, or a loop.
- The current motion is self-propelled rather than passive advection: mean
  world x velocity is `-0.14784` while mean local-flow x is `-0.08219`, giving
  `0.06565` upstream-relative x speed. Capture takes `73.859` release units
  with `2.480L` mean distance and `51797` command energy. RMS force/moment are
  `24.94/410.68`; joint motion remains finite, although both acceleration
  commands touch the candidate's `28 rad/time^2` guard.
- The inherited static `2.05` policy follows the same broad diagonal corridor
  and reaches faster at `72.699`, with nearly unchanged upstream-relative x
  speed `0.06562`, less energy `50630`, and lower force/moment
  `21.05/379.50`. Its final correction is slightly lower and its mean distance
  is worse at `2.511L`, so it is a useful load/arrival endpoint rather than the
  closure anchor.
- The inherited energy-regime split (`2.1` for deficit, `2.05` for excess)
  is the most informative visually inspected failed optimization hypothesis.
  Its released sheet takes a visibly deeper lower route before returning to
  the target. Although it reaches in `73.062` with lower force/moment
  `21.85/389.56`, its mean distance regresses to `2.574L` and score to
  `-0.6755`. This rejects inferring that endpoint benefits can be combined by
  switching gain only on the sign of normalized energy error. No available
  current raw sheet is a collision, exit, horizon-miss, or instability
  termination; the inherited reversed-sign instability remains a logged
  safety boundary rather than newly inspected visual evidence.
- Inherited notes also report that isolated static gain `2.2` regressed from
  `2.1` to `77.73` arrival, `2.541L` mean distance, `0.06006`
  upstream-relative x speed, `55790` energy, and `26.42/423.30` force/moment.
  Together with the `2.05` endpoint, this brackets a non-monotone response and
  rules out extrapolating restoration authority above `2.1`.

## Single candidate hypothesis

Change only the static `oscillator_energy_gain` from `2.1` to `2.075`, the
unevaluated midpoint of the two successful static endpoints `2.05` and `2.1`.
Keep the evaluated `0.75` period, `22 deg` requested orbit, positive-bearing
steering map, posterior steering share and lag, `0.65` damping, and common
`28 rad/time^2` guard unchanged. Unlike the failed energy-regime split, this
uses one continuous static recovery law and adds no observation, coordinate,
route, clock, wake probe, or switching surface. It is a narrow empirical probe,
not an assumption that wake-route response interpolates smoothly.

Later CFD should count this as an improvement only if it reaches the target
through the compact diagonal corridor and either improves the `2.1` mean
distance while reducing effort/load, or establishes a clear Pareto gain without
losing its `0.06565` upstream-relative propulsion. Reject it if it selects the
split controller's deeper lower route, raises mean distance above `2.511L`,
materially slows capture, contacts the action guard more wastefully, or loses
finite capture. Any same-snapshot benefit remains falsifiable under held-out
wake phase, inflow, geometry, and target placement; no CFD result for this new
candidate is claimed here.
