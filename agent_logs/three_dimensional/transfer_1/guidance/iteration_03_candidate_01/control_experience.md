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
- A coherent wake plus opening target bearing diagnoses steering rather than
  weak propulsion, but always-active whole-wave curvature is not a safe remedy:
  the shared-curvature rollout curled almost from release, improved only from
  `12.33L` to `12.28L`, and exited at `7.71T`. Preserve the posterior-lag
  carrier and apply large mean curvature only through target-signed,
  body-frame gating. Falsify this boundary only if a distributed bend retains
  the inherited early closure and alternating three-dimensional wake instead
  of reproducing the immediate curl.
- Redirect release is a geometric-completion decision, not merely a detected
  yaw response or a drive-relief decision. The response-gated policy reached
  `2.46L` but crossed with the target abeam at `(0.01,-2.46)L`; the assigned
  parent's range/alignment cadence hold and the sampled amplitude/cadence
  relief improved the miss to `1.39L` and `1.23L` yet both still exited.
  Holding the same target-signed redirect until body-frame angular error
  contracted instead captured at `26.41T`, with terminal target
  `(-0.749,-0.026)L`, while retaining a visible three-dimensional wake.
  Therefore preserve completion-latched curvature before tuning terminal
  propulsion; falsify it if a held-out pose captures with response-only
  release or if latching causes a persistent circle rather than contracting
  target angle.
- Completion latching reduced, but did not remove, infeasible raw effort: at
  least one joint exceeded the acceleration envelope in `82.5%` of the
  successful trace rows, versus `95.7%` for the abeam response-gated miss.
  More additive steering is therefore poorly identified under independent
  clipping. A reusable next mechanism is coordinated two-joint allocation that
  preserves the requested anterior/posterior ratio inside a shared bounded
  scale. Treat it as falsified if capture, early closure, or the traveling wake
  disappears; lower raw clipping alone is not an improvement.
