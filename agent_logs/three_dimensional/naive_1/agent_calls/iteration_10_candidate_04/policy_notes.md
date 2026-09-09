# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations satisfy the direct-uniform still-water contract:
`initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders, and
`termination=capture`. I inspected each combined keyframe sheet. From release
to capture, both the best-scoring half-cycle composition
(`solver_a2a24e9e57f4`) and the assigned projected parent
(`solver_d719dd4d6ef7`) visibly self-propel rather than advect: the top-down row
develops a coherent alternating street behind the tail, while the oblique row
shows compact paired caudal Lambda2 structures and a target-directed track.
Neither view indicates a wake collapse or numerical instability immediately
before capture. The four sampled sheets are visually close; none is a failure
example, so the meaningful comparison is within the finite capture class. The
inherited failure evidence remains the terminal course-residual near miss and
left-domain exit, for which no sampled failure keyframe is present here.

The scalar and trace evidence separates the sampled captures. The assigned
projected parent captures at `19.1345T`, with scored mean distance `2.12198L`
and score `-0.23300`. The terminal body-lateral lead captures at `19.0190T`,
`2.11536L`, and `-0.22671`, but inherited matched comparisons show velocity
lead effects of opposite sign, so it is not established as the cause. Adding
joint-state half-cycle steering in the best sample captures at `19.0080T`,
reduces scored mean distance to `2.09994L`, and improves score to `-0.21164`
while preserving both wake views. It does not establish load relief: projected
acceleration contact is about `61.1%/73.1%` and rate contact about
`10.7%/14.7%`, close to the parent capture class. The inherited response-
qualification test also failed to improve the capture band, so another
velocity or response gate is not justified.

## Policy hypothesis

Apply exactly one new actuator mechanism to the assigned parent: positively
bounded, target-side half-cycle modulation of its existing differential mean
curvature. Infer beat alignment from the observed anterior joint displacement
relative to the state-feedback oscillator center, normalized by oscillator
amplitude. Strengthen both existing bias shares on the useful displacement
half-cycle and weaken them on the opposed half-cycle without changing their
sign or ratio. Keep the target lateral fraction as the persistent route sign,
keep the response-release rule and traveling-bend carrier, and retain final
acceleration projection. Do not compose the unproven terminal velocity lead.
This clean candidate tests whether the half-cycle mechanism, rather than that
lead, caused the best sampled trajectory.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: half-cycle amplitude or duty-ratio asymmetry layered on a propulsive rhythm
transferable_invariant: infer beat side from observed joint state and shift bounded steering authority toward the target-useful half-cycle while preserving the traveling wave
nontransferable_details: published gains, clock phase, species-specific kinematics, exact duty ratios, vortex phases, and task routes
policy_translation: normalize centered anterior displacement by owned oscillator amplitude and use a positive bounded scale on the existing target-signed anterior/posterior biases; retain static target sign, carrier, and hard acceleration projection
falsification: reject if capture is lost, both wake views lose coherence, route or scored mean distance fails to improve beyond the 19.019--19.228T and 2.1154--2.1259L capture band, or acceleration/rate/load statistics materially worsen
