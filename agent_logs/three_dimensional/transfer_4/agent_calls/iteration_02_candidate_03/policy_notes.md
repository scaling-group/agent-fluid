# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and both the
top-down mid-plane and oblique Lambda2 views are present. The views show that
all four controllers self-propel and retain an alternating three-dimensional
caudal wake; the semantic difference is course control rather than advection
or wake collapse.

The strongest example is the prefilled signed-curvature policy. Its top-down
row shows a broad but continuously closing route that turns onto the target,
and the oblique row retains organized caudal structures through capture. It
reaches `0.74968L` at `23.353T`, with mean distance `2.41468L`, peak speed
about `0.752 L/T`, peak planar force coefficient `0.0367`, and peak yaw-moment
coefficient `0.0183`. Joint angles remain below `27.62` and `37.19 deg`; joint
rates touch the envelope in about `8.74%` and `1.51%` of samples. Raw requested
accelerations still exceed the evaluator envelope in about `70.0%` and
`51.8%` of samples, so the capture is evidence for curvature polarity, not for
desaturation.

The informative failures preserve visible thrust but add mechanisms around
the inherited lower-boundary miss. The assigned parent's course redirect
improves closest approach to `4.0215L` but crosses to the upper boundary and
finishes at `8.6664L`; the steering-reserve allocator exits the upper boundary
at its `6.2764L` closest approach; and the geometry burst redirect reaches
`5.7746L` before reversing to the lower boundary and `13.0563L`. The latter
two also raise peak planar force/moment coefficients from the captured run's
`0.0367/0.0183` to approximately `0.2045/0.0932` and `0.2366/0.1076`.
Together with the inherited logs, this falsifies the idea that another large
redirect or generic acceleration reservation should be stacked onto the
captured controller merely because its raw commands clip. The simple bounded,
odd map from requested yaw correction to same-sign posterior mean tangent is
the only sampled mechanism that crosses the capture radius and should remain
the controlled baseline.

## Candidate hypothesis

Preserve the captured policy's guidance, signed mean curvature, half-cycle
asymmetry, and traveling-wave carrier. Add one rotation-invariant propulsion
gate, not another steering residual: inside the existing `2.10L` approach
region, continue the established cadence when the normalized body-frame dot
product of target direction and translational velocity shows that the fish is
already moving toward the target. The gate vanishes at low speed or poor
course alignment and cannot alter behavior outside the approach region,
because the existing distance gate is already one there.

On replayed states from the captured rollout, target/velocity alignment
averages `0.962` after the fish enters `2.10L`. The current frequency scale
falls from about `1.092` to `1.044`; the proposed continuous course gate holds
it near `1.09`. Recomputing commands on those inherited states changes the
fraction above the acceleration envelope only from approximately
`0.700/0.519` to `0.701/0.520`. This is a state replay, not new CFD evidence.
The intended test is a shorter arrival with the same capture topology and
coherent wake. Falsify the mechanism if capture is lost, arrival or integrated
distance worsens, the fish overshoots the radius, or actuator/load histories
materially deteriorate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target approach
source_mechanism: preserve a propulsive oscillator while observed target-course alignment continuously schedules its cadence
transferable_invariant: maintain the traveling wave when body-frame velocity is already closing along the target direction, and release the extra drive when alignment or speed disappears
nontransferable_details: published CPG gains, dimensional beat frequencies, species kinematics, prescribed routes, exact vortex phases, and source-task terminal maneuvers
policy_translation: use the normalized dot product of body-frame target and velocity plus a bounded speed gate to floor the existing cadence only inside the distance-conditioned approach region
falsification: reject if the next rollout loses capture, arrives later, raises saturation or loads materially, or replaces the captured route with a near-target overshoot
