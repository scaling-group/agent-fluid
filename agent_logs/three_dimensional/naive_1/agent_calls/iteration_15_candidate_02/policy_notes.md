# Candidate wake-policy diagnosis

## Evidence read before editing

- The assigned parent documents the first reactive-rudder capture at
  `24.337509T`, `0.749625L`, and `2.224316L` mean distance.
- The higher-rated sampled guidance records the matched terminal allocation
  tests: a harmful closing-deficit rudder boost and the narrower positive
  result from releasing at most 20% of that rudder.
- No inherited `logs/optimize/` file was present before this worker; the
  assigned and sampled guidance plus completed solver diagnostics are the
  available inherited rationale.
- All four sampled solvers reproduce the relief controller's numerical trace:
  capture at `24.326511T`, final/minimum distance `0.749329L`, mean distance
  `2.224097L`, and mean action norm `42.934` inside `1.5L`. This is two control
  steps earlier than the unmodified reactive rudder while preserving the
  inherited force, moment, and saturation envelope.
- Initialization is directly uniform at `U_infinity=(0,0,0)` in every sample,
  so the observed progress is self-propulsion rather than imposed advection.
  Three sampled combined sheets have identical complete top-down and oblique
  rows. The fourth has the same top-down sheet and numerical trace but a blank
  oblique row, which is a render-evidence failure rather than independent 3D
  confirmation.

## Visual diagnosis and policy hypothesis

From release through capture, the complete top-down rows show a persistent
alternating wake behind a translating fish, followed by a smooth target-side
course curl. The oblique Lambda2 rows show discrete three-dimensional wake
structures throughout the approach; propulsion does not visibly collapse or
turn into a coast. Near capture, the trajectory bends sharply around the
target while the rhythmic carrier remains active. The metrics agree: distance
falls from `12.328L` to the capture threshold without instability, while the
final body translation is poorly aligned with the head-to-target vector and
the head crosses mainly during a strong yaw/beat sweep. Thus the positive
effect is best interpreted as releasing over-allocated terminal posterior
steering, not as evidence that a one-step articulated-head distance derivative
is a reusable stall sensor.

The candidate will preserve the complete carrier, route steering, posterior
load sign, and 20% relief bound. It will replace one-step closing-deficit
sensing with a near-field approach-allocation gate: below `1.5L`, compare the
measured body-frame translation direction with the normalized head-to-target
direction and smoothly release posterior rudder as their cosine alignment
falls. The gate is identically zero outside the near field, so the established
middle-distance route and wake should remain unchanged. On the inherited
trace, translation alignment is about `0.66` at `1.5L`, `0.42` at `1.0L`, and
becomes negative at capture; this provides a directly calibrated, normalized
response signal without importing a dimensional speed threshold.

bookshelf_consulted: true
source_domain: biological and robotic fish terminal maneuvering with sensor-modulated rhythmic propulsion
source_mechanism: continuous far/middle/near approach allocation that preserves the traveling carrier while reducing excess terminal steering
transferable_invariant: condition a bounded terminal correction on measured target-relative approach quality without suppressing the propulsive rhythm
nontransferable_details: published gains, species kinematics, dimensional speeds, prescribed phases, and task-specific routes
policy_translation: inside a normalized near-distance gate, use the cosine between body-frame translation and the head-to-target vector to release at most 20% of only the posterior rudder; retain the joint-state carrier and all broad-route feedback
falsification: reject if capture is later than 24.326511T, mean distance exceeds 2.224097L, the trajectory changes outside 1.5L, capture is lost, or wake coherence, near-target effort, rate-cap occupancy, peak force, or peak moment worsens
