# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence only. It shows
  the fish held at the upper-right release pose while the four staggered
  cylinder streets develop and merge around the target; it cannot distinguish
  controller quality.
- The two sampled fraction-`0.35` rollouts are exact finite replicas and are
  the strongest current results. Their released sheets show active propulsion,
  not passive advection: after an early left-down turn the fish leaves a dense
  alternating tail trail, enters the merged wake corridor, and crosses the
  `0.75L` target ring without collision, exit, or instability. Mean leftward
  speed (`-0.2829`) exceeds mean local leftward flow (`-0.1703`). Both reach at
  `38.362`, with mean distance `1.812L`, command energy `53487.3`, power proxy
  `4007.1`, relative-crossflow RMS `0.2244`, force/moment RMS `40.73/637.79`,
  and joint maxima `0.494/0.521` rad.
- The two sampled fraction-`0.40` rollouts reproduce the same broad diagonal
  route but reach later at `39.710`. Relative to `0.35`, they have higher mean
  distance (`1.874L`), command energy (`54703.2`), power (`4092.5`), relative
  crossflow (`0.2265`), and joint maxima (`0.507/0.528` rad), plus weaker mean
  velocity (`-0.2736,-0.1132` versus `-0.2829,-0.1181`). They do have lower
  force/moment RMS (`38.40/618.59`), so the `0.35` navigation improvement is a
  measured load tradeoff rather than a uniformly cleaner gait.
- The inherited fraction-`0.45` result is the most informative hypothesis
  failure because no sampled rollout is a semantic failure. Its sheet remains
  self-propelled and still captures, but the early turn and approach are
  slower: arrival `43.323`, mean distance `2.025L`, crossflow `0.2456`,
  force/moment RMS `41.96/709.54`, energy `60174.8`, and joint maxima
  `0.544/0.562` rad. Together, the `0.45`, `0.40`, and replicated `0.35`
  evidence supports the lower-allocation direction over this tested interval,
  while the force/moment reversal warns against extrapolating it far.
- Inherited gain-`1.725`/`1.9` regressions reject another small gain change,
  and the older mixed-feedback instability gives no scale justification for a
  new velocity, force, or moment term. This candidate therefore changes only
  steering allocation and preserves the successful propulsion and observation
  structure.

## Candidate hypothesis

Preserve the measured `0.55`-period, 28-degree oscillator, gain-`1.7` bounded
bearing law, posterior phase lag, damping, and 12-degree total steering bound.
Change only `anterior_steering_fraction` from the best measured `0.35` to
`0.30`. This repeats the isolated five-point allocation step that improved
`0.40` to `0.35`, moving at most another `0.6` degree of saturated steering
center toward the posterior joint without strengthening the total curvature
command or adding an unscaled observation.

The later CFD rollout falsifies this continuation if it loses capture, arrives
no earlier than `38.362`, raises mean distance above `1.812L`, command energy
above `53487.3`, relative crossflow above `0.2244`, or either joint maximum
above `0.494/0.521` rad. Because force and moment already rose at `0.35`, a
further material rise above `40.73/637.79` is also a stopping boundary even if
arrival improves. A positive result would remain specific to the certified
wake phase and start pose; three tested allocation values do not establish a
global optimum or held-out robustness.
