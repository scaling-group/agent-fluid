# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The identical shared prewarm sheets show the fish held above and downstream
  of the target while four developed staggered-cylinder streets overlap through
  the target corridor. In the released sheets, both the strongest partial
  anterior-unload policy and the replicated full-unload policy stay outside
  that corridor: each swims a diagonal upstream closing leg, curls nose-up,
  and exits the upper boundary without wake entry or target capture.
- The motion is actively controlled rather than passive advection. The
  strongest sampled `terminal_anterior_steering_fraction=0.10` policy moves the
  head `(-4.676,+1.798)L`; its mean velocity is
  `(-0.07075,+0.01712)` versus mean local flow
  `(-0.04945,-0.00064)`. Its `6.609L` minimum range followed by a
  `9.266L` final range confirms a controlled boundary return after useful
  self-propelled closing, not wake exploitation.
- Partial anterior unloading is the reproducible local anchor. Two equivalent
  `0.10` samples score `-11.1487`, with mean/final range
  `9.342/9.266L`, progress `0.2542`, and RMS force/moment
  `75.55/984.76`. Two equivalent full-unload (`0.0`) samples preserve the same
  visible return but worsen score to `-11.1649`, head-x travel to `-4.653L`,
  mean/final range to `9.355/9.283L`, and progress to `0.2528`. They buy only
  small reductions in anterior speed and RMS moment; posterior extrema remain
  unchanged.
- The assigned parent's inherited optimizer log supplies the missing
  posterior-allocation result. With anterior allocation restored to `0.10`,
  conditionally reducing posterior allocation from `0.65` to `0.55` again
  leaves the nose-up exit visually unchanged and is worse than both sampled
  anchors: score `-11.2126`, head-x travel `-4.593L`, mean/final range
  `9.393/9.332L`, and progress `0.2489`. Its RMS force/moment
  `75.53/982.44` and unchanged `6.609L` closest range show no compensating load
  or approach benefit. Together with the full-anterior-unload result, the two
  equal-total-allocation cases (`0.0+0.65` and `0.10+0.55`) show that preserving
  posterior authority matters more than preserving the same total terminal
  bias.
- Inherited guidance already closes global steering-ceiling changes, uniform
  turn-damping interpolation, rearward-bearing interpolation, full-circle
  bearing, conditional overspeed damping, and always-active lateral-velocity
  correction in this far-field regime. The current result additionally closes
  posterior attenuation as a recovery mechanism. A strict deep-rearward,
  simultaneous instantaneous-and-windowed range-opening selector remains the
  only supported way to isolate a new terminal allocation test from the useful
  closing leg.

## Candidate hypothesis

Preserve the strongest sampled controller through its demonstrated approach:
the angle-only oscillator, `-0.125` rearward bearing authority, `0.60` bearing
gain, `12 deg` steering limit, fixed `0.04` recent-turn damping, joint guards,
soft acceleration limit, and terminal anterior fraction `0.10`. Under the
existing strict dual-opening recovery gate only, increase posterior steering
allocation from the nominal `0.65` to `0.75`. This is the opposite-side
controlled test motivated by the inherited `0.55` failure: the candidate does
not alter approach behavior, activation conditions, or anterior allocation,
and adds at most `0.10` of bounded posterior steering authority after the
target is more than `1L` rearward and range is opening on both measured scales.

The hypothesis is supported if the candidate retains approximately `-4.68L`
upstream travel and the `6.61L` approach, then improves mean or final range,
progress, lifetime, or visible return topology relative to the `0.65` anchor
without raising RMS force/moment materially above about `76/985`. It is
falsified if stronger posterior authority loses the closing leg, raises joint
or load excursions, produces a lower return, or repeats the upper exit without
a navigation improvement. A finite gain without wake entry would support only
terminal course shaping, not wake exploitation or `0.75L` capture. The policy
uses normalized body-frame target projection and range rates, joint state, and
measured recent turn; it contains no coordinate, clock, route, prescribed
inflow, remote probe, target-station signal, or omitted-shelf dependency. Its
CFD outcome is deferred to EvE and is not claimed as present evidence.
