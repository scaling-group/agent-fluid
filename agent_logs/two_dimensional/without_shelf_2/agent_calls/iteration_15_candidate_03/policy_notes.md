# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four staggered cylinder streets develop and interact
  around the second-row target. This sheet is common initial-condition
  evidence; it does not justify a phase-specific or coordinate-memorized
  route.
- No current sampled solver is a semantic failure: all four reach the target
  without collision, domain exit, or instability. The three executable
  `tail_steering_gain=0.60` policies reproduce exactly (`73.859` release time,
  `2.4800L` mean distance, `51797` total command energy, and `24.94/410.68`
  RMS force/moment), so they are one deterministic anchor rather than three
  independent control points. Their keyframes show a bounded down-left turn,
  productive beating across the developed street, a small pass below the
  target, and a final turn into the capture circle.
- The `0.60` anchor is self-propelled rather than merely advected: mean world
  x velocity is `-0.14784` versus mean local-flow x `-0.08219`, or `0.06565`
  upstream-relative x speed. Both acceleration commands touch the candidate's
  `28 rad/time^2` guard, but joint angles remain finite and the route has no
  visible coil or wasteful loop.
- The best sampled policy changes only posterior steering share from `0.60`
  to `0.65`. Its sheet retains the same compact diagonal topology and useful
  wake entry while completing the lower-to-target correction earlier. It
  improves release time to `72.160`, mean distance to `2.4638L`,
  upstream-relative x speed to `0.06732`, and total command energy to `51284`.
  The gain is not free: RMS crossflow rises from `0.13097` to `0.13603`, and
  RMS force/moment rise modestly to `25.32/420.32`. Peak anterior angle and
  speed fall (`0.526/3.150` to `0.514/3.125`), while peak posterior angle and
  speed rise slightly (`0.432/3.323` to `0.436/3.367`), consistent with a
  bounded redistribution of turning authority rather than loss of control.
- The assigned parent's static restoration midpoint is the most informative
  failed optimization comparator available. Its released sheet takes a deeper
  lower approach, and `oscillator_energy_gain=2.075` regresses against static
  `2.1` to `77.264` arrival, `2.5512L` mean distance, `53643` energy, and
  `31.45/454.27` RMS force/moment. This newly evaluated result rejects
  combining the successful posterior-share direction with restoration-gain
  interpolation. No sampled true failure keyframe is available; the inherited
  reversed-sign instability remains a safety boundary only.

## Single candidate hypothesis

Preserve the evaluated `0.75` period, `22 deg` orbit, static `2.1` restoration,
pure-bearing `0.75/10 deg` anterior steering, `0.55` lag, `0.65` damping, and
common `28/28` guard. Change only `tail_steering_gain` to `0.70`, one equal
`0.05` continuation beyond the isolated `0.60 -> 0.65` improvement. Because
the posterior mean-curvature target is still driven by the existing bounded
steering center, this adds at most `0.5 deg` beyond the successful `0.65`
policy at saturated bearing; it adds no observation, route, coordinate,
clock, wake probe, or switching surface.

The falsifiable expectation is a slightly earlier lower-to-target correction,
with target capture faster than `72.160` and mean distance no worse than
`2.4638L`, while preserving upstream-relative propulsion and the compact
diagonal corridor. Reject the continuation if it selects a lower detour, loses
capture, raises RMS force/moment materially beyond `25.32/420.32` without
corroborating closure, increases total effort, or shifts posterior motion
toward unsafe saturation. This is a deliberately narrow same-snapshot probe,
not an assumption of monotonic gain response; any positive result remains to
be falsified under held-out wake phase, inflow, geometry, and target position.
