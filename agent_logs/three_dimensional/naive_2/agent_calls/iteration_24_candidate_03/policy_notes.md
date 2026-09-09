# Unified response-and-miss handoff candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected the combined top-down mid-plane vorticity and oblique
body/Lambda2 rows for all four captures, with particular comparison between
the highest-score parent and the inherited angle-domain terminal-pursuit
failure. The parent follows a nearly direct down-left route behind a compact,
body-connected alternating wake; localized three-dimensional tail structures
remain bounded through capture. The failure follows the same self-propelled,
compact-wake approach through about `16T`, passes below the sphere, then turns
nearly vertical and exits left at `27.99T`. The distinction is terminal
steering and handoff, not passive advection, wake loss, large load, or numerical
instability.

The sampled candidates all capture at `15.921--16.027T` and
`0.74729--0.74998L`. The geometry-qualified posterior-pulse parent has the best
score (`-0.0233513`) and lowest normalized distance integral (`1.90579L`),
with zero joint-angle dwell beyond `40 deg`, about `17.2/17.0%` occupancy in
the last `10 deg/T` of the joint-rate envelope, and peak normalized planar
force/moment `0.0348/0.0175`. Its compact wake and direct route are therefore
the behavior to preserve. Its terminal crossing remains threshold-sensitive:
the head is `(9.583,9.031)L`, velocity is `(-1.080,-0.404)L/T`, and the target
is still about `0.47L` above the head while the fish crosses the sphere.

The sibling that qualifies shared half-cycle release with a body-frame lateral
corridor also captures, earlier at `15.921T`, but crosses lower at
`(9.529,8.972)L`, introduces `0.28%` posterior dwell beyond `40 deg`, and has
the weakest sampled score (`-0.0254866`). Thus more retained rhythmic steering
is compatible with capture but is not by itself an efficiency or margin win.
Inherited identical-controller repeats remain the robustness boundary: the
always-pulse controller missed at `1.2164L`, the response-released controller
missed at `1.0117L`, and replacing raw target geometry with an angle-domain
carrier estimate missed at `0.8293L` before the same left exit. Those results
reject another static-bend, carrier, or scalar-authority edit.

## Single candidate hypothesis

Preserve every owned gain and the complete parent carrier, raw body-frame
pursuit/course blend, constant-course time-to-closest and signed predicted
miss, bounded mean bend, shared half-cycle actuator, and posterior mid-stroke
actuator. Change one handoff mechanism only: compute one continuous consensus
gate from carrier-separated corrective yaw and the complement of the bounded
predicted-miss magnitude, then use that same gate to release both the posterior
pulse and shared half-cycle redirect. A transient correct-sign yaw cannot
release either channel while the predicted course remains off-center; as the
course centers, both channels return authority toward the propulsive carrier.
This transfers the parent's successful pulse qualification to the other
rhythmic steering channel without adding a threshold, gain, clock, coordinate,
or route.

Support requires capture or a closer pass with a better termination class than
the inherited `0.8293L` miss, while retaining the direct route, compact
alternating wake, zero or negligible `>40 deg` dwell, about `17%` near-rate
occupancy, and roughly `0.035/0.018` or lower normalized planar force/moment.
Falsify on loss of capture, a lower/wider pass, the same left-exit recovery,
material route or load growth, persistent steering pinning, or wake
decoherence. A threshold-level capture alone only shows compatibility; later
repeat evidence must decide robustness. The new candidate's CFD evaluation
occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: rhythmic steering is released only when measured corrective response and small residual target-relative course error jointly indicate redirect completion
transferable_invariant: require agreement between body response and remaining geometric miss before returning authority from a bounded redirect to the propulsive rhythm
nontransferable_details: species-specific maneuver timing and curvature, published CPG gains, robot linkage geometry, dimensional frequency, exact vortex phase, capture route, and task-specific coordinates
policy_translation: form one reflection-equivariant consensus gate from carrier-separated yaw response and normalized body-frame predicted miss, and apply it to the existing two-joint half-cycle and posterior-pulse release without changing their signs or carrier
falsification: reject if capture or closest pass and termination do not improve together, or if the direct route, compact wake, joint reserve, low normalized loads, boundedness, or reflection symmetry degrades

## Dry validation only

The mandated guidance-materiality check, lightweight Julia policy contract and
parameter-schema guard, and solver editable-boundary audit pass. An additional
`162,000`-state grid over normalized target geometry, body velocity, heading
response, and both joint states produced finite commands strictly inside the
smooth `30 rad/T^2` envelope and exact left/right reflection (maximum error
`0.0`). The shared consensus handoff changed a command by as much as
`9.20386 rad/T^2` relative to the parent on that grid, confirming that the edit
is semantically active. These are algebraic checks only; no CFD was run.
