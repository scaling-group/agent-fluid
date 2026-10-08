# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, finite actions, and `capture` termination.
  Their top-down rows show continuous body translation along the established
  curved approach while an alternating red/blue caudal street remains attached
  to the moving fish; this is self-propulsion rather than imposed advection.
  The complete oblique rows for `solver_43e27134a723` and
  `solver_56888ac0e1b7` retain discrete three-dimensional Lambda2 structures
  from wake formation through capture. The black oblique rows for
  `solver_2ed7853fc449` and the assigned-parent
  `solver_a9222453ae0c` are render failures and supply no independent 3D-wake
  evidence.
- The assigned parent replaces the inherited beat-scale response with
  translation-alignment terminal relief. It captures at `24.343010T` in 4,426
  steps with `2.224020L` mean distance, slightly behind the phase-qualified
  reference's `24.310009T`, 4,420 steps, and `2.223959L`. Its visible route is
  essentially unchanged, so it is an informative mechanism regression rather
  than a propulsion or route-topology failure. Together with inherited
  failures from narrowing, broadening, boosting, and response-releasing the
  terminal gates, this rules out another scalar relief or phase-boundary edit.
- `solver_56888ac0e1b7` makes a distinct semantic improvement by adding bounded
  body-forward-speed-deficit recruitment only to the anterior oscillator. It
  advances `0.110L` by `2T` instead of the phase-qualified parent's `0.062L`,
  captures earliest at `23.985519T` in 4,361 steps, and lowers mean distance to
  `2.202000L`. Its complete two-view sheet shows that the earlier wake
  recruitment develops into the same coherent alternating 3D carrier through
  capture. Peak normalized force/moment fall slightly to
  `0.029769/0.015087`, although mean action (`57.59`) and anterior/posterior
  rate-cap occupancy (about `11.7/6.4%` at the exact cap) are modestly higher
  than the phase-qualified parent; this supports feedback-gated recruitment,
  not an unbounded drive increase.
- `solver_2ed7853fc449` independently changes only the slow curvature request
  from inertial lateral speed to measured water-relative sideslip. Despite its
  blank oblique row, the complete top-down trajectory and numerical trace show
  an earlier `24.018509T` capture and lower `2.206025L` mean distance than the
  phase-qualified parent, with lower peak force/moment
  (`0.030487/0.015991`) and near-target mean action (`42.854`). Its effect is
  therefore physically useful in still water even though robustness to an
  imposed wake or inflow remains untested.

## One candidate hypothesis

Use the complete `solver_56888ac0e1b7` speed-recruiting controller as the
carrier and terminal-allocation baseline, and make one compatible observation
translation in its existing slow route loop: replace inertial body-lateral
velocity with `-state.relative_flow_velocity_body_U[2]`. Keep the normalized
speed thresholds, recovery gain, full target geometry, reactive-rudder sign,
20% closing-deficit relief, and target-side anterior-stroke qualification
unchanged. The two completed mechanisms act on different anterior paths:
forward-speed deficit restores oscillator energy only below the sampled cruise
envelope, while water-relative sideslip shifts only the bounded curvature
center. Their combination contains no clock, world coordinates, mutable state,
or scalar-only tuning and remains reflection equivariant.

The current fixed-pose CFD can test compatibility but not held-out robustness.
Falsify the combination if capture is lost or later than `23.985519T`, mean
distance exceeds `2.202000L`, the `2T` progress falls below `0.110L`, the
preterminal route changes adversely, or peak load, saturation, action effort,
or the coherent alternating wake materially worsens relative to the
speed-recruiting sample. A successful fixed-pose result would justify testing
changed pose or hydrodynamics next; it would not by itself establish multi-wake
robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction feedback
source_mechanism: recruit a traveling carrier after measured locomotor slowdown while separating persistent target steering from water-relative crossflow
transferable_invariant: preserve the joint-state carrier and add only bounded normalized feedback that restores oscillator energy below useful advance and measures slow-route sideslip relative to the surrounding water
nontransferable_details: published gains, dimensional speeds and frequencies, robot or species geometry, exact vortex phase, prescribed maneuver timing, task-specific routes, and fixed-pose performance
policy_translation: retain the sampled body-forward-speed gate on anterior Van der Pol energy injection and replace only the existing lateral-speed term in the bounded anterior curvature request with sign-equivalent body-minus-local-water velocity; preserve posterior lag, rudder sign, and terminal phase allocation
falsification: reject if capture is lost or later than 23.985519T, mean distance exceeds 2.202000L, progress by 2T falls below 0.110L, or route, wake, saturation, effort, force, or moment envelopes worsen
