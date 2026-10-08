# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held above and downstream of the
  target while four staggered-cylinder streets develop and overlap through the
  second-row target corridor. The released sheets for the strongest partial
  terminal unload and the sampled posterior-boost failure remain above and to
  the right of that corridor. Both show an active diagonal upstream closing
  leg followed by a tight nose-up return and upper-boundary exit; neither fish
  enters the developed wake region or the `0.75L` capture disk.
- The strongest sampled `0.10/0.65` terminal allocation is partly
  self-propelled rather than passively advected. Its mean velocity is
  `(-0.07075,+0.01712)L/time` versus mean local flow
  `(-0.04945,-0.00064)L/time`, and it moves the head
  `(-4.676,+1.798)L`. Its `6.609L` minimum range followed by `9.266L` final
  range and a release lifetime of `70.14` identifies controlled far-field
  course loss, not wake exploitation. The finite RMS force/moment
  `75.55/984.76`, anterior `33.23 deg`/`251.35 deg/time` extrema, and visible
  terminal fold also rule out treating the loop as productive lateral
  oscillation.
- Three evaluations of the same partial-unload law are numerically identical,
  so it is a reproducible approach anchor rather than a lucky wake phase. The
  current posterior-boost sample changes only the terminal posterior fraction
  from `0.65` to `0.75`. It keeps the same `6.609L` minimum, visible loop, and
  upper exit but worsens score from `-11.1487` to `-11.1780`, head-x travel
  from `-4.676L` to `-4.642L`, mean/final range from `9.342/9.266L` to
  `9.366/9.296L`, and progress from `0.2542` to `0.2518`. Its RMS force/moment
  (`75.55/984.56`) and posterior angle/speed extrema (`25.93 deg` and
  `191.21 deg/time`) are effectively unchanged, so extra posterior allocation
  is not a terminal recovery mechanism.
- Assigned-parent logs provide the opposite allocation endpoints. Complete
  anterior unload to `0.0` and posterior attenuation to `0.55` both retain the
  upper exit and unchanged `6.609L` closest range while worsening navigation.
  Together with the current `0.75` posterior result, this brackets allocation
  changes around the `0.10/0.65` anchor. Inherited global or abeam-activated
  turn-damping changes also damaged the useful approach, but no evidence has
  tested turn damping under the later, strict target-more-than-`1L`-rearward
  selector requiring both instantaneous and windowed range opening.
- The sampled observation JSON embeds the wake diagnostics even though a
  standalone `wake_diagnostics.json` is not copied into this workspace. Those
  diagnostics agree with the keyframes and aggregate CSV: the fish supplies
  upstream relative motion, experiences near-zero mean local crossflow, stays
  finite, and exits by controlled positive-y motion rather than collision or
  numerical instability.

## Candidate hypothesis

Preserve the replicated best oscillator, `-0.125` rearward bearing authority,
`0.60` bearing gain, `12 deg` steering ceiling, `0.10/0.65` terminal joint
allocation, guards, and smooth acceleration limit. Keep the evaluated base
recent-turn damping at `0.04` throughout the closing leg, then add one more
bounded `0.04` of turn-rate damping multiplied by the existing deep-rearward,
dual-opening recovery gate. At full activation the effective damping doubles
to `0.08`; it remains exactly the sampled `0.04` before sustained range
opening. This is one isolated test of arresting the already-established
terminal angular motion, distinct from another joint-allocation or bearing
rewrite and from the broader abeam damping selectors that activated too early.

The hypothesis is supported only if the rollout retains about `-4.68L`
upstream head travel and the `6.61L` closest approach, then materially reduces
the `+1.80L` terminal y departure, delays or removes the upper return, improves
mean/final range, and does not exceed the sampled `76/985` RMS load scale. It
is falsified if the strict gate still erodes the closing leg, the same upper
exit persists without a navigation gain, a lower full return appears, joint
saturation or loads rise, or propulsion collapses. Even a finite improvement
without wake entry would support only late course shaping, not wake use or
tight capture. The policy uses normalized body-frame target geometry and
range rates, measured recent turn, and joint state; it contains no coordinate,
clock, route, prescribed inflow, remote probe, target-station signal, or
omitted-shelf dependency. Formal CFD remains deferred to EvE.
