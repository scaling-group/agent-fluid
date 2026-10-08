# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet establishes only the certified initial condition:
  the fish remains held at the upper-right release pose while the four
  staggered cylinder streets develop and merge around the target. It is common
  across candidates and gives no controller-specific credit.
- All four current solver samples are exact gain-`1.7`, fraction-`0.40`
  replicas. Their released sheets show active propulsion rather than passive
  advection: the fish makes an early left-down turn, sheds a dense alternating
  tail trail, crosses diagonally into the developed wake corridor, and enters
  the `0.75L` target ring without collision, domain exit, or instability. The
  metrics repeat exactly at `39.710` arrival, `1.874L` mean distance,
  `0.2265` relative-crossflow RMS, `38.40/618.59` force/moment RMS, `4092.5`
  power proxy, and `0.507/0.528` rad peak joint angles.
- The inherited fraction-`0.45` rollout is the most informative counterexample
  because the current samples contain no semantic failure. Its keyframes keep
  the same broad self-propelled route and still capture, but do not show the
  hoped-for joint balancing or a cleaner approach. Diagnostics confirm a
  material regression: arrival slows to `43.323`, mean distance rises to
  `2.025L`, relative-crossflow RMS to `0.2456`, force/moment RMS to
  `41.96/709.54`, power to `4557.0`, command energy to `60174.8`, and both
  peak angles rise to `0.544/0.562` rad. Mean velocity also weakens from
  `(-0.274,-0.113)` to `(-0.251,-0.102)`, while both controllers touch the
  same rate and acceleration caps. Thus transferring five percent of the
  bounded steering center anteriorly did not merely move posterior load; it
  degraded the coupled gait and target traverse.
- The inherited gain-`1.725` and gain-`1.9` regressions already rule out
  another small steering-gain interpolation. The target-blind domain exit and
  mixed-feedback instability remain outer safety boundaries, so this candidate
  preserves the measured gain, propulsion oscillator, steering bound, signal
  set, and feedback structure.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, gain-`1.7`
bounded-bearing law, posterior phase lag, damping, and 12-degree total steering
command. Change only `anterior_steering_fraction` from `0.40` to `0.35`. This
is the opposite, equally bounded distribution step from the falsified `0.45`
test. It reallocates at most `0.6` degree of saturated steering center toward
the posterior joint without strengthening the total target curvature. The
hypothesis is that restoring posterior traveling-bend authority will recover
the stronger left-down mean velocity and shorten the wake traverse that the
anterior shift weakened.

The later CFD rollout falsifies this one-axis hypothesis if it loses capture,
arrives no earlier than the `39.710` anchor, raises mean distance above
`1.874L`, or increases the anchor's `0.2265/38.40/618.59` crossflow/force/
moment envelope. Because the posterior joint already has the larger peak
excursion, any navigation gain accompanied by a material rise above its
`0.528`-rad anchor is a load tradeoff rather than a clean improvement. A
positive result remains specific to the certified wake phase and start pose;
the single negative direction sample does not establish monotonicity in the
distribution parameter.
