# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All three finite samples satisfy the lane contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. Their motion and wakes are therefore self-generated rather than
  imposed advection.
- The assigned parent `solver_97bc3c03d55b` retains a strong alternating
  top-down vortex street and compact oblique Lambda2 structures, but its
  posterior mean-curvature sign is wrong. A positive initial body-frame target
  bearing of about `0.15 rad` produces negative mean curvature and ultimately
  increasing yaw through a full wrong-side arc. The fish moves from
  `(21,14)L` to the upper boundary at `(16.35,15.20)L` in only `11.13T`, with
  distance falling only from `12.328L` to `9.175L`. This is self-propelled and
  coherent, but not target-directed.
- The informative opposite-polarity sample `solver_e6325a747ec1` establishes
  the actuator sign: positive mean tail curvature initially decreases heading,
  as the repository turn sanity also states. Its `10 deg`, `1.10T` carrier is
  too weak relative to a bias reaching roughly `13 deg`; the top-down and
  oblique rows show a tight hairpin with little trailing wake, distance never
  improves beyond `12.323L`, and it exits the upper boundary at `9.39T` with
  final distance `13.616L`. Correct polarity alone is therefore insufficient
  when static steering dominates propulsion.
- The strongest useful finite trajectory remains `solver_19f251537923`: its
  coherent carrier reduces distance from `12.328L` to `6.138L` before a
  sustained wrong-side turn sends it to the lower boundary at `26.15T`. Local
  flow near closest approach is small, so a crossflow-rejection path is not
  supported in this no-cylinder evidence.
- In the parent, `turn_rate_recent` is the instantaneous body yaw rate rather
  than a beat-averaged response. It oscillates around `+/-2 rad/T`; the
  inherited rate loop consequently drives the requested curvature to its
  limit on most inspected whole-beat samples. The two opposite-polarity
  rollouts show that a high-authority yaw-rate loop chooses the direction of a
  boundary-exit turn, not a stable target route.

## Policy hypothesis

Preserve the parent's evidenced `0.55T`, `28 deg` joint-state traveling-bend
carrier and posterior lag. Replace its raw yaw-rate tracking loop with one
small correct-sign mean-curvature primitive driven only by normalized
body-frame line-of-sight bearing. Positive target-side bearing must create
positive posterior mean curvature, which the 3D sign calibration maps to
negative yaw. Limit the mean bend well below the propulsive amplitude so it
biases rather than replaces the traveling wave; as bearing crosses zero the
bias reverses without a hidden phase, clock, route, or mutable memory.

Expected result: retain the parent's strong wake and forward speed while
avoiding both the parent's long positive-yaw arc and the opposite-polarity
sample's steering-dominated hairpin. Falsify the mechanism if initial positive
bearing does not yield negative mean yaw, if distance fails to beat the
parent's `9.175L` minimum, if the alternating wake collapses, or if a boundary
exit is still preceded by monotonically growing absolute bearing.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking with mean-curvature modulation of a rhythmic gait
source_mechanism: persistent target-side error adds a bounded average bend while the propulsive traveling wave continues
transferable_invariant: normalized body-frame target error should set a small signed mean curvature whose authority remains subordinate to the carrier
nontransferable_details: published gains, dimensional beat rates, linkage geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: map target_body_L divided by distance_L to a bounded line-of-sight error; use the calibrated positive-bias-to-negative-yaw sign only in the posterior equilibrium of the two-joint state-feedback carrier
falsification: reject if the initial yaw sign is wrong, minimum distance does not improve beyond 9.175L, wake coherence or propulsion collapses, or either upper- or lower-boundary exit recurs with growing target bearing
