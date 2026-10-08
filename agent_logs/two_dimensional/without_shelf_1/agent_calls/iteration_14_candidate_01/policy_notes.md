# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The common prewarm sheet shows the held fish above and downstream of the target
while the four interacting vortex streets are already developed.  In every
released sheet the fish then self-propels upstream into the disturbed region;
this is not passive advection.  The strongest sampled policy moves the head
`-11.33L` while its mean local flow is only `-0.119` and its mean head velocity
is `-0.171`.  Visually, however, it crosses the target's streamwise station
well above the capture circle and then makes a sharp upward hook immediately
before the upper-domain exit.

The sampled `0.35` opposing-posterior-headroom boost is the only current change
with a useful approach gradient.  Relative to the inherited plain `11 deg`
static-bias anchor, it improves head-x travel from `-7.89L` to `-11.33L`,
closest approach from `4.87L` to `3.03L`, progress from `0.424` to `0.517`,
and head-y drift from about `+1.79L` to `+1.69L`.  The benefit is costly and
incomplete: RMS force/moment rise from `406/4113` to `511/5305`, posterior
angle reaches `0.780 rad`, both joints reach the `4.538 rad/time` rate limit
and `28.798 rad/time^2` command cap, and the fish still exits high.

All three sampled overlays on that boosted anchor regress without changing the
visible terminal topology.  Distance-gated receding-bearing reversal yields
`-10.15L/3.13L/0.495` or `-10.83L/3.10L/0.507` for head travel, closest
approach, and progress, while restoring head-y drift to `+1.77L`--`+1.79L`.
A signed fore-aft reversal is worse at `-8.49L/3.45L/0.449`.  All three still
hit both joint rate and command limits and leave through the upper boundary.
Thus receding or overshoot logic has no evidenced recovery zone at a `3L`
miss; it cancels useful approach authority before capture becomes plausible.

## Single candidate hypothesis

Keep the complete `0.90`-period, `11 deg`, `25 deg`, `0.70/0.35` controller,
its posterior-only traveling-wave steering, and its existing actuation cap.
Change only the opposing-posterior-headroom coefficient from `0.35` to `0.55`.
This bounded continuation never attenuates the evidence-best static request:
it raises the phase multiplier from at most `1.35` to at most `1.55`, and only
when the posterior target remaining after the base request still opposes the
target-bearing steering direction.  It uses the sole sampled mechanism whose
first increment improved both approach and lateral drift, without introducing
another unvalidated state gate.

The next CFD result supports the hypothesis only if it improves on the
`3.03L` closest approach or materially reduces the upper drift while preserving
roughly the boosted anchor's `-11.33L` upstream travel.  It is falsified if the
same upper exit persists with no approach gain, if progress regresses toward
the recovery-gate branches, or if force/moment growth is disproportionate to
the route change.  A failed result should end further increases of this boost
rather than motivate another stacked recovery gate.
