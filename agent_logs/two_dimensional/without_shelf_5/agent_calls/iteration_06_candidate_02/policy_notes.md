# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet fixes the common initial condition: the fish is held
  at the upper-right release pose while four staggered cylinder streets develop
  and merge around the target. It cannot distinguish candidate quality.
- The released gain-`1.7`, `1.725`, and `1.9` sheets all show active propulsion,
  not passive advection. Each fish makes an early left-down heading correction,
  leaves a dense alternating tail trail, enters the developed wake corridor,
  and crosses the `0.75L` ring without collision, exit, or instability. No
  sampled solver is a semantic failure, so the two finite regressions are the
  informative negative comparators; inherited target-blind exit and unstable
  mixed-feedback results remain only outer control boundaries.
- Gain `1.7` is the strongest finite anchor and has three identical sampled
  rollouts: capture at `39.710`, mean distance `1.874L`, total command energy
  `54703.2`, power proxy `4092.5`, relative-crossflow RMS `0.2265`, and
  force/moment RMS `38.40/618.59`. Embedded wake diagnostics report head
  displacement `(-10.913,-4.360)L` and maximum joint angles `0.507/0.528` rad.
- Gain `1.9` preserves the visible route and capture but its final approach is
  slightly flatter, consistent with less downward head displacement
  (`-4.224L`). It arrives at `40.034`, raises mean distance to `1.901L`, total
  energy to `54954.5`, power to `4136.9`, crossflow RMS to `0.2329`,
  force/moment RMS to `41.31/657.28`, and joint excursions to `0.523/0.548`
  rad. The lower command-energy mean is outweighed by the longer episode and
  worse navigation, total effort, and loads.
- The inherited gain-`1.725` rollout is an even stronger negative result. Its
  visually similar turn-then-diagonal path is slowest at `40.832`, with mean
  distance `1.915L`, energy `56614.5`, power `4263.5`, crossflow RMS `0.2364`,
  force/moment RMS `42.50/674.61`, and joint excursions `0.526/0.556` rad.
  All tested gains touch the same velocity and acceleration envelopes. This
  falsifies sparse local interpolation above `1.7`; proximity in gain is not
  evidence of proximity in wake-coupled performance.

## Candidate hypothesis

Restore only `steering_gain` from the regressed prefill value `1.9` to the
exact measured anchor `1.7`. Preserve the evaluated `0.55`-period, 28-degree
oscillator, posterior phase lag, positive two-joint bearing distribution, and
12-degree bounded curvature. This produces one evidence-backed recovery
candidate rather than another unsupported sub-step or a new feedback mechanism.

The later CFD rollout should reproduce target capture near `39.710`, mean
distance near `1.874L`, relative-crossflow RMS near `0.2265`, and force/moment
RMS near `38.40/618.59`. Loss of capture, materially later arrival, mean
distance above `1.901L`, or loads approaching the gain-`1.9` result would
falsify deterministic recovery and require a repeat of the `1.7` anchor before
probing one separately bounded axis.
