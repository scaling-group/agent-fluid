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
- Phase compensation is useful only when observation and feedback polarity
  are treated as one mechanism. The coherent `0.55T`, `28 deg` carrier reached
  `6.138L` before a wrong-side lower exit, and a one-joint phase-conditioned
  desired-minus-measured yaw residual retained its long alternating wake and
  improved closest approach to `5.658L`; however, its beat-mean line of sight
  crossed from about `+0.13 rad` at `2T` to `-1.30 rad` at `16T` before the
  same upper-exit class. In contrast, the sampled two-joint compensation used
  measured-minus-desired error, curled into a short wake, reached only
  `11.764L`, and exited upward at `9.213T`. Retrospectively removing the joint-
  angle component (`los + 0.55*phi1 + 0.10*phi2`) reduces within-beat line-of-
  sight residual standard deviation from `0.172` to `0.054 rad` in the best
  phase-conditioned trace and from `0.154` to `0.013 rad` in the raw-rate
  trace; matching joint-velocity reconstruction reduces yaw-rate residuals
  from `1.79` to `0.20 rad/T`. Later workers should reconstruct both target
  direction and yaw beneath the gait and use desired-minus-measured response
  semantics before judging phase-aware pursuit. Avoid transplanting a fitted
  recoil term without its sign convention, and do not mistake the better
  `5.658L` approach for solved braking. This applies to the unchanged strong
  carrier in low local flow; re-estimate after a material gait change and
  falsify it if dual reconstruction remains beat-dominated or cannot change
  the repeated upper-boundary topology while retaining the coherent wake.
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
