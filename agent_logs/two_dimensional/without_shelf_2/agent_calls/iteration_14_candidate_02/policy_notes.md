# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  staggered cylinders while their interacting streets develop into the common
  release field. The four sampled prewarm sheets are byte-identical, as the
  task contract predicts for the certified snapshot.
- The released sheets are also byte-identical across all four sampled solver
  examples. From release, the fish turns from the upper-right start, advances
  diagonally left through the developed street, passes below the target late,
  and then bends back into the `0.75L` capture circle without collision or
  domain exit. Thus these are replications of one route, not four visual
  response points: the source policies have identical executable expressions
  and parameter values and differ only in comments.
- The route is not passive advection. Mean fish velocity is
  `(-0.14784,-0.05607)` while mean local flow is `(-0.08219,-0.09188)`, giving
  `0.06565` mean upstream-relative x speed. It reaches in `73.859` time units
  with `2.480L` mean distance and `0.9397` progress. This agrees with the
  visible wake crossing and target closure.
- The maneuver remains finite but has little unused command margin: both
  accelerations attain the exact `28` guard, posterior speed peaks at `3.323`,
  command energy is `51797`, and RMS force/moment are `24.94/410.68`. The late
  lower detour and corrective turn are therefore the clearest remaining visual
  route feature; lowering/interpolating guards or increasing constant damping
  has already produced deeper, slower, more highly loaded routes in inherited
  evidence.
- No sampled solver in this workspace supplies a failure keyframe: all four
  terminate at the target. The informative failure boundary is consequently
  limited to the inherited, already-anchored diagnosis of the negative-sign,
  higher-amplitude controller that coiled and became unstable after `4.45`
  units with extreme crossflow and loads. I do not infer any additional visual
  detail from its score-only log.
- Inherited score-only results include finite alternatives with `73.062` and
  `72.699` arrivals and lower loads, but their policy mechanisms are absent.
  They are Pareto benchmarks, not grounds for reconstructing parameters.

## Single-candidate hypothesis

Preserve the replicated `0.75` period, `22 deg` oscillator, `2.1` restoration
gain, pure-bearing `0.75/10 deg` anterior steering, `0.55` lag, `0.65` damping,
and common `28/28` guard. Change only `tail_steering_gain` from `0.60` to
`0.65`. At saturated anterior steering this adds at most `0.5 deg` of bounded
posterior mean-curvature target, while leaving oscillatory propulsion and
command authority unchanged. The expected effect is a quicker lower-to-target
heading correction and a smaller distance integral without the guard, damping,
or restoration-gain route branches already falsified by inherited evidence.

Falsification is direct: reject the mechanism if it loses target capture,
selects a deeper lower route, slows arrival relative to `73.859`, reduces
upstream-relative propulsion, or raises effort and force/moment without a
corroborating closure improvement. Because the available sheets share one
prewarm phase, even a positive result would remain specific to this common
snapshot until a held-out wake phase or geometry reproduces it.
