# Target-line-rate redirect handoff candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in quiescent water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm. I inspected every combined keyframe sheet from
release to capture, including the top-down mid-plane vorticity row and oblique
body/Lambda2 row. Each fish self-propels on the same direct down-left route and
leaves a compact, alternating, body-connected three-dimensional wake. There is
no sampled failure sheet; the weakest finite capture is therefore the visual
comparison, while the inherited `1.01--1.22L` left exits remain the semantic
failure boundary. The common carrier and far-field route do not need repair.

The unified response-plus-predicted-miss policy `solver_e0a2513d969f` remains
the strongest sampled controller: it captures at `15.5008T`, scores
`-0.02109`, has distance integral `1.90236L`, and crosses with velocity
`(-1.286,-0.014)L/T` and raw head-relative predicted course miss `0.179L`.
Its normalized peak planar force/moment is `0.0365/0.0180`, neither joint
dwells beyond `40 deg`, and the near-rate band occupies about `17.8/17.0%` of
samples. The assigned duty-skew parent `solver_11c13c1fcaff` preserves the
same route, wake, load class, and capture, but arrives at `15.9148T`, scores
`-0.02231`, crosses at `(-0.711,-1.038)L/T`, and widens predicted course miss
to `0.717L`; posterior `>40 deg` dwell also returns at `0.138%`.

The other sampled and inherited terminal refinements close several tempting
follow-ups. Active carrier-yaw arrest, course-confirmed release, centered
amplitude relief, and unused-authority moment rejection all capture, but end
with `0.679--0.747L` predicted course miss and scores
from `-0.02175` to `-0.02329`; none improves the centered sample. The moment
residual also raises peak normalized planar force slightly to `0.03746`.
Together with the inherited static-curvature, phase-selective-pulse, and broad-braking
negatives, this rejects further gain changes to those mechanisms. Across the
sampled near field, absolute inertial target-line rate is materially separated:
the centered capture ends near `0.411/T`, whereas the duty-skew, yaw-arrest,
and amplitude-relief captures end near `1.57--1.70/T`. Target-line rotation is
therefore a measured terminal error that neither body yaw nor hydrodynamic
moment represents reliably.

## Single candidate hypothesis

Return to the strongest sampled unified controller, preserving all of its
owned parameters, state-feedback traveling carrier, posterior lag and pulse,
far-field pursuit/course blend, predicted-miss geometry, bounded mean bend,
and response-plus-miss consensus. Change only the redirect-to-cruise handoff.
When that consensus releases a bounded share of rhythmic target steering,
transfer the same share to a target-line-rate request instead of leaving it
idle. Compute inertial target-line rate from the cross product of normalized
body-frame target and translational velocity divided by squared distance, then
smoothly bound it on the observed terminal scale. This signal strengthens as a
closing trajectory becomes tangential, but it cannot enlarge the existing
half-cycle asymmetry envelope, alter the carrier, or act in the far field.

The hypothesis is that a target-relative redirect handoff retains the direct
compact-wake capture while arresting the repeated lateral crossing class that
instantaneous yaw, moment, duty skew, and mild drive relief did not correct.
Support requires capture with raw terminal course miss below `0.590L`,
preferably near `0.179L`, and arrival/score comparable to the unified sample,
while preserving negligible `>40 deg` dwell, near-rate occupancy near the
sampled `18%` class, and normalized peak planar force/moment at or below about
`0.037/0.019`. Falsify on a miss or left exit, terminal course miss at or above
`0.590L`, slower lateral capture without margin improvement, changed far-field
route, wake decoherence, increased joint/load class, nonfinite commands, or
loss of reflection equivariance. Formal CFD is deferred to EvE and is not
claimed as evidence in these notes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded residual path following
source_mechanism: preserve an autonomous rhythmic propulsive carrier while sensed directional error modulates a bounded steering channel
transferable_invariant: redirect authority should remain target-relative during the return to cruise, and a persistent rotation of the target line during closing is a navigation error rather than carrier yaw or vortex phase
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, clock phase, dimensional frequency, exact vortex phase, task coordinates, capture routes, and source-task waypoints
policy_translation: compute signed target-line rate from normalized body-frame target and velocity, then transfer only the already-released shared half-cycle authority to its bounded correction while retaining the two-joint traveling carrier and common response-plus-miss handoff
falsification: reject if capture margin, terminal course, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `26,244`-state grid
over normalized body-frame target geometry and velocity, heading response, and
both joint angles and rates produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The target-line-rate handoff changed `6,786` grid states and differed from the
strongest sampled unified parent by as much as `3.86158 rad/T^2`, confirming an
active feedback mechanism rather than a comment or scalar-gain edit. These are
algebraic checks only; formal CFD remains deferred to EvE.
