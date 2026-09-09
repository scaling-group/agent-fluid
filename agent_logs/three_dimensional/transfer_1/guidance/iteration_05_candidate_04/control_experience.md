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
  axis and achieved course diverge. In the sampled still-water rollouts, a
  speed-gated target-versus-velocity course servo reached `1.0435L`, versus
  `3.0031L` for a phase-compensated bearing servo and `5.3228L` for the
  inherited wrong-way-yaw brake, while all retained coherent alternating 3D
  wakes. The course servo's direct shared-acceleration actuator exceeded the
  command envelope on about `70%` of steps and still overshot into a lower
  exit; preserve its normalized course error, but route it through a bounded,
  response-released curvature actuator rather than copying the clipped action
  path. This implication is falsified if the cascade loses early propulsion,
  fails to improve the near-miss or termination class, or shows that
  phase-compensated yaw is too beat-sensitive; in that case test a bounded
  half-cycle actuator instead of more course gain.
- Do not infer sustained propulsion from translational speed after terminal
  steering has modified the carrier. The sampled opposing-half-cycle
  reallocation reached `1.2669L`, but its head/tail phase-plane energy fell
  from about `0.84` before approach to `0.40/0.31` at `18T` and below `0.2`
  after `19T`; joint excursion and the visible Lambda2 wake collapsed while
  the fish coasted into the lower exit. A compatible half-cycle actuator kept
  roughly `55--61 deg` excursion and a coherent wake through termination, but
  missed at `2.7390L`. When one-sided steering improves route acquisition yet
  quenches a state-feedback oscillator, preserve the route signal and gate
  only the carrier modification by normalized joint angle/velocity energy so
  low energy restores the unmodified traveling bend. This applies to
  carrier-attenuating actuators, not to every close pass; falsify it if the
  energy guard harms the first approach, fails to restore excursion and wake
  coherence, worsens saturation, or retains the same lower-exit topology.
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
