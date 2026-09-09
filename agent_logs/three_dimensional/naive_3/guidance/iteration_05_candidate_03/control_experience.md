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
- The available acute `bearing` folds target-ahead and target-behind geometry
  because its denominator uses `abs(target_body_x)`. In the `2.4431L` rollout,
  the full body-frame direction error grew to about `2.69 rad` after the fish
  passed below the target while acute bearing fell to about `0.45 rad`, causing
  posterior propulsion to recover before alignment. For pass-by or orbiting
  failures, derive direction from normalized `target_body_L` (or explicitly
  retain its longitudinal sign) before adding gains; this lesson does not apply
  while the target stays forward throughout the useful trajectory.
- Do not substitute instantaneous body-velocity course for yaw response on the
  supported `0.55T` carrier: that inherited controller preserved a coherent
  wake but worsened closest approach from `2.4431L` to `3.2805L` and retained
  the lower-boundary exit. Across that trace and the four sampled rollouts,
  pre-pass heading rate is strongly gait-synchronous: raw rate has roughly
  `1.7--2.0 rad/T` standard deviation and produces wrong-sign damped steering
  in about `22%` of samples, while the reflection-equivariant residual
  `heading_rate + 0.65*phi_dot1` reduces the deviation to `0.6--0.7 rad/T` and
  wrong-sign intervals to about `6%`. When yaw damping is needed for this fixed
  gait, first test joint-phase compensation rather than velocity-course
  feedback or a larger damping gain. The coupling is gait-specific: refit or
  reject it if morphology, carrier period/envelope, or hydrodynamic conditions
  change, or if the residual fails to reduce beat-scale variance and preserve
  target progress.
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
