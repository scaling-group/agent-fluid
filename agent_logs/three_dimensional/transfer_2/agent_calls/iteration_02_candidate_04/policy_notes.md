# Course-aware response-gated curvature candidate

## Evidence diagnosis before policy edit

All four sampled evaluations report direct uniform still-water initialization,
`U_infinity=(0,0,0)`, no cylinders, and moving-window transport.  The combined
keyframe sheets were inspected in both the top-down mid-plane vorticity row and
the oblique body/Lambda2 row.

- `solver_b6bb94d9cdaf` is the strongest finite rollout by score (`-7.6367`).
  Its posterior-lag gait self-propels and sheds a persistent alternating wake,
  reducing distance from `12.3277 L` to `5.3570 L`, but it oscillates across the
  target direction rather than settling: reconstructed body bearing is about
  `-29.8 deg` at `8 T`, `-38.4 deg` at `12 T`, and `-87.4 deg` at `20 T`.
  It exits the upper boundary at `21.79 T` with distance `5.8935 L`.  At
  `16 T`, its body-frame velocity course is about `+28.7 deg` while the target
  bearing is `-37.7 deg`, so body heading feedback alone is not controlling the
  inertial direction of travel.
- The prefilled `solver_e450df1efa49` keeps an especially coherent axial wake
  and makes the closest sampled pass (`4.1281 L` at `21.80 T`), but continues
  left above the target and exits the left boundary at `32.02 T`, distance
  `9.1538 L`.  At `16 T`, target bearing is about `-64.4 deg` while velocity
  course is about `-7.6 deg`; this is again a large course-to-target mismatch,
  not a propulsion shortage.  Its branch-heavy raw accelerations also exceed
  the physical acceleration envelope frequently.
- `solver_e699ec5c28f1` initially reduces bearing from `+8.88 deg` to
  `-2.02 deg` by `4 T`, then reverses into a sustained wrong-sign turn and
  exits the lower boundary at `26.18 T` after a `6.1797 L` closest pass.
  `solver_9d409fc369f7` moves the anterior oscillator center with the curvature
  request; its gait decays nearly to a static bend, it makes only `0.024 L` of
  closest progress, curls upward, and exits near its start at `9.87 T`.

The visual and numerical evidence therefore supports preserving the compact
posterior-lag drive while replacing layered heading-only steering.  The
candidate will form a speed-gated body-frame course error from target geometry
and measured velocity, request a bounded yaw rate from that error, and map yaw
rate error only into posterior mean curvature.  It will not shift the anterior
oscillator center.  This should retain the coherent wake while correcting the
lateral momentum that carried the two useful rollouts past the target line.

Falsification: reject the mechanism if the next rollout loses the alternating
propulsive wake, remains near the release point like `solver_9d409fc369f7`,
keeps a large target/course mismatch after forward speed develops, repeats the
upper/left exit with no closest-distance improvement over `5.3570 L`, or
resides at the joint acceleration, rate, or angle limits.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and fish turning by propulsive-rhythm asymmetry
source_mechanism: sensor-driven bounded mean-curvature bias with release or reversal after measured heading response
transferable_invariant: preserve a posterior-lag traveling bend for thrust and steer it with a bounded target-error bias that is braked by observed motion
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: speed-gate normalized body-frame velocity direction, subtract it from normalized target direction, request bounded yaw rate, and drive posterior mean curvature from measured yaw-rate error
falsification: reject if course alignment does not improve, propulsion collapses, wake coherence is lost, or actuator-limit residence replaces the sampled exit failure
