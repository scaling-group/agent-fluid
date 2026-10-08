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
- Do not infer a yaw-to-bend polarity inversion from cycle-scale correlation in
  one saturated rollout. The clean-B seed formed a coherent wake and made 61.2%
  closest-distance progress before a lower exit, but the inherited explicit
  polarity flip with reserved steering authority destroyed that wake, reached
  only 1.3% closest-distance progress, and curled through the upper boundary at
  `7.99T`; a strong near-total C-bend blend produced the same upper-exit class
  at `9.01T`. In contrast, a graded same-polarity shift of oscillator center
  and tail-tangent target preserved coherent shedding and captured at
  `25.388T`. Releasing at most 28% of that redirect only after target turn-rate
  request and observed yaw agreed also preserved capture, modestly improving
  arrival to `25.152T`, mean distance from `2.5572L` to `2.5218L`, and peak
  positive yaw rate from `2.781` to `2.604 rad/T`. Preserve the graded polarity
  and use response as a bounded release signal, not as justification for a
  topology replacement; reject this lesson if an isolated unsaturated sign
  test or a held-out pose reverses the measured response.
- Command conditioning is a control mechanism when evaluator clipping is
  active, not cosmetic post-processing. On the otherwise identical captured
  C-bend controller, a component-wise fourth-order smooth projection reduced
  recorded acceleration peaks from `79.999/108.510` to
  `31.251/31.374 rad/T^2`, retained the alternating top-down and three-dimensional
  Lambda2 wakes, captured earlier (`23.997T` versus `25.388T`), and lowered mean
  distance (`2.4384L` versus `2.5572L`). This completed CFD comparison supports
  preserving the physical envelope ahead of further steering changes. It does
  not validate stronger drive: both projected and unprojected captures still
  reach the `260 deg/T` joint-speed limit. Future combinations must preserve
  capture, wake coherence, and the arrival/distance gains; lower command
  saturation alone is insufficient, and this conclusion should be retested if
  the actuator envelope or gait carrier changes.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
