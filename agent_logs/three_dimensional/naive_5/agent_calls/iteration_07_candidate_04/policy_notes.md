# Terminal carrier-recovery candidate

## Visual and trace diagnosis before the edit

- All four sampled rollouts are contract-valid direct-uniform still-water
  evaluations (`U_infinity=(0,0,0)`, no cylinders, and no prewarm). Their
  top-down rows show self-propelled alternating caudal vorticity and their
  oblique rows independently show coherent three-dimensional Lambda2 wakes;
  the route differences are controller effects rather than advection or
  moving-window transport.
- The assigned parent `solver_8b43d67d5abc` preserves that wake to `38.484T`
  but remains in the high corridor, passing the target longitude near
  `y=14.06L`, reaching only `4.516L`, and exiting left at `y=13.78L`.
  Distributing the same route side to the posterior wave in
  `solver_b6ed3f84ab58` does not supply the missing redirect: it reaches
  `5.386L` and exits through the upper margin at `26.043T`. The raw-yaw
  course closure in `solver_12fc3441a636` is the informative failure; both
  views show its wake bending upward before an even earlier `20.790T`
  upper-margin exit.
- `solver_4365157e5ac8` is the semantic improvement despite its lower scalar
  score. Its observation-gated same-sign two-joint redirect lowers the path,
  preserves a coherent wake to `39.253T`, and reaches `1.165L`, only `0.415L`
  outside the capture radius. At `25.00T` the head is `(9.08,11.34)L`, the
  reconstructed body-frame bearing is about `-0.86 rad`, normalized course
  error is about `+0.84`, and closing speed is about `0.49L/T`: the sampled
  sign is correct and the target is still being approached.
- The failure then changes regime. Below `2L`, mean translational speed stays
  near `0.67L/T`, while sampled angle, speed, and acceleration limit residence
  are all zero. The redirect weight grows to about `0.91` at closest approach,
  joint rates shrink toward zero, and commands fall near zero as the policy
  settles into a nearly static bend. Momentum carries the head left of the
  target; at `27.05T` distance bottoms at `1.165L`, closing speed crosses zero,
  and the body-frame target remains strongly off-course. Thus the near miss is
  evidence of a latched redirect/coast, not insufficient far-field propulsion
  or a need for another global steering-gain increase.

## Policy hypothesis

Use the near-miss policy as the scaffold: preserve its state-feedback
`0.90T/18 deg` traveling bend, phase pump, lagged posterior follower,
response-calibrated route sign, and large-bearing two-joint redirect. Add one
terminal mechanism: as normalized head distance enters `3L--1.5L`, and only
while the measured body-frame velocity/target course error remains large,
continuously cap the redirect blend by restoring a bounded fraction of the
traveling carrier. This is not extra propulsion gain. It prevents the
same-sign curvature target from becoming an equilibrium while the fish still
has large inertial speed, and supplies an observed-state posterior beat to
continue rotating the velocity vector through the capture circle. The gate
vanishes outside the near field or when course aligns, leaving the evidenced
far redirect unchanged.

Frozen-trace replay is only a command audit, not CFD evidence. Restoring at
most `45%` of the carrier changes the near-`2L` mean maximum command from about
`1.4` to `8.3 rad/T^2` without introducing a `30 rad/T^2` clamp on those
states. The evaluation should falsify the mechanism if the minimum distance
does not cross `0.75L`, the trajectory returns to the high corridor or early
upper exit, the near field still becomes a static coast, or angle/speed/
acceleration limit residence reappears during the terminal approach.

bookshelf_consulted: true
source_domain: biological C-start redirect, sensor-modulated robotic-fish CPG control, and terminal target capture
source_mechanism: a large-error curvature transient releases into a propulsive posterior beat, while near-target distance and alignment schedule the transition
transferable_invariant: preserve broad target-directed steering, but do not let a redirect settle into static curvature while course remains misaligned; recover a bounded rhythmic tail action using current distance and body-frame course
nontransferable_details: species-specific C-start stages, published gains, clocked phase, robot linkage geometry, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: infer phase from joint state, retain the evidenced bearing-gated two-joint redirect, and use normalized head distance plus velocity/target course error to restore part of the state-feedback carrier only during a misaligned terminal approach
falsification: reject if capture is not achieved or the 1.165L minimum is not improved, if the terminal static coast remains, if the coherent wake or lower route is lost, or if near-field actuator-limit residence returns
