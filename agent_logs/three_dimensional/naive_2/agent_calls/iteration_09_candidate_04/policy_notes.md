# Candidate wake-policy diagnosis

## Evidence read before the edit

All sampled and inherited rollouts used direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot,
and finite dynamics. Every combined keyframe sheet shows self-propulsion in
both views: the top-down mid-plane row develops a strong alternating vortex
street, and the oblique row retains tail-connected three-dimensional Lambda2
structures through the late excursion. The common failure is therefore
planar response, not advection, a missing wake, or numerical instability. The
fish continues along an upward-curving wake axis, passes above the target, and
exits the upper virtual boundary.

The sampled comparisons isolate an unsuccessful family of terminal changes.
The unrelieved three-degree course redistribution reaches `4.419L`; smooth
distance-only carrier relief worsens that to `5.126L`, and distance-times-course
damping reaches only `6.397L`. The assigned parent's completed
closure-conditioned posterior-wave relief reaches `4.162L` at `17.507T`, but
then recedes to `6.363L` and repeats the same upper exit. Its minimum still has
body-frame bearing about `-0.969 rad`, target-versus-velocity course error
about `-1.257 rad`, and speed about `0.824U`. Thus conditioning relief on loss
of closure is more selective than distance alone but still trades away the
stronger full-carrier approach without producing capture or a new trajectory
topology.

The inherited approach-gated posterior half-cycle test is also complete. It
preserves a much stronger `3.259L` minimum, but at closest approach the bearing
is about `-1.300 rad`, course error is saturated at `-pi/2`, and speed remains
about `0.758U`; it subsequently recedes to `7.016L` and exits high while both
wake views remain coherent. This rules out repeating propulsion relief or
merely strengthening the same half-cycle attenuation. It also exposes a
specific structural loss of authority: the existing posterior course term is
multiplied by a small-bearing centerline gate and then summed inside an already
saturated bearing/crossflow mean, so the translational course residual is
nearly absent precisely when the target becomes strongly lateral after the
near pass.

## Single candidate hypothesis

Restore the evidenced full-amplitude carrier with its posterior state-derived
lag, approach-aware four-degree anterior course redistribution, bounded
bearing/crossflow/recent-yaw posterior mean, and smooth acceleration envelope.
Add one new mechanism: a separate bounded posterior course-residual channel.
It uses the normalized body-frame angle between target and velocity, is silent
near rest and outside `6.5L`, and is added after the base posterior mean's
saturation. The channel therefore cannot be erased by large bearing, does not
change the anterior rhythm or oscillatory posterior wave, and continuously
vanishes when target-relative course alignment returns.

Replaying only this algebra on completed histories gives zero residual beyond
`6.5L`. On the inherited half-cycle trace it adds about `-1.12 deg` at the
inbound `5L` crossing, `-2.54 deg` at `4L`, and `-3.76 deg` at its `3.259L`
minimum; the mean absolute residual inside `6.5L` is `2.05 deg`. On the
assigned-parent trace it is about `-1.34 deg` at `5L` and `-2.72 deg` at the
`4.162L` minimum. This audit establishes localization, sign, and boundedness,
not hydrodynamic improvement.

The expected semantic change is to retain the full-carrier approach while
converting the late saturated course error into additional posterior turning
authority soon enough to reduce recession or replace the upper exit with a
return toward the target. Falsify the mechanism if far transit changes,
closest approach is materially worse than the inherited `3.135--3.259L`
full-carrier/half-cycle range, course error remains saturated through
recession, the same upper-exit topology persists without improved final
distance, or joint-limit residence, acceleration residence, peak force, or
peak moment becomes less acceptable.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual path-following control
source_mechanism: preserve the rhythmic locomotor carrier while applying a bounded low-frequency direction-tracking residual through a steering actuator
transferable_invariant: a slow target-course residual must retain independent authority instead of disappearing inside saturation of another route-feedback channel
nontransferable_details: published gains, dimensional rates, robot or species kinematics, oscillator clocks, exact vortex phases, task-specific routes, and source actuator layouts
policy_translation: form a speed-gated target-versus-velocity angle from normalized body-frame observations, localize it with a smooth proximity gate, and add it as a bounded posterior equilibrium residual after the bearing/crossflow mean while leaving the two-joint traveling wave unchanged
falsification: reject if the residual perturbs far propulsion, degrades the strong approach, fails to reduce saturated-course recession or upper exit, destroys wake coherence, or increases joint, acceleration, force, or moment excursions unacceptably
