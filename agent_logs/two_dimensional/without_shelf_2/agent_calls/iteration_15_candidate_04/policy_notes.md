# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- I read the workspace and guidance contracts, assigned-parent experience,
  sampled policies, scores, observations, metrics, embedded wake diagnostics,
  and inherited optimizer notes/results available inside this Phase 2
  workspace. I inspected the common prewarm sheet before the released sheets
  for the prefilled `tail_steering_gain=0.60` anchor, the sampled `0.65`
  posterior-steering result, and the inherited `oscillator_energy_gain=2.075`
  negative result. I used no omitted Bookshelf material, neighboring
  configuration, repository history, fixed route, coordinate, or clock.
- The prewarm sheets are byte-identical and show the held fish above and
  downstream of four staggered cylinders after their interacting wakes have
  developed around the target. They establish one common initial condition,
  not candidate robustness or a candidate-specific wake phase.
- The three `tail_steering_gain=0.60` samples are behaviorally identical
  replications. Their released sheets show a bounded down-left turn, sustained
  beating through the developed useful-wake corridor, and a compact final
  correction into the target without collision, domain exit, loop, or
  instability. Diagnostics confirm self-propulsion: mean velocity x is
  `-0.14784` versus local-flow x `-0.08219`, or `0.06565` upstream-relative x
  speed. They reach in `73.859` release units with `2.480L` mean distance,
  `51797` total command energy, and `24.94/410.68` RMS force/moment.
- Changing only posterior steering share from `0.60` to `0.65` preserves the
  same visible compact corridor and finite capture. The keyframes do not
  support claiming a wholesale route change; they show only a modest late
  correction difference. The metrics nevertheless corroborate better closure:
  arrival improves to `72.160`, mean distance to `2.464L`, score to `-0.5656`,
  and upstream-relative x speed to `0.06732`. Total command energy falls to
  `51284`, although mean command energy rises from `701.3` to `710.7` because
  the episode is shorter. RMS crossflow and force/moment rise to
  `0.1360` and `25.32/420.32`; posterior peak speed also rises from `3.323` to
  `3.367`, and both accelerations still touch the `28` guard. Thus the sampled
  improvement is a closure/load tradeoff, not evidence to keep increasing
  posterior curvature.
- The assigned parent's inherited `oscillator_energy_gain=2.075` midpoint is
  the most informative failed optimization hypothesis available. It still
  reaches, but its sheet selects a visibly different trajectory phase and its
  diagnostics regress relative to exact `2.1`: arrival `77.264` versus
  `73.859`, mean distance `2.551L` versus `2.480L`, upstream-relative x speed
  `0.06386` versus `0.06565`, energy `53643` versus `51797`, and RMS
  force/moment `31.45/454.27` versus `24.94/410.68`. This rejects further
  energy-gain interpolation on the deterministic wake snapshot.

## Single candidate hypothesis

Change only `tail_steering_gain` from the prefilled `0.60` to the exactly
evaluated `0.65`. Preserve the replicated `0.75` period, `22 deg` oscillator,
exact `2.1` restoration gain, pure-bearing `0.75/10 deg` anterior steering,
`0.55` lag, `0.65` damping, and common `28/28` command guard. At saturated
anterior steering this adds at most `0.5 deg` of bounded posterior mean-target
curvature and does not add a coordinate, route, clock, probe, or switching
surface.

The candidate deliberately reproduces the only sampled one-parameter change
that improves score, arrival, mean distance, total effort, and upstream-relative
propulsion together. Later CFD should require finite compact capture and
reproduce those closure gains without materially exceeding the observed load
cost. Reject extrapolation above `0.65` unless a controlled result improves
closure without further crossflow, posterior-speed, or force/moment growth.
Any same-snapshot success remains falsifiable under held-out wake phase,
inflow, geometry, and target placement.
