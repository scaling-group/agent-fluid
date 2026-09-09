# Corridor-gated redirect-release candidate

## Visual and metric diagnosis before editing

All four sampled solver evaluations satisfy the frozen evidence contract:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm. I inspected both rows of the combined keyframe
sheets for the highest-score capture and the assigned parent's informative
`left_domain` failure. The capture is self-propelled on a nearly direct
down-left route. Its top-down row retains a compact, body-connected alternating
vorticity street, and its oblique row retains localized paired Lambda2
structures through the `0.74998L` crossing at `15.983T`. Across the four
sampled captures, joint angles remain below `37.9 deg`, rate-envelope
occupancy in the last `10 deg/T` is about `17%` per joint, and sampled peak
normalized planar force/moment magnitudes are only `0.0332--0.0367 /
0.0166--0.0185`.

The assigned parent's angle-domain carrier-yaw subtraction initially follows
the same direct compact-wake route and remains self-propelled, but passes
outside the capture sphere at `1.10362L` and exits left at `27.654T`. Its
top-down and oblique rows retain organized shedding through the miss and show
continued propulsion afterward, rather than collision, wake collapse, passive
advection, or numerical instability. The rollout also stays physically mild:
peak normalized planar force/moment is `0.0340/0.0171`, maximum joint angle is
`40.3 deg`, and near-rate-limit occupancy is about `10%` per joint. This is a
terminal steering/handoff failure, not a propulsion or load failure.

The inherited evidence separates successful and failed terminal geometry more
cleanly than it separates carrier quality. At each sampled capture crossing,
the body's lateral target coordinate is `0.334--0.392L` and the raw
constant-course miss is `0.599--0.652L`. The assigned failure and three other
inherited response-release, carrier-sway, and lagged-follow-through failures
reach their closest points with lateral target coordinate `0.760--0.890L` and
raw predicted miss `0.791--0.897L`, despite similarly compact wakes and low
loads. Those mechanisms terminate at `0.928--1.104L` closest distance and then
exit left. Corrective carrier-separated yaw is therefore insufficient evidence
that steering authority can be released; the remaining normalized capture
corridor must also be small.

## Single candidate hypothesis

Preserve the evaluated traveling-bend carrier, raw far-field pursuit/course
blend, constant-course predicted miss, terminal mean bend, posterior
mid-stroke pulse, and every established gain. Change one handoff mechanism:
permit corrective-yaw feedback to reduce rhythmic half-cycle steering only
when the absolute body-frame lateral target offset is already inside a smooth
terminal corridor. Outside that corridor, keep the existing full half-cycle
redirect authority even if instantaneous yaw appears corrective. The new gate
changes authority magnitude only; the existing body-frame request supplies
sign, and the propulsive carrier remains active on both half-cycles.

Support requires capture or a closer pass than the inherited `0.829--1.104L`
band while retaining the direct compact-wake route, low normalized loads, and
little or no `>40 deg` joint dwell. Falsify on another left exit without a
closer pass, route-class change, wake degradation, materially greater joint or
load occupancy, or loss of boundedness or reflection equivariance. A single
threshold-level capture reproduces the parent class but does not establish
robustness; later workers should look for repeat capture or increased margin.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release bounded rhythmic steering only after both measured turning response and small residual directional error indicate that the redirect is complete
transferable_invariant: corrective response alone is not a completion signal; target-relative corridor error must also be small before returning authority toward cruise
nontransferable_details: species-specific redirect timing and curvature, published CPG gains, clock phase, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use the normalized body-frame lateral target coordinate to gate only the existing corrective-yaw reduction of shared-joint half-cycle asymmetry; retain raw target/course requests, the two-joint carrier, and the posterior pulse
falsification: reject if closest approach and termination do not improve together, or if direct routing, compact wake, joint reserve, low normalized loads, boundedness, or reflection equivariance degrades

The candidate's CFD evaluation occurs only after this worker exits. Every
rollout result above is sampled or inherited prior evidence.
