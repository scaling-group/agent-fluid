# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held in the upper-right far field
  while the four staggered-cylinder streets develop around and downstream of
  the second-row target. The four sampled released sheets have identical file
  hashes and show the same finite failure: the fish supplies a traveling body
  wave and makes a useful diagonal upstream/targetward leg, remains outside
  the developed wake corridor, then curls sharply nose-up and leaves through
  the upper boundary. It never approaches the `0.75L` capture disk or collides
  with a cylinder, so the visible terminal bend is controlled course loss, not
  productive wake interaction.
- The replicated `0.10/0.65` dual-opening allocation anchor is partly
  self-propelled. Its mean velocity is `(-0.07075,+0.01712)L/time` versus mean
  local flow `(-0.04945,-0.00064)L/time`; the useful upstream component exceeds
  advection, while its `+1.798L` terminal rise occurs against almost zero mean
  crossflow. It reaches `6.609L`, then opens to `9.266L` final range and exits
  after `70.14` released time with score `-11.1487`, progress `0.2542`, and
  RMS force/moment `75.55/984.76`. Anterior speed reaches
  `251.35 deg/time` and action reaches about `1592 deg/time^2`, but the rollout
  stays finite; this supports preserving its approach gait and guards.
- The assigned-parent logs contain the first evaluation of a structurally
  gated motion term. Subtracting body-lateral velocity at gain `0.35`, capped
  at `2 deg`, only after the target is deeply rearward and both instantaneous
  and windowed range rates show opening did not arrest the turn. Its keyframes
  retain the same nose-up upper exit and the same `6.609L` closest range and
  `+1.798L` rise; score worsens to `-11.1768`, upstream travel to `-4.637L`,
  mean/final range to `9.365/9.295L`, and progress to `0.2518`. RMS loads and
  joint extrema are essentially unchanged. Thus the selector can keep a new
  term off the closing leg, but lateral velocity at this measured scale does
  not identify or brake the terminal curvature.
- Earlier inherited brackets already reject global changes to the `12 deg`
  steering ceiling, nearby fixed turn damping, rearward bearing authority,
  terminal joint allocation, and always-active lateral-velocity feedback.
  Another interpolation on those axes would not test a new control mechanism.

## Candidate hypothesis

Preserve the replicated anchor's oscillator, `-0.125` rearward bearing,
`0.60` bearing gain, `12 deg` steering ceiling, `0.04` recent-turn damping,
terminal `0.10/0.65` allocation, joint guards, and smooth acceleration limit.
Add one owned parameter, `terminal_steering_fraction=0.0`, and use the existing
strict deep-rearward dual-opening gate to continuously remove the entire mean
steering bias only after confirmed range opening. At zero gate the evaluated
closing controller is algebraically unchanged. At full gate both anterior and
posterior mean-curvature biases vanish while the zero-mean traveling oscillator
and all protection remain active. This tests whether the terminal return is
sustained by commanded mean curvature after the target has been lost, rather
than by lateral translation that the failed `2 deg` motion brake could oppose.

The hypothesis is supported only if the candidate retains about `-4.68L`
upstream travel and the `6.61L` closest approach, then reduces the `+1.80L`
rise, delays or removes the nose-up return, or improves mean/final range without
raising the anchor's roughly `76/985` RMS load scale. It is falsified if the
gate leaks into and shortens the closing leg, neutral steering permits a lower
boundary return, or the same upper exit recurs without navigation benefit.
This is not a claim of same-worker CFD improvement. The candidate uses only
normalized body-frame target projection and range rates, recent turn, and
joint state; it contains no coordinate, clock, route, prescribed inflow,
remote probe, target-station signal, or omitted-shelf dependency. Formal CFD
remains deferred to EvE.
