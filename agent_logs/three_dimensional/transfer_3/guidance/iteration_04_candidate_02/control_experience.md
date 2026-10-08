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
- In the direct-uniform still-water transfer, a coherent alternating wake and
  useful early propulsion reduced distance from 12.328 L to 4.780 L, but the
  controller failed to redirect after closure collapsed and exited the lower
  boundary at 27.49 T. Its short-window bearing/turn rates oscillated at the
  tail-beat scale (about +/-3 rad/T), while about 71%/78% of joint commands
  reached the acceleration envelope. Two attempts to replace this behavior
  with a slower route signal were concrete negative results: a
  velocity-to-target course-error C-bend exited the upper boundary at 8.98 T
  after reaching only 11.865 L despite eliminating joint-rate saturation, and
  a joint-phase-demodulated target angle exited there at 8.48 T after reaching
  only 12.120 L. Do not infer a useful course merely from lower command effort
  or an offline replay on a parent trajectory, and do not let velocity-course
  feedback dominate at release or low speed. Reconsider these signals only
  with coupled-rollout evidence that preserves the early distance reduction;
  externally advected flow remains outside this result's scope.
- Damped actuator reallocation, rather than more curvature superposed on the
  carrier, resolves the evidenced fast terminal miss in direct-uniform still
  water. The geometry-gated large-error redirect first improved closest
  approach from 4.780 L to 1.135 L, but its posterior joint hit the 45-degree
  stop and terminal force/yaw-moment coefficient magnitudes reached about
  0.252/0.119. Replacing most of the oscillatory carrier inside 4 L with
  tracking of a shared two-joint curvature equilibrium preserved the coherent
  far approach and captured at 25.26 T; inside 4 L its acceleration-cap
  incidence was only 0.20%/0%, neither joint approached the angle stop, and
  force/moment maxima fell to 0.0159/0.00834. Two nearby alternatives sharpen
  the mechanism boundary: shrinking carrier amplitude while boosting the
  existing curvature still missed at 1.108 L and restored large loads
  (0.269/0.128), while closing-gated cadence relief plus joint damping captured
  only after a large loop at 51.65 T. Thus, for a fast misaligned approach,
  reserve joint excursion by continuously blending the gait into a damped
  curvature equilibrium with a small carrier floor; do not substitute scalar
  curvature amplification or cadence relief alone. This result applies after
  target-directed propulsion is established and remains untested under imposed
  wakes; falsify or revise it if far-field approach changes, the swimmer stalls,
  or capture, low saturation, and low terminal loads do not survive changed
  poses, flow disturbances, or a recession-release branch.
- Once terminal curvature reallocation produces the direct `25.26T` capture,
  extra branches must show activation or a distinct physical benefit rather
  than merely preserve success. A closing-speed release was exactly inactive
  over all `1026` recorded samples inside `4L` and therefore reproduced the
  parent trajectory and score. Two speed-qualified body-frame velocity-course
  residuals did activate, but yielded visually indistinguishable captures at
  `25.22T` and `25.27T` with slightly worse mean distances (`2.43200L` and
  `2.43271L` versus `2.43180L`) and scores; one reduced final course error by
  about `4.6 deg` without a net objective improvement. In a steadily closing,
  direct-uniform approach, retain recession release only as an explicitly
  unvalidated recovery guard and do not stack velocity-course correction onto
  the held curvature merely to improve alignment. Reconsider it only when a
  changed pose or disturbance actually creates recession or a course-error
  failure; if nominal terminal response still needs refinement, test the
  geometry-requested versus measured yaw response after carrier suppression
  and require better distance, trajectory, saturation, or load evidence than
  the shared-curvature baseline.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
