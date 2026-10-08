# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance and optimizer note, the four sampled solver
policies, scores, observation summaries, compact metrics, and nested wake
diagnostics before writing this hypothesis. I inspected the shared prewarm
sheet first and both unique current released sheets. I used no omitted
Bookshelf material, neighboring configuration, repository history, coordinate
route, clock, or external research.

The prewarm frames show the common held-fish release above and downstream of
four developed, interacting vortex streets, with the target in their second-row
overlap. This establishes an identical wake and pose for the gain comparison;
it does not support a candidate-specific wake-phase or memorized route.

The two current policies differ only in positive-bearing steering gain. Both
released sheets show a sustained traveling bend, a down-left turn, active
upstream traversal through the developed wake, and first capture from the
right. The metrics rule out passive advection: at gain `0.75`, mean world/local
x velocity is `-0.1468/-0.0825`, while at gain `0.77` it is
`-0.1383/-0.0757`. The `0.75` sheet completes the diagonal approach in fewer
stored frames; the `0.77` sheet follows a visibly similar path but remains in
the right-hand wake longer before entering the target circle.

The assigned parent's `0.77` gain-only probe is therefore a concrete negative
result relative to the `0.75` anchor. It still captures, but release time
regresses from `74.23` to `78.58`, mean distance from `2.561L` to `2.661L`,
and score from `-0.6617` to `-0.7586`. Its anterior/posterior angle maxima
increase from `0.516/0.427` to `0.532/0.434 rad`, joint-speed maxima from
`3.121/3.225` to `3.162/3.305 rad/time`, and RMS force from `22.39` to
`23.77`; RMS moment is effectively unchanged near `393`. Both policies touch
the candidate-owned `28 rad/time^2` action guard, so the regression is not
evidence for adding more authority. Duplicate samples of each policy reproduce
the same metrics under the certified common snapshot.

No failed rollout sheet is present in the current sample. The most informative
failure boundary available through inherited logs is the reversed-sign,
`30 deg`, `0.82`-period controller: it terminated as unstable after `4.45`
release units with relative-crossflow RMS `3.139` and force/moment RMS
`5.50e4/5.68e5`. That inherited evidence rules out combining this local gain
probe with gait enlargement, sign reversal, or removal of the soft action
guard; I do not infer new visual details from its unavailable sheet.

## One candidate hypothesis

Keep the evaluated `0.75` controller's `0.75`-period, `22 deg`
energy-regulated oscillator, posterior traveling-bend response, `10 deg`
steering bound, damping, and `28 rad/time^2` action guard. Change only the
steering gain to `0.74`. This is a `1.3%` probe on the lower side of the best
sample and directly follows the assigned parent's stated falsification rule:
because `0.77` regressed, bracket below `0.75` before making another upward
extrapolation or adding an unisolated feedback mechanism.

Later CFD should retain finite active upstream propulsion and target capture
while testing whether a slightly earlier/less forceful correction improves
release time or mean distance from `74.23`/`2.561L`, or at minimum reduces
loads without route regression. Reject `0.74` as an improvement if it loses
capture, takes longer, increases mean distance, creates persistent clipping,
or pushes joint/load diagnostics away from the `0.75` anchor. No evaluation
result for this workspace candidate is claimed.
