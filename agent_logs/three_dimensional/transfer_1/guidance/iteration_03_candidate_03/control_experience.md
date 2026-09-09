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
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not equate a centered body-axis bearing with a centered achieved course,
  and do not treat phase-aware yaw feedback as a complete route controller.
  The speed-gated course residual only moved closest approach from `6.127L` to
  `6.067L`; a response-gated posterior yaw brake then reached `5.323L`; and a
  joint-phase-compensated bearing-to-yaw-rate loop reached `3.003L` with the
  best sampled score (`-10.027`). All three retained a coherent wake and finite
  dynamics but missed and left the domain, while the last policy sat at its
  explicit acceleration clamp on about `91%` of logged steps and crossed the
  target x-neighborhood roughly `3L` too high. Preserve the carrier and useful
  phase separation, but test achieved-course outer feedback or a steering-
  actuator bypass instead of escalating bearing/rate gains or posterior
  curvature. Falsify such a change if early closure, wake coherence, or the
  `3.003L` bound is lost.
- Treat a coherent-wake near miss under saturated cruise as a terminal
  authority-allocation problem. The direct achieved-course servo reached
  `1.0435L` at `18.85T`, versus `3.003L` for the best-score phase-compensated
  branch, while still moving about `0.849L/T` with a target-versus-course
  mismatch near `1.73 rad`; its raw acceleration exceeded the actuator envelope
  on about `96.9%` of logged steps, then it crossed below the target and exited
  lower-left. For this regime, test continuous near-and-closing drive relief
  while preserving steering rather than adding more cruise gain. This lesson
  does not apply before broad target-directed closure exists, and is falsified
  if relief harms the far approach, collapses the wake, or fails to improve the
  `1.0435L` closest-approach bound.
- A direct bearing-to-posterior-mean-curvature replacement is not supported by
  the first 3D samples. Two simplified variants preserved finite rhythmic
  motion but reached only `12.206L` and `12.272L` before curling into the upper
  boundary at `7.79T` and `9.09T`, whereas the inherited coupled carrier reached
  about `6.1L` and survived to `26T`. Do not discard the demonstrated carrier
  or use an undamped static bend as the sole route controller; revisit mean
  curvature only as a small response-gated residual whose turn sign, propulsion,
  and command envelope are separately falsifiable.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
