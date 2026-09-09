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
  these rollouts, so neither contribution is causally isolated. Repeated
  captures then show that hard-projecting only the completed policy outputs at
  `1800 deg/T^2` removes the public over-envelope requests (previously about
  `61.7%/72.1%` of rows) without moving arrival or mean distance outside the
  captured repeat band. It leaves joint-rate contact essentially unchanged at
  about `10.8%/14.4%`, so retain hard projection as interface ownership, not as
  evidence of actuator or energy relief. This lesson is falsified if the
  package loses capture on repeat or held-out target geometry, destroys wake
  coherence, or worsens boundary topology, actuator contact, or loads.
- Terminal velocity feedback is not interchangeable across coordinate frames.
  A raw body-lateral-velocity lead preserved capture at `19.13--19.14T`, but
  its mean distance `2.124--2.128L` did not improve on the `2.119L` baseline.
  Replacing it with target-line transverse-course velocity kept a coherent
  wake yet missed at `0.949L`, passed onto the high-side route, and exited at
  `32.07T` with final distance `8.79L`. Do not add a geometrically richer
  terminal residual merely because it is bounded and sign-preserving; require
  repeat improvement beyond the capture band, and distrust wake coherence as
  evidence that terminal steering is correct. This boundary is falsified if a
  separately isolated course residual repeats capture while improving terminal
  cross-track motion, loads, or arrival beyond baseline variability.
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
