# Course-response release candidate

## Evidence diagnosis recorded before the policy edit

All four sampled diagnostics report direct uniform initialization with
`U_infinity=(0,0,0)`, so their translation is self-propulsion rather than
storage-window or prewarm advection. In both rows of the combined keyframe
sheets, the assigned parent `solver_adc862529891` forms a compact alternating
mid-plane wake and discrete oblique Lambda2 structures while moving under its
own power. The carrier remains coherent to the `16.77T` upper-boundary exit,
but the body and wake axis bend upward as the head rises from about `13.74L` to
`15.34L`. Its best distance is `5.658L` and its final distance is `5.843L`.

The yaw-rate failure `solver_97bc3c03d55b` also self-propels and sheds an
organized three-dimensional wake, but turns upward much sooner and exits at
`11.13T`, having reached only `9.175L`. This confirms that visible wake strength
does not substitute for a response-aware route loop. More specifically, the
raw-course and joint-rate-projected slip candidates `solver_b22e8cf1f277` and
`solver_4c50eba7cd00` preserve coherent wakes and improve closest approach to
`4.158L` and `4.128L`; however, their `0.35` slip contribution does not command
a complete course correction. Both cross the target's x line around `20T`
while still roughly `4.2L` high, then continue to the left boundary near
`29.6T` and finish about `9.05L` away. The nearly identical raw and projected
outcomes also show that the sampled two-joint lateral-recoil projection was
not the missing semantic mechanism at that attenuated course weight.

Beat-window reconstruction of the parent trace makes the release issue
explicit: the velocity course is already on the opposite side of the target
course while the body line-of-sight request still asks for the initial turn.
The available instantaneous velocity is phase-contaminated, so it must be
speed-gated and bounded, but the very small local flow (about `0.02--0.03U` in
the inherited diagnostics) means inertial body velocity remains the relevant
route observation.

## Policy hypothesis

Preserve the assigned parent's state-feedback oscillator, posterior lag, yaw
phase cancellation, and limits. Replace heading-only LOS pursuit with a
continuous response release: at low speed use bounded LOS bearing; as body
speed becomes resolved, use the full signed angle from the observed velocity
course to the target vector. This is a semantic change from attenuating slip
inside the bearing request: once the course crosses the target course, the
turn request reverses even if body heading has not crossed LOS yet. It uses
only normalized body-frame `target_body_L`, `distance_L`, and
`velocity_body_U`, and has no clock, coordinate, route, or mutable state.

Expected result: retain the parent's coherent propulsive wake, brake the
initial upward turn earlier, lower the target-line crossing, and improve the
termination class or closest/final distance. Reject the mechanism if it
destroys wake coherence or produces alternating saturated steering without a
lower crossing. That outcome would show that instantaneous course is too
carrier-contaminated and that a genuinely beat-scale observation, rather than
another algebraic joint-rate projection, is needed.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor-modulated mean tail-beat bias with response-triggered turn release
transferable_invariant: preserve the propulsive rhythm while steering sign follows observed route response, so a redirect is released when motion crosses the desired course rather than after a fixed time or delayed body-heading crossing
nontransferable_details: published gains, oscillator timing, robot morphology, species kinematics, exact vortex phase, and source-task paths
policy_translation: preserve the joint-state traveling bend and bounded posterior curvature loop; speed-gate the signed body-frame target-course error from normalized target and inertial velocity observations into the yaw request
falsification: reject if the same high crossing or left-boundary route loss remains, or if command switching weakens the coherent wake and propulsion; then require a truly beat-scale response signal before further course feedback
