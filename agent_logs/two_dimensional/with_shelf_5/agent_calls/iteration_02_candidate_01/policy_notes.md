# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the policy edit

The assigned parent is the common target-blind oscillator. Its released sheet
shows a tight curling descent that never enters the target corridor: it exits
the lower boundary after `50.127` time units, with head displacement
`(-3.545,-13.300)L`, minimum/final distances `8.615/12.123L`, and both joint
rate and acceleration caps reached. The shared prewarm sheet confirms that all
candidates start above a developed, interacting four-cylinder wake, so this
wrong-lateral trajectory is a controller failure rather than a different
initial flow field.

The strongest sampled child, `solver_0e81665db579`, adds bounded body-frame
bearing-to-mean-curvature feedback without changing the parent's propulsive
carrier. Its keyframes show a sustained upstream-left path that corrects the
initial lateral offset, enters the multi-wake corridor from downstream, and
crosses the target circle. The metrics confirm the semantic improvement:
`target_reached` at `93.032`, head displacement `(-10.915,-4.204)L`, mean
distance `4.033L`, and progress `0.940`. It is actively swimming rather than
merely advected: mean velocity is `(-0.1168,-0.0469)` while mean local flow is
`(-0.0394,-0.0752)`. However, the final keyframes show a visibly strong
oscillatory wake on approach, and both joint rate and acceleration caps remain
active; RMS lateral force and moment rise to `95.50` and `1146.61`.

The other sampled children bound what should not be changed together. The
slower, smaller-amplitude carrier in `solver_1b20554d6f99` and the stronger
mean-bias distribution in `solver_c1f78d94eff2` both drift downstream
(`+2.250L` and `+2.175L`) and exit in about `17` time units with negative
progress. An inherited heading-rate-damped variant also changes the carrier
and terminates `unstable_dynamics` at `14.508`, with RMS force/moment
`22067.65/382309.44`. These results do not isolate scalar gains or establish a
safe signed wake/load residual. They support preserving the complete successful
carrier and mean-curvature mapping while testing only a separable temporal
steering refinement.

## Candidate hypothesis

Start from the evaluated successful policy exactly. Add one bounded mechanism:
predict the short-horizon body-frame bearing from `bearing_window_rate`, then
feed that predicted bearing into the existing mean-curvature map. When bearing
is already closing, the rate term reduces steering before overshoot; when wake
motion makes the error grow, it supplies a limited extra correction. Smooth
saturation limits the temporal term to five degrees, so a fast alternating
wake event cannot replace the persistent route command. This retains the
successful joint-state oscillator, posterior lag, steering scale, and bias
distribution unchanged and introduces no clock, coordinate, cylinder, force,
or prescribed-flow dependency.

Expected post-worker evidence is retained `target_reached` semantics with no
slower arrival than `93.032`, plus a lower command/load or saturation signature
and a less abrupt final turn. Falsify this candidate if it loses capture, takes
a materially longer or less direct path, preserves the same capped/load-heavy
approach, or lets the rate term chatter under alternating wake motion. The new
CFD result is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and sensor-modulated turning
source_mechanism: bounded directional-error feedback with turn-rate damping superposed on rhythmic propulsion
transferable_invariant: persistent body-frame direction error should set mean curvature while a bounded error-rate term reduces overshoot without erasing the traveling bend
nontransferable_details: published gains, robot geometry, clocked CPG phase, species-specific amplitudes, exact vortex phases, and task-specific routes
policy_translation: add a smoothly limited short-horizon `bearing_window_rate` prediction to observed bearing before the successful two-joint mean-curvature map
falsification: reject if target capture is lost or delayed, the rate term chatters, actuator/load extrema do not improve, or the successful upstream-left trajectory changes to a domain exit
