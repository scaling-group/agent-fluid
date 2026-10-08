# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above four fully developed,
  interacting vortex streets. It is shared initial-condition evidence rather
  than a candidate advantage. In the released sheets, the assigned prefill and
  the three sampled filtered `40/60` policies all turn toward the target,
  sustain a visible posterior traveling wave, cross the interacting wakes on a
  compact diagonal path, and enter the `0.75L` capture circle without a
  collision or terminal excursion.
- The three filtered `40/60` samples are equation-equivalent (one differs only
  in comments) and replay the same completed result: capture at `35.6895`, mean
  distance `1.76192L`, mean command energy `1425.38`, relative-crossflow RMS
  `0.24775`, force RMS `59.28`, and moment RMS `821.23`. They are one
  deterministic baseline, not three independent mechanism confirmations.
- The assigned prefill adds a bearing-magnitude schedule that shifts at most
  five percentage points of the unchanged total-curvature budget posteriorly
  during a large turn. Its completed rollout preserves the same direct visual
  topology while improving capture to `35.0625` and mean distance to
  `1.73388L`. Force and moment RMS fall to `56.57` and `793.76`, and relative
  crossflow falls slightly to `0.24674`; mean command energy rises slightly to
  `1431.01`. Peak anterior excursion falls from `0.539` to `0.528 rad` while
  posterior excursion rises from `0.575` to `0.583 rad`; both policies still
  touch the joint-rate and acceleration envelopes. This supports dynamic
  posterior allocation as a navigation mechanism, with saturation and effort
  as explicit boundaries rather than claimed benefits.
- The most informative inherited failure is the additive bearing-trend policy.
  Its keyframes show no sustained body-generated wake and a short downstream
  drift before `left_domain` at `16.9564`. Metrics agree: progress `-0.14697`,
  minimum distance `12.4239L`, peak joint excursions only `0.140/0.163 rad`,
  and mean command energy `8.64`. Low load in that case was propulsion collapse.
  The new mechanism must therefore leave the autonomous traveling bend intact,
  avoid a cancellation-capable route-rate path, and retain the evaluated total
  curvature budget.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and robotic-fish asymmetric flapping control
source_mechanism: preserve a posteriorly lagged traveling wave while applying a modest turn-congruent half-cycle asymmetry
transferable_invariant: the turn-congruent half-cycle may receive more posterior steering allocation, but the opposite sweep must retain the propulsive rhythm and the mean steering budget must remain bounded
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, robot geometry, duty ratios, actuator shares, and source-task routes
policy_translation: retain the filtered body-frame bearing and evaluated bearing-magnitude posterior schedule, then use anterior joint displacement relative to the parent center to redistribute that existing shift smoothly between the two half-cycles without changing the total curvature or oscillator parameters
falsification: reject the half-cycle allocation if capture is lost or later than `35.0625`, mean distance exceeds `1.73388L`, the diagonal path curls or drifts downstream, the traveling wake weakens, or posterior saturation and load rise without a navigation gain

## Candidate hypothesis

This candidate makes one feedback-architecture change to the successful
bearing-scheduled parent. The parent's large-error posterior shift remains the
cycle-average anchor. A smooth joint-state gate multiplies that shift by
`0.75--1.25`: the posterior share is modestly larger when anterior bend and
turn request have the same sign, and modestly smaller on the opposite
half-cycle. The multiplier returns continuously to irrelevance as bearing and
the owned posterior shift approach zero. At the extrema, the large-error split
stays within approximately `33.75/66.25--36.25/63.75`, around the evaluated
`35/65` parent schedule.

The `0.55`-period, `28 deg` state-feedback oscillator, circular bearing filter,
`12 deg` total-curvature budget, posterior lag, and damping are unchanged. The
new path uses only normalized body-frame target bearing and current joint
state; it introduces no clock, target coordinates, bearing derivative, wake
phase, force residual, or route. Downstream CFD should first confirm capture
and a sustained traveling wave, then compare arrival, mean distance, joint
envelopes, command effort, relative crossflow, force, and moment against the
evaluated parent. No same-worker performance benefit is claimed.
