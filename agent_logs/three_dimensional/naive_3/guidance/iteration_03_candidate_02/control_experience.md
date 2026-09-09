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
- The common naive oscillator/posterior-lag carrier is self-propelling but not
  navigational: its coherent 3D wake carried it about `1.52L` before an upper
  exit at `8.602T`, with only `0.258L` closest-approach improvement. Across the
  first steering samples, target-relative curvature was useful only when it
  preserved that carrier. A restrained `7 deg` mean-curvature reflex retained
  a long alternating wake, survived to `24.893T`, and reduced distance from
  `12.328L` to `4.067L`; `10 deg` and `14 deg` variants coupled to altered or
  strongly biased carriers instead made tight turns with minima no better than
  `12.291L`. Curvature authority is therefore not a monotonic gain knob.
  Body-frame misalignment gating of only the posterior wave was a real but
  incomplete semantic improvement: it preserved the coherent wake, extended
  survival to `31.097T`, and improved closest approach to `2.443L`, yet at
  `15--18T` bearing grew from about `0.80` to `1.47 rad` while forward speed
  remained about `0.66--0.77 U`, followed by the same lower-boundary overshoot.
  The gated policy also clamped its anterior command about `75%` of the
  rollout; a separate toward-bend half-cycle booster clamped both commands
  about `75%` and reached only `3.587L`. For this coherent powered-overshoot
  topology, preserve posterior gating but avoid more static curvature or
  extra acceleration on the already saturated half-cycle; test a phase-shaped
  release or brake that reduces saturated return motion and must improve yaw
  response without increasing clamp/rate residence. Lost propulsion, a
  wrong-sign first turn, tight-turn topology, or unchanged residence falsifies
  that implication and calls for repairing the carrier first.
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
