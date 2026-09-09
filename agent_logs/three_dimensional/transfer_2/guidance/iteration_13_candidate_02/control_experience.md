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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Calibrate the complete two-joint steering map in 3D, then retain fore/aft
  target sense in route feedback. The inherited 2D-sign controller formed a
  coherent self-propelled wake but reached only `6.18L` before reversing
  progress and exiting the lower boundary. The compact controller with
  opposing anterior/posterior steering signs instead exited high after a
  `5.36L` closest approach. Aligning both steering contributions preserved the
  wake and the smooth `31 rad/T^2` command bound, changed the trajectory to a
  left exit, and improved closest approach to `2.58L`; however, it passed above
  the target and diverged to `8.74L` after `target_body_L[1]` changed from
  negative (ahead) to positive (astern). The supplied scalar bearing uses the
  absolute longitudinal target component and therefore aliases those states.
  Preserve the aligned mean-bend actuator, but use the full normalized
  body-frame target vector when testing re-acquisition; avoid scalar-only
  bearing/rate gain tuning after a pass. Reject this implication if fore/aft-
  aware feedback does not produce a return turn or re-approach, or if it
  destroys the coherent wake or raises joint/command-limit residence.
- Treat the distance/closing allocator as a supported steering-headroom
  mechanism, but not as a complete capture controller. Relative to the aligned
  mean-bend parent's `2.58L` pass and straight left exit near `29.5T`, reducing
  the joint-state carrier while closing inside `6L` and reallocating it to
  curvature improved closest approach to `1.73L`, prolonged the stable rollout
  to `52.5T`, replaced the left escape with a return loop, and cut residence
  above 90% of the `31 rad/T^2` smooth command bound from roughly `52--55%` to
  `21--23%`. This is evidence that approach allocation can expose usable turn
  authority when the carrier is saturated. Its applicability ends when the
  fish retains about `0.76U` speed and only a `6--8 deg` steady two-joint bend:
  the target had already moved astern at the `1.73L` minimum and remained far
  off-nose through a roughly `6L` loop. Preserve the allocator, but test an
  observation-gated redirect with materially stronger bounded curvature rather
  than another scalar route gain; reject it if the first-pass/loop radius does
  not shrink or if wake coherence and actuator-limit residence regress.
- Treat the approach-gated target-to-velocity-course redirect as the supported
  semantic completion of that allocator. Four direct-uniform still-water
  samples combining it with bounded head/posterior curvature all captured in
  `19.706--20.207T`; the inherited full-angle half-cycle controller instead
  kept a coherent two-row wake but missed at `2.127L`, curled away, and exited
  with `11.643L` remaining. The capture family reduced mean absolute commands
  from roughly `(24.1,23.4)` to `17--19 rad/T^2`, cut near-command-bound
  residence from about `52%` to `32--37%`, and eliminated near-joint-angle-
  limit residence while retaining the same approximate `0.025/0.013` peak
  planar-force/yaw-moment class. Preserve full signed body-frame target
  geometry, closing-conditioned drive headroom, and the course redirect before
  optimizing arrival; coherent wake strength or more scalar authority is not
  a substitute. Within this capture class, line-of-sight lead replicas and
  joint-state half-cycle allocation changed arrival within the finite sampled
  band without a new failure topology, so test phase/response allocation under
  the existing bounds and reject it if capture, wake coherence, load class, or
  command/joint headroom regresses.
- Stop subdividing response/phase release or blending geometric errors around
  the LOS-led redirect; none has produced evidence beyond the executable
  repeat band. The strongest unmodulated sample captured at `19.706T`, score
  `-0.21598`, and mean distance `2.10594L`, while its semantic repeat captured
  at `19.888T/-0.22270/2.11324L`. Releasing both redirect contributions gave
  `19.850T/-0.22093/2.11128L`, posterior half-cycle scaling regressed to
  `20.168T/-0.24199/2.13279L`, and anterior-only release remained a repeat.
  The assigned parent's bounded angle/projected-miss blend then captured at
  `19.723T/-0.21601/2.10565L` with the same coherent wake and terminal hook:
  it preserved the class but did not validate range blending as an improving
  mechanism. A different invariant is supported by all four current sampled
  trajectories: at first crossing `2L`, closing remains `0.74--0.75L/T` and
  the velocity-course projected miss is already only `0.38--0.45L`, inside
  the `0.75L` capture radius, yet yaw rises from `0.24--0.26rad/T` to
  `0.36--0.47rad/T` and the miss changes sign before capture. Preserve the
  unmodulated posterior traveling wave and stop tuning redirect gains or error
  blends; test a normalized interception-corridor release of only the extra
  redirect after the measured course predicts capture. Reject that implication
  if it loses capture, fails to reduce the terminal hook or miss reversal, or
  worsens arrival, distance integral, wake coherence, loads, joint margin, or
  command headroom.
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
