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
- In the sampled direct-uniform naive rollout, both wake views show a coherent
  alternating tail wake and self-propelled motion, yet the target-blind carrier
  changes heading from `0.506` rad to as low as `-1.186` rad, improves distance
  only from `12.328L` to `12.069L`, then exits the upper virtual boundary at
  `8.596T` with both joint rates reaching `260 deg/T`. Treat that topology as a
  directional-feedback failure, not a reason for scalar-only carrier tuning:
  preserve the joint-state oscillator and test bounded body-frame
  target-to-mean-curvature steering with yaw-rate release. This implication is
  falsified if the steering turn has the wrong sign, fails to beat `12.069L`,
  repeats the upper-boundary exit, or sacrifices the coherent wake by worsening
  joint saturation.
- Do not continue the inherited sequence of bend-threshold releases or
  carrier-relative asymmetry caps as if actuator reserve implied navigation.
  Mean-bend release removed simultaneous `>40 deg` dwell and held normalized
  peak planar force/moment to `0.488/0.220` but reached only `2.664L` and left
  the tail above `40 deg` for `6.349T`; posterior-bend release cut tail dwell
  to `0.930T` yet regressed to `3.312L` and raised the peaks to `0.890/0.414`.
  The inherited reverse-half-cycle cap then retained a coherent visual wake
  but also failed its own route falsifier: `2.937L` minimum, `9.264L` final
  distance, score `-10.506`, and a left-edge exit. An opposed carrier
  half-cycle is a useful algebraic safety property, not a terminal steering
  mechanism. This negative result applies to `signed_asymmetry *
  abs(carrier)` policies with the same full-circle approach relief; revisit a
  cap only if a distinct feedback signal first changes the trajectory class.
- Preserve measured target-versus-course error as the strongest evidenced
  far/middle directional signal, but give it an explicit terminal boundary.
  The sampled course-residual controller reached `1.173L`, versus `2.664L` or
  worse for the sampled full-circle variants, with no joint dwell above
  `40 deg` and only `0.034/0.017` peak normalized planar force/moment. It still
  crossed below the target at about `1.05L/T`, reversed closing speed, and
  escaped lower-left to `10.560L`; instantaneous course steering therefore
  does not establish capture by itself. The inherited evaluation of the
  proposed terminal mean-curvature handoff then narrowed the miss only from
  `1.173L` to `1.033L` and still exited left at `10.375L` final distance
  (score `-11.417`). Complementarily, the sampled prefill's carrier-relative
  terminal redirect reached only `2.595L` and had both joints pinned at
  `-45 deg` around its closest pass. The assigned parent's subsequent
  common-mode curvature PD plus positive-closing-speed carrier relief then
  regressed to `2.167L`, incurred `1.611/4.943T` of head/tail dwell above
  `40 deg`, and raised peak normalized force/moment to `0.526/0.226`. A
  parallel closing/misalignment-gated two-joint posture hold retained zero
  angle dwell and low `0.036/0.018` loads, but improved the miss only from
  `1.033L` to `1.008L`; at closest approach it still traveled at `1.01L/T`,
  had nearly stopped both joint rates, yawed the wrong way at `+0.231 rad/T`,
  and later exited left at `9.228L`. Do not strengthen common-mode braking or
  arrest both joints as a terminal fix: these results show that speed relief
  without retained beat-scale yaw authority merely changes the near-miss.
  Preserve the low-load course carrier outside roughly `3L`; inside it, test
  closing-speed/yaw allocation through one differentiated actuator role, such
  as response-gated posterior thrust relief that leaves anterior steering
  rhythmic. Falsify that allocation if it does not capture or beat `1.008L`
  with a better recovery/termination, or if joint dwell, loads, or wake quality
  worsen; a smaller miss without capture supports only the allocation, not
  terminal success.
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
