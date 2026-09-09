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
- The common naive oscillator/posterior-lag carrier is already self-propelling
  in direct-uniform still water, but that does not establish useful navigation:
  the sampled seed traveled about `1.52L` with a coherent 3D wake yet improved
  target distance by only `0.258L`, accumulated `1.252 rad` heading error, and
  exited the upper boundary at `8.602T`. When this zero-steering topology
  recurs, test bounded body-frame target-error-to-mean-curvature feedback while
  preserving the lagged carrier before changing scalar drive gains. This
  implication applies only when the wake and displacement confirm propulsion;
  a wrong-sign turn, lost wake coherence, or worse actuator-limit residence
  falsifies the curvature sign or joint split and should be corrected before
  adding flow or force compensation.
- Across the completed steering variants, mean-curvature authority is not a
  scalar improvement axis. A `14 deg` split static bend suppressed the useful
  traveling wake and reached only `12.291L`, while a restrained `7 deg` bend
  preserved a long alternating 3D wake and reached `4.067L`. Half-cycle
  authority reached `3.587L`; smoothly gating the posterior wave on body-frame
  misalignment reduced closest-approach speed to about `0.685U`, reached
  `2.443L`, and extended survival to `31.097T`. Preserve that restrained
  carrier when broad target-directed propulsion is already established; early
  wake loss, a short tight curl, or worse actuator-limit residence falsifies a
  steering translation before any terminal-distance comparison is meaningful.
- Three subsequent single-mechanism variants did not change the powered
  cross-below topology: a distance-only approach envelope regressed to
  `2.845L`, full target-direction gating reached `2.494L`, and away-half-cycle
  braking reached `2.501L`; all receded and exited the lower boundary near
  `29--31T`. Full direction remains the correct ahead/behind representation,
  but representation or drive relief alone is not a redirect. In the `2.443L`
  parent, target-versus-course error is still about `1.21 rad` at closest
  approach while anterior acceleration is clamped for roughly `75%` of the
  trace. When this coherent-wake near miss recurs, avoid another scalar braking
  schedule or higher command ceiling; test whether a bounded body-frame
  target-versus-velocity-course reflex can sustain pre-pass mean curvature
  without increasing the `7 deg` envelope. This implication applies only once
  translation makes course observable, and is falsified by degraded far-field
  progress, tailbeat-scale steering reversals, a tight curl, unchanged lower
  exit, or worse actuator-limit residence.
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
