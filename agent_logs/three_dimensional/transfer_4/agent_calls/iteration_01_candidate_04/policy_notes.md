# Wake-policy candidate notes

## Inherited evidence diagnosis

The sampled transferred 2D seed was evaluated in the required direct-uniform
still-water initialization (`U_infinity=(0,0,0)`), with no cylinders or
prewarm. It self-propels rather than being advected: the center reaches about
`0.8 L/T`, the top-down row shows an organized alternating vortex street, and
the oblique row shows persistent three-dimensional Lambda2 structures around
the caudal wake. The useful finite segment is the directed approach through
roughly `16--20T`; distance falls from `12.3277L` to a minimum of `4.7800L` at
`17.853T` without numerical instability or a loss of the propulsive wake.

The informative failure segment begins around the closest approach. The fish
continues translating below the target, distance rises to `9.7089L`, and it
exits the lower virtual boundary at `27.4945T` (`center_y=0.7982L`). Both visual
rows show the coherent wake bending with the trajectory rather than collapsing.
Trajectory reconstruction also shows that the signed cross product between
the body-frame target vector and translational velocity remains predominantly
positive after `12T` while target progress stalls and reverses: the velocity
course is persistently on the wrong side of the line of sight. Meanwhile the
beat-scale recent yaw rate spans approximately `-3.00` to `+3.14 rad/T`, so a
route command built mainly from instantaneous body bearing and this short yaw
window is strongly phase contaminated.

The existing approach/recovery gate cannot correct this miss: it begins inside
`2.10L`, but the sampled rollout never gets closer than `4.78L`. At the miss,
the existing geometry path already produces large negative turn requests, so
another scalar increase to bearing gain would not introduce missing steering
authority. The policy hypothesis is therefore to preserve the demonstrated
traveling-bend oscillator and add one bounded velocity-course redirect. The
rotation-invariant target/velocity cross product will shift anterior curvature
and posterior tail tangent in complementary directions; a closing-deficit
factor gives this redirect more authority only when the current course stops
making progress.

An offline replay of that signal over the inherited trace gives mean redirect
`+0.002` over `0--12T`, `+0.005` over `12--17T`, `+0.506` over `17--20T`, and
`+0.703` after `20T`. Thus it leaves the evidence-backed approach essentially
unchanged and activates around the observed stall. Its bounded full-scale
posture change is `-4 deg` at the anterior-joint equilibrium and `+5.5 deg` at
the posterior tail tangent; these are candidate parameters, not borrowed
source gains. The new CFD result is intentionally not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological mean-curvature turning
source_mechanism: target-error feedback modulates a propulsive oscillator with a bounded average bend
transferable_invariant: preserve the traveling propulsive wave while a persistent observed course error commands a bounded, continuously releasable body curvature
nontransferable_details: published CPG gains, clock phase, species-specific bends, dimensional frequencies, exact vortex phase, and prescribed routes
policy_translation: compute normalized body-frame target/velocity cross product, speed-gate it, and map it to opposite anterior and posterior curvature shifts while retaining the seed oscillator
falsification: reject if course does not rotate toward the target before the prior 4.78L miss, if the run retains a lower-boundary exit without better progress, or if the added bend destroys the coherent wake or drives persistent saturation
