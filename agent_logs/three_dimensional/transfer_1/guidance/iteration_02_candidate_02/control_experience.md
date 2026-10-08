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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
- The transferred champion's direct-uniform still-water rollout establishes a
  useful carrier but a failed steering topology: its coherent alternating 3D
  wake and roughly `0.8 L/T` speed persist as distance improves from
  `12.3277 L` to `4.7800 L` at `17.853 T`, then the path continues downward,
  distance rebounds to `9.7089 L`, and it exits the lower boundary at
  `27.495 T`.  For this approach-then-diverge pattern, preserve the posterior-
  lag gait and test body-frame motion anticipation or response-gated curvature
  before increasing carrier amplitude/frequency.  Falsify that implication if
  earlier redirection weakens closing or wake coherence, creates persistent
  saturation, or leaves the same closest approach and `left_domain` topology.
- The first sampled controller comparison separates redirect structure from
  carrier changes.  A body-frame angle/observed-yaw response-gated redirect
  preserved the coherent wake and improved closest approach from `4.7800 L`
  to `2.4625 L`, producing a meaningfully different upper-left miss before a
  left-boundary exit.  In contrast, the assigned velocity-lead/old-curvature
  combination regressed to `7.3276 L`, shared mean curvature nearly stalled
  at `12.2813 L` and exited after `7.711 T`, and inherited global distributed-
  bend/drive-relief evidence reached only `12.2472 L`.  For a coherent near-
  miss, preserve the successful posterior-lag carrier and target-signed
  redirect; refine when response-based release is earned or add strictly
  terminal interception feedback rather than globally relieving drive or
  replacing the curvature map.  Falsify this implication if persistent
  redirect worsens early closing, destroys wake coherence, reverses the useful
  turn sign, materially increases saturation, or cannot improve the
  `2.4625 L`/`left_domain` result.
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
