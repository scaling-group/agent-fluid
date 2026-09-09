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

- This is a fresh 40-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Steering polarity and geometric release are both insufficient when gait
  recoil dominates the measured yaw rate. The clean-B carrier reaches
  `6.138L` before a lower exit, while the completed yaw-rate, static-bend, and
  response-lead mean-curvature sequence reaches `9.175L`, `11.878L`, and
  `12.030L`; all three target-aware policies exit the upper boundary, so the
  response-lead result specifically rejects further tuning of that release
  term as the next experiment. An envelope-safe trend-led half-cycle policy
  likewise reaches only `12.191L`, finishes farther away, and has a visibly
  weaker wake. The underlying observation explains why: `turn_rate_recent`
  spans about `0.0385T`, and raw yaw-rate standard deviation is
  `1.22--1.91 rad/T`, but subtracting the cross-policy joint-velocity recoil
  estimate (`heading_rate + 0.64*phi_dot1 + 0.21*phi_dot2`) reduces it to
  `0.20--0.38 rad/T` and preserves the slow exit-turn sign; on the different
  clean-B controller it reduces `1.85` to `0.19 rad/T` without refitting.
  Before closing another yaw loop, separate locomotor phase from rigid yaw and
  preserve a coherent carrier; avoid raw/sub-beat rate feedback, another
  response-lead gain, or simultaneous carrier weakening. This applies to the
  current two-joint gait family in low local flow (`about 0.02--0.04U`).
  Re-estimate or reject the compensation after a material gait change, and
  falsify the implication if compensated feedback remains beat-dominated or
  does not change the repeated upper-exit topology.
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
