# Dogfish L64 3D Moving-Window Still-Water Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The transferred 2D clean-B iteration-20 champion retains useful propulsion
  in 3D: its direct-uniform still-water rollout forms a coherent top-down and
  oblique wake, stays numerically stable, and closes from `12.328L` to
  `4.780L`. Its target steering does not transfer with that drive, however:
  mean heading continues in the wrong direction after closest approach and the
  fish exits the lower boundary at `27.49T`, `9.709L` from the target. When a
  later rollout has this combination of coherent propulsion and growing
  body-frame target angle, preserve the traveling gait and test a bounded
  target-error/observed-turn-response redirect rather than increasing cadence
  or damping all lateral motion. Falsify that implication if the redirect
  worsens early closure, produces wrong-sign yaw, persistent saturation, or
  disrupts the coherent wake. No 3D solver or optimizer population is imported.
- Across the first sampled 3D variants, response-gated target-angle curvature
  is the only steering change that improves the seed's approach while
  preserving its propulsive wake: it reduces minimum distance from `4.780L`
  to `2.463L` and changes the lower-boundary exit into a later left-boundary
  exit. In contrast, shared mean curvature turns into the upper boundary by
  `7.711T` with only `12.281L` minimum distance, while velocity-lead posterior
  curvature makes a broad loop, bottoms at `7.328L`, and finishes `15.024L`
  away. The stronger redirect still passes upper-left of the target with
  correct-sign yaw but misaligned translational velocity; raw acceleration is
  already clipped in about 96% of its trace, consistent with inherited logs'
  saturation warning. For a coherent-wake near miss of this kind, preserve the
  response-gated carrier and test whether near-target redirect release should
  require body-frame velocity-to-target alignment, rather than increasing an
  additive gain or applying a far-field velocity predictor. This implication
  does not apply to weak-propulsion failures; falsify it if early closure or
  wake coherence degrades, wrong-sign yaw appears, or the broad-loop topology
  returns.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
