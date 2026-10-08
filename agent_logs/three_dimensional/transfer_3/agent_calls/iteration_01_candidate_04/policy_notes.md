# Candidate diagnosis and hypothesis

## Inherited evidence

Only one sampled solver is available, so its useful finite approach segment is
the positive comparator for its own terminal failure segment.  The rollout is
contract-valid direct uniform still water (`U_infinity=(0,0,0)`) with no
prewarm and no cylinders.  It is stable, moves under its own actuation, and
reduces distance from `12.3277L` to `4.7800L`; it then moves away and exits the
lower virtual boundary at `27.4945T` with distance `9.7089L`.

The top-down row shows a strong alternating wake and useful leftward progress
through roughly `16T`, followed by sustained downward translation while the
target moves from the forward sector to broadside/behind.  The oblique row
confirms coherent three-dimensional vortex loops rather than absent thrust or
solver instability.  Around closest approach (`17.853T`) the center is
`(13.673,7.912)L`, still `4.780L` from the target, and the fish continues with
substantial downward velocity.  There is no terminal-capture regime to tune.

The inherited state-feedback carrier is much stronger than its steering
residual under the fixed actuator envelope.  Raw commands exceed
`1800 deg/T^2` on `70.5%` of joint-1 samples and `77.5%` of joint-2 samples;
joint speeds also sit near `260 deg/T` on `8.9%` and `10.8%` of samples.  Thus
adding another small steering gain to the already clipped command is not a
credible mechanism.  The gait is worth preserving when the target is near the
forward axis, but a large body-frame target angle needs a qualitatively
different allocation of the same two joints.

## Policy hypothesis

Add one continuous large-error redirect primitive.  Use only the normalized
body-frame target angle to blend from the inherited traveling-bend carrier to
a slower, bounded whole-body mean-curvature equilibrium.  During redirect,
reduce carrier cadence enough to reserve acceleration authority; bias the
anterior oscillator and posterior total tangent with the same signed request;
and release continuously back to the inherited carrier as the target returns
to the forward cone.  There is no clock, route, target coordinate, hidden
state, or vortex-phase command.

This candidate is falsified if it destroys the coherent propulsive wake before
the large-error gate is active, still drives the target behind while leaving
through the lower boundary, fails to improve the `4.780L` closest approach, or
merely replaces acceleration clipping with persistent angle/velocity
saturation.  A useful result should visibly redirect before the old
`12T`--`18T` divergence and then restore posterior-lag propulsion.

bookshelf_consulted: true
source_domain: robotic-fish turning and biological rapid-redirect control
source_mechanism: target-conditioned bounded mean curvature with release back to a posterior-lag propulsive rhythm
transferable_invariant: persistent large target angle requires reserved steering authority and a bounded body bend that relaxes as alignment returns
nontransferable_details: published gains, species-specific C-start kinematics, exact beat phase, dimensional cadence, and task-specific routes
policy_translation: normalized body-frame target angle gates a sign-consistent two-joint curvature equilibrium and cadence relief while the inherited state-feedback traveling bend remains the aligned behavior
falsification: reject if approach, termination class, trajectory topology, or saturation do not improve, or if aligned propulsion is materially weakened before redirect is needed
