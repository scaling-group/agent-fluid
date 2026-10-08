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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Across the first direct-uniform still-water population, the target-blind
  seed remained best (`-14.825`, minimum `12.078L`) despite rate saturation
  and an upper exit at `8.55T`. Three bounded body-frame steering additions
  all scored worse and kept that upper-exit curl. In particular, two laws that
  recentered the anterior oscillator on target curvature settled near static
  `8 deg` bends, reduced joint rates below about `75 deg/T`, and reached only
  `12.286--12.304L`; an always-on common acceleration residual retained more
  oscillation but reached only `12.228L` before exiting. Treat this as a
  falsification of static/common mean-curvature steering on this weakly
  growing carrier, not as a reason to tune its gain again: preserve the
  zero-centered oscillator and test a phase-conditioned asymmetry or another
  mechanism that keeps the alternating posterior wake. Reopen mean-curvature
  steering only if a later implementation demonstrably retains carrier
  amplitude and replaces the clockwise upper-exit topology with sustained
  target progress.
- The next phase-conditioned population partially rescues steering without
  validating route control. Anterior-only, velocity-gated half-cycle drive
  preserves the alternating 3D wake and improves minimum/mean/final distance
  from the seed's `12.078/12.366/12.380L` to
  `11.782/11.823/11.797L`; posterior-only scaling reaches
  `12.006/12.203/12.205L`, while a shared aligned residual reaches only
  `12.140/12.651/12.686L`. All still curl clockwise through the upper boundary
  by about `9T`, and the strongest anterior law raises out-of-envelope raw
  acceleration requests from roughly one third to about 44% of samples.
  Therefore retain the zero-centered carrier and anterior actuator placement,
  but do not treat stronger one-sided drive as a solved turn: test a
  phase-coupled law that also brakes the wrong half-cycle or filters the route
  response. Falsify that direction if it loses the alternating wake, increases
  saturation, fails to beat `11.782L`, or preserves the same upper-exit
  topology.
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
