# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is byte-identical across the four sampled solvers.
  It shows the fish held above and downstream of the target while the four
  staggered-cylinder streets develop through the target corridor. The released
  sheets for both sampled terminal allocations remain above and to the right of
  that corridor: the fish swims a diagonal upstream closing leg, turns sharply
  nose-up after its closest approach, and exits the upper boundary without wake
  entry or target capture.
- The approach and terminal departure are controlled motion rather than simple
  advection. For the stronger `terminal_anterior_steering_fraction=0.10`
  sample, mean velocity is `(-0.07075,+0.01712)` while mean local flow is
  `(-0.04945,-0.00064)`. Its `6.609L` minimum range followed by `9.266L` final
  range and `+1.798L` head-y displacement confirms a self-propelled approach
  followed by failed upper course recovery.
- Two sampled `0.10` evaluations reproduce score `-11.1487`, `-4.676L`
  upstream head travel, `9.342/9.266L` mean/final range, `0.2542` progress,
  and RMS force/moment `75.55/984.76`. Two sampled full-unload (`0.0`)
  evaluations reproduce the same upper-exit sheet and `6.609L` minimum while
  worsening score to `-11.1649`, upstream travel to `-4.653L`, mean/final
  range to `9.355/9.283L`, and progress to `0.2528`. Their small load and
  anterior-speed reductions therefore do not support continuing anterior
  allocation below `0.10`.
- An inherited evaluated candidate kept the `0.10` anterior terminal fraction
  but reduced posterior allocation from `0.65` to `0.55` under the same strict
  gate. Its sheet still makes the nose-up upper exit; score worsens to
  `-11.2126`, upstream travel to `-4.593L`, mean/final range to
  `9.393/9.332L`, and progress to `0.2489`, while RMS force/moment remain
  essentially unchanged at `75.53/982.44`. Posterior attenuation is thus a
  second negative allocation direction, not a recovery mechanism.
- Assigned-parent guidance and inherited logs also rule out global steering or
  damping interpolation, rearward-bearing rewrites, conditional overspeed
  damping, opening-only attenuation, and always-active lateral-velocity
  subtraction. The reusable positive boundary is narrower: preserve the
  `0.10` anchor through its closing leg, and keep any new correction inactive
  until the target is more than `1L` rearward and both instantaneous and
  windowed range rates show opening.

## Candidate hypothesis

Restore the replicated `0.10` terminal anterior allocation and preserve the
oscillator, `-0.125` rearward bearing authority, `0.60` bearing gain, `12 deg`
steering ceiling, fixed `0.04` recent-turn damping, posterior `0.65`
allocation, joint guards, and soft acceleration limit. Add exactly one new
terminal mechanism: subtract a bounded body-lateral-velocity correction from
the steering request only through the existing deep-rearward dual-opening
gate. Use the previously sampled motion-feedback scale (`0.35` gain with a
`2 deg` correction limit), but gate it so it is identically inactive during
the demonstrated closing leg. This isolates whether body sideslip can arrest
the terminal turn without repeating the known damage from always-active
motion feedback or the navigation loss from further joint-allocation changes.

The hypothesis is supported only if the candidate retains roughly `-4.68L`
upstream head travel and the `6.61L` approach, then delays or removes the
nose-up return, improves mean/final range, and keeps RMS force/moment near or
below `76/985`. It is falsified if the correction erodes the closing leg,
repeats either boundary return without better range metrics, or raises joint
excursions or loads. Even a finite gain without wake entry would establish
terminal course shaping only, not wake exploitation or `0.75L` capture. The
policy uses normalized body-frame target geometry, range rates, body velocity,
joint state, and measured recent turn; it contains no coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Its CFD result is deferred to EvE and is not claimed as current
evidence.
