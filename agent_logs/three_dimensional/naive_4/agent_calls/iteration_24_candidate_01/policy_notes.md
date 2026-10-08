# Candidate visual diagnosis and hypothesis

The four sampled rollouts are valid direct-uniform still-water evaluations
(`U_infinity=0`, no prewarm, no cylinders), and all capture at `16.0544T` with
239 moving-window shifts.  In both the top-down mid-plane row and oblique 3D
Lambda2 row, the fish is visibly self-propelled rather than advected: a
coherent alternating wake grows behind a translating body from release through
the target-directed approach, without a collapse, collision, domain exit, or
3D instability.  The baseline and the comment-only terminal-response variant
have byte-identical combined sheets and trajectories; the line-of-sight slip
and moment-led variants remain visually indistinguishable at sheet resolution.
This agrees with the metrics: the policies share every `8/6/4/2/1.25/0.9/0.8L`
milestone, the same capture step, `49.20/21.86%` anterior/posterior
acceleration-limit residence, and the same reported force/moment peaks.

The informative difference is confined to the terminal fraction of the last
beat.  The assigned parent finishes at `0.745943L`, distance integral
`1.929921L`, and score `-0.047001`.  The translational line-of-sight slip
damper first changes posterior action at `15.9664T`, advances the crossing by
`0.000074L` at the common final step, and improves the integral/final/score to
`1.929859L`, `0.745869L`, and `-0.046924`.  A yaw-moment lead starts at the
same time but changes final distance by only `0.000005L`; the nominal combined
response edit is trajectory-identical.  Thus terminal angular reopening is a
real but very small residual, while further selectors or moment prediction do
not supply a new route mechanism.

Policy hypothesis: preserve the established traveling-bend carrier, redirect,
mean-curvature damping, and all far/middle approach behavior.  Inside the
existing closing capture corridor only, use normalized bearing rate and the
posterior wave sign to identify the half-cycle whose wave curvature reinforces
an already reopening target bearing.  Attenuate only that lobe, continuously
and without reversal or amplification.  This changes feasible carrier action
rather than adding another mean-bend gain, and should reduce the final
line-of-sight reopening while leaving all pre-terminal milestones and both-view
wake coherence unchanged.  Reject the mechanism if it activates outside the
safe corridor, delays or loses capture, increases the distance integral or
limit residence, or visibly weakens the alternating wake before the last beat.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping combined with terminal capture control
source_mechanism: feedback-conditioned half-cycle attenuation during approach hold
transferable_invariant: preserve the propulsive carrier and attenuate only the rhythmic lobe that measurably reinforces a reopening target error
nontransferable_details: published gains, dimensional beat frequencies, clock-driven CPG phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: use body-frame bearing and bearing rate normalized by carrier frequency, posterior wave state normalized by joint amplitude, and the existing distance/closing/intercept gates to reduce one posterior lobe within the two-joint state-feedback contract
falsification: reject if pre-corridor trajectory or wake changes, capture is delayed or lost, final or integral distance regresses, limiting grows, or attenuation occurs on the lobe that unloads the reopening error
