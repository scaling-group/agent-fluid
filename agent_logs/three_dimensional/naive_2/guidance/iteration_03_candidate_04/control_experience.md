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
- In direct-uniform still water, the naive oscillator's coherent visible wake
  is not evidence of target-useful propulsion by itself. It improved distance
  only 0.250L (12.328L to 12.078L) before its initially useful rotation passed
  through alignment near 4T and curled to an upper-boundary exit at 8.547T;
  meanwhile roughly one third of each joint's raw acceleration requests
  exceeded the 1800 deg/T^2 envelope. Retain its state-based traveling bend
  only as a scaffold: test a bounded body-frame target-to-curvature mechanism
  with rotation damping, and reject it if bearing does not converge before the
  seed exit, forward progress collapses, or saturation remains the dominant
  control behavior.
- Matched direct-uniform rollouts reject posterior half-cycle or envelope
  asymmetry as the next rescue for this carrier. Four course-, crossflow-, and
  phase-gated variants preserved coherent alternating 3D wakes but all repeated
  the upper-domain exit at `8.585--8.772T`, with minimum/final distances only
  `11.949--12.038L`/`12.181--12.314L`. A posterior mean-tangent controller,
  while still unsuccessful, instead survived to `9.823T`, moved about `1.75L`
  leftward, and reached `11.512/11.518L`; its tail action was already above 95%
  of the acceleration envelope for about 27% of samples and both joint speeds
  touched `260 deg/T`. Preserve the uncentered anterior rhythm and do not tune
  half-cycle gain or static tail curvature upward in isolation. The next useful
  test must change the control regime, for example by using body-frame bearing
  and lateral slip to gate a bounded posterior redirect that relieves its wave
  while error is large and restores it when yaw response appears. Reject that
  translation if it cannot beat the `9.823T` upper-exit topology, if it loses
  the alternating carrier after realignment, or if limit residence/load peaks
  exceed the mean-tangent comparator.
