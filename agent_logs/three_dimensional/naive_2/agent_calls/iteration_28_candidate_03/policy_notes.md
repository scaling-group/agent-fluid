# Centered-approach joint-dissipation candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
finite dynamics, and `capture` termination. I inspected each combined sheet
from release through capture, including the top-down mid-plane vorticity row
and the oblique body/Lambda2 row. Every fish self-propels on essentially the
same direct down-left route behind a compact alternating wake. The coherent
posterior three-dimensional structures persist through capture, with no sign
of passive advection, wake collapse, a route loop, boundary contact, or
instability. The useful comparison is therefore terminal control on a proven
carrier; inherited `1.01--1.22L` left exits remain the semantic failure
boundary.

`solver_e0a2513d969f` is the strongest sample: its unified response-and-miss
controller captures at `15.5008T`, scores `-0.02109`, and crosses with
terminal speed `1.286U` and raw constant-course miss `0.179L`. Its per-joint
near-rate occupancy is about `19.1/18.1%`, peak normalized planar
force/moment is `0.0365/0.0180`, and neither joint dwells beyond `40 deg`.
Carrier-insensitive terminal-request blending (`solver_9b34df41b425`) and
active yaw arrest (`solver_1900be936beb`) preserve the same route and wake but
cross later and more laterally, at raw misses `0.682L` and `0.747L`.

The assigned parent's approach-hold mechanism is now sampled in
`solver_6a4dfc32a317`. Reducing the nominal anterior limit-cycle amplitude by
as much as 25% during a centered closing approach preserves capture, the
direct route, zero `>40 deg` dwell, and the compact load/wake class. It does
not produce the proposed relief: arrival/score worsen to
`15.6738T/-0.02289`, terminal miss widens to `0.679L`, terminal speed rises
slightly to `1.300U`, near-rate occupancy remains `19.2/17.6%`, and peak
force/moment remains `0.0366/0.0182`. The implementation changes only the
Van der Pol nonlinear damping scale; the dominant harmonic restoring term
and posterior tracking remain active. Further amplitude-share or gate-gain
tuning would therefore be scalar iteration on a mechanism that did not alter
the measured terminal gait.

## Single candidate hypothesis

Return to the strongest sampled unified response-and-predicted-miss
architecture, preserving its far-field navigation, constant-course
prediction, carrier-separated response gate, rhythmic steering handoff,
terminal mean bend and posterior pulse, and the entire evidenced traveling
carrier. Add one new feedback mechanism: bounded virtual joint damping. The
same reflection-invariant consensus of proximity, reliable closing motion,
and small predicted miss gates a dissipative acceleration opposing each
observed joint velocity. It directly removes beat energy rather than changing
the weak nonlinear amplitude regulator, and it disappears continuously for a
receding or off-course intercept so full propulsion and redirect authority
return without a timer or route state.

The hypothesis is that direct centered-approach dissipation will preserve the
compact-wake direct capture while materially reducing terminal speed or joint
near-rate occupancy. Support requires capture, preferably with raw terminal
course miss below `0.590L`, plus terminal speed below `1.20U` or at least a
two-percentage-point reduction in each joint's near-rate occupancy, without
peak normalized planar force/moment above about `0.037/0.019`, persistent
angle dwell, or loss of far-field progress. Falsify on a miss or left exit,
slower arrival without added margin/reserve, unchanged speed and rate
occupancy, early route deflection, wake decoherence, command chatter or
saturation, nonfinite output, or broken reflection equivariance. Formal CFD
for this candidate remains deferred to EvE and is not claimed as evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture scheduling
source_mechanism: preserve autonomous rhythmic propulsion while sensed approach state recruits a bounded dissipative gait transition, with normal drive restored when approach consensus is lost
transferable_invariant: approach relief must directly reduce rhythmic joint energy only when proximity, closing motion, and small target-relative course miss agree; it must vanish for receding or off-course motion
nontransferable_details: published CPG and damping gains, robot linkage geometry, species-specific amplitude envelopes, dimensional frequency, clock phase, exact vortex phase, task coordinates, and fixed routes
policy_translation: gate velocity-opposing acceleration at both joints with normalized body-frame target/velocity geometry while retaining the two-joint state-feedback traveling carrier and its rhythmic steering mechanism
falsification: reject if capture margin or termination worsens, if terminal speed and rate occupancy remain unchanged, or if direct routing, compact wake, normalized loads, boundedness, or reflection equivariance degrades

## Validation boundary

The prescribed guidance-materiality, lightweight Julia policy-contract and
parameter-schema, and solver editable-boundary checks pass. A deterministic
`59,049`-state grid over normalized body-frame target geometry and velocity,
distance, heading response, both joint angles, and both joint rates produced
finite commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). Against the strongest sampled
unified parent, the new channel changed a centered-closing command by
`5.57154 rad/T^2` and some grid commands by `11.27674 rad/T^2`, while a
near-target receding state changed by exactly `0.0`. This establishes that the
mechanism is active and that its fallback is algebraically intact, but does
not predict hydrodynamic benefit. Formal CFD remains deferred to EvE after
this worker exits.
