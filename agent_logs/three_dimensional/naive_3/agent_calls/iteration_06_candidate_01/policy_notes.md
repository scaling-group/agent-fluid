# Wake-policy candidate notes

## Visual and numeric diagnosis

- All four sampled solver rollouts and the assigned parent's inherited
  `fd9d...` rollout satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm. Their
  translation and wakes are policy-generated rather than ambient advection.
- The sampled sheets all show a coherent alternating mid-plane vorticity
  street during broad travel, and their oblique rows confirm corresponding
  three-dimensional Lambda2 structures. They remain numerically stable and
  follow nearly identical useful trajectories through about `12T`; the common
  failure is late geometric control, not absent propulsion.
- The three sampled carrier-relief schedules do not improve the inherited
  `2.960L` closest approach: posterior-only relief reaches `3.162L`, joint
  damping reaches `3.592L`, and amplitude scheduling reaches `3.032L`. The
  damping case has almost stationary joints by `16--21.5T` but coasts near
  `0.7U` past the target and exits left. Free actuator reserve without an
  active bend therefore does not provide corrective authority.
- The prefilled full-quadrant redirect also becomes a static posture. At its
  `2.999L` minimum near `17.67T`, the joints are approximately
  `(-10.2,-12.1) deg` with rates only `(-0.06,0.05) rad/T`, while inertial
  motion remains about `0.70U` body-forward and `0.32U` lateral. The late
  top-down and oblique frames show the body departing its established wake;
  it then coasts upward to the same left-domain termination. Error-gated
  anterior damping has thus falsified the intended nonzero-beat redirect.
- The assigned parent's inherited closing-and-distance-gated active C-bend is
  the strongest geometric evidence despite its worse scalar score. Its
  top-down and oblique rows retain active alternating/Lambda2 structures
  through `24T`; it improves closest distance to `2.679L` at `18.41T` and
  moves the head to `(9.055,12.179)L`. However, it still crosses about
  `2.679L` high with full-quadrant bearing `-1.115 rad`, body-forward speed
  about `0.71U`, and lateral speed about `0.50U`, then exits left at final
  distance `8.637L`. Within `5L`, its raw acceleration requests exceed the
  envelope in about `69.0%/71.3%` of samples and its rate-limit occupancy is
  about `9.5%/10.9%`. Active anterior recruitment can improve target-normal
  displacement, but a mean-center bend does not contain lateral slip or
  capture.

## Policy hypothesis

Restore the demonstrated zero-centered bearing/slip carrier and retain the
inherited active redirect's continuous proximity, misalignment, and positive
closing-speed trigger. Replace static anterior recentering and carrier relief
with one phase-aware duty-ratio primitive: on the anterior half-cycle already
bent toward the requested turn, smoothly reduce restoring frequency to extend
that useful stroke; leave the opposing half-cycle at the established carrier
frequency. The modulation never strengthens peak restoring acceleration,
never damps the oscillator, and vanishes outside the imminent misaligned
approach. The posterior joint keeps the established lag and bounded mean
curvature, so the test isolates whether active half-cycle dwell supplies the
missing yaw impulse without erasing the traveling wake.

The next rollout should match the demonstrated far-field trajectory and wake,
then preserve visible joint cycling while the redirect gate is active, reduce
the target-normal miss below `2.679L`, and contain the large approach lateral
slip before the x crossing. Falsify the mechanism if it changes far-field
travel, stalls into another static posture, materially increases joint-limit
occupancy, fails to beat `2.679L`, or repeats the left exit without a distinct
corrective arc.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and asymmetric flapping or duty-ratio control
source_mechanism: observed directional error biases the duration or strength of the useful propulsive half-cycle while preserving a rhythmic traveling carrier
transferable_invariant: create turning moment through bounded phase-dependent asymmetry, and release the asymmetry from measured alignment or closing response rather than elapsed time
nontransferable_details: published duty ratios, gains, dimensional trigger distances, clock phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: infer anterior beat side from normalized joint angle, form a bounded turn request from full body-frame target geometry and lateral velocity, and only during a close positively-closing misaligned approach lengthen the requested half-cycle by reducing its restoring frequency
falsification: reject if the far-field wake changes, the active beat collapses, approach acceleration or rate occupancy rises materially, lateral slip is not contained, closest distance does not improve below `2.679L`, or the same left-exit trajectory persists
