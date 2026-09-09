# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance is the fresh common-naive lineage in
  `guidance_examples/optimizer_c62f560a3896`; no inherited optimizer log is
  present in this workspace. The sole sampled solver is therefore both the
  best finite example available for comparison and the informative failure.
- `solver_35fea652543a` is valid direct-uniform still water evidence:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and 34 moving-window shifts.
  It terminated `left_domain` at 8.602 T without capture. Distance changed
  from 12.3277 L to a minimum of 12.0701 L and then 12.3677 L, so its early
  propulsion did not become sustained target progress.
- In the top-down sheet, the initially wake-free fish develops a visible
  alternating tail wake by 2--3 T. By 5--6 T the wake is coherent and the fish
  is clearly self-propelled rather than advected, but its path is already
  curving upward, away from the lower-left target. At 8 T a large curved body
  path and strong lateral wake immediately precede the top/left-domain exit.
  The oblique Lambda2 sheet independently shows three-dimensional tail-wake
  formation, followed by the same sustained bend; it does not show a prewarm
  structure or an external wake carrying the fish.
- The trace agrees with the images: center y rises from 14.000 L to 15.202 L,
  heading changes from 0.506 to -0.747 rad, and final world lateral velocity is
  0.487 L/T while the target remains lower-left. At the closest-distance
  quarter, the body already carries large yaw motion. Raw joint commands exceed
  the 31.42 rad/T^2 acceleration envelope in 512 joint-1 rows and 524 joint-2
  rows, so a steering edit must not rely on still larger unbounded acceleration.
- Reusable implication from the assigned parent and sampled rollout: preserve
  the demonstrated joint-state oscillator and posterior lag as a propulsion
  scaffold, but add an actual target-feedback mechanism and keep the combined
  command within an explicit reserve below the actuator limit.

## Policy hypothesis

Use one compact mechanism: map normalized body-frame target bearing to a
bounded mean-curvature equilibrium for the two-joint state-feedback wave.
Apply correctly signed, bounded heading-rate and body-frame lateral-velocity
damping to that slow route request so an existing turn is released instead of
becoming a full-circle bias. Moderate the carrier period/amplitude only enough
to place nominal sinusoidal velocity and acceleration below the documented
hard limits, then softly bound the final acceleration; this is saturation
hygiene supporting the architectural test, not the source of homing.

Expected evidence after evaluation: the fish should retain an alternating
posterior wake, rotate in the sign that reduces body-frame bearing, remain
inside the virtual field beyond 8.602 T, and reduce distance below 12.0701 L.
Reject the mechanism if bearing or lateral excursion grows with the same sign,
if the wake loses its propulsive traveling character, or if command/velocity
saturation remains persistent despite the explicit reserve.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and mean-curvature turning
source_mechanism: sensor-driven bias of a propulsive rhythm to turn while retaining the traveling wave
transferable_invariant: a slow target-direction error should shift the mean bend continuously, while measured turn and slip damp overshoot
nontransferable_details: published gains, dimensional beat settings, species kinematics, exact waveform phase, and any task-specific route
policy_translation: bounded bearing with signed yaw/slip damping sets a normalized body-frame curvature equilibrium shared by the two joint-state controllers
falsification: reject if target bearing does not shrink, domain survival does not improve beyond 8.602 T, closest approach is not below 12.0701 L, or propulsion and saturation diagnostics worsen
