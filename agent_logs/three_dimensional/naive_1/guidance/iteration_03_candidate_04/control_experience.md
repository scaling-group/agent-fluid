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
- The sampled L64 direct-still-water seed rollout establishes that a coherent
  alternating 3D wake is not evidence of route control: the target-blind
  oscillator self-propelled about `0.95L` left and briefly reduced distance by
  `0.264L`, yet accumulated `1.20L` upward drift, swept heading across about
  `1.77 rad`, and exited the upper boundary at `8.61T`. Preserve its traveling
  bend and posterior lag when testing steering, but add a bounded body-frame
  target-to-curvature mechanism before wake compensation or scalar-only drive
  tuning. This implication is falsified if such feedback collapses the coherent
  wake, increases sustained actuator saturation, or retains the same
  upper-boundary trajectory topology.
- Do not treat a sub-beat recent-yaw estimate as mean turn response. In the
  best sampled differential-curvature rollout, target bearing remained
  negative (`-1.52` to `-0.66 rad` during `18--28T`) while the seven-sample
  turn rate swung about `-2.50` to `+2.49 rad/T`; its inner servo therefore reversed
  steering within a persistent route error, carried the fish almost straight
  past the target at `4.977L`, and incurred `16.7%/19.1%` joint-rate contact.
  The inherited posterior response-gated variant also retained the early upper
  exit and worsened closest approach from `11.096L` to `11.789L`. When history
  is much shorter than the `0.55T` carrier period, preserve the useful
  opposite-sign joint allocation but test a bounded persistent bearing command
  or a genuinely beat-scale response proxy; this lesson is falsified if a
  longer-horizon yaw estimate contracts bearing without beat-synchronous sign
  reversal or added saturation.
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
