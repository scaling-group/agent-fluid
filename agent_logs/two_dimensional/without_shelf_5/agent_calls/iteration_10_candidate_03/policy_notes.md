# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The sampled shared-prewarm sheets are byte-identical common-initial-condition
  evidence: the held fish remains at the upper-right release pose while the four
  staggered cylinder wakes develop and merge through the target region. They do
  not distinguish controller quality.
- The two fraction-`0.35` rollouts are exact replicas and the strongest current
  finite examples. Their released sheets show an actively self-propelled early
  left-down turn, a dense alternating tail trail, entry into the merged wake,
  and target-ring crossing without collision, domain exit, or instability.
  Mean fish velocity `(-0.2829,-0.1181)` versus mean local flow
  `(-0.1703,-0.1656)` confirms that the leftward traverse is not passive
  advection. Both arrive at `38.362`, with mean distance `1.812L`, command
  energy `53487.3`, power `4007.1`, relative-crossflow RMS `0.2244`,
  force/moment RMS `40.73/637.79`, and joint peaks `0.494/0.521` rad.
- The two fraction-`0.30` rollouts are exact replicas of the most informative
  current policy-hypothesis failure. Their keyframes retain the same broad
  self-propelled turn-then-diagonal route and still capture, but show less
  progress at corresponding frames. Metrics confirm a regression: arrival
  `39.286`, mean distance `1.850L`, command energy `56145.5`, power `4263.2`,
  relative crossflow `0.2447`, force/moment RMS `42.06/662.67`, and weaker mean
  velocity `(-0.2764,-0.1132)`. The posterior peak rises sharply to `0.583`
  rad while the anterior peak rises to `0.512` rad.
- Full trajectory diagnostics sharpen that boundary. At fraction `0.35`, the
  posterior acceleration is at its cap on `60.1%` of recorded rows and its
  rate touches the cap on 531 rows, versus `53.3%` and 312 rows anteriorly.
  Fraction `0.30` worsens these to `62.0%` posterior acceleration saturation
  and 612 rate-cap rows, with higher mean absolute posterior angle and action.
  Thus further posterior steering allocation is not a useful continuation;
  `0.35` is the measured allocation anchor, and the remaining posterior
  saturation/load imbalance warrants a separately bounded tail-response test.
- Inherited logs agree with this stopping decision: fraction `0.45` was slower
  and higher-load than `0.40`, while gain `1.725` and `1.9` regressed from the
  replicated gain-`1.7` bearing law. The older multi-signal slow controller
  became unstable at `2.807`, so this candidate does not add an unscaled state
  signal, alter bearing feedback, or change the propulsion period/amplitude.

## Candidate hypothesis

Preserve the replicated fraction-`0.35`, gain-`1.7`, 12-degree bounded-bearing
controller, `0.55`-period 28-degree anterior oscillator, damping, and all state
inputs. Change only `tail_lag_gain` from `0.80` to `0.75`. This reduces the
velocity-derived component of the posterior phase-lag target by `6.25%` while
leaving the target-directed steering center and anterior propulsion oscillator
unchanged. The hypothesis is that this small reduction will retain the visible
active turn and capture while lowering posterior excursion/cap contact,
crossflow, load, and command effort that worsened when allocation moved from
`0.35` to `0.30`.

The later CFD rollout falsifies this isolated tail-response test if it loses
capture, arrives later than `38.362`, raises mean distance above `1.812L`, or
fails to lower the `0.521`-rad posterior peak or its saturation incidence. Any
energy/load improvement must also preserve mean leftward propulsion close to
`-0.2829` and stay within the `0.2244/40.73/637.79` crossflow/force/moment
envelope; otherwise reduced phase lag merely weakens the useful gait. A
positive result remains specific to the certified wake phase and start pose
until it survives held-out conditions.
