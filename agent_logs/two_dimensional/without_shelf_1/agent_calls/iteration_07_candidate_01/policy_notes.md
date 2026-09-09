# Multi-wake candidate diagnosis

## Evidence read before policy editing

- The shared prewarm sheet shows the fish held near the upper-right boundary
  while four developed, interacting wakes span the route to the target behind
  the second cylinder row. This is the certified common initial condition, not
  candidate-specific performance.
- The best sampled finite policy keeps the `0.90`-period, `28 deg` oscillator,
  positive `10 deg` posterior bias, and normalized heading-rate damping gain
  `0.70`. Its released sheet shows a productive traveling bend and strong
  self-propelled upstream motion before a sharp upper curl: mean head velocity
  x is `-0.130` versus mean local-flow x `-0.091`. It improves head x travel to
  `-6.93L`, closest approach to `5.33L`, progress to `0.380`, and score to
  `-9.53`, but exits after `55.38` release units with center/head y displacement
  `+1.20L/+1.80L`, maximum lateral target offset `6.09L`, both joint-rate and
  command caps active, and RMS force/moment `325/3331`. The pictures and
  diagnostics therefore agree that this is active approach, not wake
  advection, but it still turns away from the target and never enters the
  useful target wake region.
- The most informative sampled failure replaces direct heading-rate feedback
  with target-bearing-rate damping and an `8 deg` bias. Its sheet has the same
  broad upper-loop topology but far less leftward travel. Metrics confirm only
  `-2.95L` head x displacement, `7.90L` closest approach, `0.145` progress,
  posterior angle saturation, and a left-domain exit. Target-bearing rate is
  not a useful stronger brake because it mixes body rotation with target-vector
  translation.
- The clean heading-rate sequence isolates gain `0.35`, `0.70`, and `1.05`
  while preserving the rest of the controller. Raising gain from `0.35` to
  `0.70` improves progress `0.255 -> 0.380`, closest approach `7.30L -> 5.33L`,
  and x travel `-4.69L -> -6.93L`. Raising it again to `1.05` slightly reverses
  every approach metric (`0.369`, `5.64L`, `-6.67L`), raises RMS force/moment
  to `334/3463`, and leaves the same `+1.20L` center-y upper exit. The visual
  sheets likewise show no useful topology change. Crossing zero with the
  saturated rate term is therefore not supported.
- An inherited isolated `8 deg` static-bias trial at gain `0.70` is a stronger
  negative boundary than the confounded bearing-rate failure: progress falls
  from `0.380` to `0.095`, closest approach worsens from `5.33L` to `8.22L`,
  and upstream head travel falls from `-6.93L` to `-2.19L`, while center-y exit
  remains `+1.20L`. Lower steady posterior authority destroys the useful
  approach without fixing the lateral failure. Inherited lateral-velocity and
  global gait-weakening trials similarly lost progress, so neither should be
  combined with the next rate test.

## Single candidate hypothesis

Preserve the complete best sampled policy and change only
`turn_rate_damping` from `0.70` to `0.85`. This brackets the observed optimum
boundary: it strengthens direct body-rotation damping beyond `0.70`, where the
upper curl remains, but its maximum normalized subtraction stays below one, so
a saturated positive bearing request cannot be reversed as it can at the
regressing `1.05` gain. The oscillator, `10 deg` posterior authority,
turn-rate scale, target fade, and acceleration ceiling remain unchanged.

The next CFD evaluation should retain upstream head travel near the `0.70`
anchor while improving closest approach or upper-boundary clearance. The
hypothesis is falsified if progress falls toward the `1.05` result without a
lateral/topology benefit, or if the same upper loop persists. In that case
later workers should keep gain `0.70` and vary only turn-rate sensitivity or a
different bounded rotational structure; they should not increase gain past
`1.05`, reduce the `10 deg` bias, revive target-bearing/lateral-rate feedback,
or weaken the propulsion gait.
