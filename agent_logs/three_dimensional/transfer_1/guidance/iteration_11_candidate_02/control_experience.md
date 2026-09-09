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
- Separate route sensing from steering realization when a free swimmer's body
  axis and achieved course diverge. A speed-gated target-versus-velocity course
  servo reached `1.0435L`, while a phase-compensated bearing servo reached
  `3.0031L`; routing course error through the same phase-compensated rate
  cascade then reached only `3.1135L` and repeated the upper/left exit. In
  contrast, bounded opposing-half reallocation retained the course-directed
  topology and reached `1.2669L`, and carrier-aligned allocation later reached
  `0.9532L`. A terminal velocity-ray collision corridor then preserved the
  coherent wake but regressed to `1.6045L` and the same lower exit, so changing
  when the outer route request is released is not a substitute for changing
  how that request is realized. Preserve the normalized achieved-course outer
  signal; avoid another yaw-rate cascade, collision-corridor threshold, or
  scalar course-gain edit unless it changes the first-pass or termination
  class. Prefer a separately bounded phase-selective wave-shape actuator, and
  falsify that direction if it cannot beat the `0.9532L` carrier-aligned pass
  while retaining the alternating wake and early route.
- Treat terminal locomotor reserve as an observed state constraint, not an
  incidental wake detail. The `1.2669L` opposing-half near miss improved route
  geometry but its head/tail phase-plane energy fell from about `0.85` to below
  `0.2`, joint excursion collapsed from roughly `52 deg` to below `9 deg`, and
  the fish coasted into the lower exit. A terminal mean-curvature alternative
  kept roughly `0.83--0.89` carrier energy and `50--51 deg` excursion but
  missed farther at `1.5454L` while its two acceleration commands sat at the
  envelope on about `70.5%/72.5%` of rows. Thus neither unguarded carrier
  suppression nor wholesale replacement by static curvature is supported:
  preserve the useful half-cycle turn while releasing steering or restoring
  oscillatory energy at a normalized reserve boundary. Falsify this lesson if
  reserve-aware control fails to restore the alternating terminal wake,
  worsens the first pass, increases saturation, or leaves the same lower-exit
  topology; then test a separately bounded yaw/slip-response release.
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
