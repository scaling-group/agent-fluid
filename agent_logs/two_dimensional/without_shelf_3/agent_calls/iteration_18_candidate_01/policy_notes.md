# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while four developed staggered-cylinder streets overlap through the
  target corridor. In the released sheets for both sampled terminal
  allocations, the fish remains above and to the right of that corridor: it
  actively swims a diagonal upstream closing leg, then bends sharply nose-up
  and exits the upper domain without entering the useful wake region or the
  `0.75L` capture circle. The immediate failure mechanism is controlled
  far-field course loss, not collision, instability, or passive wake advection.
- Flow diagnostics support that visual reading. With the partial terminal
  anterior fraction of `0.10`, mean velocity is
  `(-0.07075,+0.01712)L/time` while mean local flow is
  `(-0.04945,-0.00064)L/time`; the fish supplies upstream motion and its
  terminal positive-y departure is not explained by mean crossflow. It moves
  its head `(-4.676,+1.798)L`, reaches `6.609L`, then opens to `9.266L` and
  exits after `70.14` released time.
- The two sampled partial-unload evaluations are numerically equivalent and
  outperform the two sampled full-unload evaluations on navigation. Changing
  only `terminal_anterior_steering_fraction` from `0.10` to `0.0` worsens score
  from `-11.1487` to `-11.1649`, head-x travel from `-4.676L` to `-4.653L`,
  mean/final range from `9.342/9.266L` to `9.355/9.283L`, and progress from
  `0.2542` to `0.2528`, while leaving minimum range (`6.609L`), terminal
  positive-y travel, and the visible upper-exit topology unchanged.
- Full unload does make a small load/state trade: inherited diagnostics put
  partial versus full anterior angle at `33.23` versus `33.11 deg`, anterior
  speed at `251.35` versus `249.86 deg/time`, and RMS force/moment at
  `75.55/984.76` versus `75.48/982.10`. The posterior extrema are unchanged.
  Inherited optimizer logs report a third equivalent full-unload evaluation,
  so the navigation loss is a reproduced negative result rather than evidence
  for continuing attenuation.
- Inherited logs already falsify global steering attenuation, nearby fixed
  turn-damping changes, stronger/weaker/delayed/full-circle rearward bearing,
  conditional overspeed damping, opening-only attenuation, and always-active
  lateral-velocity correction in this far-field regime. The only locally
  positive structure is the strict target-more-than-`1L`-rearward selector
  requiring simultaneous instantaneous and windowed range opening, bounded to
  a partial anterior unload. This evidence does not establish wake exploitation
  or tight capture.

## Candidate hypothesis

Restore the strongest sampled policy by changing only
`terminal_anterior_steering_fraction` from the assigned full-unload parent
value `0.0` to the evaluated `0.10`. Preserve the oscillator, `-0.125`
rearward bearing authority, `0.60` bearing gain, `12 deg` steering ceiling,
fixed `0.04` recent-turn damping, nominal posterior `0.65` allocation, joint
guards, acceleration limiter, and strict deep-rearward dual-opening selector.
This is one isolated exploitation candidate: it does not combine the rollback
with another mechanism whose effect would be confounded.

The hypothesis is supported if reevaluation recovers approximately `-4.68L`
upstream head travel, the `6.61L` closest approach, `9.342/9.266L` mean/final
range, `0.254` progress, and RMS force/moment near `76/985`, improving
navigation over the replicated `0.0` parent. It remains falsified as a complete
task policy by another upper-domain exit or failure to enter the wake and
target. The policy uses only normalized body-frame target projection and range
rates, recent turn, and joint state; it contains no fixed coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Its CFD result is deferred to EvE and is not claimed as present
evidence.
