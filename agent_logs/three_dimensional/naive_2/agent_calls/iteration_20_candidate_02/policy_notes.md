# Response-released predictive-interception candidate

## Evidence and visual diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected both the top-down vorticity and oblique body/Lambda2 rows
of the best finite capture and the informative prefill failure. The successful
predicted-miss policies travel nearly directly toward the target behind a
compact, body-connected alternating wake and retain localized three-dimensional
structures through capture. The prefill also self-propels and sheds an
organized wake, but its phase-corrected bearing and proximity-triggered carrier
relief arc upward: it reaches only `4.64998L`, ends at center
`(8.671,15.202)L`, and exits left at `20.0337T`. This is a route-controller
failure, not passive advection, absent propulsion, or numerical instability.

The three current predicted-miss samples all capture at `15.983--16.016T` and
`0.7472--0.7500L`. Their score summaries report mean distance near `1.907L`,
whereas the prefill averages `6.304L` and finishes `5.706L` away. Two samples
use a joint-phase-gated posterior pulse; the third releases that pulse when
carrier-separated yaw is already corrective and still captures at `16.016T`.
Thus early body-frame course/miss prediction and preservation of the full
traveling carrier are the supported architecture; the posterior release is a
bounded terminal refinement rather than the source of propulsion.

Inherited optimizer results sharpen the boundary. A base predictive-miss
repeat and its response-gated handoff missed narrowly at `0.9631L` and
`0.8100L`, followed by two pulse-controller captures. A later phase-envelope
startup-recovery mechanism regressed to `3.8633L/left_domain`, and a subsequent
promotion also missed at `1.2164L`; the response-released posterior redirect
then restored capture. The sampled success is consequently worth reproducing,
but its threshold-level margin is not evidence of robustness under reflected
or perturbed geometry.

## Single candidate hypothesis

Replace the failed prefill with the evaluated response-released predicted-miss
policy. Preserve the state-feedback traveling bend, rotation-invariant
target/course error, constant-course time-to-closest and signed-miss gate,
bounded terminal mean curvature, and response-gated half-cycle handoff. During
a still-closing terminal intercept, recruit the small posterior mid-stroke
pulse only while carrier-separated yaw has not responded in the requested
direction; fade it continuously once corrective yaw appears. This keeps the
propulsive carrier intact and avoids redundant terminal steering without an
explicit clock or route.

Support is repeat capture with the direct compact-wake trajectory, no new
large-angle dwell, and force/moment and rate occupancy comparable to the three
sampled captures. Falsify on loss of capture, another lower-left escape or
upward loop, slower arrival than the no-pulse reference, materially greater
joint-limit occupancy or loads, or degradation of the alternating wake.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a geometry-gated steering transient is released when measured turning response becomes corrective, returning authority to the propulsive rhythm
transferable_invariant: recruit bounded steering only while target-relative miss persists and the phase-separated body response is not yet corrective
nontransferable_details: species-specific C-start curvature and duration, published CPG gains, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract the two-joint-rate carrier model from heading rate, and multiply the joint-phase-gated posterior target pulse by the complement of corrective-yaw response under the two-joint state-feedback contract
falsification: reject if capture, trajectory class, wake coherence, joint reserve, and low load scale do not remain jointly favorable

The candidate's CFD evaluation occurs only after this worker exits. The
capture and physical behavior above are prior sampled evidence, not a claim
about the new rollout.
