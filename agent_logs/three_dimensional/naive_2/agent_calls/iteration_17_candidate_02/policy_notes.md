# Reproduced predicted-miss interception candidate

## Visual and metric diagnosis before editing

All four sampled rollouts report direct uniform initialization in still water,
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
top-down vorticity and oblique Lambda2 rows for all four, comparing the best
finite response-gated predicted-miss capture with the full-circle pursuit
failure and the other captures. The fish are self-propelled: each top-down row
develops body-connected alternating vorticity and each oblique row develops
three-dimensional wake structures from an initially quiescent field.

The full-circle prefill preserves propulsion but not navigation. Its top-down
sequence bends into a broad high-side arc and its late oblique frames show a
strongly curled body continuing away from the target; the trajectory reaches
only `4.64998L`, then exits left at `20.0337T` and `5.70592L`. Its inherited
load audit reports peak normalized planar force/moment near `0.620/0.261`, so
the broad wake is not evidence for a useful route.

The predicted-miss policies instead travel directly down-left behind a compact
alternating wake and retain body-connected Lambda2 structures through the
capture circle. The base architecture captures at `16.0105T` and `0.747725L`.
More importantly for the assigned parent, the exact response-gated policy with
a joint-phase posterior pulse has policy SHA
`c8459795cfc38bc3ebbebc4120c1427abe9622491e2bc3fae39385b55f1805ca`
in two independent sampled evaluations and captures both times, at
`15.9830T/0.749982L` and `16.0435T/0.749337L`. Their terminal body phase and
velocity differ, but both sheets retain the same compact wake topology. The
assigned-parent audit also reports zero joint dwell beyond `40 deg` and peak
normalized planar force/moment near `0.0342/0.0173`; its remaining concern is
about `17%` near-rate-limit occupancy on both joints, not loss of propulsion or
capture.

Inherited logs establish why each part of the composite is retained. An
identical base predicted-miss repeat previously missed at `0.96311L` and
escaped lower-left; yaw-response-gated release of rhythmic steering improved
that repeat to `0.81002L`, and the subsequent joint-phase posterior pulse is
present in both current same-hash captures. By contrast, static curvature,
distance-only holds, full-circle pursuit, and broad rate braking all preserved
weaker failure topologies. The new evidence supports replication of the
composite, not stronger gains or an additional rate barrier.

## Single candidate hypothesis

Replace the weaker prefill with the exact independently reproduced composite:
the joint-state traveling-bend carrier; rotation-invariant body-frame
target/course residual; constant-course time-to-closest and signed-miss gate;
bounded terminal mean curvature; carrier-separated yaw-response handoff; and
joint-phase-gated posterior pulse. No scalar or mechanism change is added.
This candidate asks whether the first same-hash repeat success survives a third
evaluation without obscuring the answer with another controller change.

Support is capture near `16T` with the direct targetward trajectory, compact
alternating 3D wake, zero `>40 deg` dwell, and normalized planar force/moment
near `0.034/0.017`. Falsify on loss of capture, recurrence of the lower-left
escape, materially larger loads or angle/rate occupancy, weaker far-field
translation, or loss of wake coherence. The roughly `17%` rate-envelope use is
an audit boundary; prior broad braking lost translation, so it does not justify
changing the reproduced candidate before a selective allocation mechanism is
tested separately.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish interception
source_mechanism: preserve rhythmic propulsion while observed directional response governs the handoff of steering authority and observed joint phase gates a brief posterior correction
transferable_invariant: separate propulsion from target correction, release rhythmic steering only after corrective response is observed, and recruit bounded posterior authority only during an active joint-state phase
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract two-joint-rate carrier yaw from heading response, and gate a target-signed posterior offset by normalized anterior-joint speed
falsification: reject if repeated capture, useful trajectory topology, compact wake, joint reserve, and low normalized loads do not remain jointly favorable

## Dry validation only

The candidate is byte-identical to both sampled same-hash captures. The
mandated guidance-materiality check, Julia policy contract, deterministic
parameter-schema guard, and solver editable-boundary check pass. These checks
establish provenance and executable semantics only. No CFD was run in this
workspace; downstream capture, trajectory, wake, joint, and load outcomes are
future evidence and are not claimed here.
