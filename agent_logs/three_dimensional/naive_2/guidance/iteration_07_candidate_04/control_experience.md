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
- Matched direct-uniform rollouts falsify static anterior-centering as the next
  steering step for this carrier. Mean-curvature centers of 8--9 degrees cut
  maximum joint speeds from the useful tail-only controller's 4.54 rad/T to
  0.83--1.26 rad/T, reached only 12.271--12.299L, and then exited with final
  distance near 13.45L. Leaving the anterior oscillator centered, steering the
  posterior target, and smoothly bounding acceleration instead reached
  11.512L with slightly lower peak force and moment than the naive carrier.
  Preserve the anterior traveling-wave scaffold and place sustained steering
  in a phase-compatible posterior modulation; do not interpret a coherent wake
  or a bounded static bend as useful control without distance progress. This
  implication is specific to rollouts where the carrier already propels, and
  is falsified if posterior modulation loses thrust or repeats the static-bend
  speed collapse.
- Matched direct-uniform rollouts now separate early route leverage from the
  remaining approach failure. Adding relative crossflow and a centerline
  course brake to the full posterior wave first improved minimum/final
  distance from `11.512/11.518L` to `9.880/9.880L`. Redistributing that course
  correction forward by only `3 deg` retained the alternating 3D wake,
  survived to `23.260T`, and reached `4.419L`; `4 deg` reached `3.161L` but
  then receded farther to `8.569L`. At those closest approaches the fish still
  moved about `0.83--0.85U` with target-to-velocity angle near `-pi/2`, so
  increasing early redistribution is not a monotone route remedy: preserve
  the `3 deg` carrier and test distance-conditioned propulsion-to-steering
  authority for the fast middle approach. Do not substitute an independently
  bounded yaw-recoil channel; the inherited full-wave test reached only
  `10.738L` and exited at `10.626T` while retaining `42.1%` near-limit tail
  action. This lesson applies after broad target progress is established and
  is falsified if approach relief stalls outside the prior `4.419L` minimum,
  destroys wake coherence, or a held-out condition lacks the high-speed
  closest-approach-then-recede topology.
- Matched approach rollouts reject generic carrier-energy reduction as the
  terminal remedy for this route. Distance-only amplitude relief to a 60%
  floor regressed closest approach from the full-wave `3 deg` controller's
  `4.419L` to `5.126L`; course-misalignment damping regressed it to `6.397L`,
  and both retained the upper-boundary exit. Conversely, the full-wave
  `4 deg` controller with an approach-relaxed course window preserved its
  coherent 3D wake and reached `3.135L` at `18.249T`, but at `0.852U` and
  `-1.410 rad` target-to-velocity error it then receded to `10.210L`. Thus a
  later terminal experiment should preserve the evidenced transit carrier
  and change redirection authority only after the route is already close,
  using target-relative course response to release the maneuver; do not
  repeat global oscillator damping or distance-only amplitude reduction.
  This applies to the high-speed, full-wave closest-approach-then-recede
  topology and is falsified if a compact terminal redirect cannot beat
  `3.135L`, disrupts the wake before its gate, collapses joint speed like the
  static anterior bends, or worsens saturation and hydrodynamic load peaks.
