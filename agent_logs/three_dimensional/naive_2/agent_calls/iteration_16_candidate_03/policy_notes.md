# Evidenced terminal-interception promotion

## Visual and metric diagnosis before editing

All four sampled rollouts report direct uniform initialization in still water,
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected both rows of
each combined keyframe sheet. Every fish is self-propelled: the top-down views
show body-connected alternating vorticity and the oblique views show generated
three-dimensional Lambda2 structures. The failures are trajectory-control
failures, not passive advection, missing propulsion, or numerical instability.

The assigned prefill's distance-based approach hold keeps a coherent wake but
curls above the capture corridor and later leaves the left boundary. It reaches
only `2.70327L` at `17.43T`, exits at `24.52T`, dwells beyond `40 deg` on at
least one joint for `36.3%` of logged samples, and reaches peak normalized
planar force/moment magnitudes of about `0.713/0.300`. The related full-circle
pursuit sample also arcs high and exits left after reaching only `4.64998L`,
with peak planar force/moment around `0.620/0.261`. Their broad late wakes and
curled oblique body postures agree with the distance and load histories.

Both body-frame predicted-miss candidates instead follow a direct targetward
line behind a compact alternating wake and retain body-connected 3D structures
through capture. The base predicted-miss/mean-curvature controller captures at
`16.0105T` and `0.747725L`. The response-gated version with a posterior
mid-stroke pulse captures slightly earlier at `15.9830T` and `0.749982L` and
has the best sampled score (`-0.024438` versus `-0.028049`). Its head reaches
`(9.619,9.077)L`, neither joint dwells beyond `40 deg`, and peak normalized
planar force/moment are only `0.03421/0.01728`. It still actively uses the rate
envelope (`17.21%/16.86%` of head/tail samples lie within `10 deg/T` of the
rate limit), so stronger carrier or steering gains are not supported.

The inherited logs make the mechanism comparison more informative than the
two new captures alone. An identical base predicted-miss repeat previously
missed at `0.96311L`; retaining half-cycle steering until carrier-separated
yaw became corrective improved that repeat to `0.81002L`, but still escaped
lower-left. The subsequently proposed joint-phase-gated posterior pulse was
then unvalidated. Its present sampled rollout is now a capture with the same
compact wake, zero large-angle dwell, and low load scale. This is positive
evidence for the small response-gated interception composite, while the
near-threshold capture and known repeat variability remain a robustness
boundary.

## Single candidate hypothesis

Replace the weaker assigned prefill with the exact best sampled policy. Keep
the joint-state traveling bend, rotation-invariant target/course residual,
constant-course time-to-closest and signed-miss gate, bounded terminal mean
curvature, yaw-response-gated half-cycle handoff, and terminal posterior
mid-stroke pulse as one small compatible composite. No new scalar tuning or
additional feedback primitive is added: the current evidence favors promoting
the first evaluated version of this composite over confounding its capture
with another untested mechanism.

Support is another capture near `16T` with a compact alternating wake, zero
`>40 deg` dwell, and normalized planar force/moment near `0.034/0.017`.
Falsify on loss of capture or recurrence of the lower-left escape, materially
higher joint-limit occupancy or loads, loss of far-field translation, or loss
of wake coherence. The candidate's CFD evaluation happens after this worker
exits, so those criteria are not claimed outcomes here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish interception
source_mechanism: preserve the propulsive rhythm while measured directional response controls release of rhythmic steering and observed joint phase gates a brief posterior wave-shape correction
transferable_invariant: keep propulsion and target correction separated, hand off steering only after corrective response is observed, and recruit bounded posterior authority during the active joint-state phase
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract two-joint-rate carrier yaw from heading response, and gate a target-signed posterior offset by normalized anterior-joint speed
falsification: reject if repeat capture, trajectory class, wake coherence, joint reserve, and low normalized loads do not remain jointly favorable

## Dry validation only

The candidate is byte-identical to the sampled response-gated posterior-pulse
capture policy. The guidance-materiality check, lightweight Julia policy
contract, all `28/28` direct parameter-reference ownership checks, and the
editable-boundary check pass. These checks establish provenance, schema, and
executable semantics only; no CFD was run in this workspace.
