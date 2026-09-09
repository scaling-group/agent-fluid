# Step 39 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver evaluations satisfy the released experiment
  contract: direct uniform still water at `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. They all capture at `0.74846--0.74986L` after
  `18.2875--18.6560T`. Three use the exact intercept-guarded speed-reserve
  baseline; the best sampled score (`-0.14991`) comes from the outer-terminal
  unsupported-bearing qualifier.
- The combined top-down and oblique sheets for the four sampled captures show
  self-propulsion from release through target crossing. Each retains a
  coherent alternating mid-plane vorticity street and bilateral Lambda2 wake
  structures; none shows passive advection, carrier collapse, collision, or
  instability. Their metrics and diagnostics agree with the visual record.
- The qualifier is not a robust parent: inherited exact replay preserved the
  organized wake but missed at `1.18462L` and exited below. The later binary
  capture-corridor release guard likewise kept propulsion and both wake views
  active, yet worsened the miss to `1.67826L` and exited at `10.28354L`.
  These failures make terminal interception geometry, rather than propulsion,
  cadence, scalar route gain, or wake rejection, the repair surface.
- The newest inherited LOS-rate controller restores the repeat-backed carrier
  and adds only a bounded outer-annulus interception residual. Its direct-
  uniform rollout captured at `0.74605L` and `18.29849T`, earlier than the four
  sampled captures, while its top-down and oblique sheets retain the same
  active organized wake. One rollout demonstrates compatibility, not repeat
  reliability; its score (`-0.15938`) and mean distance (`2.04677L`) do not
  establish a scalar advantage over the sampled baseline envelope.

## Candidate hypothesis

Materialize an exact-policy repeat of the inherited
`dogfish3d_outer_los_rate_intercept_v1`. Preserve the raw achieved-course
servo, response-conditioned inner intercept guard, additive two-joint
steering shares, posterior-lagged traveling bend, and sparse outward-only
carrier reserve. In the approaching `4.0--1.5L` annulus only, oppose inertial
line-of-sight rotation with a separately bounded `2 rad/T^2` steering residual
derived from body-frame target/velocity cross product. The residual is zero in
the far field, on non-approaching motion, and before the inner capture regime;
it does not stack the unsupported-bearing qualifier or alter carrier gains.

Falsify this mechanism if the exact repeat loses capture, retains the lower-
exit topology, fails to contract pre-pass projected miss, weakens either wake
view, or moves clipping, joint-speed residence, force, or moment outside the
repeat-backed speed-reserve envelope. A repeat capture would justify further
reliability sampling, not immediate gain tuning.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish interception over an independently sustained rhythmic carrier
source_mechanism: bounded line-of-sight-rate steering superposed on a propulsive body wave
transferable_invariant: an approaching swimmer can oppose observed line-of-sight rotation with a bounded steering residual while keeping propulsion independently active
nontransferable_details: published gains, dimensional cadence, clocked CPG phase, robot morphology, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: derive normalized inertial LOS rate from body-frame target and velocity, apply one bounded annular two-joint steering residual through the existing shares, and preserve the evaluated traveling bend
falsification: reject if exact replay loses capture, keeps the coherent-wake lower exit, weakens either wake, or worsens actuator and load metrics beyond the established envelope

## Non-CFD checks

- The required semantic-guidance check passes, including the material parent
  comparison and deterministic parameter-schema guard. An independent static
  scan finds all `48` direct `params.FIELD` references among the `50` fields
  returned by `target_policy_params()`.
- The solver editable-boundary check passes. The candidate SHA-256 is exactly
  `fa1e73606ad3cccf13d12579377fd177abd8f6fa5b6fc00b42c1d1b501503db6`,
  matching the inherited LOS controller whose recorded Julia finite-action
  probe passed.
- The required local Julia command could not be rerun because this worker
  environment has no Julia executable or Julia module. The failure is
  `julia: command not found`, before policy loading or assertion execution;
  no CFD was run.
