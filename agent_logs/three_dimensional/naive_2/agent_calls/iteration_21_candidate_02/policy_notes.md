# Phase-separated terminal-pursuit candidate

## Visual and metric diagnosis before editing

All four sampled episodes satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected both the top-down mid-plane vorticity and oblique
body/Lambda2 rows in the highest-score capture and the lowest-score capture.
Both are self-propelled on the same nearly direct down-left route, retain a
compact body-connected alternating wake and localized three-dimensional tail
structures, and enter the capture sphere without a boundary encounter or wake
breakup. The score difference is therefore not a distinct trajectory class.

Three byte-identical always-pulse runs capture at `15.983--16.044T`, and the
response-released-pulse sibling captures at `16.016T`; all finish at
`0.7472--0.7500L`. Their normalized distance integrals are
`1.9064--1.9125L`, neither joint dwells beyond `40 deg`, peak normalized
planar force/moment stays within `0.0309/0.0186`, and each joint occupies the
last `10 deg/T` of its rate envelope for about `17%` of samples. Releasing the
posterior pulse thus preserves the route and physical class, but the identical
controller's score spread is larger than the apparent release advantage. It
does not establish pulse release as the cause of improved capture reliability.

The assigned parent establishes constant-course predicted miss as the first
capture-producing architecture, while its inherited logs supply the crucial
repeat boundary: the same response/pulse composite later missed at
`1.01564L`, `1.12140L`, and `1.21644L` before exiting left, and a no-pulse
sibling also captured. The terminal pulse is therefore neither necessary nor
sufficient for reliable capture. In an inherited replay of three direct
captures, raw body-frame target bearing changed sign five times and the
blended terminal request six times during the final `2.5T`; subtracting the
angle-domain integral of the existing joint-rate carrier-yaw model reduced
request deviation by about one third and left only two brief crossings. That
offline replay is diagnostic evidence, not CFD validation of the edit.

## Single candidate hypothesis

Preserve the complete state-feedback traveling-bend carrier, far-field
pursuit/course blend, body-frame constant-course time-to-closest and signed
miss gate, bounded terminal mean curvature, response-gated half-cycle handoff,
and posterior pulse. Change one feedback mechanism only: form the terminal
pursuit request after subtracting the two-joint angle-domain carrier-yaw
estimate from raw target bearing. Far-field routing and the course predictor
remain raw, so the evidenced direct approach is unchanged until the existing
terminal gate recruits its fallback. The intended effect is to let persistent
target geometry, rather than beat-correlated body yaw, determine the terminal
steering sign.

Support requires repeat capture instead of another `1.0--1.22L` left-domain
miss while retaining the direct compact-wake route, zero `>40 deg` joint dwell,
roughly `0.031/0.019` or lower normalized planar force/moment, and comparable
far-field translation. Falsify on a worse closest pass, a changed route or
termination class, persistent terminal sign switching, wake loss, material
joint/load growth, or loss of boundedness or reflection equivariance.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: separate slow directional error from fast rhythm-correlated body response before handing authority between propulsive rhythm and redirect
transferable_invariant: persistent target geometry after removal of the observable carrier contribution should set terminal steering sign while the established traveling rhythm remains intact
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific C-start timing and curvature, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target geometry and the two observed joint angles to remove the angle-domain carrier-yaw estimate only from terminal pursuit; retain the joint-rate residual for response gating and leave far-field prediction unchanged
falsification: reject if repeat capture, closest approach, and termination do not improve together, or if direct routing, wake coherence, joint reserve, normalized load scale, boundedness, or reflection equivariance degrades

The candidate's CFD evaluation occurs only after this worker exits. All capture
and replay results above are inherited or sampled prior evidence.
