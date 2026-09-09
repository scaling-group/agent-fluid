# Reproduced response-gated predicted-miss candidate

## Visual and metric diagnosis before editing

All four sampled evaluations use direct uniform initialization in still water,
`U_infinity=(0,0,0)`, with no cylinders or prewarm. I inspected the combined
top-down vorticity and oblique Lambda2 rows for the best finite candidate and
the assigned prefill failure. Both are self-propelled rather than advected:
their wakes grow from the body in the initially quiescent fluid. The useful
difference is trajectory control, not wake existence.

The assigned distance-hold prefill forms an alternating wake but bends into a
broad high-side arc. Its late top-down vorticity follows the curled body away
from the target, and its oblique row shows the same continuing turn before the
fish exits left. The metrics agree: it reaches only `2.70327L`, exits at
`24.5181T` with distance back at `7.05630L`, dwells beyond `40 deg` on the two
joints for `22.7%/35.4%` of samples, and reaches peak normalized planar
force/moment magnitudes of `0.713/0.300`. This is productive oscillation with
failed navigation and excessive late curvature, not passive drift or numerical
instability.

The response-gated predicted-miss policy instead follows a direct down-left
line into the capture circle. Its top-down row retains a compact alternating
wake through arrival, while its oblique row retains body-connected 3D
structures without the failure's large curled posture. The same policy SHA,
`c8459795cfc38bc3ebbebc4120c1427abe9622491e2bc3fae39385b55f1805ca`,
captures in two current samples at `15.9830T/0.749982L` and
`15.9940T/0.747234L`. Across those runs, peak normalized planar force/moment
remain `0.0342--0.0367/0.0173--0.0185`, neither joint exceeds `40 deg`, and
speed remains about `1.19L/T` after entering the `3L` terminal region. Both
joints still occupy the near-rate-limit band for about `17%` of samples, but
the assigned-parent evidence shows that broad carrier braking eliminated rate
occupancy at the cost of translation and still exited a boundary.

Inherited logs clarify the mechanism sequence. A base predicted-miss repeat
missed at `0.96311L`; retaining rhythmic steering until carrier-separated yaw
became corrective improved that topology to `0.81002L`; adding the
joint-phase-gated posterior pulse is present in the now-reproduced captures.
The other sampled base predicted-miss policy also captures at
`16.0105T/0.747725L`, but the response-gated composite has the best sampled
score and two independent current successes. This supports promotion without
confounding the reproducibility test with new gains or an unevidenced reserve
allocator.

## Single candidate hypothesis

Replace the weaker prefill with the exact reproduced composite: a joint-state
traveling-bend carrier, rotation-invariant body-frame target/course residual,
constant-course time-to-closest and signed-miss gate, bounded terminal mean
curvature, carrier-separated yaw-response handoff, and a joint-phase-gated
posterior pulse. The hypothesis is that preserving propulsive rhythm while
measured response controls the steering handoff will reproduce capture near
`16T` with the direct trajectory, compact wake, no large-angle dwell, and low
normalized loads.

Falsify on loss of capture, recurrence of the lower-left or broad high-side
escape, materially higher load or joint-limit occupancy, reduced far-field
translation, or loss of wake coherence. The roughly `17%` near-rate-limit
occupancy remains an applicability boundary; later work should test a
selective allocation mechanism only if it can retain the repeated capture and
translation, rather than adding the already-disfavored broad braking.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish interception
source_mechanism: preserve a propulsive rhythm while observed directional response governs steering release and observed joint phase gates a bounded posterior correction
transferable_invariant: separate rhythmic propulsion from target correction, release rhythmic steering only after corrective response is observed, and recruit posterior authority only in an observed active joint phase
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract the two-joint-rate carrier contribution from yaw response, and gate a target-signed posterior offset by normalized anterior-joint speed
falsification: reject if repeated capture, useful trajectory topology, compact wake, joint reserve, and low normalized loads do not remain jointly favorable

## Evaluation boundary

The candidate CFD evaluation occurs only after this worker exits. The evidence
above belongs to completed sampled and inherited rollouts; no outcome is
claimed for the unevaluated candidate in this workspace.

## Dry validation

The candidate is byte-identical to both current same-hash captures. The
guidance-materiality check, lightweight Julia policy contract, and solver
editable-boundary check pass. These checks establish provenance, schema, and
executable semantics only; no CFD was run in this workspace.
