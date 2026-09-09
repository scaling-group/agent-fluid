# Multi-wake candidate diagnosis

## Evidence read before the policy edit

I read the assigned-parent guidance, all four sampled solver policies, scores,
observations, compact metrics and nested wake diagnostics, and the available
inherited optimizer notes and evaluated descendants. I inspected the common
held-fish prewarm sheet first, followed by the released sheets for the best
finite `22 deg / 28` anchor and the informative `22.25 deg` and `29`-guard
regressions. No omitted Bookshelf material, neighboring configuration,
repository history, coordinate route, clock, or external research was used.

The prewarm sheet shows the common release condition: the fish is held in the
upper-right, above and downstream of four developed interacting vortex
streets, while the target lies in the merged second-row wake. This is common
initial-condition evidence, not candidate-specific evidence or justification
for memorizing a route.

The two exact `steering_gain=0.75`, `oscillator_amplitude=22 deg`, and
`acceleration_limit=28` samples are the strongest finite anchor. Their
identical released sheets show a bounded initial turn, compact diagonal
upstream approach, late entry into the useful wake, and first crossing without
a loop, collision, or boundary excursion. Metrics confirm self-propulsion
rather than passive advection: mean x velocity is `-0.14682` against mean
local-flow x velocity `-0.08249`, or `0.06433` mean upstream-relative speed.
Capture takes `74.23` release units, mean distance is `2.561L`, and RMS
force/moment are `22.39/393.08`. Both actions touch the candidate's `28`
guard, but maximum joint angles (`0.516/0.427 rad`) and speeds
(`3.121/3.225 rad/time`) remain below the task hard limits.

The current samples and inherited logs reject three nearby attempts to obtain
more authority through static tuning. The duplicated `steering_gain=0.77`
sample remains successful but takes `78.58` units and `2.661L` mean distance;
the parent log records a deeper, more horizontal approach. Increasing only
amplitude to `22.25 deg` preserves a visually similar target-reaching route,
but slows capture to `76.95`, lowers upstream-relative x speed to `0.05926`,
raises command energy from `50940` to `54203`, and raises RMS force/moment to
`24.75/420.04`. Increasing only the action guard from `28` to `29` is a
stronger negative result: its sheet shows a deeper, more undulatory approach
that reaches the lower-right side of the capture circle in `80.00` units.
Upstream-relative x speed falls to `0.05804`; maximum anterior angle rises to
`0.557 rad`; and RMS force/moment rise to `33.84/488.89`. The posterior action
touches `29`, while anterior action peaks at `28.68`, so the extra permission
was active without improving propulsion or route closure. The inherited
`0.745` gain result is slower and more highly loaded still, bounding further
static steering interpolation.

No failed rollout sheet exists in the currently available sampled or inherited
artifact set. The older reversed-sign, `30 deg`, `0.82`-period
`unstable_dynamics` case is therefore retained only as an inherited safety
boundary, not described as an image inspected here. All directly inspected
negative cases still reach the target; their value is the controlled
regression in arrival, route, relative propulsion, and loads.

## Single candidate hypothesis

Restore the directly evaluated `0.75` positive-bearing gain, `10 deg` steering
bound, `0.75`-period and `22 deg` energy-regulated oscillator, and the complete
posterior traveling-bend structure. Change only the candidate-owned
acceleration guard relative to that anchor, from `28` to `27.5 rad/time^2`.
The nominal anterior restoring peak at `22 deg` is about `26.94`, so this guard
should preserve the established cycle while clipping more of the steering and
wake-induced bursts that grew joint excursion and load under the `29` probe.

Falsifiable expectation: under the common prewarm, `27.5` should retain target
capture and approximately the anchor's `0.0643` upstream-relative x speed,
while improving either the `74.23` arrival or `2.561L` mean distance without
raising RMS force/moment. Reject it if added clipping deepens the approach,
slows or loses capture, materially reduces upstream-relative propulsion, or
causes persistent bang-bang action. This is an isolated common-snapshot guard
probe; it does not claim robustness across wake phase, geometry, inflow, or
capture semantics, and no CFD result for this unevaluated candidate is claimed.
