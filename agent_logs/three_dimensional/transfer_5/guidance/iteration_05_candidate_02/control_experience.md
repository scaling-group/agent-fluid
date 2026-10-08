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
- The first two generations separate carrier, redirect, response release, and
  command feasibility. The transferred carrier formed a coherent wake but
  missed below after reaching `4.780L`; opposite-sign static posture turns
  produced weak-wake upper exits, one with `78.0%` posterior angle-limit
  exposure. Preserving the carrier while shifting its centers into the sampled
  same-sign, body-frame-error-gated C-bend captured at `25.388T` (mean distance
  `2.557L`). Response-triggered bend release and a fourth-order final-command
  projection then improved that topology independently. Their evaluated
  composition retains the alternating top-down/oblique wake, advances arrival
  from the best isolated result's `23.997T` to `23.8755T`, and changes mean
  scoring distance from `2.438L` to `2.4357L`, with peak lateral load/yaw moment
  near `0.0240/0.0141` and commands below `1798 deg/T^2`. The interaction is not
  uniformly additive: posterior `>=95%` speed-limit exposure rises from about
  `4.5%` to `9.38%` and peak yaw from `2.922` to `2.949 rad/T`. Preserve the
  successful bend polarity and carrier, but judge compatible refinements jointly
  on capture, directness, kinematics, and loads; bounded acceleration alone does
  not establish a physically cleaner controller. This boundary is limited to
  the present sign conventions and sampled still-water pose.
- Terminal excess-yaw amplitude relief is a weak positive scalar result, not a
  demonstrated solution to late approach error. Against the composed controller
  it improves score by only `0.000300` and mean scoring distance by `0.000225L`,
  arrives one integration step later (`23.8810T` versus `23.8755T`), and leaves
  peak yaw and posterior speed-limit exposure effectively unchanged (`2.9486
  rad/T` and `9.35%`). Meanwhile, its sampled trajectory's mean absolute
  velocity-to-line-of-sight angle rises from `0.316 rad` inside `3L` to `0.481
  rad` inside `1L`, and mean target-transverse speed rises from `0.246` to
  `0.343 U` despite positive radial closing. Thus do not continue scalar-only
  amplitude-relief tuning to address this residual; test a small, bounded
  target-relative course correction while retaining propulsion. Falsify that
  implication if course correction fails to improve capture/directness or
  worsens wake coherence, speed-limit exposure, yaw, commands, or loads. Four
  sampled v21 files differed only in comments/version yet produced the exact
  same 4341-step trajectory, so executable-equivalent candidates count as one
  result and call for a real feedback-path change.
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
