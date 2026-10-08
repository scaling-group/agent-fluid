# Candidate diagnosis and policy hypothesis

## Sampled evidence

- The only sampled rollout is the assigned transferred 2D champion in the
  direct-uniform, still-water L64 episode. It is therefore both the best
  finite example available here and the informative failure; no inherited
  optimizer log supplies a second completed trajectory.
- The top-down row shows self-propulsion rather than advection: an organized
  alternating wake develops behind a fish that moves from `(21,14)L` toward
  the target. The oblique Lambda2 row confirms a coherent three-dimensional
  wake and no prewarm structure at release. This agrees with
  `U_infinity=(0,0,0)` and `initialization_mode=uniform_direct` in the metrics.
- Propulsion initially helps: distance falls from `12.3277L` to `4.7800L` at
  about `17.85T`. The trajectory then passes below the target, distance grows,
  and the fish exits the lower virtual boundary at `27.49T` with center
  `y=0.7982L` and final distance `9.7089L`.
- This is a steering-authority failure. Heading is `29 deg` at release,
  approximately `40 deg` at closest approach, and approximately `75 deg` at
  exit even though the target remains on the side calling for the opposite
  yaw. The target request is already large in that interval, so another
  scalar increase to the same additive turn path is not a distinct remedy.
- The action trace also shows actuator competition: approximately 98% of raw
  action rows exceed the configured `1800 deg/T^2` acceleration envelope in
  at least one joint before evaluator clipping, and a joint is at the
  `260 deg/T` speed bound in approximately 27% of rows. More cadence or raw
  additive acceleration would be poorly identifiable and likely ineffective.

## Policy hypothesis

Preserve the evidenced traveling-wave drive, but translate the target request
into a bounded mean bend shared by the anterior joint and total tail tangent.
As target misalignment grows, reduce oscillatory amplitude and cadence enough
to reserve actuator authority for that bend. Release the redirect
continuously when bearing trend shows the nose sweeping toward the target;
all gates use normalized body-frame geometry and observed joint/yaw state.
The combined joint commands are soft-bounded below the fixed physical
acceleration limit so this allocation remains visible instead of being erased
by evaluator clipping.

The candidate is falsified if the rollout retains the same below-target exit
topology or fails to produce a sustained correct-sign heading change before
closest approach. It is also rejected if early distance reduction and the
coherent posterior wake collapse, or if joint limit occupancy remains high
without better target alignment.

bookshelf_consulted: true
source_domain: robotic-fish mean-curvature turning and biological burst redirect
source_mechanism: bounded average bend for turning, with strong redirect followed by release back into posteriorly lagged propulsion
transferable_invariant: reserve actuator authority for a target-signed body bend when persistent misalignment is large, then restore the traveling wave as observed alignment improves
nontransferable_details: published gains, species-specific C-start kinematics, dimensional beat frequencies, exact vortex phases, and task-specific routes
policy_translation: map body-frame bearing and target-vector angle to bounded anterior bend and tail-tangent references; use bearing trend for continuous release and reduce joint-state oscillator amplitude and cadence only while redirect authority is needed
falsification: reject if correct-sign yaw does not precede the prior 17.85T closest-approach point, if the same lower-boundary exit remains, or if propulsion and wake coherence collapse
