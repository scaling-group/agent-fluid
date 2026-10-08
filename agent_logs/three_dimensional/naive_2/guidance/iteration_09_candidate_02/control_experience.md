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
- Matched direct-uniform posterior-mean rollouts now rank response cues more
  sharply. Bearing plus recent yaw exited high at `9.823T` with
  minimum/final distance `11.512/11.518L`; adding a speed-gated body-frame
  course cue reached `11.303/11.303L`, while a head-relative-crossflow
  residual retained the full alternating wake to `10.785T` and reached
  `10.513/10.513L`. Thus the crossflow residual is the strongest sampled
  complement to target bearing for this propulsive carrier, but it does not
  solve the route: every case still accumulated negative bearing and crossed
  the upper boundary. Preserve the full lagged wave and posterior-mean
  translation when testing an anticipatory target-line brake or a genuinely
  different response mechanism. Do not repeat the inherited course
  half-cycle translation (`11.967/12.226L`) or equate reduced saturation with
  better control: response-gated wave relief cut near-limit acceleration but
  reached only `11.330L` before receding to `11.546L`. This lesson applies to
  the established still-water carrier and is falsified for other conditions
  if crossflow loses its distance advantage, becomes dominated by imposed
  flow, or a controlled full-wave comparison repeats the same upper-exit
  topology with higher loads.
- Completed approach descendants now falsify carrier-energy relief as the next
  capture mechanism for this full-wave route family. Relative to the inherited
  unrelieved `4 deg` course redistribution's `3.161L` minimum, distance-only
  anterior amplitude relief reached `5.126L`, course-conditioned damping
  reached `6.397L`, and closure-conditioned posterior-wave relief reached
  `4.162L`; all retained the same upper-boundary exit. The closure-gated case
  did finish nearer at `6.363L` than the unrelieved parent's reported
  `8.569L`, but it failed its primary boundary by degrading the inbound
  approach while its posterior scale averaged about `0.887` inside `5L`.
  Preserve the complete anterior and posterior traveling wave and test a
  phase-compatible steering actuator rather than another distance, damping,
  or instantaneous-closure scalar. This implication applies while the carrier
  remains coherent and approaches at roughly `0.8U`; revisit relief only if a
  beat-averaged response gate retains a roughly `3.16L` approach and also
  changes the receding exit class, saturation, or load history.
