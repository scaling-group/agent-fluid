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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- In the direct-uniform transferred-seed rollout, a coherent alternating wake
  and strong finite progress did not imply viable target steering: distance
  fell from `12.33L` to `4.78L` by `17.85T`, but positive body-frame bearing
  then opened beyond `1.2 rad` while positive posterior mean bend and heading
  grew together; the fish continued downward to `y=0.80L` and exited with
  final distance `9.71L`.  Treat this topology as a curvature sign/distribution
  problem rather than weak propulsion or external advection when local flow is
  only about `0.02U` versus body speed near `0.8U`.  A reusable next test is a
  reflection-equivariant target-to-mean-curvature map shared across both joints
  with bounded slip/yaw release; falsify it if bearing still fails to contract
  before the prior closest-approach point or if the coherent propulsive wake
  collapses.
- Redirect-release semantics, rather than more carrier or curvature magnitude,
  produced the first robust capture in the sampled lineage. Three identical
  direct-uniform evaluations sustained the bounded target-signed bend until
  body-frame angular error contracted, retained the alternating top-down and
  oblique three-dimensional wake, and reproduced capture at `26.411 T` and
  `0.7496 L` with mean/max speed `0.501/0.667 L/T`. A speed-envelope projection
  on the same controller reduced joint-speed-bound occupancy from about
  `11.4%` to `1.7%`, but delayed capture to `26.813 T`, raised mean distance
  from `2.6134 L` to `2.6382 L`, and worsened score from `-0.7105` to
  `-0.7343`. For coherent large-angle near misses, require macroscopic
  body-frame error contraction before yaw-based burst release and do not treat
  saturation reduction alone as progress; retest feasibility shaping only if
  it improves route/load behavior without delaying capture. Falsify this
  lesson if a held-out pose loses capture or wake coherence under geometric
  release, or if a smoother command boundary improves both capture timing and
  the load envelope rather than merely lowering joint-speed occupancy.
