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
- The geometry-gated redirect's `1.135L` fast miss was a joint-allocation
  failure, not evidence for more curvature: its tail dwelled at the `45 deg`
  stop and force/yaw-moment coefficient magnitudes reached about
  `0.264/0.119`. Replacing the carrier inside `4L` with damped tracking of a
  shared two-joint curvature equilibrium converted that topology into capture
  near `25.26T` (`-0.530646` in two inherited results), while the sampled
  closure preview advanced capture to `25.113T`, improved mean distance to
  `2.430636L`, and removed acceleration-cap samples inside `4L`. When
  propulsion and turning compete for joint excursion on a fast misaligned
  approach, allocate the bend by replacing rather than adding to the carrier,
  and schedule the replacement from bounded target geometry and positive
  closure. This applies only after the outer target-directed wake is
  established; reject it if pre-`4L` progress changes, approach stalls, or
  terminal stop dwell/load spikes return.
- Evaluate response-conditioned terminal changes as a coordinated allocation
  unit, not as independently additive gates. The response-released paired
  handoff is policy-byte-identical across three sampled artifacts and repeats
  score `-0.52833877`, mean distance `2.429294L`, final crossing `0.746410L`,
  and capture at `25.1185T`. The distinct departure-phase allocator captures
  one integration step earlier and slightly lowers inside-`4L` force/moment
  maxima to about `0.01426/0.00757`, but is marginally weaker at
  `-0.52837563`, mean distance `2.429298L`, and final crossing `0.746517L`.
  Inherited results also show that anterior-hold/posterior-only release
  regressed to `-0.530288`, while stacking phase selection with coordinated
  release regressed to `-0.530990`; useful response signals therefore do not
  compose monotonically. Preserve the established outer carrier, closure
  preview, shared curvature equilibrium, and paired handoff. If another
  terminal mechanism is tested, isolate an independently measurable body or
  target response rather than another joint-phase/scalar gate, and require a
  materially different trajectory, load, or repeatability benefit. This
  boundary applies only to the compact closure-previewed capture topology and
  is falsified by repeated coupled rollouts under a different approach state
  showing that joint-role splitting or response-signal composition helps
  without saturation, load growth, or a low-drive loop.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
