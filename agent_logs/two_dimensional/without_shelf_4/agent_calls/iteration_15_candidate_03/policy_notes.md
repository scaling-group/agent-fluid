# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets are byte-identical. The inspected sheet
  shows the fish held at the upper-right release pose while the four staggered
  cylinders develop overlapping vortex streets through and downstream of the
  target. This is the certified common initial condition and cannot rank the
  policies.
- All four current rollouts capture without collision, domain exit, or
  instability, so the informative failure is a route-quality regression rather
  than a hard task failure. The fixed `0.07` lower bracket remains downstream
  through a longer series of broad wake-band reversals and does not capture
  until `245.449`. Its mean distance is `6.305L`, command energy is `169649.0`,
  and RMS lateral force/moment are `18.399/363.454`. Mean upstream fish speed
  `-0.04426` exceeds mean local-flow x `-0.03141`, so this is slower
  self-propelled, wake-assisted navigation rather than passive advection.
- The prefilled progress-loss schedule is the best scored current finite
  reference. Its sheet preserves the broad release acquisition loop but enters
  the central wake and closes almost horizontally by rendered frame `24`. It
  captures at `213.659`, lowers mean distance to `5.856L`, improves score to
  `-3.863`, and reduces total command energy and RMS force/moment to
  `148694.7` and `17.761/354.838`. Its mean upstream fish speed is `-0.05083`
  versus local-flow x `-0.03822`, leaving positive controller-relative
  upstream transport `0.01261`.
- The target-away-drift-magnitude schedule is the complementary strongest
  sample. Its sheet reaches the final wake corridor sooner, capturing at
  `196.900`, and it has the lowest total command energy, RMS lateral force, and
  RMS moment of the current set: `136830.1`, `17.672`, and `352.909`. It also
  has the largest controller-relative upstream transport, `0.01735`. Its mean
  distance `6.211L` and score `-4.230` are worse than the progress schedule,
  so arrival alone does not rank it above the parent.
- Both state schedules improve arrival, mean distance, effort, force, and
  moment relative to the fixed `0.08` controller (`224.488`, `6.311L`,
  `157453.9`, `17.943/361.014`) while keeping the same maximum lateral target
  offset `4.293L` and anterior acceleration `31.055 rad/time^2`. Thus the gain
  is associated with when the counter-drift lookahead is strengthened, not
  more propulsion, a wider excursion, or guard contact. The fixed `0.07`
  regression and inherited `0.10` regression (`263.346`, `6.974L`) bound the
  useful local magnitude range.
- The inspected inherited alignment-gated heading-rate rollout is the most
  informative broader negative comparison: its sheet shows a larger far-field
  loop and repeated late reversals before a `265.298` capture; mean distance,
  total command energy, and RMS force worsen to `7.822L`, `181783.2`, and
  `18.886`. Assigned-parent notes also record a sign-asymmetric bearing-rate
  horizon miss at final distance `3.632L`. These results do not support adding
  rotational-rate feedback or changing propulsion in this candidate.

## Single candidate hypothesis

Preserve the prefilled `20.25 deg`, `0.67`-period oscillator, posterior
lag/damping, `10 deg` steering limit, `0.30` bearing scale, `0.25` bearing-rate
lead, `0.10` lateral-velocity clamp, and `31.2` acceleration guard. Retain the
evaluated progress-loss and target-away-drift weights, but schedule the
counter-drift lookahead with their bounded maximum:

```text
schedule_weight = max(progress_loss_weight, away_drift_weight)
lookahead = 0.07 + (0.08 - 0.07) * schedule_weight
```

The maximum selects one of the two evaluated state schedules at every control
step: receding motion can request recovery strength even before away drift is
large, while strong target-away drift can retain the faster sample's response
even during net closing. Both weights and the resulting lookahead remain
bounded, and the correction stays zero for stationary or targetward lateral
motion because it is still multiplied by `away_drift_weight * lateral_velocity`.
The maximum added pre-nonlinearity correction remains `0.008 rad`. The policy
adds no coordinate, route, clock, prescribed inflow, remote wake probe, or new
unbounded observation.

The falsifiable expectation is to retain capture no later than the prefilled
`213.659` and mean distance no higher than `5.856L`, while moving load and
effort toward the drift schedule's `17.672/352.909` and `136830.1`. Reject the
combination on lost or later capture, worse mean distance/score than the
prefill, controller-relative upstream transport below `0.01261`, increased
crossflow/load/effort, guard contact, a larger corridor rebound, or visible
switching. This inference is local to the certified fixed-prewarm phase; no
same-worker CFD result is claimed, and held-out wake-phase transfer remains an
open test.
