# Candidate diagnosis and hypothesis

The assigned parent and all three peer samples satisfy the experiment contract:
they start from direct uniform still water (`U_infinity=0`), self-propel rather
than advect, preserve an alternating coherent top-down wake and compact 3D
Lambda2 structures, and reach the `100T` horizon. Their combined sheets show the
same broad closed-loop return rather than a flow or stability failure. None is
captured: the parent harmful-impulse posterior damping reaches `2.294L`, the
dual-joint energy variant `2.320L`, the joint-state bend release `2.215L`, and
the posterior turn-response phase variant `2.439L`; final distances remain
`3.31--3.47L`.

The common failure is resolved in control state, not just in the images. At
each sampled minimum the fish still translates at about `0.677--0.681U`, the
target is behind and lateral (`target_forward` about `-0.83`), the course error
is about `1.70 rad`, and useful signed yaw is only about `-0.25--0.27 rad/T`.
Both joints have converged to nearly the same quiet negative C-bend
(`q1` from `-0.359` to `-0.356 rad`, `q2` from `-0.379` to `-0.376 rad`, joint speeds at most
`0.003 rad/T`) and commands are small. Thus the wake remains propulsive but the
traveling joint wave has been replaced by a parked turn while the body moves
tangentially past the target. The parent's force-conditioned tail damping does
not solve that state: it is outside `2L`, never enters the anterior carrier's
strong terminal gate, and does not restore phase propagation.

Policy hypothesis: remove the failed force-conditioned posterior residual and
preserve the evidenced mean-curvature, C-turn, course-response, lagged tail,
and symmetric anterior low-activity carrier. Add one geometry-gated
inter-joint phase-coupling release. Only when the target is behind, the course
is nonclosing, and anterior phase-plane activity is low, use the normalized
measured `q1-q2` split to give joint 1 a bounded release acceleration. This
split has the mirror-equivariant sign needed to unpark the sampled common bend,
but the low-activity gate removes the coupling once the traveling wave resumes.
The intended semantic change is a tighter powered return with active anterior
motion, not scalar drive relief or a different static equilibrium.

bookshelf_consulted: true
source_domain: robotic-fish coupled CPG control and traveling-wave propulsion
source_mechanism: state-coupled oscillators preserve inter-joint phase propagation instead of allowing a reciprocal or parked bend
transferable_invariant: use measured relative joint phase to restore a directed traveling bend while slow body-frame target geometry selects when recovery is needed
nontransferable_details: published oscillator gains, clock phase, species-specific envelopes, exact tail-beat timing, and source-task routes
policy_translation: gate a bounded anterior acceleration from normalized `q1-q2` by target-behind nonclosing response and low measured anterior activity, while retaining the existing posterior lag target
falsification: reject if the first return changes before the recovery gate, either joint parks again, clamp residence or loads worsen materially, wake propagation is lost, or closest/near-target/mean/final distance do not improve jointly over the sampled parked-loop class
