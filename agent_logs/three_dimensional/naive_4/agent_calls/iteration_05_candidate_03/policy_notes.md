# Candidate diagnosis and hypothesis

## Evidence diagnosis recorded before the policy edit

The assigned parent guidance establishes that the target-blind `0.55T`,
`28 deg` carrier self-propels with a coherent alternating wake but cannot hold
the initially small body-frame bearing. Its inherited result reached only
`12.078L` before an `8.547T` upper-boundary exit, so extra open-loop drive is
not the missing capability. The inherited optimizer logs also show that
posterior bearing/trend steering was only a partial improvement, while shared
anterior bias suppressed the carrier; the anterior oscillator equilibrium
therefore remains unchanged here.

All four current sampled rollouts satisfy the direct-uniform still-water
contract (`U_infinity=(0,0,0)`, no prewarm, and no cylinders), are finite, and
end at the upper virtual boundary. Their top-down rows show self-propelled
leftward translation and alternating vorticity, and their oblique rows confirm
three-dimensional caudal Lambda2 structures rather than passive advection.
The most informative controlled comparison is the course-weighted posterior
mean-curvature policy `solver_ab59732b5ad0` against
`solver_324d10ed189d`, which adds one-sided posterior wave relief while leaving
the carrier and course law unchanged. Relief preserves the wake, improves
minimum distance from `6.218L` to `5.144L`, extends the episode from `16.879T`
to `18.975T`, and reduces returned posterior acceleration-limit residence from
about `60.8%` to `35.9%`. This is evidence to preserve wave relief rather than
amplify an already clipped half-cycle.

The best rollout is still a partial mechanism. Its top-down path and oblique
wake both bend upward after the useful leftward run; it reaches minimum
distance near `15.31T`, then recedes to `6.297L` and exits at center
`y=15.203L`. Reconstructed normalized body-frame signals expose an earlier
opportunity: near `10T`, bearing remains about `+0.12 rad` while the lateral
course angle is already about `+0.49 rad`. The fixed `0.55` course weight asks
for only about `-0.15 rad` of correction, whereas the actual target-versus-
course residual is about `-0.37 rad`. By `12T`, bearing/course are about
`-0.17/+0.67 rad`; the fish is already in a large lateral overshoot. The
sampled exact-course policy `solver_270f6c358fd0` improves on the prefilled
speed-reliable policy (`7.558L` versus `8.515L`) but, without wave relief,
still spends about `56.1%` of samples at the posterior acceleration limit.
Thus exact course feedback and one-sided relief are individually incomplete
but form a small evidence-compatible combination.

## Policy hypothesis

Retain the autonomous anterior carrier and the evidenced posterior one-sided
wave relief. At release or reverse motion, use bounded body bearing because a
velocity direction is ill-conditioned. As normalized forward speed becomes
reliable, hand authority smoothly to the exact signed body-frame angle from
velocity to target. Feed the resulting target-versus-course request to the
same bounded posterior mean tangent and attenuate only the posterior wave lobe
that opposes that request. This should start lateral-course correction before
bearing alone exposes the overshoot, while retaining the posterior headroom
and coherent wake demonstrated by the strongest sample.

The downstream evaluation should show a course reversal earlier than the
best sample's `10--12T` divergence, a minimum distance below `5.144L`, and
either a later exit or a better termination class without posterior limit
residence returning toward `60%`. Falsify the combination if it loses the
alternating wake or leftward progress, performs no better than `5.144L`, or
retains the same upper-exit topology without earlier lateral-course response.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: bounded target-feedback course correction combined with one-sided half-cycle wave relief
transferable_invariant: preserve a propulsive traveling bend while reliable target-versus-course error modulates only the oscillatory lobe opposing the requested turn
nontransferable_details: published gains, duty ratios, clocked CPG phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: blend body bearing into the exact signed body-frame velocity-to-target angle using normalized forward-speed reliability, then apply bounded posterior mean curvature and state-phased relief inferred from joint state
falsification: reject if wake coherence or forward progress is lost, closest approach does not beat 5.144L, posterior limit residence rises toward 60 percent, or the same upper exit occurs without earlier course correction

The candidate has no same-worker CFD result; these expectations are for the
downstream evaluation.
