# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held above and downstream of the target while the four staggered-cylinder
  streets develop across the second-row target corridor. In the released
  sheets the fish never reaches that corridor: it swims diagonally upstream,
  passes through its closest approach, curls sharply nose-up, and exits the
  upper boundary. The last two frames show a large course-reversing bend rather
  than productive lateral oscillation, wake entry, or `0.75L` capture.
- The three sampled `0.10/0.65` terminal-allocation policies produce
  byte-identical released sheets and metrics. Their mean body motion
  `(-0.07075,+0.01712)L/time` differs materially from mean local flow
  `(-0.04945,-0.00064)L/time`, so the useful upstream leg is partly
  self-propelled and the terminal rise is controlled motion rather than passive
  crossflow advection. The `6.609L` minimum followed by `9.266L` final range,
  `+1.798L` head-y travel, and `left_domain` termination identify failed
  far-field course recovery, not useful wake exploitation.
- The sampled posterior-increase policy changes terminal posterior allocation
  from `0.65` to `0.75` under the same strict selector. It visibly repeats the
  upper return and the same `6.609L` minimum while worsening score from
  `-11.1487` to `-11.1780`, upstream head travel from `-4.676L` to `-4.642L`,
  mean/final range from `9.342/9.266L` to `9.366/9.296L`, and progress from
  `0.2542` to `0.2518`; RMS force/moment remain essentially unchanged at
  `75.55/984.56`. Inherited posterior attenuation to `0.55` was worse again
  (`-11.2126`, `-4.593L`, `9.393/9.332L`, progress `0.2489`) with the same
  closest range and topology. Posterior `0.65` is therefore bracketed by two
  negative directions rather than an allocation knob to continue tuning.
- The assigned-parent logs also contain a strict-gated body-lateral-velocity
  correction using gain `0.35` and a `2 deg` limit. It likewise retains the
  `6.609L` minimum and upper exit while worsening score to `-11.1768`, head-x
  travel to `-4.637L`, mean/final range to `9.365/9.295L`, and progress to
  `0.2518`, with no useful load change (`75.58/984.25`). Thus the strict
  selector prevents neither late navigation loss nor makes body sideslip alone
  a valid recovery signal. Earlier inherited evidence already rules out
  always-active sideslip subtraction, broader abeam-gated speed damping,
  uniform turn-damping changes, and further bearing rewrites.
- The strongest `0.10/0.65` anchor still reaches anterior angle/speed
  `33.23 deg`/`251.35 deg/time`, compared with posterior
  `25.93 deg`/`191.21 deg/time`, while anterior action approaches the
  `1600 deg/time^2` soft limit. Partial anterior unloading improved this state
  and the navigation metrics over fixed `0.35`, whereas complete unloading
  traded away navigation for only a small additional speed/load reduction.
  The remaining measured terminal excursion is therefore anterior joint rate,
  but prior broad speed protection shows that any new damping must stay
  inactive during the demonstrated closing leg.

## Candidate hypothesis

Preserve the replicated anchor's oscillator, `-0.125` rearward bearing
authority, `0.60` bearing gain, `12 deg` steering ceiling, fixed `0.04`
recent-turn damping, `0.10/0.65` terminal allocation, joint guards, and soft
acceleration limit. Add one bounded mechanism after the existing target-more-
than-`1L`-rearward, simultaneous instantaneous-and-windowed opening selector:
subtract `1.0 * qd1` from anterior acceleration in proportion to that recovery
gate. At the measured `251 deg/time` anterior excursion, the fully active term
opposes about `251 deg/time^2`, far below the action limit. It is exactly zero
during the useful closing regime and leaves the posterior traveling-bend branch
unchanged.

This isolates late anterior rhythm braking from the failed abeam-gated
overspeed guard: it acts on all terminal anterior rate, but only after both
range scales confirm persistent opening. The hypothesis is supported only if
the rollout retains roughly `-4.68L` upstream head travel and the `6.61L`
approach, materially lowers the `251 deg/time` anterior excursion, delays or
removes the nose-up return, improves mean/final range, and keeps RMS
force/moment near or below `76/985`. It is falsified if the gate activates
early enough to erode the closing leg, the upper or lower boundary return
persists without better range, propulsion collapses, the excursion transfers
to the posterior joint, or loads rise. Even a finite improvement without wake
entry would establish terminal course shaping only, not wake exploitation or
tight capture. The policy uses normalized body-frame target projection and
range rates, recent turn, and joint state; it contains no coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Formal CFD remains deferred to EvE.
