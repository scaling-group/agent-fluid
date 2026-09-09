# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- All four current shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the four staggered cylinder wakes
  develop, merge, and cross the target region. This is the certified common
  initial condition, not candidate-specific evidence.
- The two `1650 deg/time^2` posterior-bound policies and released sheets are
  byte-identical, as are the two `1700 deg/time^2` comparators. Both controllers
  visibly turn the fish left and down, sustain a dense alternating propulsive
  trail, enter the merged wake late in the traverse, and cross the target ring
  without collision, exit, or instability. At `1650`, mean body velocity
  `(-0.3289,-0.1367)` versus mean local flow `(-0.1840,-0.1909)` confirms
  active useful leftward swimming rather than passive advection.
- Tightening only the candidate-owned posterior acceleration bound from `1700`
  to `1650 deg/time^2` repeats as a navigation and effort improvement. The two
  `1650` evaluations reach at `33.027`, score `0.189303`, and mean distance
  `1.683L`, versus `34.331`, `0.159531`, and `1.714L` for both `1700`
  evaluations. Command energy/power fall from `45153/3390` to `42310/3183`,
  mean leftward speed rises from `-0.3164` to `-0.3289`, and posterior peak
  angle falls from `0.509` to `0.495` rad. The posterior maximum equals each
  policy bound (`29.671` versus `28.798 rad/time^2`), while anterior
  acceleration and both joint rates still touch the episode limits.
- The improvement is not unloading. Relative-crossflow RMS rises from `0.2312`
  to `0.2358`, force RMS from `54.48` to `63.93`, and moment RMS from `766.14`
  to `859.31`. The `1650` sheet agrees qualitatively through a more strongly
  disturbed late trail. The moment also narrowly exceeds the inherited
  continuation hypothesis's `850` rejection boundary. The full inherited
  sequence `1800 -> 1750 -> 1700 -> 1650` therefore supports faster, lower-
  effort capture as the cap tightens at this one certified condition, but also
  an increasingly expensive hydrodynamic-load mode; it does not justify a
  lower cap.
- No supplied current or inherited keyframe sheet ends in a semantic failure.
  The inherited 27-degree amplitude probe is the clearest adverse visual
  control comparison: it preserves the safe route but visibly needs a sixth
  frame and reaches at `38.214`, with score `0.063788`, mean distance `1.812L`,
  and energy/power `53078/3978`, despite lower force/moment `40.03/630.70`.
  Both joints still contact the episode rate and acceleration limits. This
  rejects weakening global propulsion as a way to reproduce the useful
  posterior-bound mechanism. Inherited lag, damping, steering allocation, and
  bearing-gain continuations are already bracketed, and mixed auxiliary
  feedback became unstable; those axes and observations remain fixed. No
  omitted shelf, neighboring configuration, repository history, or external
  research was consulted.

## Single-candidate hypothesis

Materialize the replicated `1650 deg/time^2` posterior acceleration bound
exactly. Preserve the `0.55`-period, 28-degree oscillator, lag `0.75`, damping
`0.65`, bounded body-frame bearing gain `1.7`, 12-degree steering limit,
fraction-`0.35` allocation, and existing observation set. This selects the
best repeated navigation/effort result available to the worker; it is a
replication candidate, not a claim that further tightening is safe or that the
mechanism lowers hydrodynamic load.

The later CFD rollout supports the candidate only if it retains the visible
self-propelled turn-then-diagonal capture and remains near the repeated `1650`
envelope: arrival below `33.5`, mean distance below `1.70L`, command energy
below `44000`, posterior excursion below `0.51` rad, relative-crossflow below
`0.24`, and force/moment not materially beyond `65/870`. Loss of capture,
route change, collision, exit, instability, regression to the `1700` navigation
envelope, or higher load rejects repeatability. Do not continue the cap below
`1650` without a separately justified load-control mechanism or held-out wake
evidence. Any positive result remains limited to this certified wake phase and
start pose.
