# Carrier-separated turn-response preview candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
prewarm, finite dynamics, and capture termination. I inspected every combined
keyframe sheet from release through capture, including both the top-down
mid-plane vorticity row and the oblique body/Lambda2 row. All four policies
self-propel on the same direct down-left route behind a coherent alternating
mid-plane wake and a compact body-connected three-dimensional vortex train.
There is no visible passive advection, wake breakup, boundary interaction, or
instability. The carrier, posterior lag, far-field navigation, and common
response-plus-miss handoff should therefore remain unchanged; the evidence
isolates terminal redirect completion and joint quality.

The score-leading tail-only cubic residual arrives at
`15.1403T/-0.01094`, but its terminal head-relative constant-course miss is
`0.651L`, posterior `>40 deg` dwell is `1.269%`, and peak normalized planar
force/moment are `0.04041/0.01902`. The assigned absolute-reserve parent is
slower at `15.4464T/-0.01764`, yet uniquely centers the sampled course to
`0.362L`; its cost is `0.285/0.996%` anterior/posterior dwell with
`0.03970/0.01889` loads. Dual absolute reserve arrives at `15.2957T` but
widens miss to `0.556L` and retains `0.898%` posterior dwell.

Most importantly, the newly completed approach-scheduled phase-space policy
falsifies the inherited scheduling hypothesis. It recovers the desired
arrival class at `15.2650T/-0.01575` and lowers loads to
`0.03781/0.01864`, but widens terminal miss to `0.529L` and retains
`0.360%` posterior dwell. Its top-down and oblique views retain the same direct
compact-wake topology, so the result is an allocation/scheduling trade rather
than a propulsion improvement. Do not continue distance-gate or projection-
gain variants around `residual * abs(carrier_acceleration)`.

## Single candidate hypothesis

Start from the assigned absolute-reserve parent and preserve its carrier,
target/course blend, constant-course predictor, response-plus-miss handoff,
posterior pulse, residual allocator, parameter magnitudes, and final smooth
acceleration envelope. Add one feedback mechanism before the existing
prediction request: use the already evidenced carrier-separated yaw residual
to estimate the lateral sweep that a correct-sign turn response can produce
over the remaining bounded closest-approach horizon. Bound that sweep by the
owned predicted-miss normalization and let it reduce, but never reverse, the
signed constant-course miss. Wrong-sign yaw receives no credit. The resulting
response-previewed miss drives the existing terminal gates and redirect.

This translates a burst-redirect-to-cruise invariant into current-state
feedback: strong redirection persists until observed response can finish part
of the turn, then relaxes continuously toward the productive carrier. It uses
only normalized body-frame target/course geometry, joint state, and yaw
response; it introduces no clock, history, global direction, route, target
identity, or exact vortex phase. Support requires capture with the direct
compact wake, terminal miss at or below the parent's `0.362L`, anterior and
posterior dwell no worse than `0.285/0.996%`, peak normalized force/moment no
worse than about `0.040/0.019`, and arrival no later than `15.4464T`.
Especially useful evidence would pair the scheduled sample's `15.14--15.34T`
arrival class and lower loads with the parent's margin. Falsify on lost
capture, a wider miss, unchanged dwell/load trade, lost far-field translation,
nonfinite action, or broken reflection equivariance. Formal CFD remains
deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG control
source_mechanism: apply a bounded redirect while geometry is wrong, then release continuously toward the propulsive rhythm as observed heading response develops
transferable_invariant: corrective response already present in the body should reduce the remaining redirect demand without replacing the traveling carrier
nontransferable_details: published gains, dimensional timing, species-specific C-start kinematics, hardware duty ratios, linkage geometry, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: combine normalized body-frame constant-course miss with carrier-separated yaw residual and bounded time-to-closest; credit only correct-sign response, cap its predicted sweep by the existing miss scale, and prevent response preview from reversing the miss sign
falsification: reject if capture margin, arrival, direct compact wake, joint dwell, normalized loads, bounded finite action, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality, lightweight Julia contract/schema, and
solver editable-boundary checks pass without running CFD. A deterministic
`11,664`-state grid spanning normalized body-frame target/course geometry,
distance, heading response, both joint angles, and both joint rates produced
finite commands inside the owned `30 rad/T^2` smooth envelope with exact
left/right reflection (maximum error `0.0`). The response preview changed
`3,861` grid states relative to the assigned parent. Offline evaluation on all
`2,810` logged parent states changed `1,193` actions, including `532` of the
`682` states inside `5L`, while retaining exact reflection. These algebraic
and replay checks establish that the mechanism is active, bounded, and
symmetry preserving; they do not establish a new capture, wake, load, joint,
arrival, or margin result.
