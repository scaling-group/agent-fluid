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
- Pair the distance/closing steering-headroom allocator with a velocity-course
  redirect: sampled descendants show that this is now a supported capture
  scaffold, not only a smaller-miss hypothesis. The allocator alone changed
  the aligned parent's `2.58L` straight pass into a `1.73L` return loop; all
  four sampled course-redirect descendants remove that topology and capture in
  `20.207--20.971T` with coherent top-down and oblique wakes. Once capture is
  established, prefer state-derived half-cycle steering over widening the
  redirect's distance gate: half-cycle asymmetry improved the `20.971T`
  unmodulated redirect to `20.207T`, reduced the trajectory distance integral
  from `157.510` to `152.044 L*T`, and was already ahead at `12T` (`6.420L`
  versus `6.696L`) while keeping per-joint high-command residence in the same
  approximate `34--37%` band. An `8L` redirect gate changed little
  (`20.653T`, `157.174 L*T`). Closing-gated line-of-sight lead has a repeatable
  geometric effect but not yet a repeatable scalar benefit: two functionally
  identical sampled lead policies captured at `19.706T` and `20.036T` with raw
  trajectory integrals of `150.565` and `152.299 L*T`, bracketing the unled
  half-cycle redirect's `20.207T` and `152.080 L*T`. Both lead runs nevertheless
  reduced the velocity-course error magnitude at `1L` to about `0.02--0.10 rad`
  from `0.44 rad`; their top-down/oblique wakes stayed coherent and their joint,
  command, force, and moment bands remained comparable. Treat one lead rollout
  as variance-sensitive evidence rather than a settled ranking. Preserve its
  bounded closing gate when testing it, and align phase-shaped steering with
  the net route-plus-redirect request rather than a conflicting route channel;
  reject that composition if replicated arrival/integral, capture, terminal
  course alignment, wake coherence, actuator residence, or loads regress.
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
