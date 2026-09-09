# Geometry-qualified posterior-release candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the combined top-down mid-plane vorticity and
oblique body/Lambda2 rows for the highest-scoring sampled capture, the assigned
parent capture, and the most informative inherited near-miss. The sampled
captures are self-propelled on essentially the same smooth down-left route.
They leave compact, body-connected alternating vorticity and localized paired
three-dimensional tail structures through capture; there is no sign of passive
advection, wake breakup, collision, or numerical instability.

The current sampled generation is semantically saturated but still separates
small terminal refinements. All four policies capture at `15.921--16.027T` and
`0.74729--0.74998L`. The assigned parent keeps its posterior mid-stroke pulse
active and scores `-0.0244375` with distance integral `1.906407L`. Releasing
that pulse on corrective yaw alone also captures but scores `-0.0250177`.
Qualifying release by small remaining predicted miss gives the best sampled
score, `-0.0233513`, and the lowest distance integral, `1.905785L`, while
retaining the same compact wake. Gating the separate half-cycle handoff by a
lateral corridor arrives fastest at `15.9209T` but has the weakest score,
`-0.0254866`, so arrival time alone is not a reason to combine the gates.

The inherited `0.82926L` near-miss is the useful failure comparison. Its
top-down row follows the same coherent targetward approach through about
`16T`, then turns nearly vertical and exits lower-left at `27.99T`; the oblique
row continues to show organized tail structures. Inherited metrics keep peak
normalized planar force/moment near `0.0351/0.0176` and reduce rate-limit
occupancy to about `10%`, yet termination remains `left_domain`. Together with
earlier `1.0--1.22L` repeats of pulse variants, this shows that low effort,
fewer request crossings, or one nominal capture is not enough to establish
robust terminal geometry.

## Single candidate hypothesis

Preserve the complete assigned-parent controller: its joint-state traveling
bend, rotation-invariant pursuit/course blend, constant-course time-to-closest
and signed predicted miss, bounded terminal mean curvature, response-gated
half-cycle handoff, and posterior mid-stroke actuator. Change only the
posterior-release decision to the evaluated geometry-qualified mechanism.
Correct-sign carrier-separated yaw releases the pulse only to the extent that
the bounded predicted-miss request is already small; a large remaining miss
retains posterior redirect authority. This changes neither far-field routing
nor the propulsive carrier and avoids the inherited failure caused by replacing
raw terminal geometry with a joint-angle carrier estimate.

Support requires capture with score/distance-integral quality at least
comparable to the sampled geometry-qualified rollout, while preserving the
direct route, compact alternating wake, negligible large-angle dwell, and the
roughly `0.037/0.019` normalized planar force/moment envelope. Falsify on loss
of capture, a repeated lower-left escape, a worse distance integral, persistent
posterior pinning, materially greater joint/rate/load occupancy, or wake
decoherence. The downstream CFD evaluation occurs after this worker exits and
is not claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: steering authority returns to the propulsive rhythm only when measured turning response and remaining target-relative course error both support release
transferable_invariant: release a bounded rhythmic redirect only when the observed response is corrective and predicted miss is small; retain authority while either condition remains unmet
nontransferable_details: species-specific maneuver timing and curvature, published CPG gains, robot linkage geometry, dimensional frequency, exact vortex phase, capture route, and task-specific coordinates
policy_translation: retain normalized body-frame target and velocity prediction, and qualify the existing carrier-separated-yaw posterior-pulse release by the complement of bounded signed-miss magnitude under the two-joint state-feedback contract
falsification: reject if capture, distance-integral quality, and termination do not remain favorable together with direct routing, coherent wake, joint reserve, boundedness, reflection symmetry, and low normalized loads

## Dry validation after editing

The mandated guidance-materiality, lightweight Julia contract, parameter
schema, and solver editable-boundary checks pass. All `28` direct
`params.FIELD` references are owned by `target_policy_params()`. The policy is
byte-identical to the sampled geometry-qualified capture (SHA-256
`a4d8d482b070adc79d8301764df1a2cfe4e059e4494fb3f8e4fa2dabee86f565`).
A `19,683`-state grid over target geometry, body velocity, heading response,
and both joint states produced finite commands strictly inside the smooth
`30 rad/T^2` envelope (maximum `29.999999999995104`) with exact left/right
reflection (maximum error `0.0`). These checks establish provenance and
algebraic semantics only; no CFD was run in this workspace.
