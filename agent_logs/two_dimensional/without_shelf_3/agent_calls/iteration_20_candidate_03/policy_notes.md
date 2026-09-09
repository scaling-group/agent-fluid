# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held above and downstream of the
  target while four staggered-cylinder streets develop and overlap through the
  second-row target corridor. All four current sampled solver sheets are exact
  image and metric replications of the same functional `0.10/0.65` terminal
  allocation law. The fish stays above and to the right of the useful wake,
  makes a diagonal upstream closing leg, then folds into a nose-up turn and
  exits the upper boundary without collision, instability, wake entry, or
  `0.75L` capture.
- The replicated anchor is partly self-propelled, not merely advected. Mean
  head velocity is `(-0.07075,+0.01712)L/time` versus mean local flow
  `(-0.04945,-0.00064)L/time`; head displacement is
  `(-4.676,+1.798)L`. Its `6.609L` minimum followed by `9.266L` final range,
  finite RMS force/moment `75.55/984.76`, and visible terminal fold identify a
  controlled course reversal rather than useful wake-assisted lateral motion.
  Anterior angle/speed reach `33.23 deg`/`251.35 deg/time`, posterior extrema
  stay near `25.93 deg`/`191.21 deg/time`, and the soft acceleration demand
  reaches about `1592 deg/time^2`.
- The assigned parent establishes the strict target-more-than-`1L`-rearward,
  simultaneous instantaneous-and-windowed opening selector as reproducible
  terminal localization: unloading anterior allocation from `0.35` to `0.10`
  improved navigation and RMS moment without changing the `6.609L` minimum or
  upper-exit topology. Inherited full anterior unload and posterior allocation
  tests on both sides of `0.65` all preserve the same minimum and exit while
  worsening navigation, so `0.10/0.65` is bracketed as the allocation anchor.
- The best current finite sheet was compared with the inherited strict-gate
  turn-damping failure. Adding `0.04` recent-turn damping only under the same
  selector leaves the visible loop and joint/action extrema essentially
  unchanged, but worsens score from `-11.149` to `-11.257`, upstream head
  travel from `-4.676L` to `-4.532L`, mean/final range from
  `9.342/9.266L` to `9.429/9.377L`, progress from `0.254` to `0.245`, and RMS
  force/moment to `75.68/987.00`. The inherited gated body-lateral-velocity
  subtraction also retains the `6.609L` minimum and upper exit while worsening
  upstream travel, mean/final range, and progress. These failures show that
  selector localization alone does not make proportional motion attenuation a
  recovery mechanism.

## Candidate hypothesis

Preserve the replicated oscillator, `-0.125` rearward bearing authority,
`0.60` bearing gain, `12 deg` steering ceiling, fixed `0.04` recent-turn
damping, terminal `0.10/0.65` allocation, joint guards, acceleration limiter,
and strict deep-rearward dual-opening selector. Add one owned parameter,
`terminal_steering_fraction=-0.5`, and use the recovery gate to transition the
entire bounded steering bias from its evaluated value to the opposite sign at
half magnitude. At zero gate the demonstrated closing controller remains
exactly unchanged; at full gate the existing `12 deg` steering bound becomes
at most `6 deg` of counter-curvature on both joint biases. This tests a smooth
change of terminal turn topology after attenuation-only mechanisms repeatedly
left the nose-up return intact.

The candidate is supported only if it retains about `-4.68L` upstream head
travel and the `6.61L` approach, then reduces the `+1.80L` terminal rise,
avoids or materially delays the upper exit, improves mean/final range, and
keeps loads near the anchor's `76/985` RMS scale. It is falsified if the gate
damages the closing leg, the same upper return persists, a lower-boundary
return replaces it, posterior saturation grows, or force/moment loads rise.
Even a finite course improvement without wake entry would support only gated
terminal curvature reversal, not wake exploitation or tight-radius capture.
The policy uses normalized body-frame target projection and range rates,
measured recent turn, and joint state; it contains no fixed coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Formal CFD remains deferred to EvE.
