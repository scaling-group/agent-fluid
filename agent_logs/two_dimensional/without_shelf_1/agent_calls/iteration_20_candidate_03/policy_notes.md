# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish begins above and downstream of the target while four asymmetric cylinder
streets develop and merge across the route. The four sampled released sheets
are byte-identical, and their policies differ only in comments, so they provide
one deterministic successful anchor rather than a four-point parameter sweep.
The anchor visibly self-propels upstream, descends through the interacting wake,
makes a broad terminal bend, and crosses the `0.75L` target circle without a
collision or domain exit. Metrics corroborate that reading: the head moves
`(-10.925,-4.435)L`, mean head velocity x is more upstream than mean local flow
(`-0.124` versus `-0.092`), capture occurs after `88.129` release units, and
minimum/mean distance and progress are `0.747L/2.736L/0.940`. The sheet's sharp
late curvature agrees with the diagnostic posterior-angle, two-rate, and
two-command cap contacts; capture does not establish desaturation.

The inherited step-19 sheets provide the informative failures absent from the
sampled batch. Raising the complete controller's cross-track gain from `0.18`
to `0.20` initially swims upstream and comes within `1.123L`, but then turns
nearly vertical and exits the upper boundary with `(+1.781L)` head-y travel;
lowering the same gain to `0.17` produces a larger loop, misses at `3.267L`,
and also exits upward at `(+1.800L)`. Their mean distances regress to
`6.365L/7.775L` and RMS loads to `490/4800` and `478/5138`, respectively,
versus `2.736L` and `445/4597` for the anchor. Thus the useful additive
cross-track term is locally bracketed on both sides, not a monotone gain knob.

The assigned parent's `1700 deg/time^2` command-ceiling sheet supplies a
second independent failure contrast. It preserves active upstream motion at
first, then turns upward before entering the target corridor and exits after
`58.344` units, no closer than `5.734L`; head travel changes to
`(-8.038,+1.748)L` and mean distance/progress regress to `7.515L/0.433`.
Together with the earlier `1550` failure, this closes simple ceiling tuning on
both sides of `1650`. The `1700` result has slightly lower RMS force/moment
(`430/4342`), demonstrating that lower loads during a shorter failed episode
are not evidence of a useful route.

## Single candidate hypothesis

Restore the complete sampled `0.18` cross-track, `0.50` phase-headroom, and
`1650 deg/time^2` command controller, then change only
`steering_fade_width_L` from `0.75L` to `0.65L`. With the existing smoothstep,
the old controller is fully active outside `1.50L` and fades to zero at the
`0.75L` capture boundary; the candidate remains identical in the far field,
becomes fully active outside `1.40L`, and retains modestly more of the already
successful steering request only during the terminal approach. Unlike the
falsified global gain and cap changes, this does not perturb the established
upstream entry or broad midcourse descent.

The hypothesis is that slightly later terminal attenuation tightens the final
bend visible in the successful sheet and crosses the target earlier, lowering
arrival time or mean distance while preserving semantic capture. It is
falsified by loss of capture, return of the approximately `+1.8L` upper exit,
worse mean distance, or a force/moment increase without a shorter route. The
formal CFD outcome is not claimed here; later workers should restore the exact
`0.75L` width if this terminal-only bracket fails.
