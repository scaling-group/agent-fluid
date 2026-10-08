# Multi-wake target-policy candidate diagnosis

## Visual and numerical diagnosis before editing

- All four sampled evaluations use direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and `capture` termination.
  The prefilled response-plus-stroke relief in `solver_43e27134a723` captures
  at `24.310009T` with `2.223959L` mean distance. Its complete top-down row
  shows self-propelled curved translation behind an alternating red/blue
  caudal street, and its complete oblique row shows discrete three-dimensional
  Lambda2 structures at `8T`, `16T`, and through capture rather than wake
  decay or an inertial coast.
- `solver_56888ac0e1b7` adds body-forward-speed-deficit oscillator recruitment
  and is the strongest sampled result: capture advances to `23.985519T`, mean
  distance falls to `2.202000L`, and distance at `2.002T` improves from
  `12.265744L` to `12.218025L`. Its complete visual sheet retains the same
  useful target-directed topology and an active alternating three-dimensional
  wake through capture. Peak normalized planar force/yaw moment fall from
  `0.031649/0.016385` to `0.029769/0.015087`; anterior/posterior rate-cap
  occupancy stays finite at about `14.47/7.34%`, although near-target mean
  action norm rises from about `43.00` to `43.33`. This supports a closed-loop
  carrier-recruitment mechanism, not a general increase in cruise gain.
- `solver_2ed7853fc449` makes only one semantic change to the prefilled policy:
  its anterior curvature center responds to water-relative lateral sideslip
  instead of body lateral velocity. It independently advances capture to
  `24.018509T`, lowers mean distance to `2.206025L`, lowers peak normalized
  force/moment to `0.030487/0.015991`, and slightly lowers near-target action
  norm to `42.85` at similar rate-cap occupancy. Its top-down sheet preserves
  the target-directed alternating wake, but its oblique panels are blank
  render artifacts, so this sample is numerical/top-down support rather than
  independent three-dimensional-wake confirmation.
- The informative nearby negatives bound the edit. Replacing the terminal
  response with translation alignment in `solver_a9222453ae0c` delays capture
  to `24.343010T` and raises mean distance to `2.224020L`; its oblique sheet is
  also blank. The inherited response-released anterior-redirect experiment
  captures at `24.321011T` with `2.223987L` mean distance, slightly worse than
  its assigned parent. Do not add another terminal release, response gate, or
  scalar rudder change to the candidate.

## One candidate hypothesis

Use the evidenced speed-deficit carrier-recruitment policy as the base and
make the independently positive observation substitution in its slow route
loop: compute lateral sideslip as the negative lateral component of
`relative_flow_velocity_body_U`, then use it in the inherited folded-bearing
curvature request. This small compatible combination separates locomotor
recruitment from flow-relative steering. It preserves the full target-angle
posterior rudder, its measured load sign, joint-state phase allocation, and
stroke-qualified terminal relief exactly. It uses normalized body-frame
observations and remains reflection equivariant; it introduces no clock,
world coordinate, task route, or new scalar gain.

The evaluation should retain the speed-recovery policy's improved startup and
complete three-dimensional carrier wake while preventing self-generated or
external local crossflow from being mistaken for inertial lateral motion.
Falsify the combination if it loses capture, arrives later than
`23.985519T`, exceeds `2.202000L` mean distance, loses the `12.218025L`-or-
better progress boundary at `2T`, or materially worsens the sampled wake,
`14.47/7.34%` rate-cap occupancy, `43.33` near-target action norm, or
`0.029769/0.015087` force/moment envelope. A fixed-pose still-water result
cannot establish robustness to imposed inflow or cylinder wakes.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling propulsive carrier while separating measured flow-relative lateral disturbance from the slow target-route request
transferable_invariant: recruit rhythmic propulsion from normalized forward-speed deficit and base lateral correction on water-relative sideslip so environmental or self-wake crossflow is not conflated with inertial body motion
nontransferable_details: published gains, dimensional speed targets, species kinematics, robot sensor calibration, prescribed CPG timing, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: retain the sampled body-forward-speed-gated anterior oscillator and replace only body lateral velocity in the folded-bearing route loop with negative normalized body-frame relative-flow lateral velocity
falsification: reject if capture is later than 23.985519T, mean distance exceeds 2.202000L, 2T progress regresses, or the established three-dimensional wake, saturation, effort, force, or moment envelope worsens
