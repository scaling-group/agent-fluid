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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- In the direct-uniform transferred-seed rollout, a coherent alternating wake
  and strong finite progress did not imply viable target steering: distance
  fell from `12.33L` to `4.78L` by `17.85T`, but positive body-frame bearing
  then opened beyond `1.2 rad` while positive posterior mean bend and heading
  grew together; the fish continued downward to `y=0.80L` and exited with
  final distance `9.71L`.  Treat this topology as a curvature sign/distribution
  problem rather than weak propulsion or external advection when local flow is
  only about `0.02U` versus body speed near `0.8U`.  A reusable next test is a
  reflection-equivariant target-to-mean-curvature map shared across both joints
  with bounded slip/yaw release; falsify it if bearing still fails to contract
  before the prior closest-approach point or if the coherent propulsive wake
  collapses.
- The sampled redirect lineage identifies geometric completion gating—not
  carrier retuning—as the first validated 3D capture mechanism.  The seed's
  coherent carrier reached `4.7800 L` before a lower-boundary exit, and a
  target-signed distributed redirect released by instantaneous correct-sign
  yaw improved to `2.4625 L` but missed above/left.  Keeping that carrier and
  redirect while allowing yaw-based release only as normalized body-frame
  target angle contracted produced capture at `26.411 T` and `0.7496 L`; raw
  action clipping also fell from `95.7%` in the response-gated miss to `82.5%`
  in the capture.  Treat beat-scale yaw as evidence of oscillation, not burst
  completion, while macroscopic target error remains large.  Preserve this
  completion gate before testing refinements: sampled terminal amplitude/
  cadence-relief branches still missed at `1.2329 L` and `1.3896 L` and exited
  left.  Falsify the lesson if the fixed-evaluator replay loses capture, or if
  held-out target/pose tests show that sustained curvature damages early
  closing, wake coherence, saturation, or reflection-equivariant steering.
- Do not add anticipatory joint-speed attenuation to this captured carrier
  merely to make its output look more feasible.  Against three deterministic
  completion-gated captures at `26.411 T` and score `-0.71050`, attenuation of
  outward acceleration above `96%` of the speed envelope reduced exact
  anterior speed-limit residence from `11.1%` to `1.68%` and eliminated
  above-limit returned accelerations, but still left `80.9%` of rows at an
  acceleration limit, delayed capture to `26.813 T`, raised mean distance from
  `2.6134 L` to `2.6382 L`, and lowered score to `-0.73429`.  Wake structure,
  local flow, force, and moment remained similar and finite, so this is a
  carrier-authority tradeoff rather than stabilization of a failing flow.
  When the evaluator already enforces the acceleration envelope, prefer an
  exact final acceleration projection that preserves the proven dynamics;
  test future saturation reductions inside oscillator/turn generation or
  inter-joint allocation.  Reconsider the speed guard only if a held-out case
  shows actual joint-limit instability whose benefit outweighs lost closing.
