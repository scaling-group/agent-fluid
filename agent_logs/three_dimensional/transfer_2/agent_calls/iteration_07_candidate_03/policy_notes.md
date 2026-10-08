# Sector-intercept to recapture-pivot candidate

## Evidence diagnosis before the policy edit

All four sampled diagnostics confirm direct uniform quiescent initialization,
`U_infinity=0`, no cylinders, and stable finite dynamics.  In both visual rows,
the fish is self-propelled: the top-down sheets show an alternating wake laid
behind the translating body, while the oblique Lambda2 sheets show coherent
three-dimensional shed structures rather than passive advection or a startup
artifact.

The assigned sector-pulse parent makes the deepest sampled approach
(`2.606L`) but stays on the westbound runout and leaves the left boundary at
`39.699T` with final distance `8.714L`.  The posterior-recapture samples share
a slightly shallower `2.996--3.031L` pass, then visibly bend the trajectory into
the only late hairpin between about `29T` and `40T`; all nevertheless leave the
upper boundary near `49.4T` with the target still behind.  Their coherent wakes
persist through the turn, so the missing behavior is tighter route recapture,
not basic propulsion or numerical stability.

The sampled persistent-route plus recapture controller does not change that
topology: relative to basic recapture it changes minimum/final distance only
from `3.031/7.528L` to `2.996/7.522L` and exits at the same time and place.
Posterior carrier unloading during recapture also does not complete the turn,
but it is a useful allocation adjunct: relative to basic recapture it lowers
raw acceleration-limit exposure from `92.77%` to `82.97%`, and improves mean
and final distance from `7.107/7.528L` to `7.021/7.417L` without erasing the
hairpin.

## Policy hypothesis

Keep the assigned parent's closing/abeam sector pulse because it uniquely
deepens closest approach.  Add the separately evidenced, mirror-equivariant
target-behind pivot as a distinct passage regime: signed posterior mean
curvature supplies the hairpin, while request magnitude unloads only the
posterior oscillatory carrier toward a nonzero floor.  The closing-speed gate
makes the sector pulse decay as range begins increasing; the behind gate arms
the pivot from normalized body-frame geometry, and reacquisition or lateral
closure restores the unmodified carrier.  No clock, world direction, target
coordinate, or stored mode is introduced.

Expected result: preserve a closest approach materially below the recapture
family's `~3.0L`, then replace the parent's left runout with an earlier,
tighter recapture turn while keeping raw acceleration-limit exposure below the
sector parent's `92.24%`.  Falsify the combination if it loses the `2.606L`
approach, turns before definite passage, retains either sampled exit topology,
or raises limit exposure materially.

bookshelf_consulted: true
source_domain: biological C-start and robotic-fish asymmetric-flapping control
source_mechanism: observed-error burst redirect with curvature followed by release into a propulsive posterior beat
transferable_invariant: separate large-error reorientation from cruise, use bounded signed curvature, and restore traveling-wave thrust as observed geometry is reacquired
nontransferable_details: species-specific C-start shape, published gains and timing, dimensional beat settings, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame forward and lateral target components to arm a mirror-equivariant target-behind posterior pivot; unload only its oscillatory carrier by request magnitude and release continuously on reacquisition
falsification: reject if the deep sector-pulse approach is disturbed, the pivot does not tighten the post-pass route, the target remains behind at exit, or saturation and loads worsen
