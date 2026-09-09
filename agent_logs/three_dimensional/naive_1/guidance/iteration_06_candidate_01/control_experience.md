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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- The sampled L64 direct-still-water seed rollout establishes that a coherent
  alternating 3D wake is not evidence of route control: the target-blind
  oscillator self-propelled about `0.95L` left and briefly reduced distance by
  `0.264L`, yet accumulated `1.20L` upward drift, swept heading across about
  `1.77 rad`, and exited the upper boundary at `8.61T`. Preserve its traveling
  bend and posterior lag when testing steering, but add a bounded body-frame
  target-to-curvature mechanism before wake compensation or scalar-only drive
  tuning. This implication is falsified if such feedback collapses the coherent
  wake, increases sustained actuator saturation, or retains the same
  upper-boundary trajectory topology.
- The target-to-curvature rollouts show that joint allocation and observation
  timescale are control mechanisms, not interchangeable bias gains. Equal
  head/tail bias suppressed the traveling gait and exited right at `15.36L`;
  posterior-only bias preserved its coherent wake but reversed too late and
  exited high at `11.10L`; shared bias with slip reached `8.17L` before a broad
  lower exit. Adding bearing/yaw response gating to the posterior channel then
  repeated the early upper exit at `11.79L`. An opposite-sign head/tail
  turn-rate servo produced the strongest route evidence (`4.98L` minimum,
  `33.21T` survival), but swam almost horizontally past the target near
  `y=14L`; its roughly `0.04T` recent-rate window was far shorter than the
  `0.55T` carrier, and beat-scale feedback coincided with joint-rate contact on
  `16.8%/19.1%` and over-limit raw acceleration on `70.5%/77.6%` of samples.
  Preserve the differential allocation, but do not let a beat-scale
  yaw/bearing-rate error reverse route sign while the target stays on one side.
- Completed redirect rollouts sharpen that rule. A full signed-line-of-sight,
  geometry-held differential bend preserved the coherent wake and reached
  `1.093L` at `19.06T`, but failed to release through the terminal crossing,
  passed below the target, and exited the lower boundary. In contrast, four
  evaluations of the same executable bounded-lateral/one-sided-yaw-release
  equations all preserved the traveling wake and captured at `0.748--0.750L`
  in `19.23--19.78T`; their score spread (`-0.2433` to `-0.2299`) is repeat
  variability, not a gain comparison between comment-only variants. Therefore
  persistent body-frame target side should own steering sign, while correcting
  response may reduce but not invert the bend. Retain the lateral mapping and
  release gate as one evidenced package because their contributions remain
  causally entangled. The four captures still contacted joint-rate limits on
  `10.6--10.8%/14.0--14.4%` and requested over-envelope acceleration on
  `61.7--62.2%/71.7--72.3%` of rows across far, middle, and near regimes. Test
  changes against that burden without treating contact reduction as the
  objective. The capture package itself is falsified if it loses repeat or
  held-out capture, destroys wake coherence, or returns to the lower-exit or
  high-pass topology.
- Two post-capture actuator ablations establish a concrete negative boundary.
  Per-joint rate barriers beginning at `0.80` and `0.85` of the normalized
  `260 deg/T` envelope, each with full braking authority and returned-action
  clipping, reduced or eliminated rate-limit residence and slightly lowered
  load RMS, yet both destroyed the target-directed bend: they reached only
  `5.339L` and `5.028L`, then exited the upper boundary with scores `-7.587`
  and `-7.615`, versus four unshaped captures near `19.2--19.8T`. Their
  top-down streets and caudal Lambda2 structures remained coherent, proving
  that a clean wake and lower saturation can coexist with semantic route
  failure. Avoid pointwise joint-rate guards, independent action compression,
  or acceleration caps as generic efficiency fixes for this carrier; they
  perturb the head-tail phase/steering response on most beats. This boundary
  does not rule out a mechanism that leaves the successful acceleration path
  intact and changes only target-signed phase allocation, but such a mechanism
  must first retain capture and route topology before load reductions count.
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
