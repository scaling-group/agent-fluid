# Predictive braking-reserve candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm, finite dynamics, and inertial moving-window transport. Three are
  byte-identical course-preview controls and reproduce capture at
  `24.5795T`, minimum/final distance `0.746968L`, and mean distance
  `2.36044L`. They establish the route and capture mechanism to preserve.
- Both rows of the combined keyframe sheets were inspected for a replicated
  course-preview capture and the assigned-parent predictive-stroke capture.
  In the top-down row each fish translates from otherwise quiescent water,
  establishes a coherent alternating wake, follows the same long diagonal,
  and redirects before crossing the target circle. The oblique row shows
  compact three-dimensional Lambda2 structures persisting through the
  redirect and capture. The parent has no visible wake breakup, passive
  advection, unstable motion, or materially new trajectory to repair.
- The assigned parent retains capture at `24.5960T`, `0.748582L`, and mean
  distance `2.36174L`. Relative to the inherited position-only stroke guard
  (`24.6180T`, `0.748724L`, mean `2.36225L`), outward-rate preview lowers
  peak absolute body-frame force/yaw-moment coefficients from
  `0.165/0.118/0.089` to `0.149/0.097/0.0667`. This reduced-load effect is
  useful and should be retained.
- The preview nevertheless fails its stated constraint objective. Posterior
  hard-stop occupancy is `12.634%` versus `12.601%` for the position-only
  guard, any-joint rate-limit exposure is `15.139%` versus `15.103%`, and
  raw acceleration-envelope exposure is `72.742%` versus `72.654%`.
  Both guards first reach the negative posterior hard stop near `18.6T`.
  In the predictive trace, near `q2=-0.7468 rad` and
  `q2_dot=-1.4953 rad/T`, the returned posterior acceleration is only
  `+13.68 rad/T^2`; stopping that measured outward rate inside the remaining
  reserve requires almost the owned `31.42 rad/T^2` envelope. Earlier
  interpolation of the same 15 percent priority release can soften loads but
  cannot reserve sufficient braking authority. Another preview threshold,
  priority-floor scalar, output clamp, or conditional handoff is not supported
  by the completed evidence.

## Policy hypothesis

Preserve the assigned parent's course preview, route requests, state-feedback
traveling wave, and predictive priority guard. Add one actuator-level
braking-reserve filter to the posterior command after carrier/steering
allocation. From observed posterior angle and outward rate, calculate the
constant-deceleration command needed to stop before the owned stroke reserve.
When projected stopping stroke enters the existing `36--44 deg` guard band,
blend only an insufficient outward/inward posterior command toward that
mirror-equivariant braking requirement, capped by the already owned
acceleration envelope. Leave the command unchanged when the joint moves
inward inside the reserve, the current command already brakes strongly enough,
or the projected stroke is inside the reserve. For a stalled joint outside the
full reserve, retain the same 15 percent authority released by the sampled
guard as a bounded inward recovery command until the joint re-enters. This
directly reserves feasible deceleration instead of changing the magnitude or
timing of target steering.

Expected evidence: preserve capture, the established far path, coherent wake,
and the assigned parent's reduced peak-load class while lowering posterior
hard-stop occupancy below `12.63%` and any-joint rate exposure below
`15.14%`. Falsify the mechanism if capture is lost, terminal margin becomes
worse than the completed conditional variants, the far trajectory changes,
or hard-stop/rate exposure does not fall. Raw output-envelope exposure is not
an acceptance criterion because the inherited final projection proved that
downstream-equivalent clipping changes representation without changing
dynamics.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive swimming
source_mechanism: preserve a posterior traveling wave while proprioceptive feedback protects finite actuator stroke needed for continued reactive thrust
transferable_invariant: when measured outward posterior momentum predicts a stroke conflict, reserve only the bounded inward acceleration needed to recover while leaving unconstrained rhythmic motion unchanged
nontransferable_details: published gains, motor models, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized posterior angle, outward rate, the owned guard band, and the owned acceleration envelope to apply a mirror-equivariant braking-reserve filter to the second-joint command
falsification: reject if capture, far-path dormancy, or the reduced-load class is lost, or if posterior hard-stop and joint-rate exposure do not improve beyond the predictive parent

## Pre-evaluation validation

- All `82` direct `params.FIELD` references resolve in
  `target_policy_params()`, and the required public-contract smoke state
  returns two finite accelerations.
- A deterministic `6075`-state grid spanning range, target side, bearing,
  closing speed, body-frame lateral velocity, posterior stroke, and posterior
  rate returns finite actions. Direct braking-reserve probes are
  mirror-equivariant to numerical tolerance, exactly unchanged inside the
  stroke reserve, request the full owned inward envelope for the evidenced
  near-stop state, and retain only the inherited 15 percent recovery authority
  for a stalled hard-stop state.
- Fixed-state replay over the assigned-parent trace first activates the filter
  at `18.5185T` and never above `6.5L` distance, supporting the intended
  far-path dormancy without claiming a new trajectory result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account. Its three declared no-CFD commands
  were run directly and separately: the reusable-guidance semantic check,
  Julia contract check, and solver editable-boundary audit all pass. No formal
  CFD was run.
