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
- Preserve the full-vector velocity-course redirect as a slow mean C-bend, and
  keep phase allocation confined to the evidenced route-steering term. Four
  sampled variants with that scaffold all self-propelled on coherent top-down
  and oblique wakes and captured in `19.706--20.207T`; combining joint-state
  half-cycle steering with closing-gated LOS lead was the strongest sample
  (`-0.21598`, `19.706T`) versus `20.207T` without LOS lead. The assigned
  parent's later test of applying the same half-cycle factor to posterior LOS
  redirect curvature still captured but regressed to `-0.24199`, `20.168T`,
  was `0.126L` farther away at `12T`, and raised posterior peak angle to
  `0.602rad`. Do not phase-scale that redirect again without a distinct
  observation-level gate. Because `bearing_window_rate + turn_rate_recent`
  can be dominated by alternating body yaw even when inertial target/velocity
  geometry rotates slowly, later LOS edits should test an independent
  body-frame kinematic consistency cue rather than another lead gain. Reject
  this boundary if such consistency gating loses capture or reverts toward the
  LOS-free timing class; retain checks on command residence, joint margin,
  force/moment peaks, and both wake views.
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
