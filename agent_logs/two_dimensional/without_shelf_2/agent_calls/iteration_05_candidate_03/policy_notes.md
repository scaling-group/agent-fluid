# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I used the assigned parent guidance, all four sampled solver policies, scores,
observations, metrics and nested wake diagnostics, and the available inherited
optimizer notes. I inspected the canonical shared-prewarm sheet before every
released sheet. The four shared sheets have the same content hash and show the
fish held above and downstream of four developed interacting wakes, with the
target in the second-row overlap. This is common initial-condition evidence,
not support for a clock, coordinate route, or memorized wake phase. I did not
use the omitted Bookshelf, neighboring configurations, repository history, or
evidence outside this Phase 2 workspace.

There is no failed termination among the current sampled solvers: all four
reach the target. The best-versus-failure comparison requested by the visual
procedure is therefore unavailable in this sample; I instead compare the best
finite rollout with the weakest success and both upper-response successes,
while retaining the inherited downstream-exit result as the failure boundary
against bearing-rate lead.

All four released sheets show an actively bending fish turn down-left, traverse
the developed wake corridor, and reach the target from the right. The metrics
confirm self-propulsion rather than passive advection. For the best `0.75`
gain / `10 deg` policy, mean world x velocity is `-0.1468` versus mean local
flow `-0.0825`, and the fish reaches `0.7497L` after `74.23` release units with
mean distance `2.561L`. Its RMS lateral force/moment are only `22.39/393.08`,
and its maximum angle and speed remain below the hard limits (`0.516 rad` and
`3.225 rad/time`), although both actions touch the candidate's
`28 rad/time^2` guard.

The otherwise identical static-gain neighbors bracket that result. At
`0.70/10 deg`, capture takes `91.61` units and mean distance is `2.834L`, with
RMS force/moment `38.81/550.75`. At `0.82/10 deg`, capture takes `83.83` units
and mean distance is `2.668L`, with RMS force/moment `36.11/515.17`; its sheet
also retains the same target-reaching topology rather than revealing a new
route. Thus strengthening small-error response from `0.70` to `0.75` helped,
but continuing to `0.82` gave back `9.60` release units and raised both loads.
The `0.80/11 deg` rollout is worse again at `87.63` units, `2.760L`, and
`52.88/687.45`, but it changes gain and steering limit together, so it only
supports keeping the evaluated `10 deg` envelope; it cannot isolate a gain
effect. Mean command energy remains in the narrow `672--686` range across all
four, so the `0.75` advantage is route/load organization rather than a large
increase in average command effort.

## One candidate hypothesis

Keep the common evaluated propulsion core, posterior phase relation,
`10 deg` steering limit, and `28 rad/time^2` candidate guard unchanged. Set
only `steering_gain` to `0.77`, an interpolation inside the successful
`0.75--0.82` bracket. A quadratic interpolation of the three same-limit
samples places the release-time and scalar-score turning points near
`0.768--0.772`; `0.77` tests that narrow optimum without adding a new signal,
enlarging maximum curvature, or revisiting the inherited bearing-rate failure.
Every active constant remains owned by `target_policy_params()`.

Later CFD should preserve target capture and material upstream velocity while
improving release time or mean distance beyond the `0.75/10 deg` anchor's
`74.23` / `2.561L`, without materially exceeding its `22.39/393.08` load
scale. Reject the interpolation if arrival or mean distance regresses, the
visible route develops a larger lateral excursion, hard joint limits are
approached, or the low-load advantage disappears. Such a result would favor
the directly evaluated `0.75/10 deg` anchor and would not justify either the
larger `11 deg` envelope or derivative steering.
