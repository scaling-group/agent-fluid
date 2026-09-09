# Multi-wake target-policy candidate notes

## Evidence diagnosis

- The assigned parent guidance describes a fresh lineage whose common seed is
  a target-blind joint-state oscillator; there are no inherited optimizer logs
  and only `solver_a328086a43ca` is sampled, so no same-task success is
  available for comparison.
- The shared-prewarm sheet shows a developed, interacting four-cylinder wake
  and the held fish starting well above and downstream of the target. In the
  released sheet the seed visibly self-propels, but its path bends steeply
  downward on the release side, never enters the target/wake corridor, and
  exits the lower domain after only `50.1269` time units.
- The scalar diagnostics agree with the pictures: head displacement is
  `(-3.545, -13.300)L`, minimum distance improves only to `8.615L` before final
  distance worsens to `12.123L`, and progress is only `0.0243`. This is a
  directional-control failure, not a collision or nonfinite-dynamics failure.
- Both joint accelerations reach the `1800 deg/time^2` cap and both velocities
  reach `260 deg/time`; the estimated tailbeat/shedding-frequency ratio is
  `32.83`. The seed therefore demonstrates useful propulsion, but leaves poor
  steering headroom and supplies no target-dependent mean turn.

## Policy hypothesis

Preserve the state-feedback traveling bend, but add one missing controller
mechanism: convert bounded body-frame target bearing into a mean-curvature
bias shared by the two joint attractors. Moderate the gait period and
oscillator scale enough to reduce the evidenced cap contact while retaining a
posterior lag. Do not add wake-crossflow or load rejection on this iteration:
the seed never reaches the useful wake corridor, and the sampled evidence does
not establish a transferable sign or scale for such a residual.

Expected test: the first released keyframes should show a sustained turn into
the target corridor rather than the same near-vertical descent, release should
survive materially beyond `50.1`, and acceleration/velocity cap contact should
fall. Falsify the mechanism if the turn has the wrong sign, the trajectory
retains the lower-domain-exit topology, or propulsion collapses before closest
distance improves beyond `8.615L`.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological mean-curvature turning
source_mechanism: bounded target-error-driven mean bend superposed on a propulsive traveling wave
transferable_invariant: persistent body-frame directional error should create bounded left-right gait asymmetry while the oscillatory posterior lag remains propulsive
nontransferable_details: published gains, robot or species kinematics, dimensional beat frequencies, exact vortex phase, and task-specific routes
policy_translation: map clamped body-frame bearing through a smooth saturation to joint mean-bend setpoints; regulate the original joint-state oscillator and lagged tail around those setpoints
falsification: reject if early motion turns away from the target, repeats the lower-domain exit, loses upstream propulsion, or maintains cap-dominated actuation without improving closest approach
