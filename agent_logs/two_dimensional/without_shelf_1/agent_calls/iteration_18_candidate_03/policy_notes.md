# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish starts above and downstream of the target while four developed,
interacting vortex streets fill the route. The current released sheets are
four deterministic reproductions of one functional policy, not four gain
brackets: all use the `0.50` opposing-phase boost plus
`0.18*tanh(target_body_L[2]/2L)`, reach the `0.75L` circle after `88.13`
release units, and report identical score and diagnostics.

The successful keyframes show active diagonal swimming into the disturbed
corridor. The fish descends early instead of remaining above the target, but
it still makes a broad midcourse return toward the upper wake before descending
again for capture. The metrics confirm that this is a useful controller route,
not passive advection or a visually dramatic vortex: mean head velocity x is
`-0.124` versus mean local flow x `-0.092`, head displacement is
`(-10.92,-4.44)L`, final/minimum distance is `0.747L`, and progress is
`0.940`. RMS relative crossflow and force/moment are `0.289` and `445/4597`.
The diagnostics also show that the posterior angle reaches `45 deg` and both
joint rates and commands reach their caps, so capture does not establish
actuator desaturation.

The inherited failure contrast isolates the route mechanism. A near-target
bearing-to-lateral replacement reaches `1.89L` but then hooks upward and exits
after `72.80` units with head displacement `(-12.01,+1.79)L`, mean distance
`6.45L`, RMS relative crossflow `0.302`, and force/moment `568/5495`. The plain
`0.50` phase-headroom branch has the same upper-exit topology. Thus late
replacement, further phase-headroom tuning, clipping, target-motion gates,
and velocity or load rejection remain falsified. The additive far-field
cross-track signal is the sole sampled change that preserves self-propulsion,
reverses lateral topology, reduces aggregate load, and captures the target.

## Single candidate hypothesis

Keep the complete reproduced success policy and increase only
`cross_track_gain` from `0.18` to `0.20`. This is an `11%` authority bracket on
the demonstrated bounded, normalized body-frame signal; it leaves the
anterior oscillator, posterior traveling wave, bearing and body-rate feedback,
`0.50` phase allocation, distance fade, and command ceiling unchanged. The
existing distance fade removes the added request across the final
`1.5L`, so the change targets the visible midcourse upper excursion rather
than adding a terminal recovery mode.

The score has zero effort weight and is dominated among successful policies by
the horizon-normalized distance integral. Support therefore requires repeat
capture plus release time below `88.13` or mean distance below `2.736L`, with
the keyframes showing a more direct descent and no material increase over
`445/4597` RMS force/moment. Falsify the increase if capture is lost, the upper
hook returns, arrival/distance integral does not improve, or load rises without
a route benefit. In that case later workers should restore the exact `0.18`,
`2L` anchor and close upward gain tuning before testing the lower-gain side or
a distinct single-axis desaturation mechanism.
