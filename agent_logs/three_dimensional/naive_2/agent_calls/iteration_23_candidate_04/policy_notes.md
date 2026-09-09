# Geometry-qualified terminal-pulse release candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the combined top-down mid-plane vorticity and
oblique body/Lambda2 rows for the highest-score sampled capture and the
assigned parent's latest informative failure. The sampled capture advances on
a nearly direct down-left route behind a compact, body-connected alternating
wake; localized three-dimensional tail structures persist through capture at
`15.983T`. The parent failure has the same coherent self-propelled approach and
low-load wake through about `16T`, but passes below the capture sphere, turns
nearly vertical, and exits the left boundary at `27.990T`. These are terminal
course-control differences, not passive advection, missing propulsion, wake
breakup, or numerical instability.

The four sampled rollouts all capture at `15.983--16.044T` and
`0.7472--0.7500L`. Three use the byte-identical always-active posterior pulse;
the prefill uses response-released pulse logic. Across them, peak normalized
planar force/moment is only `0.0332--0.0367/0.0166--0.0185`, neither joint
dwells beyond `40 deg`, and both joints occupy the last `10 deg/T` of their
rate envelope for roughly `17%` of samples. Thus the established traveling
carrier, body-frame predicted-miss route, and compact wake should be
preserved; stronger carrier or static-curvature gains are not supported.

Inherited repeats expose the robustness boundary hidden by the four sampled
captures. The same always-pulse policy later missed at `1.2164L`, and the same
response-released prefill both captured at `0.7486L` and missed at `1.0117L`.
The assigned parent's subsequent angle-domain carrier-yaw subtraction reduced
near-rate-limit occupancy to about `10.0/10.5%`, but altered terminal geometry,
passed low at `0.8293L`, and still exited left. At that closest pass the head
was `(9.625,8.955)L`, velocity remained targetward at about
`(-1.010,-0.205)L/T`, and normalized planar force/moment stayed low at
`0.0351/0.0176`. Lower effort and fewer terminal request crossings therefore
did not establish a better controller. Raw body-frame pursuit and predicted
miss should not be replaced by a joint-angle carrier estimate.

## Single candidate hypothesis

Preserve the complete response-released predicted-miss prefill: its
joint-state traveling bend, far-field pursuit/course blend, constant-course
time-to-closest and signed miss, bounded terminal mean curvature,
yaw-response-gated half-cycle handoff, and posterior mid-stroke actuator.
Change one feedback mechanism only: a corrective yaw response may release the
posterior pulse in proportion to how centered the predicted course already is.
Use the magnitude of the existing bounded predicted-miss request as the
normalized geometry deficit. A large remaining miss keeps most of the pulse
available despite a transient correct-sign yaw; a small miss lets the existing
response gate return authority to the carrier. No new gain, clock, route, or
static bend is introduced, and far-field behavior remains unchanged because
the existing terminal and closing gates still bound the pulse.

The hypothesis is that requiring response and geometry to agree will reduce
phase-sensitive low passes without the failed angle-domain bearing rewrite or
broad carrier braking. Support requires repeat capture, or at minimum a pass
below `0.8293L` with a better termination class, while retaining the direct
route, compact alternating wake, zero `>40 deg` dwell, comparable rate reserve,
and roughly `0.037/0.019` or lower normalized planar force/moment. Falsify on
loss of capture, a larger low-side miss or left exit, persistent posterior
pinning, higher joint/load occupancy, altered far-field translation, or wake
decoherence. The new candidate's CFD evaluation occurs only after this worker
exits and is not claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: steering authority returns to the propulsive rhythm only when measured turning response and remaining target-relative course error both support release
transferable_invariant: release a bounded rhythmic redirect when the body response is corrective and predicted miss is small, while retaining authority if either condition remains unmet
nontransferable_details: species-specific maneuver timing and curvature, published CPG gains, robot linkage geometry, dimensional frequency, exact vortex phase, capture route, and task-specific coordinates
policy_translation: retain normalized body-frame target and velocity prediction, and qualify the existing carrier-separated-yaw pulse release by the complement of the bounded signed-miss magnitude under the two-joint state-feedback contract
falsification: reject if capture or closest pass and termination do not improve together, or if the direct route, coherent wake, joint reserve, boundedness, reflection symmetry, and low normalized load scale are not preserved

## Dry validation only

The mandated guidance-materiality check, lightweight Julia policy contract,
direct parameter-schema guard, and solver editable-boundary check pass. An
additional `21,870`-state grid over normalized target geometry, body velocity,
heading response, and both joint states produced finite commands strictly
inside the smooth `30 rad/T^2` envelope with exact left/right reflection
(maximum error `0.0`). In a constructed still-closing off-center intercept,
the geometry-qualified release changed the posterior action by
`0.6514 rad/T^2` relative to the response-only prefill, confirming that the
edit is semantically active. These are algebraic checks only; no CFD was run.
