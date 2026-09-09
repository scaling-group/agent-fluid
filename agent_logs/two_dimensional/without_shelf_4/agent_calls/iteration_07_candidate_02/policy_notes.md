# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheets are byte-identical. They show the fish held high
  and to the right of the target while the four staggered cylinder streets
  develop and overlap across the target corridor. This is a common initial
  condition and cannot rank policies.
- The inherited `19 deg`, `0.67`-period horizon miss is the informative
  failure boundary available in the assigned optimizer logs. Its released
  sheet showed active oscillation and sustained upstream-left travel, but
  repeated wide corrections remained right of the central wake corridor. It
  survived the full `300` horizon and ended at its rollout minimum `5.812L`,
  with head travel `(-5.846,-4.282)L` and mean x velocity `-0.01942` versus
  local-flow x `-0.00682`. Its `29.138 rad/time^2` anterior maximum did not
  touch the actuator cap, so merely preserving feasible oscillation was not
  enough to acquire the useful corridor.
- All four current sampled solvers are exact behavioral replicates of the
  `20.25 deg`, `0.67`-period controller: their prewarm and released sheets are
  byte-identical and each captures at `244.547` with mean distance `6.452L`,
  head travel `(-10.916,-4.187)L`, and score `-4.439`. Cosmetic source
  differences therefore provide no independent control mechanism.
- Read from release to termination, the successful sheet shows a controlled
  but broad alternating approach: a large initial descent/turn, a reverse
  correction, another lower sweep, and only then leftward alignment through
  the interacting wake to the target. The fish is not merely swept to the
  goal: mean x velocity `-0.04443` is more upstream than mean local-flow x
  `-0.03649`, while target-directed turning selects the corridor. The small
  difference and the developed vortex region visible around the route also
  show that the capture remains wake-assisted rather than high-speed swimming
  through still water.
- Diagnostics bound further propulsion tuning. Maximum anterior acceleration
  is already `31.055 rad/time^2` against the policy's `31.2` guard and the
  episode's `31.416` cap. RMS lateral force is `18.263`, RMS relative
  crossflow is `0.1344`, and RMS moment is `362.21`; the latter increased from
  `353.21` for the inherited `20 deg` capture. Raising gait amplitude is not a
  supported way to shorten the remaining turns.
- The inherited isolated static-bearing test is negative: sharpening bearing
  scale from `0.30` to `0.28` at `20 deg` produced a larger down/up detour,
  worsened mean distance from `7.218L` to `8.112L`, and raised RMS lateral
  force from `18.26` to `18.58` despite a slightly earlier final crossing.
  The current candidate must therefore preserve static bearing scale, steering
  limit, posterior lag/damping, and propulsion while testing a distinct axis.

## Candidate hypothesis

Keep the demonstrated `20.25 deg`, `0.67`-period phase shell, `0.65/0.80`
posterior lag/damping, `10 deg` posterior steering limit, `0.30` static bearing
scale, `0.30 rad/time` rate bound, and `31.2 rad/time^2` acceleration guard.
Increase only bounded bearing-rate anticipation from `0.25` to `0.30` time
units. In the existing prediction `bearing + lead * bearing_rate`, an approach
toward zero bearing makes the rate oppose the bearing; the added lead should
therefore unwind steering earlier during an already-developing correction,
without increasing the initial saturated bearing command or adding a new
observation.

Under the certified fixed prewarm, the next CFD rollout should retain central
wake acquisition and target capture while reducing the visible alternating
turn width, mean distance, and preferably RMS moment. This is one bounded
feedback-axis test, not evidence that rate lead is already beneficial.
Falsify it if capture is lost or later than `244.547`, mean distance exceeds
`6.452L`, the fish fails to enter the central wake, or force/moment load rises.
If falsified, restore the evaluated `0.25` lead and do not combine rate-lead
changes with static bearing sharpening or further amplitude increase.
