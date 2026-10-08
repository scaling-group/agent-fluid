# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of the
  target while the four developed staggered-cylinder streets overlap around
  the second-row target corridor. The sampled released sheets are byte-identical
  and remain outside that useful wake region: the fish actively closes
  diagonally, reaches `6.609L`, then curls sharply nose-up and exits the upper
  boundary without collision, instability, wake entry, or `0.75L` capture.
- All four sampled solver results reproduce the terminal `0.10/0.65`
  allocation anchor exactly (policy-file differences are comments only): score
  `-11.1487`, head travel `(-4.676,+1.798)L`, mean/final range
  `9.342/9.266L`, progress `0.2542`, and release lifetime `70.14`. Mean fish
  velocity `(-0.07075,+0.01712)L/time` versus mean local flow
  `(-0.04945,-0.00064)L/time` confirms active upstream propulsion and a
  controlled positive-y departure rather than passive advection. Finite RMS
  force/moment are `75.55/984.76`; anterior angle/speed reach
  `33.23 deg`/`251.35 deg/time` while the acceleration request remains just
  below the `1600 deg/time^2` soft bound.
- The assigned parent's inherited evaluation tests the structurally distinct
  correction proposed by its worker: a `0.35` body-lateral-velocity gain capped
  at `2 deg`, activated only after the target is more than `1L` rearward and
  both instantaneous and windowed range opening exceed `0.02L/time`. It
  preserves the identical `6.609L` closest approach, showing that the strict
  selector protects the closing leg, but it does not reduce the terminal
  `+1.798L` rise or alter the visible nose-up exit. Instead it worsens score to
  `-11.1768`, upstream travel to `-4.637L`, mean/final range to
  `9.365/9.295L`, and progress to `0.2518`, with effectively unchanged RMS
  force/moment `75.58/984.25`. Body-lateral velocity is therefore not a useful
  recovery direction even after confirmed course loss at this tested scale.
- Earlier inherited evidence already brackets terminal anterior allocation at
  `0.10`, posterior allocation at `0.65`, uniform turn damping around `0.04`,
  the `12 deg` steering ceiling, rearward-bearing authority, global steering
  attenuation, and always-active motion correction. Those mechanisms retain
  the same upper return or damage the approach, so another interpolation would
  not test the missing capability.

## Candidate hypothesis

Preserve the replicated anchor's oscillator, steering gain and limit,
`-0.125` nominal rearward bearing authority, `0.04` turn damping, terminal
`0.10/0.65` allocation, joint guards, and acceleration limiter. Reuse the
strict deep-rearward dual-opening gate that demonstrably leaves the closing leg
unchanged, but replace the ineffective lateral-motion correction with one
bounded structural test: smoothly blend the complete steering-request
multiplier from `+1` to `-1`. At zero recovery gate the evaluated approach is
algebraically identical; at full gate the same target-relative and turn-rate
request is countersteered through the existing `12 deg` saturation. This is a
late command reversal, not another global rearward-bearing or derivative-gain
interpolation.

The hypothesis is supported only if evaluation retains roughly `-4.68L`
upstream travel and the `6.61L` approach, then breaks or delays the nose-up
return, lowers the `+1.80L` terminal rise, or improves mean/final range and
lifetime without materially exceeding the anchor's roughly `76/985` RMS load
scale. It is falsified if the recovery gate leaks into the closing leg, the
zero-crossing/reversal repeats either boundary return without navigation gain,
or joint/load excursions rise. The controller uses only normalized body-frame
target geometry and range rates, recent turn, and joint state; it contains no
fixed coordinate, clock, route, prescribed inflow, remote wake probe,
target-station signal, or omitted-shelf dependency. Formal CFD remains
deferred to EvE.
