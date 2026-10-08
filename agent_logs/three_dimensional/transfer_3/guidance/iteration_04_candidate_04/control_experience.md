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
- A geometry-gated large-error redirect first improved closest approach from
  4.780 L to 1.135 L but missed while its tail dwelled at the 45-degree stop
  and force/yaw-moment coefficient magnitudes reached about 0.264/0.119.
  Replacing the carrier inside 4 L with damped tracking of a shared two-joint
  curvature equilibrium then converted that topology into capture at 25.26 T
  with score -0.53065 and mean distance 2.4318 L. Inside 4 L its acceleration-
  envelope incidence fell to about 0.2%/0%, joint-stop dwell disappeared, and
  force/moment maxima fell to about 0.0159/0.00834. When propulsion and turning
  share excursion on a fast misaligned approach, preserve the outer
  target-angle redirect but allocate the terminal bend by replacing rather
  than adding to the oscillatory carrier. This implication is falsified if an
  aligned or slowly closing approach stalls, the outer wake changes, or
  terminal saturation/load spikes return.
- Once that fast capture was established, two speed-qualified terminal
  velocity-course residuals were concrete non-improvements: both retained
  capture, but scores regressed to -0.53103 and -0.53177 and mean distance rose
  to 2.4320 L and 2.4327 L despite one crossing 0.0385 T earlier. A separate
  recession-release gate exactly reproduced the -0.53065 parent because every
  inside-4 L sample exceeded its full-support closing threshold; it therefore
  proves nominal noninterference, not recovery. Do not layer velocity-course
  steering onto the validated terminal equilibrium merely to advance the
  final crossing, and do not claim robustness from a dormant response gate.
  Test transition scheduling with independently activated closure loss or a
  bounded range preview, and reject it if the outer trajectory changes, the
  compact capture degrades, or transition clipping and loads do not fall.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
