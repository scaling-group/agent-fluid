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
- The four first-generation direct-still-water rollouts establish that redirect
  allocation and sign dominate cadence tuning in this contract. The transferred
  carrier formed a coherent alternating wake and reached `4.780L`, but lacked
  steering authority and exited below at `27.49T`. Preserving that carrier while
  shifting its oscillator centers into a same-sign, geometry-gated C-bend was
  the sole capture (`0.7495L` at `25.39T`, mean distance `2.557L`) and retained
  the alternating wake. In contrast, two response-gated designs that replaced
  most of the carrier with opposite-sign static posture turns gained only
  `0.466L` and `0.155L` before upper-boundary exits at `9.01T` and `7.99T`; one
  spent `78.0%` of samples on the posterior angle limit and produced roughly
  tenfold larger peak lateral load and yaw moment than the capture. Therefore
  preserve the traveling-wave oscillator, use the successful request-to-bend
  sign, and modulate redirect within its posture/lag allocation rather than
  blending wholesale to a static bend. This conclusion is limited to the
  current observation and joint-sign conventions and one fixed still-water
  pose; falsify it if a carrier-preserving redirect loses capture/wake coherence
  or an independently validated sign/allocation improves semantic outcome and
  limit/load histories.
- Once the graded same-sign C-bend established capture, two isolated structural
  refinements improved the same coherent-wake trajectory without changing
  steering polarity or scalar drive gains. Releasing at most `28%` of redirect
  after target-derived yaw and recent yaw response agree advanced capture from
  `25.388T` to `25.152T` and reduced mean scoring distance from `2.557L` to
  `2.522L`; independently, a fourth-order smooth projection of the combined
  accelerations advanced capture to `23.997T`, reduced mean distance to
  `2.438L`, and bounded recorded commands below `1798 deg/T^2` instead of the
  parent's `4584/6217 deg/T^2`, while retaining similar peak lateral load/yaw
  moment (`0.0252/0.0141` versus `0.0255/0.0138`). Therefore, after a useful
  target-directed bend exists, refine posture-to-propulsion handoff from
  observed yaw response and bound the final combined command; do not replace
  the carrier or infer that lower command magnitude alone caused the faster
  route. These mechanisms were evaluated separately, so their composition must
  be falsified hydrodynamically against the `23.997T`, `2.438L` capture and
  rejected if it loses capture, wake coherence, or joint/load quality. The
  lesson is currently limited to the observed still-water pose and sign
  convention.
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
