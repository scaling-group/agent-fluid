# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of the target while four developed, interacting
wakes span the route. The sampled released sheets then separate two route
topologies. The plain `0.50` phase-opposition anchor is self-propelled rather
than passively advected (mean head velocity x about `-0.174` versus mean local
flow x `-0.123`) and travels `-12.28L` upstream, but it passes above the target,
hooks sharply upward, and leaves the domain after only reaching `2.13L`. Its
terminal head-y displacement is `+1.78L`, with RMS force/moment `535/5416`.

Replacing bearing by normalized lateral offset inside `3L` does not repair
that topology. The replacement enters slightly closer (`1.89L`) but the
keyframes still show the same nearly vertical upper-boundary exit, terminal
head-y displacement rises to `+1.79L`, and RMS force/moment rise to `568/5495`.
This falsifies near-target lateral offset as a substitute for the angular
bearing drive; the brief approach gain is not a recovery mechanism.

In contrast, adding `0.18*tanh(target_body_L[2]/2L)` to the complete bearing
command changes the visible route: the fish descends across the wake field,
continues active upstream swimming, corrects around the target rather than
escaping high, and crosses the `0.75L` capture circle. The metrics agree:
termination is `target_reached` at `88.13` release units, minimum/final distance
is `0.747L`, mean distance is `2.736L`, progress is `0.940`, and head-y travel
is `-4.44L` rather than approximately `+1.8L`. RMS force/moment also fall to
`445/4597` despite the longer episode. This is the only sampled semantic
success. It still reaches the `45 deg` posterior angle and both joint rate and
acceleration caps, so it is evidence for route correction, not desaturation.

Inherited optimizer logs bound the mechanism: phase-headroom increases above
`0.50`, close-only continuation, receding or fore-aft reversal, bearing-rate
lead, lateral-speed/slip damping, yaw-moment rejection, posterior clipping, and
the sampled bearing replacement all regress approach or retain the upper hook.
Those negatives provide no support for composing another gate with the sole
successful route.

## Single candidate hypothesis

Restore the sampled successful additive cross-track controller exactly: keep
the full `0.50` phase-opposition gait and add only the bounded `0.18`, `2L`
body-frame lateral-offset request before heading-rate damping. This candidate
deliberately does not tune the successful gain or add a second mechanism; the
available evidence contains no bracket showing that either direction would
retain capture. All active gait, steering, normalization, damping, phase, fade,
and command-limit values remain owned by `target_policy_params()`.

Under the certified initial condition, support is repeat target capture with
the demonstrated downward route and roughly comparable approach/load metrics.
A repeat upper exit, failure to enter `0.75L`, or a materially worse load spike
would falsify reproducibility. Across later wake-phase or geometry tests, retain
the additive lesson only while it improves lateral topology without collapsing
upstream propulsion; posterior saturation remains a separate unresolved axis.
