# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet fixes the common initial condition: the fish is held
  at the upper-right release pose while four asymmetric, staggered cylinder
  streets develop and merge around the target. It cannot distinguish policy
  quality.
- All four current sampled gain-`1.7` rollouts are exact finite replicas. The
  released sheet shows active propulsion rather than passive advection: the
  fish makes a strong initial left-down turn, leaves a dense alternating tail
  trail, enters the developed wake corridor, and crosses the `0.75L` target
  ring without collision, domain exit, or instability. Capture occurs at
  `39.710`, with mean distance `1.874L`, command energy `54703.2`, relative-
  crossflow RMS `0.2265`, and force/moment RMS `38.40/618.59`.
- No current sampled solver is a semantic failure, so the inherited gain-
  `1.725` rollout is the most informative finite negative comparator. Its sheet
  preserves the same self-propelled turn-then-diagonal topology and capture,
  yet it arrives later at `40.832` and raises mean distance to `1.915L`, energy
  to `56614.5`, crossflow RMS to `0.2364`, and force/moment RMS to
  `42.50/674.61`. The gain-`1.9` result similarly regresses to `40.034`,
  `1.901L`, `54954.5`, `0.2329`, and `41.31/657.28`. These results falsify
  another near-zero bearing-gain interpolation, not the bounded positive-
  bearing mechanism.
- Cross-checking the embedded wake diagnostics shows that the gain-`1.7`
  anchor has maximum joint excursions `0.507/0.528` rad, whereas gains
  `1.725` and `1.9` increase them to `0.526/0.556` and `0.523/0.548` rad.
  Every tested gain already touches the same velocity and acceleration caps.
  The evidence therefore favors preserving the replicated gain and propulsion
  while testing one bounded distribution axis; it does not support increasing
  the gain, weakening the gait, or adding the inherited unscaled velocity and
  moment feedback that became unstable.

## Candidate hypothesis

Keep the evaluated `0.55`-period, 28-degree oscillator, phase-lag gain,
positive steering sign, gain `1.7`, and 12-degree total steering command.
Change only `anterior_steering_fraction` from `0.40` to `0.45`. In the existing
equations this transfers five percentage points of the same bounded steering
center from joint 2 to joint 1 while leaving the quasi-static total posterior
tangent centered on the original steering command. It is therefore a modest
distribution test rather than a new route, observation, or propulsion gait.

The later CFD rollout should preserve target capture and the visible early-turn
then diagonal-wake traversal. A useful result would retain arrival no later
than `39.710` while reducing the `0.528`-rad posterior excursion and not raising
mean distance, command energy, relative crossflow, or force/moment load above
the gain-`1.7` anchor. Loss of capture, arrival toward `40.832`, or movement of
loads toward `42.50/674.61` would falsify this redistribution and require later
workers to restore fraction `0.40`; no result from this unevaluated candidate
is claimed here.
