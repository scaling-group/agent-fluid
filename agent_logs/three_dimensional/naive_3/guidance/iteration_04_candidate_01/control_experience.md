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
  `12.291L`. Curvature authority is therefore not a monotonic gain knob. When
  the restrained topology makes sustained progress but target bearing grows to
  roughly `1 rad` while the fish keeps crossing the route, test body-frame
  misalignment-gated posterior propulsion or state-phased asymmetry before
  increasing static bend. This implication applies when the wake remains
  coherent and the miss is a powered cross-track overshoot; lost propulsion,
  a wrong-sign first turn, or persistent actuator-limit residence instead
  falsifies the carrier/curvature combination and calls for repairing it first.
- On the alignment-gated `7 deg` carrier, three semantic additions preserved
  the same lower-exit miss instead of improving its `2.443L` minimum: full
  behind-target direction reached `2.494L`, distance-conditioned carrier
  relief reached `2.845L`, and return-half-cycle braking reached `2.501L`;
  toward-half-cycle boosting was worse at `3.587L`. Do not stack more approach
  scheduling or state-phased asymmetry onto this topology before auditing the
  yaw-response sign. The head points along body `-x`, so positive bearing calls
  for negative `theta` rate, yet at closest approach all five rollouts had
  positive bearing (`0.947--1.421` rad) and positive heading rate
  (`0.562--2.322` rad/T). A term that subtracts heading rate from bearing
  therefore releases curvature during the observed wrong-way yaw. The next
  reusable test is coordinate-correct rate damping that releases the bend only
  when yaw reduces body-frame error while leaving the proven curvature ceiling
  and carrier unchanged. This implication applies under the current body-axis
  and yaw conventions; reverse it if a controlled response shows positive bend
  produces the opposite yaw sign, and reject it if yaw excursions, early wake
  coherence, or target progress worsen.
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
