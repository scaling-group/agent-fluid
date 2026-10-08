# Candidate wake-policy notes

## Evidence diagnosis

The only sampled rollout is both the strongest finite segment and the
informative failure segment available for this first Phase-2 candidate.  It is
a valid direct-uniform still-water rollout (`U_infinity=0`, no prewarm), so its
motion is not ambient advection.  In both keyframe rows the fish sheds a
coherent alternating wake and self-propels from `(21,14)L` toward the target:
distance falls from `12.3277L` to `4.7800L` at `t=17.853T`.  The oblique row
also shows a finite three-dimensional Lambda2 wake rather than a planar-only
rendering artifact.

The useful approach does not survive its steering error.  Over the early
approach, two-period averages show bearing falling to about `0.08 rad`; later,
as the posterior joint mean grows from about `+0.04` to `+0.20 rad`, heading
rises from about `0.42` to `0.93 rad` and bearing opens beyond `1.2 rad`.
After closest approach the fish continues mostly downward: the center reaches
`y=0.798L`, termination is `left_domain` at `27.495T`, and final distance is
`9.7089L`.  At representative late samples body speed is near `0.8 U` while
measured local flow is only about `0.02 U`; this is persistent self-generated
cross-track motion, not a strong external wake event.  The run is numerically
stable, so adding propulsion or reacting to local vortices would not address
the observed failure.

## Policy hypothesis

Preserve the evidenced state-feedback oscillator, posterior lag, and far-field
cadence.  Replace the inherited sign-asymmetric, tail-only curvature plus
half-cycle acceleration perturbation with one bounded mean-curvature mechanism:
body-frame target bearing requests the bend sign, normalized lateral body slip
increases the request only when translation is cross-track, and measured yaw
rate releases the bias once rotation is correcting the bearing.  Center the
anterior oscillator on a modest share of this curvature and give the posterior
joint the larger remaining share, retaining the traveling bend while creating
a persistent turn moment.  The rollout directly supports reversing the old
positive-mean-bend association for positive target bearing; the new mapping is
reflection-equivariant rather than a fixed world-direction command.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical carangiform propulsion
source_mechanism: target-driven mean-curvature bias superposed on a posterior-lagged traveling bend
transferable_invariant: persistent route error should shift the oscillation center with modest anterior and stronger posterior curvature, while measured corrective yaw releases the shift
nontransferable_details: published gains, clocked CPG phase, species amplitudes, exact tail-beat timing, and task-specific routes
policy_translation: map normalized body-frame bearing, lateral velocity, and yaw rate to one bounded signed curvature; center joint 1 on a smaller share and joint 2 on the remaining posterior share while preserving state-derived phase lag
falsification: reject if bearing does not contract before the prior 17.853T closest-approach point, if minimum distance does not improve on 4.7800L, or if the coherent propulsive wake and forward progress collapse

## Scope

No same-worker CFD result is claimed.  This candidate tests one controller
mechanism against the inherited rollout; downstream evaluation must decide
whether its curvature sign and distribution transfer to the L64 dynamics.
