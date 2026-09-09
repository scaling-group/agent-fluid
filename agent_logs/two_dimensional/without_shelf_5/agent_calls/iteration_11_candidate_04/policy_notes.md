# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheet shows the common held fish at the upper-right
  release pose while four staggered vortex streets develop and merge through the
  target region. It is initial-condition evidence only and does not distinguish
  controllers.
- Three sampled `tail_lag_gain=0.80` rollouts are exact finite replicas. Their
  released sheets show a vigorous early left-down turn, an alternating
  self-generated tail trail, entry into the developed merged wake, and safe
  target-ring crossing at `38.362`. Mean fish velocity
  `(-0.2829,-0.1181)` versus local flow `(-0.1703,-0.1656)` confirms active
  leftward propulsion. They record mean distance `1.812L`, command energy
  `53487.3`, power `4007.1`, relative-crossflow RMS `0.2244`, force/moment RMS
  `40.73/637.79`, and joint peaks `0.494/0.521` rad.
- The current best finite rollout changes only tail lag to `0.75`. Its keyframes
  retain the same turn-then-diagonal topology, dense tail trail, wake entry, and
  collision-free capture, but show slightly more progress at matched frames.
  Metrics confirm arrival `38.049`, mean distance `1.802L`, stronger mean fish
  velocity `(-0.2853,-0.1198)`, command energy `52895.0`, and power `3965.3`.
  Thus the navigation/effort improvement is self-propelled rather than a change
  in the certified prewarm flow.
- The proposed load-relief mechanism did not survive that rollout. Reducing
  tail lag leaves the posterior peak effectively unchanged
  (`0.520809 -> 0.520808` rad), both joints still touch the recorded rate and
  acceleration caps, relative crossflow rises slightly
  (`0.22437 -> 0.22494`), and force/moment RMS rise from `40.73/637.79` to
  `42.01/653.13`. The `0.75` result is therefore a navigation/effort anchor,
  not evidence that less lag unloads the tail.
- No sampled rollout is a semantic failure. The inherited fraction-`0.30`
  rollout is the most informative policy-hypothesis failure: its sheet retains
  the broad safe route and capture, but arrival regresses to `39.286`, mean
  distance to `1.850L`, energy/power to `56145.5/4263.2`, crossflow to `0.2447`,
  force/moment to `42.06/662.67`, and posterior peak to `0.583` rad. Together
  with the inherited fraction-`0.45` and steering-gain regressions, it rules out
  another allocation or bearing-gain step. The older mixed-signal controller's
  instability at `2.807` also provides no scale basis for a new observation.

## Candidate hypothesis

Adopt the measured `tail_lag_gain=0.75` navigation/effort anchor and preserve
the replicated `0.35` steering allocation, gain-`1.7` bounded body-frame
bearing law, 12-degree steering bound, `0.55`-period 28-degree anterior
oscillator, and existing state inputs. Change only `tail_damping` from `0.65`
to `0.70` relative to that evaluated anchor. The modest dimensionless damping
increase directly opposes posterior joint rate; unlike another lag or steering
step, it targets the unchanged posterior excursion and persistent cap contact
without changing the desired phase-lag geometry or target curvature.

The later CFD rollout falsifies this isolated damping test if it loses capture,
arrives later than the `0.80`-lag baseline's `38.362`, raises mean distance above
`1.812L`, or raises command energy above `53487.3`. To support the intended
mechanism it must also lower the `0.75` anchor's `42.01/653.13` force/moment
RMS or its `0.5208`-rad posterior peak without raising relative crossflow above
`0.22494`; otherwise extra damping merely trades away useful propulsion.
Preserving mean leftward speed near or above the baseline `0.2829` is a further
boundary. Any positive result remains specific to the certified wake phase and
start pose until repeated or tested under held-out conditions.
