# Multi-wake candidate diagnosis and hypothesis

## Evidence boundary and visual diagnosis

- The assigned parent identifies the `20 deg`, `0.67`-period phase-shell
  controller with `0.65/0.80` posterior lag/damping and bounded negative
  bearing/rate bias as the fixed-prewarm local incumbent. The shared prewarm
  sheet is byte-identical for all four sampled policies: the fish is held high
  and downstream/right while the four staggered-cylinder streets develop and
  overlap through the target corridor. It is common initial-condition evidence,
  not a policy comparison.
- The inherited matched `19 deg`, bearing-scale `0.30` horizon miss is the most
  informative failure. Its released sheet shows a broad turn and productive
  upstream-left swimming, but it remains to the right of the target after the
  full `300` release units. Metrics agree: it ends at its `5.812L` minimum,
  travels `(-5.846,-4.282)L`, and samples only `-0.00682` mean local x-flow.
  This is inadequate corridor acquisition rather than collision, instability,
  or gross advection; the still weaker inherited controller exited downstream
  after `16.747` with `+2.172L` head-x travel.
- The replicated `20 deg`, scale-`0.30` incumbent straightens into the central
  wake and reaches the target from the right at `266.255`, with `0.749L`
  final/minimum distance and `-11.031L` head-x travel. Its mean head velocity
  `(-0.04144,-0.01765)` nearly matches mean local flow
  `(-0.03889,-0.02029)`, so the gait primarily selects and retains a useful
  reverse-flow corridor rather than sustaining large speed relative to water.
- The best current sample changes only anterior amplitude and its inactive
  guard: `20.25 deg` and `31.2 rad/time^2` at the same period, posterior
  phasing, and scale `0.30`. Its sheet keeps the same broad release turn but
  straightens and advances through the wake sooner, reaching at `244.547` and
  reducing mean distance from `7.218L` to `6.452L`. Mean upstream velocity
  increases from `-0.04144` to `-0.04443`; the non-flow contribution is also
  larger (`0.00793` versus `0.00254` mean relative x-flow). Diagnostics remain
  finite: maximum anterior acceleration is `31.055`, below the `31.2` policy
  guard and `31.416` episode cap; RMS force is unchanged (`18.263`), while RMS
  moment rises modestly from `353.21` to `362.21` and relative crossflow from
  `0.13191` to `0.13437`.
- The assigned scale-`0.28` prefill supplies a separate one-axis negative
  result. Against the otherwise identical `20 deg`, scale-`0.30` incumbent it
  reaches only `3.36` release units earlier but worsens mean distance by
  `0.894L` and score by `0.896`; its released sheet follows a longer lower
  excursion before corridor entry. Sharpening bearing response therefore did
  not produce the earlier, cleaner alignment hypothesized in its inherited
  optimizer log. The current fixed-prewarm samples do not justify combining
  that change with the successful amplitude interpolation.

## Candidate hypothesis

Replace the assigned scale-`0.28`, `20 deg` prefill with the complete sampled
best bundle: `20.25 deg` anterior shell, `0.67` period, `0.65/0.80` posterior
lag/damping, scale-`0.30` bounded bearing/rate correction, and the policy-owned
`31.2 rad/time^2` guard. This is one fixed-morphology candidate and uses only
normalized body-frame target feedback and joint state; it introduces no route,
coordinate, target identity, or time signal.

Under the certified prewarm it should reproduce capture near `244.55`, preserve
negative head-x transport, and keep the local guard inactive. Do not increase
amplitude further in this candidate: at this period `20.5 deg` already has a
nominal acceleration just beyond the hard envelope, and the positive
`20 -> 20.25 deg` interpolation has not established monotonicity beyond its
sample. Falsify the candidate if capture is lost or later than the replicated
`20 deg` anchor, approach rebounds, the guard becomes active, or force/moment
growth outweighs the distance improvement. A later distinct wake phase is
also required before treating this fixed-prewarm result as robust.
