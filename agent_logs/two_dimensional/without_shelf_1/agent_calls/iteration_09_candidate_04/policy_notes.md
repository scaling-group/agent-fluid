# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

- The shared prewarm sheet is a common initial condition: the held fish starts
  near the upper-right boundary while the four developed cylinder wakes fill
  the route to the second-row target. It is not candidate-specific evidence.
- The released sheets show active upstream swimming rather than passive
  advection, but none of the sampled policies enters the useful target wake.
  The best finite sample has mean head velocity x `-0.1413 L/time` versus mean
  local flow x `-0.0995`, and travels `-7.89L` upstream. Visually it still
  follows the common broad loop above the cylinders, curls upward in the last
  two frames, and exits the upper boundary. Its `+1.20L` center-y displacement
  at exit agrees with that topology.
- Raising only posterior steering authority from `10 deg` to `11 deg` improves
  score from `-9.53` to `-8.91`, progress from `0.380` to `0.424`, closest
  approach from `5.33L` to `4.87L`, and upstream head travel from `-6.93L` to
  `-7.89L`. It does not produce the inherited hypothesis's requested downward
  turn: head-y displacement remains about `+1.79L`, the center again exits at
  `+1.20L`, posterior peak angle rises from `0.770` to `0.781 rad`, and RMS
  force/moment rise from `325/3331` to `406/4113`. More static bias therefore
  improves travel along the failed loop but is not yet a route repair.
- The assigned parent's `20 deg` bearing-scale hypothesis is now directly
  falsified. Relative to the otherwise identical `25 deg` anchor, progress
  regresses to `0.310`, closest approach to `5.77L`, and upstream head travel
  to `-5.62L`, while the same upper exit remains. The sampled `1.05` yaw-rate
  damping policy likewise retains the loop and regresses to `0.369` progress
  and `5.64L` closest approach. These results agree with the inherited log's
  warning against another bearing-sensitivity or direct-rate continuation.
- All four diagnostics reach both `260 deg/time` joint-rate caps and both
  `1650 deg/time^2` candidate command caps. The `10 deg` anchor already reaches
  `44.11 deg` posterior angle, and the `11 deg` probe reaches `44.72 deg`
  against the `45 deg` hard limit. Because changing yaw damping can lower the
  posterior peak without fixing the route, the next isolated mechanism should
  constrain the posterior servo demand itself rather than claim that angle
  relief alone is useful.

## Single candidate hypothesis

Restore the evidence anchor (`10 deg` posterior bias and `0.70/0.35` direct
heading-rate feedback) and add one posterior phase-allocation mechanism. Split
the posterior target into the sampled propulsive target and desired steering
bias. First bound the propulsive target at a parameter-owned `42 deg`, then
clamp the desired steering bias to the remaining signed headroom before
recombining them. Positive steering is retained when it moves a negative
propulsive extreme back toward the feasible range and withheld when it would
push a positive extreme farther into saturation. The anterior oscillator,
tail lag, servo gains, final-distance fade, and command ceiling stay fixed.

This is a pre-evaluation hypothesis, not a claim about the new candidate's CFD
outcome. It is supported if it retains roughly the anchor's upstream progress
while reducing the `44.11 deg` posterior excursion or posterior rate/command
saturation and bends below the repeated upper loop, ideally improving on the
`5.33L` closest approach or avoiding the upper exit without a load increase.
It is falsified if bounding the phase target weakens upstream travel toward the
previous globally weakened-gait failures, if both posterior caps persist, or
if the same `+1.20L` center-y exit repeats without a closer approach. Later
workers should then restore the unallocated `10 deg` anchor and test a single
posterior servo-dynamics change rather than add more static bias, decrease the
bearing scale, or retune direct yaw-rate damping.
