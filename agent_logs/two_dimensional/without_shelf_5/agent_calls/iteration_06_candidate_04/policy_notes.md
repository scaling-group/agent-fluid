# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while four staggered, interacting wake
  streets develop around the target. It cannot distinguish controller quality.
- The released sheets for gains `1.7`, `1.725`, and `1.9` all show active
  propulsion rather than passive advection. Each controller makes an early
  heading correction, leaves a dense alternating tail trail, crosses left and
  down through the developed wake, and enters the `0.75L` target ring without
  collision, exit, or instability. The similar route topology makes arrival,
  distance, crossflow, loads, and joint excursions the decisive comparators.
- Three sampled gain-`1.7` rollouts are deterministic replicas. Each reaches
  at `39.710`, with mean distance `1.874L`, total command energy `54703.2`,
  power proxy `4092.5`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, and maximum joint angles `0.507/0.528` rad.
- The assigned-parent gain-`1.9` prefill still captures, but is later at
  `40.034` and raises mean distance to `1.901L`, total command energy to
  `54954.5`, power to `4136.9`, relative-crossflow RMS to `0.2329`,
  force/moment RMS to `41.31/657.28`, and joint maxima to `0.523/0.548` rad.
  Its slightly flatter head path and smaller downward head displacement do not
  improve capture.
- The inherited gain-`1.725` rollout is the most informative negative result:
  the proposed interpolation regressed further to `40.832` arrival,
  `1.915L` mean distance, `56614.5` total command energy, `4263.5` power,
  `0.2364` crossflow RMS, `42.50/674.61` force/moment RMS, and
  `0.526/0.556` rad joint maxima. All three gains touch the same rate and
  acceleration caps. This falsifies smooth local interpolation from the sparse
  gain samples; it does not falsify bounded positive bearing steering.
- The inherited outer boundaries remain relevant: the target-blind seed left
  the domain downward, while a slower controller that simultaneously changed
  steering structure and added velocity/moment feedback became unstable at
  `2.807`. No current evidence supports changing propulsion or adding those
  signals to this recovery candidate.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, posterior phase
lag, positive two-joint steering distribution, and 12-degree `tanh` bound.
Change only `steering_gain` from the regressed prefill value `1.9` to the exact
measured value `1.7`. This is an evidence-backed recovery to a triply replicated
finite anchor, not another interpolation or a claim of a universal optimum.

The later CFD rollout should preserve target capture and reproduce approximately
`39.710` arrival, `1.874L` mean distance, `0.2265` relative-crossflow RMS, and
`38.40/618.59` force/moment RMS. Loss of capture or regression toward the
gain-`1.9`/`1.725` envelopes would falsify deterministic recovery and require a
repeat of the anchor before testing one separately bounded controller axis.
