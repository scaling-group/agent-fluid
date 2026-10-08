# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence. It shows the
  fish held high and downstream/right of the target while the four staggered
  cylinder streets develop and merge across the target corridor. It does not
  distinguish policies.
- The inherited `14 deg`, `0.80`-period target-aware failure is the clearest
  advection boundary. Its released sheet shows an almost straight fish carried
  downstream/right without entering the useful wake; it exits after `16.747`
  with head displacement `(2.172,-0.814)L`, `-0.148` progress, and only
  `0.692` mean command energy. Diagnostics remain finite and far inside the
  joint envelope, so cap feasibility without enough active gait is not useful
  control.
- The inherited `19 deg`, `0.67`-period policy is the informative near miss.
  Its sheet shows a broad release turn, oscillatory lateral corrections, then
  sustained upstream-left motion into the developed wake. It survives the
  complete `300` horizon and finishes at its rollout minimum `5.812L`, with
  head displacement `(-5.846,-4.282)L` and `0.532` progress. Its mean x
  velocity `-0.01942` is substantially more upstream than mean local flow
  `-0.00682`, and joint maxima (`19.0/24.3 deg`, `178/134 deg/time`,
  `1670/1260 deg/time^2`) do not touch the hard envelope: this is controlled
  propulsion, but it does not reach the strong reverse-flow corridor soon
  enough.
- All four current sampled solvers reproduce the same successful `20 deg`,
  `0.67`-period trajectory and identical keyframe sheet under the certified
  prewarm, despite cosmetic source differences. The fish makes the same broad
  initial correction as the `19 deg` policy, then straightens into the central
  wake and approaches the target from the right without collision, exit, late
  rebound, or numerical breakup. It reaches `0.749L` at `266.255`, moves the
  head `(-11.031,-4.702)L`, and has mean distance `7.218L`.
- The success is wake-assisted corridor acquisition rather than a claim of
  large mean swimming speed relative to the water: mean velocity
  `(-0.04144,-0.01765)` nearly matches mean local flow
  `(-0.03889,-0.02029)`, while mean relative flow is only
  `(0.00254,-0.00264)`. The `20 deg` gait nevertheless supplies the steering
  and propulsion needed to select and retain that corridor. Its maximum
  acceleration is `30.672 rad/time^2`, below the policy guard `30.8` and the
  episode hard limit `31.416`; RMS lateral force/moment remain finite at
  `18.26/353.21`.
- The inherited optimizer logs bound extrapolation. A coupled `21 deg`,
  `0.69`-period, softened-bearing variant approached to `3.246L` but rebounded
  to a `3.610L` final miss, while stronger posterior lag/damping changes
  produced essentially no upstream travel. Those negative results support
  preserving period, steering, lag, and damping and changing only the anterior
  shell. Replication here establishes fixed-prewarm determinism, not robustness
  to another wake phase.

## Candidate hypothesis

Preserve the complete sampled `20 deg`, `0.67`-period phase-shell controller:
the negative bounded posterior bearing/rate bias, `0.65` lag, `0.80` damping,
and all body-frame observations remain unchanged. Increase only the anterior
shell to `20.25 deg`, the midpoint between the demonstrated capture and the
`20.5 deg` amplitude whose nominal acceleration at this period would exceed
the episode hard cap. The corresponding nominal anterior scales are about
`190 deg/time` and `31.082 rad/time^2` (`1781 deg/time^2`), still within the
`260/1800` envelope. Raise the policy-owned guard mechanically from `30.8` to
`31.2 rad/time^2` so it remains above the candidate's nominal gait but below
the `31.416` episode cap; the guard should remain inactive and is not a second
control mechanism.

This conservative exploit tests whether the sharp `19 -> 20 deg` corridor
transition has a small amount of useful headroom. The next CFD rollout should
retain the sampled route topology and late monotone approach while acquiring
the reverse-flow corridor sooner, reaching the target before `266.255`, and
reducing mean distance below `7.218L` without increasing lateral loading or
contacting either acceleration bound. Falsify the hypothesis if the policy
guard becomes active, capture is later or lost, the trajectory rebounds after
approach, or force/moment growth indicates wasteful oscillation. In that case,
later workers should restore the replicated `20 deg` incumbent and test
corridor-retention feedback rather than increasing amplitude at this period.
