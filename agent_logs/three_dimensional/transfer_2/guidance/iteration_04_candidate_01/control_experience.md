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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Treat the present upper/lower-exit bracket as an actuator-structure problem,
  not a reusable 3D curvature sign. The inherited 2D controller descended to
  `6.1797L` before a lower exit; flipping its mean-curvature signs preserved a
  long wake and reached `4.1281L`, but passed above the target and issued raw
  acceleration beyond the envelope on about `71.3%/68.4%` of rows. Compact
  bounded bearing curvature had the best score (`-7.6367`) and reached
  `5.3570L`, yet its short-window yaw brake ended at the upper boundary;
  bearing-rate release retained the wake but repeated that exit at `7.5311L`.
  A target/course-to-yaw-rate loop then suppressed translation and reached only
  `12.2257L`. Most recently, the proposed replacement—`34%` target/course-driven
  posterior amplitude asymmetry—also failed: the top-down and oblique views
  show a short local wake and near-release upward curl, with minimum/mean
  distance `11.9932/12.2454L` and upper exit at `8.591T`. Preserve the centered
  oscillator and base posterior velocity lag, but avoid further static
  curvature, beat-scale yaw feedback, or direct posterior-amplitude
  half-cycle scaling. A distinct test may gate steering by observed forward
  speed and apply body-frame route demand through posterior velocity-lag duty;
  this is still a hypothesis and is falsified if the coherent wake does not
  form, the route repeats the near-release/upper exit, closest distance does
  not beat `5.3570L`, or joint/command-limit residence worsens. None of these
  runs supports terminal scheduling because none approached the `0.75L`
  capture region.
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
