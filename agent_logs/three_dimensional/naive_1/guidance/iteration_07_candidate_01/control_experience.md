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
  passed below the target, and exited the lower boundary. A bounded lateral
  direction cosine with recent yaw used only as a one-sided release gate kept
  the same traveling-wake scaffold and captured at `0.748L` and `19.23T`.
  Therefore persistent body-frame target side should own steering sign, while
  correcting response may reduce but not invert the bend. Retain the lateral
  mapping and release gate as one evidenced package: both changed between
  these rollouts, so neither contribution is causally isolated. The capture
  still contacted joint-rate limits on about `10.8%/14.3%` and requested
  over-envelope acceleration on `61.9%/72.0%` of rows; test command relief as
  a separate ablation after preserving capture. This lesson is falsified if
  the package loses capture on repeat or held-out target geometry, destroys
  wake coherence, or worsens boundary topology, actuator contact, or loads.
- Completed step-6 ablations separate terminal feedback from command-interface
  ownership. A raw body-lateral-velocity lead inside `2.5L` still captured at
  `19.129T` with mean scored distance `2.1245L`, but that lies inside the
  unmodified controller's sampled `19.228--19.321T` and `2.1185--2.1279L`
  repeat band. Its favorable terminal line-of-sight transverse speed is not
  causal evidence: a hard-projection baseline independently produced nearly
  the same value (`0.249U` versus `0.251U` inside `1.5L`). Do not promote raw
  body-lateral lead or a tied scalar score as an improvement; a later course
  mechanism must outperform repeat variability and should define motion
  relative to the target line. By contrast, hard-projecting only the completed
  public accelerations at `1800 deg/T^2` retained capture (`0.7464L` at
  `19.135T`) and the coherent route while eliminating raw over-envelope
  returns, but left rate contact essentially unchanged (`10.81%/14.46%`). Use
  that projection for interface ownership, not as evidence of actuator relief.
  The inherited `80%/85%` outward-rate tapers remain a negative boundary: both
  preserved coherent wakes yet lost capture and exited high after only
  `5.34L/5.03L` closest approaches. Reconsider rate-aware shaping only after it
  independently preserves carrier phase, target turn, and capture; falsify the
  hard-projection lesson if its integrated trajectory differs from the
  episode's identical clamp for the same finite states.
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
