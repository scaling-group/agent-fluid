# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence. It shows the
  fish held at the upper-right release pose while the four staggered cylinder
  wakes develop and merge around the target; it cannot distinguish policies.
- The four current sampled policies and released keyframe sheets are
  byte-identical `anterior_steering_fraction=0.40`, gain-`1.7` replicas. The
  fish actively self-propels: its mean leftward speed (`-0.2736`) exceeds the
  mean local leftward flow (`-0.1632`), and a dense alternating tail trail
  accompanies an early turn toward the target. It traverses left and down into
  the developed wake and reaches the `0.75L` ring at `39.710` without
  collision, exit, or instability. All four repeat mean distance `1.874L`,
  relative-crossflow RMS `0.2265`, force/moment RMS `38.40/618.59`, total
  command energy `54703.2`, and joint maxima `0.507/0.528` rad.
- The assigned parent proposed increasing the anterior steering fraction from
  `0.40` to `0.45` while preserving the same gait, gain, total steering bound,
  and posterior phase lag. Its inherited released sheet still shows active
  propulsion and target capture, but the approach is less effective rather
  than a gentler redistribution: arrival regresses to `43.323`, mean distance
  to `2.025L`, mean leftward speed to `-0.2509`, relative-crossflow RMS to
  `0.2456`, force/moment RMS to `41.96/709.54`, and total command energy to
  `60174.8`. Both joint maxima rise to `0.544/0.562` rad, while the same rate
  and acceleration caps are touched. Thus the static `0.507/0.528` excursion
  imbalance did not predict the closed-loop response: moving the steering
  center anteriorly amplified, rather than relieved, both excursions and
  loads.
- No sampled rollout is a semantic collision, exit, or unstable failure, so
  the inherited `0.45` hypothesis failure is the most informative negative
  visual comparator. The older inherited unstable mixed-feedback result
  remains an outer boundary only; there is no current scale evidence for
  adding velocity, force, or moment signals. The gain evidence likewise
  rejects another small gain interpolation and retains the replicated `1.7`
  bounded-bearing law.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, gain-`1.7`
bounded-bearing steering, 12-degree total steering limit, phase lag, and
damping. Change only `anterior_steering_fraction` from `0.40` to `0.35`. This
is the opposite, equally sized allocation test to the failed `0.45` proposal:
it moves five percent of the unchanged steering center away from the anterior
joint without strengthening the total curvature command or introducing an
unscaled observation. The hypothesis is that reducing the anterior share will
avoid the slower, higher-load early turn seen at `0.45` and may improve the
replicated anchor's approach while retaining active propulsion and capture.

The later CFD evaluation falsifies this candidate if it loses capture, arrives
later than `39.710`, raises mean distance above `1.874L`, raises the posterior
maximum above `0.528` rad, or fails to improve any of the `0.2265`, `38.40`,
`618.59`, and `54703.2` crossflow/load/energy anchors. Even if it improves this
single certified wake phase and start pose, the allocation direction is not a
general optimum until it survives changed wake phase or initial pose.
