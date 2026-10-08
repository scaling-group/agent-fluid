# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while four developed staggered-cylinder streets overlap through the
  target corridor. The released sheets for both sampled terminal allocations
  remain above and to the right of that corridor: each fish actively swims a
  diagonal upstream leg, then bends sharply nose-up and exits the upper domain
  without wake or target entry. Mean head x velocity is about
  `-0.0704--0.0708L/time` versus mean local flow `-0.0492--0.0494`, while mean
  y velocity is `+0.0171` versus near-zero mean local y flow, so the closing
  leg is self-propelled and the terminal upward departure is controlled motion,
  not passive wake advection.
- The partial dual-rate-gated anterior unload to `0.10` remains the strongest
  sampled finite policy. It scores `-11.1487`, moves the head
  `(-4.676,+1.798)L`, reaches `6.609L`, and has mean/final range
  `9.342/9.266L` with progress `0.2542`. Its RMS force/moment are
  `75.55/984.76`; anterior angle and speed peak at `33.23 deg` and
  `251.35 deg/time`, while posterior extrema are `25.93 deg` and
  `191.21 deg/time`.
- Three independent full-unload samples (`terminal_anterior_steering_fraction
  =0.0`) are numerically identical and retain the same visible upper-exit
  topology. Relative to the partial unload, full unloading slightly reduces
  anterior angle/speed to `33.11 deg`/`249.86 deg/time` and RMS force/moment to
  `75.48/982.10`, but worsens score to `-11.1649`, head-x travel to `-4.653L`,
  mean/final range to `9.355/9.283L`, and progress to `0.2528`; minimum range is
  unchanged. The posterior angle, speed, and peak action are exactly unchanged.
  Thus more anterior attenuation trades away navigation for a small load
  reduction and is not a terminal recovery mechanism.
- Inherited logs already close global steering attenuation, stronger or weaker
  rearward bearing, added turn damping, conditional overspeed damping,
  full-circle bearing, short-window opening attenuation, and always-active
  lateral-velocity feedback. The only locally positive structure is the strict
  more-than-`1L`-rearward, simultaneous instantaneous-and-windowed opening gate;
  its benefit is bounded to partial anterior allocation and does not cure the
  exit.

## Candidate hypothesis

Preserve the best sampled policy throughout its demonstrated closing leg and
retain its terminal anterior fraction at the evaluated `0.10`. Under the same
strict dual-rate recovery gate only, reduce posterior steering allocation from
the nominal `0.65` to `0.55`. At a fully active gate the new `0.10 + 0.55`
terminal allocation has the same total `0.65` steering fraction as the failed
full-anterior-unload sample's `0.0 + 0.65`, but shifts `0.10` of authority from
the posterior joint back to the anterior joint. This is a controlled test of
allocation, not another global authority reduction: it preserves the anterior
fraction that gave the best navigation while acting on the posterior branch
whose extrema and command were untouched by the anterior-only bracket.

The hypothesis is supported only if the candidate retains about `-4.68L`
upstream head travel and the `6.61L` approach, then delays or removes the
nose-up return, improves final or mean range, and keeps RMS force/moment at or
below roughly `76/985`. It is falsified if posterior attenuation damages the
traveling bend, loses the closing leg, transfers speed/load to the anterior
joint, produces a lower return, or repeats the upper exit without a navigation
gain. Even a finite improvement without wake entry would support only terminal
course shaping, not wake exploitation or tight capture. The policy uses only
normalized body-frame target projection and range rates, joint state, and
measured recent turn; it contains no coordinate, clock, route, prescribed
inflow, remote probe, target-station signal, or omitted-shelf dependency. Its
CFD result is deferred to EvE and is not claimed here.
