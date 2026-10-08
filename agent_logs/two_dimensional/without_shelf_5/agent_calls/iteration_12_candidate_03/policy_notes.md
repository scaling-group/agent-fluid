# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheets are byte-identical common-initial-condition
  evidence. They show the fish held at the upper-right release pose while four
  staggered cylinder streets develop and merge through the target region; they
  do not distinguish controller quality.
- Three sampled `tail_lag_gain=0.75`, fraction-`0.35` rollouts are exact metric
  and keyframe replicas and are the strongest finite evidence. From release the
  fish turns left and down under its own dense alternating tail trail, enters
  the merged wake without contacting a cylinder, and crosses the target ring.
  Its `-10.913L` x displacement in `38.049` versus mean local x flow `-0.1687`
  confirms useful self-propulsion rather than passive advection. Each repeat
  records mean distance `1.802L`, command energy `52895.0`, power `3965.3`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, and no
  collision, exit, or instability.
- The sampled `tail_lag_gain=0.80` rollout is the direct policy-hypothesis
  failure comparator. Its keyframes preserve the same turn, diagonal corridor,
  and safe capture, but it is slightly behind at the matched late frames.
  Metrics confirm later arrival `38.362`, higher mean distance `1.812L`, higher
  energy `53487.3`, and higher power `4007.1`. Thus reducing lag by `0.05`
  produced a repeatable navigation/effort gain at the certified wake phase.
  It did not unload the gait: relative crossflow changed only `0.2244 ->
  0.2249`, force/moment rose `40.73/637.79 -> 42.01/653.13`, posterior peak
  stayed `0.521` rad, and inherited trajectory summaries say both joints still
  touched their rate and acceleration caps.
- The inherited fraction-`0.30` sheet is the stronger failed-extrapolation
  boundary. It visibly retains active propulsion and the broad safe route, yet
  arrives at `39.286` with mean distance `1.850L`, energy `56145.5`, crossflow
  `0.2447`, loads `42.06/662.67`, and posterior peak `0.583` rad. Together with
  the logged fraction-`0.45` and gain-`1.725`/`1.9` regressions, it rules out
  another allocation or bearing-gain step. The older mixed-signal instability
  at `2.807` supplies no scale for adding flow, force, moment, or rate feedback.
- The compact evidence bundle contains no local `wake_diagnostics.json`; the
  visual claims above are therefore restricted to the supplied keyframes,
  `wake_metrics.csv`, score diagnostics, and inherited optimizer trajectory
  summaries. No archival artifact outside this Phase 2 workspace was read.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, gain-`1.7`
bounded body-frame bearing law, 12-degree steering bound, fraction-`0.35`
allocation, damping, and observation set. Change only `tail_lag_gain` from
`0.75` to `0.70`. This is a bounded `6.67%` continuation of the only isolated
axis whose latest measured step (`0.80 -> 0.75`) improved arrival, distance,
command energy, and power while preserving the visible route and semantic
success. It is a bracket-extension test, not a claim that lag response is
monotone and not a claim that the prior force/moment increase was beneficial.

The later CFD rollout supports this candidate only if it captures, arrives
before `38.049`, and lowers mean distance below `1.802L` or command energy
below `52895` without materially departing from the diagonal route. It is
falsified by loss of capture, any collision/exit/instability, regression beyond
the `tail_lag_gain=0.80` anchors (`38.362`, `1.812L`, `53487`, `4007`), or a
material rise above the `0.75` crossflow/load envelope
`0.2249/42.01/653.13`. Even a positive result applies only to the certified
wake phase and start pose until tested on held-out conditions.
