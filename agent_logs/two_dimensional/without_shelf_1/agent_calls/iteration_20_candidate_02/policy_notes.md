# Multi-wake visual diagnosis and candidate hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet fixes the initial condition: the held fish begins
above and downstream of the target while four developed, interacting vortex
streets fill the route. The four sampled solver sheets are deterministic copies
of the same successful controller, not a gain sweep. In each, the fish actively
swims upstream into the disturbed corridor, descends, makes a broad bend, and
then crosses the `0.75L` circle after `88.13` release units. Its mean head
velocity in x (`-0.124`) exceeds the upstream local flow (`-0.092`), its head
travels `(-10.925,-4.435)L`, and its mean/minimum distance is
`2.736/0.747L`. RMS relative crossflow and force/moment are
`0.289` and `445/4597`. Posterior angle and both joint rate/command caps are
still reached, so capture does not establish desaturation.

The assigned parent's isolated increase of the additive body-frame cross-track
gain from `0.18` to `0.20` is the informative failure contrast. The released
sheet shows that it retains strong self-propulsion and initially passes close,
but then curls nearly vertical and exits the upper boundary instead of making
the successful final descent. Metrics agree: mean head velocity x improves to
`-0.151`, upstream displacement reaches `-11.03L` in only `76.17` units, and
minimum distance is `1.123L`; nevertheless head-y displacement returns to
`+1.781L`, mean distance regresses to `6.365L`, and RMS force/moment rise to
`490/4800`. The inherited lower-side `0.17` test also restores the upper exit,
but is a weaker approach: it reaches only `-7.31L` upstream and `3.267L`
minimum distance in `84.93` units, with `+1.800L` head-y displacement and
`478/5138` RMS loads. Thus `0.18` is a narrow global-gain arrival point, not a
monotone tuning axis. The useful evidence inside the `0.20` failure is faster
far-field approach; its failed mechanism is retaining the surplus authority
through the close approach.

## Single candidate hypothesis

Preserve the complete reproducibly successful `0.18` controller at distances
up to `3L`. Add only a smooth far-field cross-track surplus: interpolate its
gain from `0.18` at `3L` to `0.20` at `6L`, leaving it at `0.20` farther away.
This never attenuates or replaces the sampled anchor, and it leaves bearing,
body-rate damping, opposing-phase allocation, distance fade, propulsion gait,
and command ceiling unchanged. The schedule uses bounded target-relative
distance rather than elapsed time, global coordinates, or a fixed route.

The falsifiable expectation is to retain the `0.20` branch's faster upstream
approach while recovering the `0.18` branch before the observed close pass,
thereby preserving capture with a release time below `88.13` or mean distance
below `2.736L`. Reject the schedule if capture is lost, the roughly `+1.8L`
upper-exit topology returns, or force/moment rise without a shorter successful
route. The new CFD run occurs after this worker exits, so this is a candidate
hypothesis rather than same-worker outcome evidence.
