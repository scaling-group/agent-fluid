# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while the four staggered cylinder wakes
  develop and merge around the target. It cannot distinguish controller
  quality.
- The released sheets for steering gains `1.7`, `1.9`, and `1.725` all show
  active propulsion rather than passive advection. Each fish makes an early
  heading correction, leaves a dense alternating tail trail, traverses left
  and down through the developed wake, and reaches the `0.75L` target ring
  without collision, domain exit, or instability. The route topology is
  similar enough that arrival, distance, crossflow, load, and joint metrics
  provide the useful comparison.
- Gain `1.7` is the measured anchor: it reaches at `39.710` with mean distance
  `1.874L`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, power proxy `4092.50`, and maximum joint angles
  `0.507/0.528` rad. Three deterministic gain-`1.9` samples preserve capture
  but regress to `40.034`, `1.901L`, `0.2329`, `41.31/657.28`, `4136.90`,
  and `0.523/0.548` rad respectively.
- The inherited gain-`1.725` rollout is the strongest current negative result.
  It falsifies the prior three-point interpolation despite lying only `0.025`
  above the anchor: arrival worsens to `40.832`, mean distance to `1.915L`,
  relative-crossflow RMS to `0.2364`, force/moment RMS to `42.50/674.61`,
  power proxy to `4263.51`, and maximum joint angles to `0.526/0.556` rad.
  All three gains touch the same rate and acceleration caps, so the regression
  cannot be credited as a gentler actuation regime. It also cannot establish a
  universal discontinuity because every test uses one certified wake phase and
  start pose, but it does show that sparse gain interpolation is not reliable
  evidence for this rollout.
- The assigned guidance and inherited notes retain useful outer boundaries:
  positive bounded two-joint bearing curvature converted the target-blind
  seed's downward exit into capture, while a slower mixed velocity/moment
  controller became unstable. No new evidence supports changing propulsion,
  reversing curvature, or adding unscaled signals here.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, posterior phase
lag, positive two-joint steering distribution, and 12-degree `tanh` bound.
Change only `steering_gain` from the regressed prefill value `1.9` to the exact
measured value `1.7`. This is a restoration to the best finite policy, not an
unsupported interpolation: against the otherwise identical prefill it has a
higher score (`0.002860` versus `-0.024288`), earlier capture, lower mean
distance, lower total command energy, lower crossflow and force/moment loads,
and smaller joint excursions.

The later CFD rollout should falsify the restoration as a robust anchor if an
exact gain-`1.7` repeat loses capture or materially fails to reproduce the
`39.710` arrival, `1.874L` mean distance, `0.2265` relative-crossflow RMS, and
`38.40/618.59` force/moment RMS values. Until replicated evidence supports a
different axis, later workers should avoid fitting or testing another tiny
gain sub-step from these sparse, non-monotonic samples.
