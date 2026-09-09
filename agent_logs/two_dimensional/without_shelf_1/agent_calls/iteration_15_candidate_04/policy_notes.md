# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the common held fish above and downstream of
the target, with four developed interacting wakes spanning the route. The
released sheets show active upstream propulsion rather than passive advection:
for the `0.50` opposing-phase candidate, mean head velocity is about `-0.174`
while mean local flow is `-0.123`, and the head travels `-12.28L`. Visually it
enters the disturbed wake region and passes closer to the target than the
`0.35` anchor, but then curls sharply upward and crosses the upper boundary.
The common terminal hook therefore remains a controlled-route failure, not a
collision or numerical instability.

The isolated phase-headroom bracket is unusually informative. Increasing its
coefficient from `0.35` to `0.50` improves upstream travel from `-11.33L` to
`-12.28L` and closest approach from `3.03L` to `2.13L`; mean head speed remains
more upstream than local flow. The gain is not a solved steering mechanism:
progress changes slightly from `0.517` to `0.509`, head-y exit remains about
`+1.78L`, both joint rates and commands reach their caps, and RMS force/moment
increase from `511/5305` to `535/5416`. The assigned parent's inherited
`0.55` rollout then crosses a sharp negative boundary: it travels only
`-3.89L`, reaches just `5.70L`, has `0.206` progress, exits sooner, and raises
RMS moment to `5969`. Its keyframes show the upward turn beginning in the
far-field, well before a useful approach. Thus a globally active increase
above `0.50` is falsified, even though the `0.50` rollout establishes a new
close region that prior `0.35` recovery candidates never reached.

Other inherited overlays do not justify another recovery or saturation
composition. Two receding-distance reversals on the `0.35` anchor regress
closest approach to `3.13L/3.10L` and preserve the upper hook; fore-aft,
bearing-rate, lateral-motion, and yaw-moment terms also lose approach without
changing topology. Clipping the posterior target at `42 deg` does reduce load
and posterior motion, but collapses travel to `-1.89L`, closest approach to
`8.21L`, and progress to `0.074`. These are concrete reasons to preserve the
unclipped propulsion gait and avoid a stacked recovery signal.

## Single candidate hypothesis

Keep the complete sampled `0.50` policy unchanged at and beyond `2.75L`.
Inside that target-relative distance, smoothly add at most `0.05` to the
opposing-posterior-headroom coefficient, reaching the inherited `0.55` value
only at `2.0L` and closer. This is not distance attenuation: every demonstrated
far-field command is identical to the `0.50` anchor, and the close gate can
only add the same bounded phase allocation that produced the sole positive
approach gradient. It uses normalized target distance and joint phase, with no
elapsed time, global coordinates, route, prescribed flow, or remote wake
probe.

The hypothesis is supported by capture, a closest approach below `2.13L`, or
a changed terminal topology while retaining approximately `-12.28L` upstream
travel. It is falsified if the far-field hook begins before the gate, if the
gate reproduces the `0.55` collapse after activation, or if force/moment rises
without an approach benefit. A negative result should close phase-headroom
increases even when localized by distance and direct later workers to restore
the sampled `0.50` anchor before testing a genuinely different observation.
