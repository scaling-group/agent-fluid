# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while the four staggered-cylinder streets develop through the target
  corridor. Every released sheet stays above and to the right of that useful
  wake region. The fish makes an active diagonal upstream leg, turns sharply
  nose-up after closest approach, and exits the upper boundary without wake or
  target entry. In the strongest sample, mean head x velocity is about
  `-0.06666L/time` versus mean local flow `-0.04945`, while mean head y velocity
  is about `+0.02564L/time` versus local flow `-0.00064`; both the approach and
  the terminal upward departure are controlled motion rather than passive
  advection.
- The sampled `terminal_anterior_steering_fraction=0.10` policy remains the
  strongest finite result. It moves the head `(-4.676,+1.798)L`, reaches
  `6.609L`, records mean/final range `9.342/9.266L`, progress `0.2542`, and RMS
  force/moment `75.55/984.76`, then repeats the nose-up upper exit after
  `70.14` released time. Inherited diagnostics show that, relative to the
  fixed-`0.35` anterior allocation, its strict deep-rearward dual-opening gate
  lowered anterior angle/speed and moment while preserving the upstream leg.
- Three independently sampled files implementing full anterior unload
  (`terminal_anterior_steering_fraction=0.00`) produce byte-identical
  keyframes and metrics. Against the `0.10` partial unload, they keep the same
  `6.609L` minimum and upper-exit topology, but slightly reduce head-x travel
  to `-4.653L`, progress to `0.2528`, and worsen mean/final range to
  `9.355/9.283L`. RMS force/moment fall only marginally to `75.48/982.10`, and
  lifetime changes to `70.23`. Thus continuing anterior allocation below
  `0.10` is a reproducible negative navigation result, not a recovery or a
  meaningful load-control gain.
- The current and inherited evidence also closes simple bearing, damping, and
  selector rewrites: wider, zero, delayed, and full-circle rearward bearing,
  added turn damping, conditional overspeed damping, short-window opening
  attenuation, and always-active lateral-velocity feedback all retain a
  boundary return or damage the demonstrated approach. The remaining steering
  asymmetry is structural: even at full anterior unload the strict terminal
  mode leaves the fixed posterior fraction `0.65` active, so total terminal
  mean-curvature allocation changes only from `0.75` to `0.65` and the
  posterior bias is never tested by the sampled continuation.
- The compact solver copies do not contain `wake_diagnostics.json`; visual
  claims were therefore cross-checked against the in-workspace
  `wake_metrics.csv` summaries and against the inherited optimizer diagnostics
  for joint extrema. No external artifact path or omitted research shelf was
  read.

## Candidate hypothesis

Restore the strongest evaluated `0.10` terminal anterior fraction and preserve
its oscillator, `-0.125` rearward bearing authority, `0.60` bearing gain,
`12 deg` steering ceiling, fixed `0.04` turn damping, joint guards,
acceleration limiter, and three-factor terminal selector. Add one bounded
terminal allocation parameter: smoothly unload the posterior steering fraction
from its evaluated `0.65` to `0.00` only when the target is more than `1L`
rearward and both instantaneous and windowed range rates show opening faster
than `0.02L/time`. The anterior retains the locally supported `0.10` residual,
and removing posterior mean bias does not remove the posterior traveling-gait
terms `-centered_q1` and velocity lag.

This isolates whether the residual posterior mean curvature sustains the
upper return after anterior-only continuation has saturated. It should be
exactly the evaluated best controller during the useful closing leg, then
reduce terminal total steering allocation from `0.75` toward `0.10` without
reversing curvature. The hypothesis is supported only if the rollout remains
finite, retains about `-4.65L` upstream travel and a `6.65L` or better closest
approach, and materially improves final/mean range or removes the upper return
without exceeding roughly `76/1005` RMS force/moment. It is falsified if the
gate erodes the closing leg, propulsion collapses, a lower return appears, the
upper exit repeats without material navigation gain, posterior oscillation is
destabilized, or loads rise. The policy uses only normalized body-frame target
projection and range rates, joint state, and measured recent turn; it contains
no coordinate, clock, route, prescribed inflow, remote probe, target-station
signal, or omitted-shelf dependency. Its CFD result is deferred to EvE and is
not claimed here.
