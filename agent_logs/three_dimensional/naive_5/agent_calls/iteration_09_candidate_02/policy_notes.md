# Course-guarded terminal redirect candidate

## Visual and trace diagnosis before the edit

- All sampled and inherited evaluations used contract-valid direct-uniform
  still water (`U_infinity=(0,0,0)`, no cylinders, and no prewarm). In both
  visual rows, translation follows the body and the top-down alternating
  vorticity is accompanied by a three-dimensional oblique Lambda2 trail, so
  the route differences are controller effects rather than advection or
  moving-window transport.
- The prefilled assigned solver parent, `solver_b6ed3f84ab58`, is not the
  scaffold to strengthen. Its posterior half-cycle redistribution preserves a
  wake but bends into the upper boundary at `26.043T`, reaches only `5.386L`,
  and the inherited trace audit reports roughly tenfold larger peak planar
  force and yaw moment than the redirect family. The raw-yaw closure
  `solver_12fc3441a636` and globally intercept-qualified
  `solver_b3b6be8f076f` likewise exit through the upper margin with minima of
  `6.268L` and `4.278L`; the latter settles into a same-sign bend at range.
- The sampled `solver_4365157e5ac8` establishes the useful mechanism: its
  observation-gated two-joint redirect visibly carries the coherent wake into
  the lower corridor and reaches `1.165L`. At closest approach it is still
  moving about `0.680L/T` on an almost perpendicular course (normalized
  course error `0.997`, projected miss `1.161L`) while its joint commands are
  nearly static. This is a controlled near miss, not wake collapse.
- The assigned parent's later terminal-carrier-recovery rollout is a concrete
  negative result. It improves the minimum only from `1.165L` to `1.137L`,
  still misses, and then exits with final distance `11.078L`; both visual rows
  show that the broad redirect and coherent wake survive, so added terminal
  rhythm did not correct the inertial course. The sampled terminal-frequency
  escalation is also negative (`0.870L`). A localized redirect-release veto
  is the best evaluated descendant at `0.829828L`, only `0.079828L` outside
  capture, without changing the far-field wake.
- Reconstructing that best descendant's normalized body-frame signals exposes
  a remaining semantic gap. On approach at `1.751L`, the fish is closing at
  about `0.526L/T` and its projected miss is still `1.235L`, but instantaneous
  body bearing has fallen to `-0.631 rad`. The bearing-only redirect-entry gate
  is therefore only about `0.19`, while the terminal release veto has not yet
  engaged. At `1.101L`, course error has grown to `0.843` and projected miss
  remains `0.928L`, but bearing modulation still limits redirect entry to
  about `0.73`. The terminal controller is guarding release while allowing
  the maneuver itself to drop out on a gait-sensitive bearing excursion.

## Policy hypothesis

Use the best sampled terminal-release-veto controller as the scaffold,
including its state-feedback traveling bend, posterior lag, calibrated turn
side, bounded same-sign redirect, yaw/joint-state release, and capture-local
projected-miss veto. Add one continuous mechanism: inside a small body-length
approach zone, let persistent normalized velocity/target course miss place a
floor under redirect *entry*. Outside that joint proximity-and-course gate,
the sampled controller is exactly unchanged. Inside it, a transient reduction
in body bearing can no longer return authority to the propulsive carrier while
the measured course still misses the target. This acts on mode allocation, not
on a scalar drive or published gain, and retains the sampled redirect dynamics
and actuator envelope.

Expected evidence is the same coherent lower-corridor approach with sustained
redirect authority through the `1.75--1.10L` bearing dropout and a first
crossing below `0.75L`. Falsify the mechanism if it does not beat `0.829828L`,
recreates the globally latched high corridor, loses the alternating 3D wake,
touches the angle boundary, or materially increases acceleration residence or
the redirect family's load scale.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish direction tracking, combined with terminal capture control
source_mechanism: preserve a response-released rhythmic carrier at range, but retain bounded curvature near capture when target-relative motion still predicts a miss
transferable_invariant: near-target steering entry and release should use measured course as well as body attitude, so a transient bearing reduction cannot erase a still-needed redirect
nontransferable_details: species-specific C-start stages, published gains and bend angles, clocked CPG phase, robot linkage geometry, dimensional cadence, exact vortex phases, world coordinates, and task-specific routes
policy_translation: keep joint-state phase and the sampled yaw/bend release, then use normalized head distance and body-frame velocity/target course error only to floor the existing redirect-entry gate in the terminal neighborhood
falsification: reject if capture or a minimum below 0.829828L is not achieved, if a far-field static bend returns, or if wake coherence, angle contact, limit residence, or hydrodynamic loads worsen

## Non-CFD implementation audit

Replaying the sampled `solver_8097d423c0eb` states through both policies
changes `4.30%` of the full trace and exactly zero states at or beyond the new
`2.50L` terminal boundary. Within that boundary the mean maximum joint-command
change is `0.668 rad/T^2` and the maximum is `6.932 rad/T^2`; frozen-state
acceleration-clamp incidence decreases slightly from `37.552%` to `37.538%`.
A direct zero-speed test is finite, a representative dropout state remains
inside the command envelope, and mirrored target, velocity, yaw, and joint
state negate both accelerations exactly. These checks establish locality,
activity, boundedness, schema use, and reflection equivariance only; they are
not CFD evidence or a claim of capture.
