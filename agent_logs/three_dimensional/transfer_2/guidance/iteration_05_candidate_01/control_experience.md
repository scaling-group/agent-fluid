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
- Steering release is only a partial correction in direct-uniform still water,
  while phase-selective carrier allocation is the first sampled mechanism to
  produce a meaningfully different useful trajectory.  Relative to the seed,
  yaw-response release changed minimum/final distance only from
  `4.780/9.709L` to `4.660/9.604L` and retained the lower exit; geometry-gated
  wrong-polarity curvature release then reached `4.141L` at `20.67T` and
  survived to `32.20T`, but still exited below with raw acceleration above the
  envelope on `98.1%` of steps.  Adding bounded posterior half-cycle relief
  preserved the visibly coherent alternating wake, improved closest approach
  to `3.033L` at `23.24T`, extended survival to `40.33T`, reduced raw envelope
  exposure to `93.6%`, and changed termination to the left boundary.  That is
  a positive mechanism result, not a capture result: at closest approach the
  head remained about `2.65L` below the target, body-frame bearing was about
  `+1.35 rad`, and forward body speed remained about `0.63L/T`, so the fish
  propelled past the target corridor before the redirect accumulated.  Keep
  the `0.55T/28 deg` carrier and phase-selective allocation, but do not repeat
  another response-release threshold or global gait softening: the evaluator's
  roughly `0.0385T` history is subcycle, and a `0.80T/22 deg` soft-limited gait
  eliminated raw acceleration exceedance yet reached only `8.752L` before an
  upper exit.  The open test is steering priority inside the actuator budget,
  judged by target approach and termination rather than zero raw exceedance.
  This lesson applies while carrier clipping and the short-history observation
  contract persist; it is falsified if actuator-priority allocation destroys
  the alternating wake or cannot improve the `3.033L` left-exit reference, or
  if a genuinely cycle-scale response signal becomes available and changes
  route topology without losing the deep approach.
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
