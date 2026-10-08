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

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
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
- Cross-candidate evidence upgrades terminal carrier reallocation from a
  hypothesis to a still-water capture mechanism. The transferred seed formed
  a coherent wake but exited after reaching `4.780L`, and geometry-gated mean
  curvature improved that topology to a fast `1.135L` miss with posterior
  angle/load saturation. In all four sampled direct-uniform children, blending
  most of the carrier into a damped two-joint curvature equilibrium inside
  `4L` preserves the coherent top-down and oblique far wake and captures at
  `25.223--25.267T` with scores `-0.53065` to `-0.53177`. After reallocation is
  full below `2.4L`, neither command reaches its acceleration cap; sampled
  joint-angle magnitudes stay below about `0.141/0.297` rad and force/moment
  coefficient magnitudes below `0.00282/0.00087`. Preserve this separation of
  far posterior-lag propulsion from near damped hold; do not replace it with
  more curvature stacked on the carrier or an unqualified velocity-course
  bend. Two course-curvature variants also capture but do not beat the plain
  reallocation score (one arrives only `0.0385T` earlier while scoring
  `0.000389` lower, and the other is slightly slower and lowest-scoring).
  Course or closing signals remain plausible only as bounded allocation/release
  qualifiers after target-directed motion is established, not as release-time
  steering. This result is limited to direct-uniform still water: falsify it if
  changed poses or imposed wakes alter the far approach, if terminal release
  permits recession or a miss, or if low saturation/load and capture do not
  survive. The inherited optimizer log's earlier `-1.1974` capture also warns
  that a capture label alone cannot rank controllers without trajectory, load,
  and distance-integral evidence.
- Within the terminal-reallocation family, bounded closure preview is now an
  evidence-backed transition refinement, while closure-only release is a
  recovery safeguard rather than a nominal-performance mechanism. Previewing
  normalized range by `0.75` of one declared control period during positive
  closure improved the distance-only parent's capture from `25.2615T` to
  `25.1130T` and score from `-0.530646` to `-0.530060`, shortened the recorded
  center path from about `13.7781L` to `13.7105L`, and reduced inside-`4L` head
  command-cap incidence from about `1.17%` to zero without changing the
  coherent outer wake; terminal force and yaw-moment peaks also fell slightly.
  In contrast, a closure-support release without preview was fully supported
  along the strongly closing nominal trajectory and reproduced the parent
  exactly. Use closure only to schedule entry to or release from a
  target-geometry-owned two-joint equilibrium, never to choose steering sign.
  Keep the preview shorter than a state-feedback period and restore the
  posterior-lag carrier at nonpositive closure. This result applies to the
  sampled direct-uniform, monotone-closing approach; falsify it if another pose
  or wake makes preview trigger a premature low-drive turn, if recession does
  not restore propulsion, or if the capture, low clipping, and load advantage
  fail to reproduce.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
