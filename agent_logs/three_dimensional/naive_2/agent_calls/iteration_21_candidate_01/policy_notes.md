# Closing-course terminal handoff candidate

## Visual and metric diagnosis before editing

All four sampled episodes use direct uniform still-water initialization at
`U_infinity=(0,0,0)`, with no cylinders or prewarm. I inspected the combined
top-down mid-plane vorticity and oblique body/Lambda2 rows for the best-scoring
sample and the lowest-scoring repeat, then compared them with the inherited
phase-separated terminal-bearing failure. The current samples are
self-propelled captures on the same direct down-left route: a compact,
body-connected alternating wake forms by `4T` and localized three-dimensional
structures persist through capture. Three byte-identical pulse policies
capture at `15.983--16.044T` and `0.74723--0.74998L`; releasing that pulse on
measured yaw response also captures at `16.016T` and `0.74859L`. Their score
spread does not identify the pulse or its release as a route mechanism.

The assigned-parent guidance correctly treated those threshold crossings as
fragile because inherited repeats of the same terminal composite missed by
`1.0--1.22L` and exited left. The now-completed parent experiments also
falsify the proposed joint-angle carrier-yaw subtraction: two phase-separated
copies missed at `1.07282L` and `1.21754L`, survived to about `27.5T`, and
exited left. Their combined sheet retains the compact wake and the direct
approach through `16T`, but the fish then curls into a nearly vertical escape.
Thus the failure is terminal steering topology, not advection, missing thrust,
or numerical instability. A replay reduction in request variance did not
translate into CFD capture and must not be treated as evidence that the
joint-angle carrier model has the right phase or offset.

## Single candidate hypothesis

Preserve the evidenced traveling-bend carrier, far-field pursuit/course blend,
constant-course time-to-closest and signed-miss predictor, bounded terminal
mean bend, measured-response half-cycle handoff, and posterior pulse. Change
one scheduling mechanism: while measured body-frame course is still closing
and reliable, let the rotation-invariant signed predicted miss own the
terminal request; smoothly restore raw pursuit only as closing alignment is
lost or speed becomes too low for course prediction. The existing
`course_weight * closing_alignment` supplies this handoff, so no scalar gain or
new route state is introduced.

This leaves the successful direct route and propulsive carrier unchanged while
preventing beat-correlated raw bearing from competing with predicted miss on
the final closing run. Support requires repeated capture or a closest approach
below the inherited `1.0--1.22L` miss band, with the same compact wake,
far-field translation, joint reserve, and low normalized load scale. Falsify
if capture is lost, the route changes before approach, recovery begins too
late after closest approach, the same left-domain curl remains, or wake/joint/
load quality degrades.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and continuous terminal interception
source_mechanism: separate a persistent course-level directional request from fast rhythm-correlated body bearing, and hand authority back to pursuit when the intercept stops closing
transferable_invariant: preserve the established propulsive rhythm while a reliable target-relative course signal owns closing correction and a bounded fallback recovers when that signal loses validity
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific capture kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity dot/cross products to suppress only the raw-bearing share of terminal mean-bend and posterior-pulse requests while course-weighted closing alignment is high; retain raw pursuit at low speed or after closing alignment is lost
falsification: reject if repeated capture or closest-pass/termination class does not improve together, or if the direct route, compact wake, joint reserve, low load scale, boundedness, or reflection equivariance degrades

## Dry validation only

The required guidance-materiality, lightweight Julia contract, deterministic
parameter-schema, and solver editable-boundary checks pass. A `12,960`-pair
reflected state grid spanning target geometry, course, both joint angles and
rates, and yaw response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope (maximum magnitude `29.9999999986`), with all `28/28`
direct parameter references owned and exact reflection error `0.0`. These are
contract and symmetry checks, not CFD evidence. Formal evaluation occurs after
this worker exits; capture, trajectory, wake, joints, and loads remain the
downstream falsifiers.
