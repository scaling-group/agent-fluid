# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

All sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, and no cylinders. The combined sheets show
self-propulsion rather than advection. Their top-down rows develop alternating
mid-plane vorticity, while the oblique rows show coherent three-dimensional
Lambda2 structures shed behind the caudal region.

The posterior mean-tangent controller is the strongest finite comparison. It
keeps the anterior oscillator uncentered, advances the center from `x=21.000L`
to `19.253L`, reaches `11.512L`, and survives to `9.823T`. Its wake remains
organized, but the path still hooks upward and ends at `y=15.203L`. At `7T`
the body-frame lateral velocity is about `+0.321U` while target bearing is
already `-0.219 rad`; by `8T` bearing is `-0.925 rad` and recent yaw is
`-2.175 rad/T`, so translation and rotation are both still carrying the fish
away from the required correction. The posterior action also spends about
`27%` of samples above 95% of the acceleration envelope and both joint speeds
touch `260 deg/T`, so simply increasing its static steering limit is not a
supported next step.

Four posterior half-cycle variants provide a matched negative result. The
sampled course-, crossflow-, phase-gated, and envelope-asymmetry policies all
retain visible alternating wakes, yet all repeat the upper-domain exit at
`8.585--8.772T`. Their minimum distances remain `11.949--12.038L` and final
distances `12.181--12.314L`, including the inherited course-aware controller
at `11.967/12.226L`. The nearly identical top-down hooks and oblique vortex
trains show that the failure is insufficient route-redirection authority, not
wake collapse. Phase/half-cycle asymmetry should therefore not receive another
scalar-only gain edit.

## Policy hypothesis

Test one observation-gated redirect mechanism. Preserve the uncentered
joint-state anterior oscillator. At small route error, retain the evidenced
posterior mean-tangent steering. Form a reflection-equivariant route error
from body-frame bearing minus bounded lateral body velocity so accumulated
sideslip requests correction before bearing alone becomes large. When that
error grows, smoothly increase bounded posterior mean curvature while reducing
the posterior oscillatory component; recent yaw releases the command once the
requested rotation develops. Clamp the combined tail target and softly bound
both accelerations, rather than asking the hard limits to create the redirect.

The first semantic test is a departure from the repeated upper hook: remain in
the virtual field beyond `9.823T`, reverse upward drift, and improve on the
`11.512L` minimum while retaining a coherent alternating wake after
realignment. Falsify the mechanism if the same upper exit recurs, if posterior
wave relief collapses leftward propulsion, if the tail stops crossing zero
after route error falls, or if joint-limit residence and load peaks exceed the
posterior mean-tangent comparator.

bookshelf_consulted: true
source_domain: biological burst turning and robotic-fish closed-loop CPG direction tracking
source_mechanism: observation-gated strong-curvature redirect that releases into the propulsive rhythm when heading response appears
transferable_invariant: separate cruise propulsion from a bounded large-error redirect, gate the transition by body-frame route error, and release it with measured response
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat frequency, clock phase, exact vortex timing, and prescribed routes
policy_translation: use normalized bearing, lateral body velocity, recent yaw, and joint-state phase to trade posterior wave amplitude for bounded posterior mean curvature without shifting the anterior oscillator center
falsification: reject if the upper-exit topology remains, minimum distance does not beat 11.512L, the alternating carrier fails to recover, or actuator and load saturation increase
