# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- The byte-identical sampled prewarm sheets show the fish held at the common
  upper-right release pose while the four staggered-cylinder vortex streets
  develop and merge around the second-row target. This anchors the release
  condition; it is not candidate-specific evidence and does not justify a
  coordinate, route, phase, or clock command.
- Three sampled policies are executable replications of the prefilled
  `tail_steering_gain=0.60` controller. Their released sheets and all physical
  diagnostics are identical: each makes a bounded down-left turn, sustains
  lateral beating through the developed wake, crosses the target without a
  loop, collision, domain exit, or instability, and arrives in `73.859` release
  units with `2.4800L` mean distance. Mean world/local-flow x velocities
  `-0.14784/-0.08219` give `0.06565` upstream-relative speed, so the route is
  materially self-propelled rather than passive advection.
- The fourth sampled policy changes only posterior steering share from `0.60`
  to `0.65`. Its sheet retains the same compact diagonal route and reaches the
  capture circle without a visibly deeper lower excursion. Metrics corroborate
  a closure/propulsion improvement: arrival is `72.160`, mean distance is
  `2.4638L`, upstream-relative x speed is `0.06732`, and total command energy is
  `51284`, versus `73.859`, `2.4800L`, `0.06565`, and `51797` for each
  replicated `0.60` rollout.
- The gain is not established as load regulation. Relative crossflow rises
  from `0.13097` to `0.13603`, RMS force/moment from `24.94/410.68` to
  `25.32/420.32`, posterior peak speed from `3.323` to `3.367`, and mean command
  energy from `701.3` to `710.7` because the lower total effort comes from the
  shorter episode. Both accelerations still touch the `28` guard, although
  joint angles and speeds remain inside the task envelope.
- No current sampled rollout is a collision, exit, horizon miss, or numerical
  failure. I therefore compared the score-leading finite sample with the most
  informative available failed optimization hypothesis: the inherited static
  restoration midpoint. Its sheet visibly takes a deeper lower route and its
  metrics regress to `77.264` arrival, `2.5512L` mean distance, `53643` energy,
  and `31.45/454.27` RMS force/moment. Together with inherited damping, guard,
  and steering-gain route branches, this warns against assuming that a narrow
  scalar interpolation or extrapolation has a smooth trajectory response.

## Single-candidate hypothesis

Adopt the exactly evaluated `tail_steering_gain=0.65` controller. Preserve its
`0.75` period, `22 deg` oscillator, `2.1` energy-restoration gain, bounded
positive-bearing `0.75/10 deg` anterior steering, `0.55` posterior lag, `0.65`
damping, and common `28/28 rad/time^2` acceleration guard. This is one isolated,
already observed posterior-curvature change from the assigned `0.60` parent;
it adds no observation, switching surface, global coordinate, timing signal,
wake probe, or unsupported extrapolation above `0.65`.

The candidate should reproduce finite compact capture and the observed closure
gain on the certified snapshot. Count it as a reusable improvement only while
arrival, mean distance, total effort, and upstream-relative propulsion outweigh
the modest crossflow and load increase. Reject it if reevaluation selects a
deeper route, fails to capture, loses propulsion, or raises effort/load without
closure benefit. The current evidence is deterministic same-snapshot evidence,
not robustness: held-out wake phase, inflow, geometry, and target placement can
falsify the mechanism.
