# Multi-wake candidate diagnosis

## Evidence and visual diagnosis

I read the assigned parent guidance, all four sampled solver scores,
observations, compact metrics and nested diagnostics, and the available
inherited optimizer notes before selecting this candidate. I inspected the
common held-fish prewarm sheet first and then the released sheets for the best
`0.75` gain, the duplicated `0.77` gain, and the inherited `0.745` gain. No
omitted Bookshelf, neighboring configuration, repository history, coordinate
route, clock, or external research was used. The currently sampled solver set
contains no failed rollout sheet; the older unstable sign/amplitude result is
therefore used only as inherited guidance and is not presented as a newly
inspected image.

The prewarm frames show the common release condition: the held fish begins
above and downstream of four developed, interacting vortex streets, and the
target sits in the merged second-row wake. This is shared initial-condition
evidence, not candidate-specific support or a route to memorize.

The duplicated `steering_gain=0.75` sheets show the strongest finite behavior.
The fish makes a bounded initial turn, self-propels diagonally upstream, enters
the useful wake late, and crosses the target circle without a loop, collision,
or boundary excursion. Metrics confirm propulsion rather than passive
advection: mean x velocity is `-0.14682` against mean local-flow x velocity
`-0.08249`, giving `0.06433` upstream-relative speed. Capture takes `74.23`
release units, mean distance is `2.561L`, and RMS force/moment is
`22.39/393.08`. Both requested accelerations touch the candidate's
`28 rad/time^2` guard, while maximum joint angles (`0.516/0.427 rad`) and
speeds (`3.121/3.225 rad/time`) remain below the task hard limits.

The duplicated `0.77` samples retain the gait and reach the target, but visibly
take a deeper, more horizontal final approach. Capture regresses to `78.58`,
mean distance to `2.661L`, and upstream-relative x speed to `0.06261`; their
lower relative crossflow and mean power do not compensate for weaker route
closure. More decisively, two inherited behaviorally identical `0.745`
rollouts falsify the earlier lower-side interpolation hypothesis. Their sheets
show a still deeper excursion below the direct corridor before returning to
the target. Capture slows to `86.99`, mean distance rises to `2.694L`,
upstream-relative x speed falls to `0.05865`, and RMS force/moment rise to
`39.84/540.72`. Thus the deterministic common-snapshot response is not smooth
enough to justify another fitted static-gain interpolation around `0.75`.

## One candidate hypothesis

Retain the directly evaluated `0.75` positive-bearing gain, `10 deg` steering
bound, `0.75`-period and `22 deg` state-energy oscillator, and the complete
posterior traveling-bend structure. Change only the candidate-owned
acceleration guard from `28` to `29 rad/time^2`, still below the task's
`1800 deg/time^2` (`31.42 rad/time^2`) hard envelope. The best sample touches
both soft guards but has substantial joint-angle, joint-speed, and load margin;
this isolated probe tests whether brief clipping is limiting traveling-bend
tracking and upstream propulsion without repeating the now-rejected steering
gain search.

Falsifiable expectation: the common-snapshot rollout should retain the compact
target-reaching topology and finite load scale while improving either the
`74.23` capture time or `2.561L` mean distance through upstream-relative x
speed above `0.0643`. Reject the change if the final approach deepens, capture
slows or fails, joint speed approaches its hard limit, or RMS force/moment rise
materially above `22.39/393.08`. This is a local guard-isolation experiment,
not evidence that greater acceleration authority generalizes across wake phase,
geometry, inflow, or capture semantics; no CFD result for this unevaluated
candidate is claimed.
