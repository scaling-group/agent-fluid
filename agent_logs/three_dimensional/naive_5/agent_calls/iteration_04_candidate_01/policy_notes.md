# Wake-policy candidate diagnosis

## Evidence diagnosis before the edit

- All sampled evaluations are contract-valid direct-uniform still water:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and an inertial moving
  window. Motion in both visual rows is therefore self-propulsion rather than
  background advection or a frame artifact.
- The naive seed and the assigned-parent course controller show the same
  failure topology in both views. They form compact, coherent alternating
  wakes, rotate into a tight upward arc, and cross the upper virtual boundary
  at `8.547T` and `8.778T`. The parent improves only to `12.186L` before
  regressing to `12.547L`; angle headroom and a normalized velocity/target
  cross product did not produce a useful course correction.
- The strongest finite comparison, `solver_0334e73ca6df`, visibly generates a
  sustained reverse-street-like top-down wake and a coherent three-dimensional
  caudal Lambda2 trail. It survives to `39.088T` and reaches `5.156L`, versus
  minima near `12L` for the three short failures. It is nevertheless a
  propulsion result, not target steering: the fish stays in the high-y
  corridor, passes the target's x station near `(9.40,14.68)L`, and leaves the
  left boundary at `(0.80,14.96)L` with final distance `10.235L`.
- The inherited logs explain that apparent improvement. In the long rollout,
  instantaneous heading rate correlates with anterior joint velocity at about
  `-0.935`; the yaw-closed half-cycle selector follows beat phase and pumps
  both half-strokes. Joint speed is near its cap on roughly half the samples
  and at least one acceleration is clamped on roughly `58%`. It creates a
  stronger carrier while mean turn selection remains only about `0.1` under
  large bearing error.
- Two direct falsifications are now sampled. Bearing-persistent anterior
  half-cycle steering (`solver_4c2f69e357da`) produces a mean phase-selective
  injection comparable to the long rollout but returns to the upper exit at
  `9.295T` and reaches only `11.954L`. The assigned course-error half-cycle
  controller also returns to the upper exit at `8.778T`; early course direction
  is dominated by low-speed lateral motion, and the soft angle gate does not
  create recovery. Thus neither persistent bearing selection nor
  target-versus-velocity selection turns this half-cycle actuator into useful
  steering, and another scalar gain change within that architecture is not
  supported.

## Policy hypothesis

Keep the evidenced `0.90T`, `18 deg` state-feedback traveling-bend carrier,
but replace continuous half-cycle forcing with a state-gated burst redirect.
Body-frame bearing selects the sign of a same-sign two-joint C-bend. A smooth
gate blends from the carrier into damped joint-pose tracking only while the
target is materially off-axis; observed bearing recovery releases the bend
continuously back into the alternating propulsive gait. This changes the
actuator mechanism, rather than tuning the already-falsified half-cycle gain,
and remains reflection equivariant without time, coordinates, or a memorized
route.

Expected result: before the inherited upward curl reaches the boundary, the
joint-pose burst should generate a finite correct-sign yaw response, reduce
absolute bearing, and release into the coherent leftward carrier on a lower-y
course. Falsify the mechanism if bearing remains large so the fish stays
locked in a static bend, if the same near-`9T` upper exit persists, if the
alternating wake does not resume after alignment, or if joint angle, speed, or
acceleration limits become materially occupied.

```text
bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish sensor-gated direction control
source_mechanism: large observed direction error invokes bounded curvature, and observed directional recovery releases the body back into a propulsive posterior wave
transferable_invariant: separate a finite redirect mode from cruise and gate both entry and release by current body-frame geometry rather than elapsed time
nontransferable_details: species-specific C-start shape and timing, published gains, robot linkage geometry, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: smoothly blend the joint-state traveling-bend carrier into a bounded same-sign two-joint bend selected by normalized body-frame bearing, then let bearing recovery restore the carrier
falsification: reject if the bend fails to reduce absolute bearing before the upper exit, becomes a persistent nonpropulsive posture, prevents the alternating wake from resuming, or materially occupies actuator limits
```
