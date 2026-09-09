# Response-gated predictive-interception candidate

## Evidence and visual diagnosis before editing

All four sampled solver rollouts and both completed assigned-parent rollouts
use direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected the combined top-down vorticity and oblique Lambda2 rows
for the sampled capture, the prefilled posterior-bend failure, and the assigned
parent's repeated predictive-interception run. Each fish is self-propelled
behind a body-connected alternating wake; the failures are route/control
failures, not advection, missing thrust, or numerical instability.

The prefilled controller retains a coherent wake but turns late, passes high,
and exits the upper boundary after reaching only `3.312L`. The predicted-miss
architecture is uniquely useful but not yet robust: the same policy SHA and
config SHA captured once at `16.01T` and `0.74772L`, then missed on the assigned
parent's repeat at `0.96311L` and exited lower-left. The capture crosses with
head `(9.656,9.140)L`; the repeat reaches `(9.712,8.852)L` while still moving
down-left at about `(-1.089,-0.241)L/T`. Both have zero joint-angle dwell above
`40 deg`, coherent compact wakes, and similar low peak normalized planar
force/moment (`0.030/0.017` and `0.029/0.017`). This is a capture-margin and
terminal response problem, not evidence for stronger carrier gains.

The repeated miss also exposes the actuator handoff. Near closest approach its
target/course request is large and positive, yet the predicted-miss controller
unconditionally fades course half-cycle steering to `35%` as terminal mean
curvature enters. An inherited response-burst controller without predictive
mean curvature reached only `3.204L`, so response feedback should not replace
the successful interception mechanism. It can instead decide when that
controller is allowed to relinquish its rhythmic steering channel.

## Single candidate hypothesis

Preserve the sampled predicted-miss controller's traveling-bend carrier,
course feedback, early body-frame time-to-closest/miss gate, and bounded mean
curvature. Add one response-gated handoff: subtract the joint-rate-correlated
carrier yaw from measured heading rate, and fade half-cycle course steering
toward its terminal share only after the residual yaw has the corrective sign
for the active terminal turn. If yaw is neutral or wrong-side, retain the full
rhythmic steering share; mean curvature remains active throughout. This small
combination preserves the only evidenced capture mechanism while adding a
closed-loop recovery channel for the repeated lower-side miss.

Support requires capture with more margin than the sampled threshold crossing,
or at minimum a pass below `0.96311L` followed by target-side recovery, while
retaining the compact wake, zero `>40 deg` dwell, and the roughly `0.03/0.017`
load scale. Falsify on loss of the predictive approach, another lower-left
escape without a closer pass, oscillatory handoff, joint/load growth, or loss
of wake coherence.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion and release redirect authority only after observed directional response becomes corrective
transferable_invariant: a predictive target-relative turn may hand authority away from a rhythmic steering channel only when phase-separated body response confirms the requested turn
nontransferable_details: C-start timing and curvature, published CPG gains, robot linkage geometry, dimensional frequencies, species kinematics, exact vortex phases, and task-specific routes
policy_translation: retain body-frame predicted-miss mean curvature, subtract a two-joint-rate carrier model from heading rate, and gate the terminal fade of shared-joint half-cycle steering by correct-sign yaw response
falsification: reject if capture margin or termination does not improve together without preserving wake coherence, joint reserve, and low normalized loads

## Dry validation only

The mandated guidance-materiality, Julia policy-contract, parameter-schema,
and editable-boundary checks pass. A `19,683`-state grid spanning fore/aft and
lateral target geometry, body velocity, both joint angles/rates, and yaw
response produced finite commands within the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). In a constructed terminal
miss state, changing only carrier-separated yaw from wrong-side to corrective
changed the action by `1.273 rad/T^2`, confirming that the response-gated
handoff is active. These are algebraic checks, not CFD evidence; the downstream
evaluation must decide capture margin, trajectory, wake, joint, and load
falsifiers.
