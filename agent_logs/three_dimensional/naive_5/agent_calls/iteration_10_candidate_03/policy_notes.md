# Miss-gated terminal curvature candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations and the inherited step-9 evaluation are
  contract-valid direct-uniform still-water rollouts (`U_infinity=(0,0,0)`, no
  cylinders, no prewarm). Their top-down vorticity rows show body-attached
  alternating wakes, and the oblique Lambda2 rows show genuinely
  three-dimensional trails following the fish. Translation is therefore
  self-propelled rather than imposed advection or moving-window transport.
- The assigned `solver_8097d423c0eb` parent is the strongest semantic sample:
  both visual rows preserve a coherent wake while the fish leaves the high
  corridor, approaches from above, and passes the target before exiting left.
  It reaches `0.829828L`, only `0.079828L` outside capture, without angle
  contact; peak planar force and yaw moment are about `0.02142` and `0.00981`.
  At closest approach it still travels about `0.659L/T`, its measured course
  projects an approximately `0.807L` miss, and its heading response has the
  requested sign. This is a terminal turn-authority deficit, not wake collapse.
- The high-corridor `solver_b3b6be8f076f` comparison retains a coherent wake
  but latches near a static same-sign bend, reaches only `4.278L`, and exits the
  upper margin. The posterior-redistribution `solver_b6ed3f84ab58` also exits
  high, touches the `45 deg` boundary, and raises peak force/moment to roughly
  `0.2124/0.0968`. Those views and traces rule out a far-field static latch or
  another posterior half-cycle redistribution.
- The inherited predictive-entry candidate changes only the approach region
  but worsens the parent's minimum from `0.829828L` to `0.926872L`, preserves
  `left_domain`, and raises mean distance from `7.89069L` to `7.92726L` while
  leaving the force, moment, and angle scales essentially unchanged. At its
  minimum it is higher (`head_y=10.180L` rather than `9.961L`) and faster
  (`0.676L/T` rather than `0.659L/T`). Thus projected miss should not force
  earlier entry on this carrier; entry and release are held fixed here.
- Reconstructing the assigned-parent gates shows redirect weight already rises
  to about `0.92` at `1.0L` and essentially `1.0` by `0.9L`. At the minimum,
  however, the joints are only about `(-19.9,-23.1) deg` against bounded
  redirect targets near `(-23.2,-29.0) deg`, and commands have relaxed to about
  `(0.3,0.6) rad/T^2`. The remaining testable actuator gap is close-range
  curvature depth, not more entry duration or response frequency.

## Policy hypothesis

Preserve the parent's traveling-bend carrier, calibrated turn side, bearing
entry, yaw/bend release, and terminal release qualification. Reuse the existing
continuous distance-and-projected-miss gate solely to deepen both same-sign
redirect targets by a bounded amount. The added curvature is exactly zero
outside `1.75L` or for a projected course inside the capture corridor, so it
cannot change the trajectory-producing far-field switching or create the
global intercept latch. Near a predicted miss it supplies continuing yaw
authority after the base redirect has nearly settled, without adding posterior
half-cycle energy or changing cadence.

Expected evidence is the same downward coherent trajectory followed by a
first crossing inside `0.75L`, or at least a minimum below `0.829828L` with a
smaller projected miss. Falsify the mechanism if the target crossing moves
upward, the high-corridor/static-bend topology returns, the angle boundary is
touched, the wake loses coherence, or force, moment, or actuator-limit
residence materially exceeds the assigned parent's scale.

bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish direction tracking
source_mechanism: large observed target error elicits bounded body curvature, while measured response releases the maneuver back to rhythmic propulsion
transferable_invariant: when maneuver entry and release already work at range but course still misses during capture, extra curvature should be conditional on sensed near-target miss and should vanish when the intercept becomes safe
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific bend envelopes, exact vortex phases, clocked CPG phase, world coordinates, and task-specific routes
policy_translation: retain the body-frame turn side and all parent entry/release gates; use normalized target distance and body-frame projected miss to add bounded angles to both redirect targets only in the terminal bad-intercept regime
falsification: reject if the rollout does not beat `0.829828L`, changes the far-field trajectory, recreates a static-bend latch, contacts the angle limit, or worsens wake coherence, loads, or limit residence

## Non-CFD implementation audit

Reconstructing the parent and candidate commands on the assigned rollout fields
shows that the new term is exactly inactive at and beyond `1.75L`; it changes
`758/7278` frozen samples, all inside that boundary. At the parent's closest-
approach state the terminal gate is one, the effective target magnitudes remain
bounded at about `(30.8,38.5) deg`, and the command changes from approximately
`(0.31,0.61)` to `(-1.02,-1.05) rad/T^2`. Frozen-state acceleration-clamp count
is unchanged. The candidate has `33` directly referenced and `33` owned
parameter fields, remains finite at zero speed, and negates both accelerations
exactly under reflected lateral target, velocity, yaw, and joint state. These
checks establish locality, boundedness, schema coverage, and reflection
equivariance only; they do not predict the unevaluated CFD response.
