# Candidate diagnosis and hypothesis

The assigned parent guidance, sampled rollouts, and inherited scores agree
that the carrier is no longer the main failure.  All sampled evaluations used
direct uniform still water.  In both rows of the combined keyframe sheet,
`solver_8097d423c0eb` visibly self-propels with a coherent alternating planar
wake and compact three-dimensional Lambda2 structures through a long transit.
It approaches the target rather than being advected, but curves past it and
leaves the left margin.  The trace places closest approach at `27.489T` and
`0.829828L`: speed is about `0.659L/T`, projected miss is about `0.807L`, the
redirected joints are only about `-19.9/-23.1 deg`, and their commands have
settled to about `0.31/0.61 rad/T^2`.  Peak planar force and yaw moment remain
about `0.0214` and `0.00981`, so the miss is not a load-spike failure.

The informative `solver_b6ed3f84ab58` failure preserves a visible wake but
stays in the upper corridor, touches the posterior angle boundary, and has
roughly tenfold larger peak force/moment (`0.212/0.0968`).  This rejects more
posterior half-cycle authority or acceleration-headroom exploitation.  The
strict, globally intercept-qualified redirect in `solver_b3b6be8f076f` also
regressed to a `4.278L` minimum, so closing-speed qualification must not hold
the redirect throughout the route.  The inherited step-9 score for
`solver_af63b0225670` is another non-capture (`0.8957L` minimum and `9.289L`
final distance); without its trajectory or policy it corroborates a repeated
terminal near-miss but cannot support a more specific causal claim.

Policy hypothesis: preserve the parent's traveling bend, calibrated steering
side, redirect entry, and release logic outside the approach neighborhood.
Inside that neighborhood only, smoothly deepen the same-sign two-joint
redirect when projected miss is unsafe and measured closing speed is positive.
This terminal curvature schedule is bounded below the joint hard limit and
vanishes for safe intercepts, outbound motion, or range, so it tests terminal
interception rather than another scalar carrier retune.  It should move the
head across the `0.75L` capture circle without reproducing the posterior-only
load topology.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish approach control
source_mechanism: C-start redirect followed by a distance-and-closing-conditioned terminal approach regime
transferable_invariant: preserve an effective propulsive carrier at range and add bounded near-target curvature only while the measured intercept is unsafe and still closing
nontransferable_details: published gains, species-specific kinematics, exact beat or vortex phase, and task-specific routes
policy_translation: normalized body-frame distance, projected miss, and closing speed gate a small same-sign increment to both redirect joint targets
falsification: reject if capture still fails, minimum distance does not beat `0.829828L`, the coherent wake is lost, or angle, speed, acceleration, force, or moment exposure approaches the posterior-only failure
