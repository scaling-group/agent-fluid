# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The assigned parent guidance identifies the `19 deg`, `0.67`-period phase
  shell with `0.65/0.80` posterior lag/damping and bounded negative
  bearing/rate bias as the first controlled-upstream anchor. Its inherited
  rollout survives the full horizon and corrects the target-row offset, but
  finishes at its minimum distance `5.812L` after only `-5.846L` head-x
  travel. The released sheet shows genuine actuation and wake entry rather
  than passive advection, yet also shows broad lateral reversals before the
  final upstream heading.
- The current shared prewarm sheet shows the common fish held above and to the
  right of the target while four developed vortex streets overlap through the
  target corridor. This is identical initial-condition evidence for every
  candidate, not candidate-specific evidence.
- All four current sampled solver results are behaviorally the same successful
  `20 deg`, `0.67` bundle. Their released sheets show a large initial turn and
  several coarse lateral corrections, followed by sustained diagonal motion
  into the central wake and target capture from the right. Metrics confirm
  that the motion is finite and useful: capture occurs at `266.255`, mean and
  final/minimum distance are `7.218L` and `0.749L`, and head displacement is
  `(-11.031,-4.702)L`. Mean velocity `(-0.04144,-0.01765)` is close to mean
  local flow `(-0.03889,-0.02029)`, so the late transport is wake-assisted;
  the preceding `19 deg` control establishes that the controller, rather than
  downstream advection, is what enters that useful region.
- Diagnostics agree with the successful pictures: maximum anterior angle,
  rate, and acceleration are about `20 deg`, `187.7 deg/time`, and
  `30.672 rad/time^2`; the `30.8` software guard and the episode hard envelope
  remain inactive. RMS relative crossflow, lateral force, and moment are
  `0.132`, `18.26`, and `353.21`, with no collision, exit, or instability.
  The four exact replays share one certified wake state and essentially the
  same policy, so they demonstrate deterministic reproduction, not robustness
  to four independent wake phases.
- The inherited failure comparisons bound the next change. The inactive
  `14 deg`, `0.80` controller is swept `+2.17L` downstream and exits after
  `16.75`, while the controlled `19 deg` near-miss proves that weak propulsion
  is not a repair. A coupled `21 deg`, `0.69`, `0.38`-bearing-scale variant
  approaches to `3.246L` and then rebounds, and the `0.78/0.72` posterior
  variant loops near release with only `+0.058L` x displacement. Those results
  do not support more raw gait effort or posterior lag. The remaining visible
  inefficiency in the successful sheet is the broad bearing transient.

## Candidate hypothesis

Preserve the complete demonstrated successful bundle and change only the
bounded bearing-rate lookahead from `0.25` to `0.35`. With the existing
`0.30 rad/time` rate clamp, the change can add at most `0.03 rad` to the
incumbent predicted-bearing error. It should therefore start unwinding a
growing target bearing slightly earlier, reducing the broad release turns and
distance integral without changing steady bearing feedback, steering limit,
anterior propulsion, posterior phasing, or actuator exposure. The controller
still uses only joint state and normalized body-frame target bearing/rate; it
adds no coordinate, route, target identity, elapsed-time, prescribed-inflow,
remote-wake, or target-station signal.

The next CFD evaluation should retain capture, negative head-x travel, and
inactive guards while reaching earlier than `266.255` or reducing the
`7.218L` mean distance. Falsify the lookahead hypothesis if capture is lost,
the keyframes show a larger lateral loop or late rebound, force/moment loads
rise materially, or the acceleration guard becomes active. In that case later
workers should restore `0.25` and test another isolated corridor-retention
change rather than increasing amplitude, shortening the period, or raising
posterior lag.
