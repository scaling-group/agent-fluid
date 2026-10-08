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
- The geometry-gated redirect's `1.135L` fast miss was an actuator-allocation
  failure, not evidence for more curvature: its tail dwelled at the `45 deg`
  stop and force/yaw-moment coefficient magnitudes reached about
  `0.264/0.119`. Replacing the carrier inside `4L` with damped tracking of a
  shared two-joint curvature equilibrium converted that topology into capture
  at `25.2615T` with mean distance `2.431797L`; inside-band acceleration-cap
  incidence fell to about `0.292%/0%`, joint-stop dwell disappeared, and
  force/moment maxima fell to about `0.01593/0.00834`. When propulsion and
  turning share excursion on a fast misaligned approach, allocate the bend by
  replacing rather than adding to the oscillatory carrier. This applies only
  after the outer target-directed wake is established and is falsified if the
  outer trajectory changes, approach stalls, or terminal saturation/load
  spikes return.
- Transition scheduling can improve that equilibrium, but course-based release
  is not supported. A bounded positive-closure range preview preserved the
  outer wake, advanced capture by `0.1485T`, improved mean distance to
  `2.430636L` and score from `-0.530646` to `-0.530060`, eliminated the last
  inside-`4L` command-cap samples, and slightly reduced terminal force/moment
  maxima to about `0.01547/0.00800`. In contrast, a recession-release gate was
  dormant and reproduced its parent exactly, two velocity-course steering
  residuals regressed score, and restoring carrier inside a predicted
  intercept corridor retained capture but regressed score to `-0.531485` and
  mean distance to `2.432459L`. Prefer response-conditioned preview or
  joint-state allocation over direct course steering/restoration; reject any
  extension that changes the pre-transition carrier, produces the inherited
  `51.645T` low-drive orbit, or loses the compact capture and low terminal
  loads.
- Response-conditioned terminal mechanisms must be evaluated as an allocation
  unit, because individually useful signals did not compose monotonically.
  Coordinated two-joint release after normalized curvature-tracking error
  settled was reproduced exactly in two evaluations and improved the
  closure-preview baseline from score `-0.530060`, mean distance `2.430636L`,
  and final distance `0.748252L` to `-0.528339`, `2.429294L`, and `0.746410L`.
  Holding the anterior joint on curvature while releasing only the posterior
  regressed to `-0.530288`, and stacking the separately positive
  departure-half-cycle boost with the coordinated release regressed further to
  `-0.530990` and mean distance `2.431337L`. Preserve the paired traveling-wave
  handoff as the supported response mechanism; do not assume that tail-only
  recovery or two positive terminal gates will add. Two later ways of retaining
  extra curvature after that handoff also converged on the same negative
  outcome: closing the bend on a body-yaw-rate residual scored `-0.529278` with
  mean/final distances `2.430028L/0.747435L`, while vetoing carrier release when
  settled joint error began growing scored `-0.529296` with
  `2.430036L/0.747430L`. Both retained compact capture and finite loads but made
  the first crossing shallower than the paired-release parent's `0.746410L`.
  Once both curvature targets have settled, do not add phase, joint-role, or
  body-rate logic that restores hold merely because it appears more responsive;
  if extending this topology, test a disjoint normalized body-response signal
  that releases both joints further into the mean-centered carrier. This lesson
  applies to the established closure-previewed compact-capture approach and is
  falsified by repeated coupled rollouts under a meaningfully different
  approach state showing that added hold improves capture or mean distance
  without saturation, load growth, wake loss, or a low-drive loop.
- Treat exact replication under a renamed descendant as evidence of no new
  mechanism, not as independent progress. Four sampled direct-uniform rollouts
  have identical actions and trajectories through capture at `25.11852T`
  (score `-0.528339`, mean/final distance `2.429294L/0.746410L`); three use the
  v23 coordinated two-joint response release, while the sampled v25 source
  differs from it only in comments and its version label. Preserve the proven
  paired handoff, but do not spend another iteration on metadata, commentary,
  or a branch that cannot activate on the measured path. The next mechanism
  must expose a separately measurable normalized response gate and state how it
  changes allocation. On this topology, body-relative lateral flow is a
  plausible disjoint test axis because it has the target-helpful sign in about
  95% of inside-`4L` samples (mean about `-0.232U`) while curvature tracking is
  settled for roughly 65% and terminal commands decay to about
  `0.09/0.24 rad/T^2`; this is a hypothesis to test, not evidence of benefit.
  Falsify it if the gate is dormant, alters the pre-terminal carrier, weakens
  compact capture or distance integral, or restores saturation, joint-stop
  dwell, wake loss, or terminal load growth.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
