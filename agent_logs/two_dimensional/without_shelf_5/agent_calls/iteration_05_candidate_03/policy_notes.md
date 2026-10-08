# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose while the four staggered cylinder wakes grow into interacting
  streets around the target. It is initial-condition evidence only; it cannot
  distinguish controllers.
- The released sheets for gains `1.7`, `1.9`, and inherited `1.72` all show a
  self-propelled fish: a dense alternating tail trail accompanies the initial
  turn, followed by a left-down diagonal traverse through the developed wake
  and into the `0.75L` target ring. Lateral motion is mostly route-producing,
  although wake-scale undulations remain on final approach. None of the
  available sampled or inherited sheets is a collision, exit, horizon miss, or
  instability, so `1.72` is used as the most informative degraded success and
  the assigned parent's target-blind lower-boundary exit is retained as the
  semantic failure boundary.
- The gain-only evidence is sharply non-monotonic. Gain `1.5` reached at
  `41.316` with mean distance `1.919L`. Gain `1.7` was best: score `0.002860`,
  arrival `39.710`, mean distance `1.874L`, relative-crossflow RMS `0.2265`,
  and force/moment RMS `38.40/618.59`. Gain `1.9` regressed to
  `40.034/1.901L`, crossflow `0.2329`, and loads `41.31/657.28`. The inherited
  interpolation tests did not validate the fitted optimum: gain `1.72`
  regressed further to `41.464/1.944L`, crossflow `0.2386`, loads
  `41.85/675.43`, and score `-0.066129`; gain `1.725` reached at `40.832` with
  mean distance `1.915L`, crossflow `0.2364`, loads `42.50/674.61`, and score
  `-0.037209`.
- Embedded diagnostics agree with the images rather than revealing an effort
  advantage for the upper-side probes. Gain `1.7` had maximum joint angles
  `0.507/0.528` rad, versus `0.529/0.563` at `1.72`, while both reached the
  same `4.538` rad/time velocity and `31.416` rad/time-squared acceleration
  envelopes. The `1.72` mean velocity was also less headward than `1.7`
  (`-0.262/-0.109` versus `-0.274/-0.113` in world components). The common
  maximum lateral target offset near `4.297L` indicates that the regression is
  accumulated along a visually similar route, not a different initial miss.
- The assigned parent records that the target-blind oscillator escaped the
  lower boundary at `50.127` after rebounding to `12.123L`, and inherited notes
  report that a slower mixed-feedback controller became unstable at `2.807`.
  Together with the successful gain-only sweep, that evidence supports
  preserving the vigorous gait, positive two-joint bearing curvature, and
  bounded `tanh` structure rather than adding unscaled wake/force signals or
  changing several axes at once.

## Candidate hypothesis

Keep the evaluated `0.55`-period, 28-degree oscillator, posterior phase lag,
positive two-joint bearing distribution, and 12-degree steering bound. Change
only `steering_gain` from the measured `1.7` anchor to `1.68`. This is a
lower-side bracket symmetric with the failed `1.72` upper-side probe and tests
whether the narrow best region lies immediately below `1.7`; it does not assume
that a quadratic fit to the sparse gain sweep is predictive.

The later CFD result should falsify this candidate if it loses capture, arrives
later than `39.710`, exceeds `1.874L` mean distance, or raises crossflow or
force/moment RMS above the gain-`1.7` anchor. If so, later workers should
restore the measured `1.7` value and stop sub-step gain fitting under this
single wake phase before testing a separately motivated controller axis.
