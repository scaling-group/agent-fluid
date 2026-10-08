# Phase-neutral steering-allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the Phase-2 contract: direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and semantic `capture`.  The two v24 files reproduce the same
  effective trajectory at `26.0425 T`, mean distance `2.59751 L`, and score
  `-0.69471683`; this is the informative weaker control for the sampled
  mechanisms rather than a distinct termination failure.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  v24, the steering-preserving allocation, and phase-neutral yaw.  Each shows
  self-propelled motion from quiescent water, a coherent alternating posterior
  wake by `8 T`, and a continuous targetward arc through capture.  The
  allocation sheet retains the compact three-dimensional wake chain while
  visibly following a slightly tighter middle route; the phase-neutral sheet
  reaches the capture disk sooner, but with larger terminal oscillation.
- Metrics agree with the visual comparison.  Projecting the carrier before
  adding the target residual improves v24 to `25.9545 T`, mean distance
  `2.55008 L`, and score `-0.64778945`; it reduces rows touching either
  acceleration limit from about `84.35%` to `33.95%`, reduces maximum
  speed from `0.7170` to `0.6672 L/T`, and does not increase the sampled
  `0.02974/0.01484` peak lateral-force/yaw-moment scale.  Joint-phase yaw
  neutralization independently reaches capture at `25.0745 T` and improves
  mean distance to `2.55414 L`, but touches an acceleration limit in about
  `89.41%` of rows and raises maximum speed and planar-force magnitude.
- The assigned-parent logs bound the propulsion branch.  The v24
  closure-gated posterior lag reproducibly improves the earlier
  completion-gated capture only later in the route, not during launch; an
  aligned-cadence residual and a speed-released posterior energy envelope do
  not improve that opening and trail the stronger v24/steering-allocation
  results.  The remaining evidenced opportunity is therefore beat-scale
  steering observability and allocation, not another carrier gain.

## One-candidate policy hypothesis

Retain v24's completion-gated redirect, progress-gated posterior lag,
target-relative guidance, state-feedback oscillator, and parameter-owned
acceleration limit.  Combine the two compatible sampled steering mechanisms:
remove the joint-state-correlated carrier recoil from measured yaw before
route feedback, then project each carrier acceleration before adding and
projecting its target-steering residual.  The first operation prevents a
propulsive half-cycle from looking like macroscopic turn completion; the
second lets the corrected target residual unload an already saturated
opposite-sign carrier command.

This uses only observed joint state and normalized body-frame target feedback.
It adds no clock, global coordinate, target identity, prescribed route, exact
wake phase, or scalar carrier increase.  Expected evidence is capture no later
than the `25.9545 T` allocation parent with mean distance below `2.55008 L`,
while retaining its coherent wake and reduced saturation/load envelope.
Falsify the combination if capture or distance integral regresses, peak speed
or force approaches the isolated phase-neutral result without an offsetting
route improvement, acceleration-limit residence returns toward v24, or the
alternating posterior wake loses coherence.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping, sensor-modulated CPG direction tracking, and residual control over a rhythmic locomotor carrier
source_mechanism: infer beat state from observed joints, separate rhythmic recoil from route response, and retain bounded target-steering authority over useful half-cycles
transferable_invariant: slow target-relative steering feedback should remain distinguishable from carrier-scale oscillation and should be applied as an actuator-feasible residual without erasing the posterior traveling wave
nontransferable_details: published gains, robot geometry, clocked CPG phase, prescribed duty ratios, dimensional cadence, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: subtract the joint-correlated carrier component from observed yaw, use that response in the existing normalized body-frame guidance, project the joint-state carrier first, then add and project the existing target-steering residual
falsification: reject if capture time or mean distance exceeds the steering-allocation parent, if saturation and load move toward the isolated phase-neutral rollout, or if route direction, wake coherence, or posterior thrust regresses

## Scope

The numerical comparisons above are completed inherited and sampled CFD
evidence.  This combined candidate has no same-worker CFD result; formal
evaluation occurs only after worker exit.
