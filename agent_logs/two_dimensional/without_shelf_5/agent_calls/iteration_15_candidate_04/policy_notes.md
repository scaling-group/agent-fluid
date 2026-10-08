# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled candidates, released keyframe sheets, and metric rows are
  byte-identical. Their shared-prewarm sheets are also byte-identical and show
  the common held fish at the upper-right release pose while four staggered
  cylinder streets develop and merge through the target region. The prewarm
  is an initial-condition check, not controller-specific evidence.
- In every released sheet the fish makes a strong early left-down turn, sheds
  a dense alternating tail trail, enters the developed wake corridor, and
  crosses the target ring without collision, domain exit, or instability.
  Mean velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)`, together with head displacement
  `(-10.913,-4.349)L`, confirms that the useful leftward traverse is actively
  propelled rather than passive advection. The four exact rollouts reach at
  `38.049`, with mean distance `1.802L`, command energy/power `52895/3965`,
  relative-crossflow RMS `0.2249`, and force/moment RMS `42.01/653.13`.
- The embedded diagnostics agree with the visual evidence but expose the
  remaining control boundary: anterior/posterior peak angles are only
  `0.496/0.521` rad, yet both rate maxima are exactly `4.537856` rad/time and
  both acceleration maxima are exactly `31.415927` rad/time squared, the
  configured `260/1800` degree caps. Thus the dense trail is productive, but
  the controller still asks both joints for clipped motion; another exact
  replication cannot distinguish a useful traveling bend from cap-dominated
  posterior response.
- No sampled rollout is a semantic failure. The assigned-parent log supplies
  the closest failed policy hypothesis: `tail_lag_gain=0.7675` kept the route
  and capture but regressed to `38.412/1.817L`, energy/power `53566/4024`, and
  crossflow/load `0.2268/42.78/659.63`. The inherited `0.70` extrapolation was
  worse at `39.605/1.872L`, `55461/4197`, and `0.2429/43.11/675.66`, with a
  larger posterior excursion. These results close further tail-lag fitting.
  Earlier steering-gain and allocation regressions and the mixed-feedback
  instability at `2.807` likewise argue against combining a new axis with an
  unscaled observation.
- The compact evidence has no local standalone `wake_diagnostics.json`;
  diagnostic cross-checks above use the metrics and wake-diagnostics object
  embedded in `wake_observation.json`. No omitted shelf, neighboring
  configuration, repository history, MP4, VTK field, or external artifact was
  consulted.

## Candidate hypothesis

Preserve the four-times-replicated `tail_lag_gain=0.75`, `0.55`-period,
28-degree oscillator, gain-`1.7` bounded body-frame bearing law, 12-degree
steering limit, fraction-`0.35` allocation, and observation set. Change only
posterior `tail_damping` from `0.65` to `0.70`. This bounded `7.7%` increase
directly strengthens opposition to posterior joint velocity without changing
the anterior oscillator, steering center, desired phase-lag geometry, or
public policy contract. The hypothesis is that slightly less posterior
ringing/cap contact will retain the visibly productive diagonal traverse while
converting less of the saturated command into crossflow and moment, allowing a
more coherent final approach.

The later CFD rollout supports this isolated damping probe only if it captures,
preserves the turn-then-diagonal topology, and improves arrival below `38.049`
or mean distance below `1.802L` without exceeding the replicated
`52895/3965` effort and `0.2249/42.01/653.13` crossflow/load envelopes. It is
falsified by loss of capture, regression beyond the inherited `0.80` lag
anchors (`38.362/1.812L`), weaker mean leftward speed, or unchanged cap contact
without a load reduction. In those cases extra damping merely weakens the
useful gait or acts too late behind the hard caps, and later workers should
restore `0.65` rather than continue upward. Any positive result remains
specific to the certified wake phase and start pose until held-out testing.
