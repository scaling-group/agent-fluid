# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is identical across all four sampled solvers. It
  shows the fish held above and downstream of the target while the four
  staggered-cylinder streets develop through the target corridor. The released
  sheets for both the strongest finite sample and the replicated full-unload
  failure remain above and to the right of that corridor: the fish makes a
  diagonal upstream closing leg, then turns nose-up and exits the upper
  boundary without wake entry or target capture.
- This is active rather than passively advected motion. In the strongest
  `terminal_anterior_steering_fraction=0.10` sample, mean velocity is
  `(-0.07075,+0.01712)` while mean local flow is
  `(-0.04945,-0.00064)`. The visible upstream approach has a self-propelled
  component, and the terminal upward motion cannot be attributed to mean
  crossflow. The `6.609L` minimum range followed by a `9.266L` final range and
  upper exit identifies failed course recovery, not useful wake exploitation.
- Three current evaluations of complete terminal anterior unload (`0.0`) are
  equivalent at the summary level and repeat the same visible upper-return
  topology. Relative to the `0.10` sample, full unload worsens score from
  `-11.149` to `-11.165`, upstream head travel from `-4.676L` to `-4.653L`,
  mean/final range from `9.342/9.266L` to `9.355/9.283L`, and progress from
  `0.2542` to `0.2528`, with the same `6.609L` closest range and about
  `+1.798L` terminal y displacement. It does reduce anterior angle/speed from
  `33.23 deg`/`251.35 deg/time` to `33.11 deg`/`249.86 deg/time` and RMS
  moment from `984.8` to `982.1`. Thus the selector is reproducible terminal
  load shaping, but continuing anterior allocation below `0.10` trades away
  navigation without changing the failure mode.
- Inherited optimizer logs rule out applying extra recent-turn damping merely
  at abeam crossing: that broader selector shortened the useful approach.
  They also rule out global damping interpolation, rearward-bearing rewrites,
  conditional overspeed damping, opening-only attenuation, and always-active
  lateral-velocity feedback. With full anterior unload now negative as well,
  no unevaluated continuation is better supported than restoring the strongest
  measured `0.10` allocation anchor.

## Candidate hypothesis

Restore exactly the strongest sampled terminal anterior allocation of `0.10`
while preserving its oscillator, `-0.125` rearward bearing authority, `0.60`
bearing gain, `12 deg` steering ceiling, fixed `0.04` recent-turn damping,
posterior `0.65` allocation, joint guards, soft acceleration limit, and strict
deep-rearward dual-opening selector. This is a one-parameter exploitation
candidate after three replicated evaluations falsified the parent's stronger
`0.0` unload. It deliberately does not combine that rollback with another
bearing, damping, guard, or motion-feedback mechanism whose effect could not
be separated from the restored anchor.

The hypothesis is supported if reevaluation recovers approximately the sampled
`-11.149` score, `-4.68L` upstream head travel, `6.61L` closest approach,
`9.342/9.266L` mean/final range, `0.254` progress, and RMS force/moment near
`76/985`, all better in navigation than the replicated `0.0` parent. It remains
falsified as a complete task policy by the sampled upper-domain exit and lack
of wake or target entry; a replicated finite gain supports terminal shaping
only, not wake exploitation or `0.75L` capture. The policy uses normalized
body-frame target projection and range rates, measured recent turn, and joint
state; it contains no coordinate, clock, route, prescribed inflow, remote wake
probe, target-station signal, or omitted-shelf dependency. Its CFD result is
deferred to EvE and is not claimed as current evidence.
