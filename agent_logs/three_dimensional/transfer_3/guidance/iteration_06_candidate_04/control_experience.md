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
- Do not assume that a successful 2D target-to-curvature sign transfers to the
  3D body/force convention. In the sampled clean-B port, the coherent carrier
  self-propelled from `12.328L` to `6.138L`, but a persistently positive
  body-frame target bearing accompanied increasing heading (`0.506` to
  `1.383 rad`), distance regression to `10.460L`, and lower-boundary exit at
  `26.147T`; local crossflow was small at closest approach. Preserve the
  carrier, but sign-calibrate bounded curvature against measured yaw response
  before tuning steering magnitudes. This lesson applies to cross-dimensional
  controller ports with the same normalized observations; falsify it if a
  future correct-sign initial yaw response retains the same route loss, which
  would implicate authority, braking, or propulsion rather than polarity.
- After polarity is calibrated, do not treat improved closest distance as
  evidence of controlled pursuit when the trajectory remains a high lateral
  pass. On the preserved `28 degree`, `0.55T` carrier, one-joint yaw-recoil
  compensation reached `5.658L` before an upper exit, while two-joint
  recoil/slip feedback and direct course response reached `4.158L` and
  `4.358L` yet crossed the target abscissa about `4.2--4.5L` above capture and
  continued to the left boundary. These posterior-equilibrium steering
  variants improved forward travel without controlling cross-track course.
  The inherited half-cycle result does not reject asymmetric steering because
  it simultaneously weakened the carrier to `20 degree`, `0.70T`, advanced
  only to `12.195L`, and exited upward. In this still-water/no-cylinder regime,
  later steering-actuator tests should preserve the strong carrier and require
  both a lower cross-track pass and intact wake coherence; falsify this lesson
  if a posterior mean-curvature controller reaches capture or shows materially
  lower cross-track error without sacrificing propulsion.
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
