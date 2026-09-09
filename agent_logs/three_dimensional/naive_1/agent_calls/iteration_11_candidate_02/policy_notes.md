# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
finite moving-window transport, and `capture`. I inspected the combined
top-down vorticity and oblique body/Lambda2 sheets for the highest-score sample
(`solver_072da2f3a45e`), both executions of the prefilled policy, and the
geometry-only half-cycle sample. No sampled failure termination is present, so
the lowest-score exact-policy repeat (`solver_2a49b91aea58`) is the informative
failure-to-improve comparison; the inherited near-miss and domain-exit records
remain the applicable failure evidence.

The sheets show one physical class. Each fish self-propels from a uniform
quiescent field, builds a coherent alternating caudal street in the top-down
row, retains compact paired three-dimensional caudal structures in the oblique
row, and follows the same broad target-directed curve into first crossing.
There is no visible wake collapse, passive advection, collision, domain exit,
or numerical instability before capture. Head-sampled crossflow, planar force,
and yaw-moment ranges overlap across the diagnostics, so the small scalar
ordering is not supported by a distinct wake or load class.

Two samples execute the identical prefilled policy SHA
`b0fd145a012b0623f37abe8b3c3ae479075c8a54adcce7d409eb97f5af4f391d`.
They capture at `18.86499T` and `19.00799T`, with scores `-0.21654` and
`-0.21164` and scored mean distances `2.10468L` and `2.09994L`. That exact
repeat bounds the resolved variation: the geometry-only half-cycle policy at
`18.88149T`, `2.10234L`, and `-0.21389`, and the approach-envelope policy at
`19.05201T`, `2.09874L`, and `-0.21057` do not establish semantic improvement.

In particular, the inherited `20%` terminal Van der Pol amplitude relief does
not meet its actuator-relief hypothesis. Below `1.5L` it averages speed
`0.8863L/T`, inside the identical-policy values `0.8724--0.8971L/T`; terminal
acceleration contact is `65.6%/78.0%`, also inside or worse than the repeated
`60.0--66.8%/76.2--78.2%`. Overall rate contact remains
`10.91%/14.75%`, within the repeated `10.73--10.87%/14.70--15.13%` band.
Together with the inherited loss of capture under pointwise outward-rate
barriers, this rejects another scalar approach-envelope or clipping edit.
Inherited logs likewise show that raw terminal velocity lead and an added
bearing-progress qualifier did not improve the captured route, while a
line-of-sight transverse-velocity residual caused a coherent-wake near miss
and later domain exit. I therefore remove the unproven instantaneous terminal
lead rather than adding another response qualifier.

## Single-candidate policy hypothesis

Test the assigned parent's unevaluated-in-this-sample-set posterior-only
half-cycle allocation as one isolated actuator mechanism. Preserve the sampled
geometry-authoritative lateral target request, one-sided correcting-yaw
release, opposite-sign mean curvature, state-feedback traveling bend,
posterior lag, and exact final acceleration projection. Keep anterior mean
curvature steady. Infer caudal half-cycle alignment from posterior joint
displacement relative to its geometry-owned bias, normalized by the owned
oscillator amplitude, and multiply only the posterior bias by a positive
bounded factor in `[0.8,1.2]`. This cannot invert target-owned steering or
change the public envelope.

The hypothesis is that steady anterior curvature supplies prompt route
authority while phase-selective posterior curvature concentrates steering in
the caudal half-cycle that can generate useful lateral impulse, without the
anterior center motion of the sampled both-share multiplier or the beat-scale
route modulation of terminal slip. Falsify it if capture is lost; the broad
route, arrival, or distance integral is not meaningfully outside the exact-
policy repeat band; the top-down street or oblique caudal structures lose
coherence; rate contact or loads materially worsen; reflection symmetry
breaks; or returned acceleration exceeds the owned envelope. The new CFD
outcome is unavailable to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping, interpreted through elongated-body tail emphasis
source_mechanism: concentrate bounded turning asymmetry in the target-useful caudal half-cycle while an anterior joint sustains the traveling bend
transferable_invariant: persistent normalized body-frame target geometry owns turn sign, while observed posterior joint phase may redistribute but never invert the posterior share of bounded mean curvature
nontransferable_details: published gains, clock phase, duty ratios, dimensional frequencies, motor models, species-specific kinematics, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: remove the unproven instantaneous terminal lead; preserve the geometry-only captured carrier and scale only its posterior target-signed bias by a positive bounded function of normalized posterior displacement
falsification: reject on lost capture, unchanged route within exact-repeat variation, lost wake coherence, materially worse rate or load histories, broken reflection equivariance, or an out-of-envelope command
