# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four sampled solver scores,
observations, metrics, nested wake diagnostics, policies, and the available
inherited optimizer notes before writing this hypothesis. Following the wake
visual-signals procedure, I inspected the common held-fish prewarm sheet first
and then the released sheets for the best `0.75` sample, both `0.77` samples,
and the inherited `0.70` and `0.55/8 deg` successes. No omitted Bookshelf,
neighboring configuration, repository history, coordinate route, clock, or
external research was used. The four current solver samples contain no failed
rollout; the aggressive instability is therefore used only through the
assigned parent's inherited diagnosis and metrics, not misrepresented as a
freshly inspected failure image.

The prewarm sheet shows the shared release condition: the fish is held in the
upper-right above and downstream of four developed, interacting vortex
streets, while the target lies in the second-row wake overlap. It is common
initial-condition evidence, not support for a memorized route or wake phase.

The current `0.75` sheet shows a compact, self-propelled down-left crossing.
The fish turns toward the target, enters the developed target wake from the
right, and reaches the `0.75L` circle in `74.23` release units. Its mean world
x velocity is `-0.14682`, versus mean local-flow x velocity `-0.08249`, so the
`0.06433` upstream-relative component confirms propulsion rather than passive
advection. Mean distance is `2.561L`, score is `-0.6617`, and RMS force/moment
remain finite at `22.39/393.08`. Joint angles and speeds stay below the hard
envelope, although both actions touch the candidate's `28 rad/time^2` guard.

The newly sampled `0.77` policy preserves the same gait, steering cap, and
route topology but makes a slightly deeper downward correction before wake
entry. It still reaches the target, yet arrival regresses to `78.58`, mean
distance to `2.661L`, and score to `-0.7586`; upstream-relative x speed falls
to `0.06261`, RMS force rises to `23.77`, and maximum anterior angle/speed rise
from `0.516/3.121` to `0.532/3.162`. Its nearly unchanged RMS moment (`393.44`)
and lower mean command energy (`671.40` versus `686.26`) do not offset the
longer path: total command energy increases from `50939.90` to `52761.38`.
The duplicate evaluations at each of `0.75` and `0.77` reproduce their metrics
exactly under the certified snapshot. They confirm the deterministic local
comparison, but are not evidence across wake phase.

Together with the inherited same-gait `0.70` result (`91.61` arrival,
`2.834L` mean distance, score `-0.9227`), the gain-only samples bracket an
interior response. Three-point quadratic interpolation puts the arrival-time
minimum near `0.747` and the mean-distance/score maximum near `0.743`; this is
only a local proposal, not an evaluated result. The parent's inherited
reversed-sign, `30 deg`, `0.82`-period rollout remains the failure boundary:
it coiled near release and terminated as `unstable_dynamics` after `4.45`
units, with RMS relative crossflow `3.139` and force/moment
`5.50e4/5.68e5`. It supports retaining the positive sign, moderate gait, and
action guard rather than coupling this small steering probe to a gait change.

## One candidate hypothesis

Change only the positive-bearing steering gain from `0.75` to `0.745`, the
center of the metric-derived `0.743--0.747` interval. Preserve the evaluated
`10 deg` steering limit, `0.75`-period and `22 deg` state-energy oscillator,
posterior traveling-bend response, damping, and `28 rad/time^2` guard. This
keeps the candidate inside the successful `0.70--0.77` bracket and isolates
the local static-gain hypothesis without adding derivative, force, moment,
flow, position, or route feedback.

Later CFD should retain finite target capture and material upstream-relative
propulsion while improving either arrival or mean distance from
`74.23`/`2.561L`, with joint state and loads remaining near the `0.75` anchor.
Reject `0.745` as an improvement if capture is lost, either route metric
regresses, clipping becomes persistent, or loads move materially toward the
larger-gain samples. Even if it wins on this snapshot, falsify a reusable
optimum if held-out wake phase or geometry reverses the ordering. No outcome
for this unevaluated workspace candidate is claimed.
