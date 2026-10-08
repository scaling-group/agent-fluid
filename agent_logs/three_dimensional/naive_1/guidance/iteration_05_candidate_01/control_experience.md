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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- In direct-uniform still water, the drive-only seed formed a visible
  three-dimensional posterior wake but reached only `12.078L` before reversing
  and exiting the upper boundary at `8.55T`.  Earlier anterior half-cycle
  steering improved minimum/final distance to `11.782/11.797L`, while a
  posterior redirect regressed to `11.838/12.054L`.  The sampled anterior
  phase-speed rectifier and two bearing-gated mean-curvature handoffs all kept
  the coherent wake but also kept the upper-exit topology, terminating by
  `11.20T` with minima of only `10.062L`, `9.955L`, and `9.402L`.  In contrast,
  an ungated slip-aware `8 deg` anterior mean-curvature center with a zero-mean
  posterior lag changed the topology: it approached from `12.328L` to `5.033L`
  at `17.56T`, sustained a coherent 3D wake to `28.59T`, then overshot below
  the target and exited with distance back at `9.084L`.  Its raw acceleration
  request was at or beyond the hard limit on about `97%` of samples and joint
  rate was at the cap on about `29%`, so larger static bias is not the supported
  next step.  Preserve ungated anterior mean curvature and posterior zero-mean
  lag; avoid bearing-magnitude gates, another posterior redirect, or
  propulsion-scalar tuning as steering.  Instead test bounded response
  unloading from normalized yaw or bearing trend to brake the oscillatory
  redirect.  Reject this implication if that feedback loses the alternating
  wake or the `5.033L` approach, increases saturation/loads, or repeats the same
  lower-exit overshoot without smaller bearing/yaw oscillation.
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
