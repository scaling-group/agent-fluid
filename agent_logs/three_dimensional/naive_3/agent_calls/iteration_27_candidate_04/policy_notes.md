# Terminal line-of-sight response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the combined keyframe sheets for the strongest finite sample
  (`solver_6eb170b0d70a`), the assigned-parent scaffold
  (`solver_951085a20092`), and the informative response-held failure
  (`solver_2c7a9d1d6ee7`), including both top-down mid-plane vorticity and
  oblique body/Lambda2 rows. All visibly self-propel from rest with coherent
  alternating planar wakes and compact three-dimensional structures. Passive
  advection, wake collapse, collision, and numerical instability do not
  explain the misses.
- The assigned parent's target-behind, nonclosing course-response reserve is a
  semantic improvement over the response-held C-turn: minimum/mean/final
  distance improves from `2.377/4.458/4.163L` to
  `1.314/4.056/3.077L`, and anterior acceleration-clamp residence falls from
  about `0.727` to `0.249`. The inherited optimizer note correctly localized
  its remaining release gap to close, tangential crossings rather than a lack
  of propulsion.
- The newly completed terminal course hold (`solver_6eb170b0d70a`) validates
  that localization, but only partially. It improves minimum/final distance
  from the assigned parent's `1.314/3.077L` to `1.241/2.082L` and retains
  about `15.0T` inside `2L`, with the same coherent powered-loop wake. It also
  worsens mean distance from `4.056L` to `4.157L`, reduces residence inside
  `1.5L` from about `5.38T` to `2.87T`, raises anterior clamp residence from
  `0.249` to `0.329`, and changes the first pass from `2.377L` to `2.466L`.
  A terminal hold is therefore useful scaffolding, not evidence for broader or
  stronger static curvature.
- At the best completed pass (`97.09T`, `1.241L`) speed is still `0.669U`,
  target-ray/course error is `1.692 rad`, normalized radial course is slightly
  receding (`-0.121`), and heading rate is only `-0.129 rad/T`. The target line
  is rotating at about `0.535 rad/T` in the required turn direction while the
  current bounded C-turn is nearly at joint equilibrium. Earlier close passes
  show the complementary failure: at `1.643L`, the error is `0.958 rad` but
  yaw is `+2.359 rad/T` in the wrong direction. Holding the same curvature
  cannot distinguish absent turn response from wrong-way overshoot.
- The sampled terminal lateral bridge (`solver_34419dc4414e`) reaches
  `1.371L` but then expands its loop, and inherited evidence already rejects
  carrier contraction, posterior counterbend, duty/phase retuning, and a
  same-step moment residual. The next test should therefore change the
  terminal response variable and remain bounded within the established
  curvature carrier.

## Policy hypothesis

Use the evaluated terminal-course-hold policy as the complete scaffold. Add
one compact terminal response mechanism: derive inertial target-line angular
rate from normalized body-frame target geometry and translational velocity,
form a bounded desired yaw response, and add a small two-joint mean-curvature
residual from desired-minus-measured yaw rate. The residual is gated to the
sub-`2L`, finite-speed, course-misaligned regime and vanishes continuously on a
collision course. It can reinforce a stalled correct-sign turn or oppose a
wrong-way yaw, unlike another static hold. It adds no clock, hidden maneuver
stage, world coordinate, memorized route, or wake phase.

Support requires capture, a closer pass, longer useful near-target residence,
or improved mean/final distance while preserving the coherent carrier and
without increasing clamp/load residence. Reject the mechanism if the first
`2.47L` pass changes materially, a fast alternating curl appears, the wake or
propulsion collapses, acceleration/load residence rises, or the same
`1.2--1.8L` powered orbit persists.

```text
bookshelf_consulted: true
source_domain: fish terminal-approach control and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive traveling wave while near-target yaw and slip feedback modulate bounded steering until the observed course becomes target-intercepting
transferable_invariant: terminal steering should respond to target-line rotation and measured turning response, not persist solely because range and bearing geometry remain large
nontransferable_details: species-specific capture maneuvers, published gains, dimensional beat frequencies, robot duty ratios, exact vortex phases, capture radius, target coordinates, and task-specific routes
policy_translation: normalized body-frame target/velocity cross product and distance estimate target-line angular rate; its bounded mismatch with measured yaw adds a localized reflection-equivariant equilibrium residual to both joints
falsification: reject if cruise or first-pass geometry changes, wake coherence is lost, clamp/load residence rises, yaw alternates without course improvement, or capture/near-target residence and orbit radius do not improve
```

## Evaluation boundary

The candidate receives coupled CFD only after this worker exits. Frozen-trace
selector replay and dry controller probes can establish locality, sign,
reflection equivariance, finite outputs, parameter ownership, and command
bounds, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate preserves the completed terminal-course-hold scaffold and adds
three owned response parameters. The target/velocity cross product gives a
signed inertial target-line rate; a bounded desired-minus-measured yaw residual
is blended into the anterior and posterior mean equilibria through the existing
terminal selector. Maximum redirect, response, carrier, and command-limit
parameters are unchanged.

Frozen replay on the completed `solver_6eb170b0d70a` trace makes the new
selector zero to displayed precision at `8T`. At the `2.466L` first pass its
weight is `0.0112`, it adds only `-0.089 deg` of curvature, and changes actions
from `(16.44,-1.53)` to `(16.24,-1.79) rad/T^2`. At the wrong-way-yaw
`1.643L` pass it adds `-1.218 deg`; at the `1.641L` still-tangential state it
adds `-3.083 deg`. At the best `1.241L` pass its weight is `0.524`, the target
line requests `-0.802 rad/T` yaw against the measured `-0.129 rad/T`, and the
residual adds `-3.657 deg`, changing actions from `(0.97,0.87)` to
`(-7.35,-10.52) rad/T^2`. A representative posterior command remains within
reserve at `-25.81 rad/T^2`; no replayed action exceeds `+/-28 rad/T^2`.
These are frozen-state algebraic responses, not an integrated-flow prediction.

All `47` direct `params.FIELD` references are owned by
`target_policy_params()`. Representative cruise, close-pass, stopped,
zero-target, and large finite probes remain finite and bounded. Mirroring
target, velocity, joint state, bearing, and yaw exactly negates both actions to
within `1e-10`. The mandated material-guidance, lightweight Julia contract,
parameter-schema, and solver editable-boundary checks pass. Formal CFD was not
run.
