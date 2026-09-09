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
- Pair the distance/closing steering-headroom allocator with a bounded
  velocity-course redirect; the combination is now a supported capture
  mechanism, not merely a smaller-miss hypothesis. The allocator alone changed
  the saturated aligned parent's `2.58L` straight pass into a lower-command
  `1.73L` return loop, but four subsequent full-vector/course-response C-bend
  variants all removed that topology and captured in `20.97--21.16T` while
  retaining a coherent 3D wake, zero residence above 90% of the joint-angle
  limit, peak force/moment coefficients near `0.025/0.013`, and about `35%`
  residence above 90% of the smooth `31 rad/T^2` command bound. Prefer the
  unthresholded target-to-velocity-course redirect as the current scaffold: it
  had the earliest capture (`20.971T`), best distance integral (`2.16674L`),
  best score (`-0.27435`), and lower mean commands `(18.67,18.02) rad/T^2`.
  Do not release this redirect solely because one instantaneous forward-ray
  projection enters a nominal `0.55L` corridor; that variant still captured
  but regressed to `21.087T`, `2.17489L`, score `-0.28229`, and slightly higher
  mean commands `(18.93,18.28)`. Test release against measured directional
  response instead, and reject that extension if capture timing/integral,
  wake coherence, command residence, joint limits, force, or moment regress.
- When the course redirect already captures, allocate route steering by
  observed joint half-cycle before expanding its distance gate or raising its
  actuator envelope. State-derived anterior-velocity half-cycle shaping
  improved the same captured scaffold from `20.971T`, `2.16674L`, and
  `-0.27435` to `20.207T`, `2.11794L`, and `-0.22712`; it preserved the
  coherent alternating/3D wake, kept peak joint angles at `0.534/0.590 rad`,
  and retained peak body-force/moment coefficients near `0.023/0.013`.
  Starting the unchanged course redirect farther out reached only `20.653T`,
  `2.16524L`, and `-0.27336`, so a wider gate is not a substitute for
  phase-aware steering. Measured line-of-sight rotation independently improved
  the unshaped redirect to `20.471T` and slightly lowered mean commands, making
  it a compatible terminal-feedback hypothesis but not yet evidence that its
  combination with half-cycle shaping is additive. Preserve normalized
  joint-state phase, full body-frame target/course geometry, posterior lag,
  and soft limits; reject the half-cycle lesson if a later pose or flow loses
  capture/wake coherence or increases joint, command, force, or moment
  residence, and reject the hybrid if it does not beat the half-cycle parent.
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
