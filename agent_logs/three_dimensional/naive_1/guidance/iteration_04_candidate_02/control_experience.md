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
- In direct-uniform still water, the drive-only seed made a visible
  three-dimensional posterior wake but reached only `12.078L` and exited the
  upper boundary at `8.55T`.  Anterior useful-half-cycle steering preserved the
  alternating wake and improved minimum/final distance to `11.782/11.797L`,
  outperforming posterior-only half-cycle scaling (`12.006/12.205L`), a shared
  anterior/posterior residual (`12.140/12.686L`), and the later large-error
  posterior redirect (`11.838/12.054L`).  The inherited opposing-stroke
  braking hypothesis has now also been tested: bearing/slip-driven full-stroke
  anterior rectification lengthened the coherent wake and sustained progress
  to `10.062L`, but still exited the upper boundary with roughly `-45` to
  `-67 deg` bearing over `7--11T` and raised joint-rate-cap occupancy to about
  `8/9%`, versus `1.5/2.1%` for the seed.  Treat rectification as a useful
  cruise/propulsion scaffold, not as established route control, and do not
  pursue scalar increases to its authority.  Across all four sampled traces,
  one-beat-detrended bearing ripple is strongly anticorrelated with anterior
  joint angle (`r=-0.87` to `-0.92`, slope about `-0.33` to `-0.39 rad/rad`),
  so a later route controller may test proprioceptive carrier demodulation and
  a distinct large-error curvature mechanism while leaving posterior lag
  intact.  This implication applies to the present L64 carrier in direct
  still-water release; reject its reuse if rectification no longer preserves
  the alternating wake or targetward progress, and accept a redirect only if
  it changes the upper-exit topology or sustains progress without increasing
  saturation.
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
