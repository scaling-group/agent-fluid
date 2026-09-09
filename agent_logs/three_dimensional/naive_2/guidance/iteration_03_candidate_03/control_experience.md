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
- Four sampled direct-quiescent policies all self-propel with visible coherent
  alternating 3D wakes, yet all exit the upper boundary within `8.79--9.25T`.
  The bounded, shared anterior/posterior half-cycle acceleration mechanism is a
  real improvement over sampled posterior-only phase asymmetry and mean
  curvature: it moves the center `2.041L` left, reaches `11.347L`, and finishes
  at `11.359L`, versus `11.670--12.056L` minima and `11.731--12.207L` finals for
  the other target-aware samples, while holding requested acceleration below
  `30 rad/T^2`. Preserve that traveling carrier and shared posterior-heavy
  half-cycle authority as the current useful mechanism, not as evidence of
  navigation success.
- The improved half-cycle rollout crosses from about `+0.118` to sustained
  negative body-frame bearing, ends near `-0.617`, rises from `14.0L` to the
  `15.2L` exit margin, and still touches both `260 deg/T` joint-rate limits.
  Its lateral-velocity release is therefore a concrete negative result: better
  thrust and x progress do not arrest a centerline sweep. Do not respond with
  scalar-only carrier/asymmetry increases or return to static curvature; test a
  bounded phase/half-cycle command with bearing-trend lead that releases and
  brakes as target error approaches zero. Falsify this implication if trend
  feedback weakens the alternating wake, increases limit occupancy, or fails to
  improve both closest approach and termination topology. These still-water
  runs do not establish flow-, force-, or moment-feedback signs.
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
