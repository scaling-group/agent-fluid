# Multi-wake candidate diagnosis

## Evidence and visual diagnosis

I read the assigned parent guidance, all four sampled solver scores,
observations, metrics, and nested wake diagnostics, plus the inherited parent
notes and evaluated `0.745` descendant, before changing the policy. I
inspected the common prewarm sheet first and then the released sheets for the
best finite `0.75` sample, the duplicated `0.77` sample, and the inherited
`0.745` regression. No current sampled example failed; therefore there is no
failed current keyframe sheet to compare. The inherited reversed-sign,
high-amplitude failure remains a metrics-and-notes boundary only, not a visual
claim made from the current sheets. I used no omitted Bookshelf material,
neighboring run, repository history, coordinate route, or clock.

The prewarm sheet establishes the common release above and downstream of the
four interacting vortex streets, with the target inside the developed
second-row wake. It is identical initial-condition evidence, not evidence for
one candidate.

Both `steering_gain=0.75` samples are exact behavioral duplicates. Their
released sheets show a bounded initial turn followed by the most compact
diagonal approach and direct first crossing among the available rollouts.
Capture occurs in `74.23` release units with `2.561L` mean distance. The fish
is self-propelled rather than merely advected: mean x velocity is `-0.14682`
against mean local-flow x `-0.08249`, yielding `0.06433` upstream-relative x
speed. RMS force/moment are `22.39/393.08`; maximum joint angles
`0.516/0.427 rad` and speeds `3.121/3.225 rad/time` remain below the task hard
limits, though both commands touch the candidate's `28 rad/time^2` guard.

Both `steering_gain=0.77` samples are also exact duplicates. They retain
finite capture but visibly take a deeper, later final approach. Metrics agree:
capture slows to `78.58`, mean distance increases to `2.661L`, and
upstream-relative x speed falls to `0.06261`. Their lower mean power does not
offset the targeting regression, while RMS force rises to `23.77` and RMS
moment stays near `393.44`.

The assigned parent's `steering_gain=0.745` descendant closes the lower side
of this local sweep. Its sheet shows a larger downward excursion and an upward
correction into the target rather than the `0.75` route's direct crossing.
Capture slows to `86.99`, mean distance worsens to `2.694L`, upstream-relative
x speed falls to `0.05865`, and RMS force/moment jump to `39.84/540.72`.
Thus the prior interpolation hypothesis is falsified: a sub-percent static
gain reduction does not smooth or improve this wake-conditioned route.

## One candidate hypothesis

Keep the directly evaluated `0.75/10 deg` pure-bearing steering response, the
positive sign, the `0.75` period, posterior lag/damping, and the `28
rad/time^2` candidate action guard. Change only nominal oscillator amplitude
from `22` to `22.5 deg`. Steering-gain probes on both sides now regress, so
this candidate tests whether a small increase in the demonstrated
self-propulsive component can shorten the same compact route without altering
the target-relative turn center.

At `22.5 deg`, the nominal anterior restoring peak
`omega^2 * amplitude` is about `27.56 rad/time^2`, still below the candidate
guard; nominal oscillator speed is about `3.29 rad/time`, below the `4.54`
hard joint-speed limit, and nominal amplitude plus the `10 deg` steering bound
is below the `45 deg` joint-angle limit. These arithmetic margins are only a
controller-side safety check, not a CFD outcome.

The falsifiable expectation is finite first capture on the common prewarm,
with upstream-relative x speed above `0.0643` and either arrival earlier than
`74.23` or mean distance below `2.561L`, while avoiding persistent action
clipping and keeping RMS force/moment materially below the `0.745` regression's
`39.84/540.72`. Reject the amplitude increment if it loses the compact route,
raises joint-speed or load saturation, or fails to improve either arrival or
distance integral. This is a one-parameter common-snapshot probe, not a claim
about held-out wake phase, geometry, or inflow, and no result for this
unevaluated candidate is claimed.
