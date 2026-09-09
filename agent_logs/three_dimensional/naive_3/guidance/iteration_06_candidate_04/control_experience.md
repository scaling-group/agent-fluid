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
- In the direct-uniform still-water seed rollout, the joint-only oscillator
  produced a visible alternating 3D wake and self-propulsion, but its heading
  curled from the target-directed release toward the upper boundary: it exited
  at `8.602T`, improved `12.3277L` initial distance only to `12.0701L`, and
  finished at `12.3677L`. Both joint rates also reached the `260 deg/T` limit.
  For this failure topology, add bounded body-frame target-to-curvature
  feedback before wake rejection, terminal scheduling, or scalar drive tuning;
  preserve the traveling bend and falsify the steering primitive by turn sign,
  bearing reduction, wake continuity, and boundary-exit class. This priority no
  longer applies once a rollout demonstrates sustained target-directed motion.
- Across completed target-feedback rollouts, restrained 7-degree curvature
  centered fully on the anterior carrier is the supported steering scaffold:
  plain curvature reached `4.0671L`, half-cycle asymmetry reached `3.5871L`,
  and bearing-gated posterior propulsion reached `2.4431L` with a coherent
  wake and `31.097T` survival. In contrast, posterior-heavy 14-degree steering
  and an inherited 7-to-12-degree redirect both lost propulsion and stayed
  beyond `12.29L`. Preserve the restrained full-anterior scaffold and change
  the late geometric feedback before trying stronger static bend; revisit this
  boundary only if a completed rollout retains early thrust while demonstrating
  a correct-sign high-curvature redirect.
- The available acute `bearing` folds target-ahead and target-behind geometry,
  but repairing that alias is necessary rather than sufficient for the powered
  pass-below topology. The `2.4431L` parent recovered posterior propulsion as
  acute bearing fell after the target moved behind; full direction from
  `target_body_L` correctly preserved the roughly `2.69 rad` error, yet still
  reached only `2.4939L` and exited below. Distance-only carrier relief reached
  `2.8455L`, and an inherited state-phased anterior return brake reached
  `2.5009L`, with the same termination class. Do not spend another candidate on
  any of these post-pass corrections alone. Preserve full direction for semantic
  correctness, but test a pre-pass course/phase mechanism that acts while the
  target remains forward; reject it if it cannot beat `2.4431L` or change the
  lower-exit topology. This priority ends once a completed rollout demonstrates
  sustained redirect before the closest-approach crossing.
- Instantaneous yaw is strongly contaminated by the propulsive rhythm in the
  best near-miss: before `18T`, `|heading_rate|` exceeds `2 rad/T` for about
  `42%` of samples, and the inherited `direction - 0.18*heading_rate` request
  reverses sign relative to target direction about `23%` of the time. Simply
  replacing that release with instantaneous target-versus-course error was not
  a solution: the completed course controller worsened closest approach from
  `2.4431L` to `3.2805L` and retained the lower exit. Posterior half-cycle
  asymmetry likewise reached only `3.6615L`, while a late response-gated
  C-bend reached `2.4678L` without changing termination. Avoid these mechanisms
  in isolation and do not overcome the fast feedback with more saturated
  effort or static curvature. Across the four sampled traces, however,
  `heading_rate ~= -0.70*phi_dot1 - 0.188*phi_dot2` explains `97.2--97.4%` of
  pre-pass yaw-rate energy; test subtracting this joint-state-correlated
  rhythmic component before applying yaw release. Reject that phase separator
  if early thrust, wake continuity, actuator residence, or correct-sign target
  progress worsens, or if it repeats the powered lower-exit topology.
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
