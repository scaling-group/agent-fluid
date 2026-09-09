# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while four staggered vortex streets develop and merge around
  the target. This is identical initial-condition evidence for all candidates,
  not controller credit.
- All four current sampled policies retain the `0.55`-period, 28-degree
  oscillator and positive, two-joint bearing-centered bend. Their released
  sheets show active self-propulsion: after a brief heading correction, the
  fish traverses diagonally left and down through the developed wake and
  reaches the `0.75L` target ring without collision, exit, or instability.
- Three samples use steering gain `1.5` and reproduce the same target crossing
  at `41.316`, mean/final distance `1.919/0.750L`, command-energy mean
  `1404.94`, relative-crossflow RMS `0.2364`, and force/moment RMS
  `41.98/660.23`. The gain-`1.7` sample reaches the target earlier at `39.710`
  with lower mean distance (`1.874L`), command-energy mean (`1377.57`),
  relative-crossflow RMS (`0.2265`), and force/moment RMS (`38.40/618.59`).
  The nearly identical visible route and unchanged propulsion parameters make
  this a clean local gain comparison rather than passive advection or a new
  wake mechanism.
- Both successful gains still touch the joint-rate and acceleration envelopes,
  so these results do not justify weakening propulsion: the shorter gain-`1.7`
  episode lowers total and mean effort despite retaining the vigorous gait.
  The inherited target-blind seed instead escaped downward, while an inherited
  slower controller that combined opposite-sign bearing, lateral-velocity,
  and moment terms became unstable at `2.807`, with relative-crossflow RMS
  `3.67` and force/moment RMS `5.33e4/6.88e5`. Those failures bound this test
  against reversing curvature, slowing the gait, or adding auxiliary feedback.

## Candidate hypothesis

Preserve the evaluated oscillator, positive curvature sign, posterior phase
lag, two-joint steering distribution, and 12-degree `tanh` steering bound.
Increase only `steering_gain` from `1.7` to `1.9`. The measured improvement
from `1.5` to `1.7` suggests that a comparably small increase in near-zero
bearing response can finish the initial alignment sooner, while the unchanged
outer bound prevents a larger worst-case bend and joint state continues to
encode propulsion phase. The policy uses no coordinates, elapsed time, route,
cylinder identity, or unavailable flow probe.

The post-worker CFD result should falsify this local continuation if it loses
capture, arrives later than `39.710`, raises mean distance above `1.874L`, or
increases crossflow/load excursions enough to erase the gain-`1.7` advantage.
If so, later workers should restore `1.7` and test a smaller interpolation or
a single separately bounded damping axis rather than altering propulsion and
steering together.
