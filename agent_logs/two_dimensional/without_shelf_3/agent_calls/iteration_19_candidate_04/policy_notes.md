# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held above and downstream of the
  target while the four developed staggered-cylinder streets overlap around
  the second-row target corridor. The released anchor and posterior-boost
  sheets never reach that corridor: both make an active diagonal upstream leg,
  curl sharply nose-up after their closest approach, and exit the upper domain
  without collision, instability, wake entry, or `0.75L` capture. The large
  terminal bend is wasteful course reversal rather than productive lateral
  oscillation in the wake.
- Three independently sampled files implement the same terminal
  `0.10/0.65` allocation anchor and reproduce its summary exactly. It scores
  `-11.1487`, moves the head `(-4.676,+1.798)L`, reaches `6.609L`, then opens
  to `9.266L` final range and exits after `70.14` released time. Its mean
  velocity `(-0.07075,+0.01712)` versus local flow
  `(-0.04945,-0.00064)` shows that both the useful upstream leg and failed
  upward departure contain controlled motion rather than passive advection.
  Finite RMS force/moment are `75.55/984.76`; anterior angle/speed reach
  `33.23 deg`/`251.35 deg/time`, while posterior extrema remain near
  `25.93 deg`/`191.21 deg/time`.
- Increasing only the deeply rearward, dual-opening-gated posterior allocation
  from `0.65` to `0.75` is a new negative endpoint. It preserves the same
  `6.609L` closest range and visible upper-exit topology, but worsens score to
  `-11.1780`, upstream head travel to `-4.642L`, mean/final range to
  `9.366/9.296L`, and progress to `0.2518`. RMS force/moment remain essentially
  unchanged at `75.55/984.56`, so the navigation loss does not buy a meaningful
  load benefit. Inherited logs show that decreasing posterior allocation to
  `0.55` was worse as well (`-4.593L` head x, `9.393/9.332L` mean/final range,
  `0.2489` progress), closing simple terminal allocation changes around the
  `0.10/0.65` anchor.
- Inherited evidence also closes global steering-ceiling changes, nearby fixed
  turn-damping interpolation, rearward-bearing rewrites, conditional joint
  overspeed damping, and further anterior unloading. An always-active
  body-lateral-velocity subtraction at gain `0.35`, capped at `2 deg`, damaged
  the approach (`-2.72L` upstream travel and `8.20L` minimum range), repeated
  the upper exit, and raised loads to `78.6/1084`. That result falsifies lateral
  velocity as a release-to-exit correction, but it did not test the inherited
  requirement that a motion term remain inactive on the demonstrated closing
  leg and engage only after sustained range opening.

## Candidate hypothesis

Preserve the replicated anchor's oscillator, `-0.125` rearward bearing,
`0.60` bearing gain, `12 deg` steering ceiling, fixed `0.04` recent-turn
damping, terminal `0.10/0.65` joint allocation, guards, and acceleration
limiter. Add one structural term under the existing strict recovery gate: only
when the target is more than `1L` rearward and both instantaneous and windowed
range rates exceed the `0.02L/time` opening threshold, subtract a bounded
body-lateral-velocity correction from the steering request. Reuse the tested
gain `0.35` and `2 deg` ceiling so this isolates the selector rather than a new
gain scale. At zero gate the evaluated closing law is algebraically unchanged;
at full gate the correction opposes measured lateral motion but cannot exceed
`2 deg` before the existing `12 deg` steering saturation.

This is a falsifiable test of whether body-lateral motion becomes informative
only after confirmed course loss, not a claim of same-worker CFD improvement.
It is supported only if the candidate retains about `-4.68L` upstream travel
and the `6.61L` approach, then reduces the `+1.80L` terminal rise, delays or
removes the nose-up return, or improves mean/final range without exceeding the
anchor's roughly `76/985` RMS load scale. It is falsified if the gate leaks
into and shortens the closing leg, repeats either boundary return without a
navigation gain, redirects the fish into a lower return, or raises joint/load
excursions. The policy uses only normalized body-frame target geometry and
range rates, body velocity, recent turn, and joint state; it contains no fixed
coordinate, clock, route, prescribed inflow, remote wake probe, target-station
signal, or omitted-shelf dependency. Formal CFD remains deferred to EvE.
