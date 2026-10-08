# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheets show the same held fish at the upper-right
  release pose while the four staggered cylinder streets develop, merge, and
  pass through the target. This is common initial-condition evidence and does
  not distinguish policies.
- Three sampled `posterior_acceleration_limit=1700 deg/time^2` policies have
  byte-identical released sheets and metrics. The fish turns left and down,
  lays down a dense alternating propulsive trail, enters the merged wake only
  late in the traverse, and crosses the target ring without collision, exit,
  or instability. Mean fish velocity `(-0.3164,-0.1322)` versus mean local
  flow `(-0.1782,-0.1839)` confirms active leftward propulsion rather than
  passive advection. Each reaches at `34.331`, with score `0.159531`, mean
  distance `1.714L`, command energy/power `45153/3390`, relative-crossflow RMS
  `0.2312`, force/moment RMS `54.48/766.14`, and joint peaks `0.497/0.509`
  rad. The posterior command contacts its candidate limit `29.671 rad/time^2`,
  while the anterior acceleration and both rates still contact the episode
  envelope.
- The assigned parent's `1750 deg/time^2` posterior midpoint preserves the
  same visible self-propelled turn-then-diagonal route and capture. It is
  behind the `1700` sheet at the middle and late frames and reaches at
  `35.750`, with lower score `0.133441`, higher mean distance `1.741L`, and
  higher energy/power `48243/3614`. Its slower mean velocity
  `(-0.3038,-0.1270)` agrees with that visual regression. In exchange,
  relative crossflow falls to `0.2257`, force/moment RMS to `47.39/694.77`,
  and joint peaks to `0.491/0.500` rad. The embedded diagnostics and
  `wake_metrics.csv` therefore support a real navigation/effort-versus-load
  bracket across the uncapped `1800`, midpoint `1750`, and `1700` posterior
  commands; they do not support another fitted posterior-cap interpolation.
- No current sampled rollout is a semantic failure. The inherited 27-degree
  amplitude rollout is the most informative materialized failed control
  hypothesis: its six-frame sheet follows the same safe route but visibly
  falls behind, reaching at `38.214` with score `0.063788`, mean distance
  `1.812L`, and energy/power `53078/3978`. Loads fall to `40.03/630.70`, but
  both joints still touch the rate and acceleration envelopes and posterior
  excursion rises to `0.527` rad. Thus weakening the oscillator target does
  not isolate the remaining anterior acceleration contact and trades away the
  useful traverse.
- The assigned parent and inherited logs already reject further small bearing,
  allocation, lag, damping, amplitude, and posterior-cap refinements; the
  older mixed-feedback controller supplies an instability boundary rather than
  a safe scale for a new force, moment, or velocity term. No omitted shelf,
  neighboring configuration, external artifact, or repository history was
  consulted. The compact observation JSON embeds the wake diagnostics used
  above because no standalone local `wake_diagnostics.json` is materialized.

## Single-candidate hypothesis

Keep the replicated `1700 deg/time^2` posterior navigation/effort anchor and
all of its period, 28-degree oscillator, lag, damping, bounded body-frame
bearing law, steering allocation, and observations. Add a separate
candidate-owned symmetric `1750 deg/time^2` clamp to the raw anterior
oscillator acceleration. Relative to the best sampled policy, this changes
only the still-contacted anterior command envelope. It tests whether modest
anterior command shaping can recover part of the `1750` posterior midpoint's
load reduction without weakening the oscillator amplitude or surrendering the
`1700` posterior cap's faster traverse. It is not a claim that clipping either
joint is monotonically beneficial.

The later CFD rollout supports the hypothesis only if it preserves the visible
turn-then-diagonal capture, remains better than the posterior-`1750` comparator
on arrival (`35.750`), mean distance (`1.741L`), and energy/power
(`48243/3614`), and reduces force/moment materially below the posterior-`1700`
envelope `54.48/766.14` without increasing its `0.2312` crossflow or `0.509`
rad posterior excursion. Navigation no better than the `1750` comparator,
loads no better than the `1700` anchor, route change, loss of capture,
collision, exit, or instability falsifies the mechanism. Any positive result
remains specific to the certified wake phase and start pose.
