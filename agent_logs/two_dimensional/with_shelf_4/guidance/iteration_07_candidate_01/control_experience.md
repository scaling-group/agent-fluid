# Dogfish L64 Second-Row Wake-Policy Experience

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
  import. The same guidance is used by matched 2-, 3-, and 4-worker runs.
- The fixed task is `L64`, target `(9,9.5)L`, first-crossing radius `0.75L`,
  inflow `0.18`, held-fish prewarm `200`, released horizon `300`, and actuator
  envelope `45/260/1800` in degree-based units.
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
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- For the common target-blind seed, the released keyframes and diagnostics show
  a specific architecture failure: it exits the bottom boundary after `50.13`
  time units with `-13.30L` cross-stream displacement but only `-3.55L`
  upstream displacement, and its best distance (`8.61L`) regresses to
  `12.12L`.  Both joint velocities and accelerations reach their hard limits,
  so increasing oscillator gains is not a credible first repair.  On this
  failure topology, add bounded body-frame target-bearing control to the mean
  curvature of a realizable state-feedback traveling bend before introducing
  wake-phase or flow rejection.  This lesson is falsified if that curvature
  feedback turns with the wrong sign, preserves the bottom-exit topology, or
  removes the seed's upstream progress; only after target-directed motion is
  established should repeated wake-synchronous yaw reversals motivate a
  separate disturbance residual.
- Steering placement, rather than another gait scalar, changes the observed
  trajectory topology in this lineage. The assigned-parent mean-curvature
  policy survives the full horizon and halves the seed's RMS yaw moment, but
  remains in a far-right loop with only `-1.19L` upstream displacement;
  inherited logs also record two direct static-curvature variants exiting the
  right boundary in under `20` units. In contrast, two zero-mean policies that
  map body-frame bearing to state-inferred half-cycle asymmetry both reach the
  target, in `179.22` and `268.49` units. Preserve the alternating equilibrium
  and prefer half-cycle steering when a persistent curvature center loops or
  trades away thrust.
- Once zero-mean half-cycle routing works, a small normalized yaw-moment
  residual has a narrow positive operating point: the inherited `179.22`-unit
  baseline becomes a `149.57`-unit capture, and three sampled copies under the
  common prewarm reproduce `4.384L` mean distance, `16.22/314.99` RMS lateral
  force/moment, and `101995` total command energy. Adding body-frame windowed
  bearing-rate damping preserves essentially the same arrival (`149.61`) while
  improving mean distance to `4.358L`, force/moment to `15.49/308.48`, and
  energy to `96933`; its value is therefore smoother response and lower load,
  not demonstrated transit acceleration. Preserve the route-bearing owner,
  alternating equilibrium, and direct residual before testing whether signed
  bearing divergence can soften rejection of helpful wake yaw. Do not revive
  the inherited `1 - abs(route_turn)` headroom gate: bundled with a slower gait
  and higher load gain it exited the top boundary after `126.43` units and only
  `-1.12L` upstream travel, so it neither isolates a useful gate nor validates
  navigation from moderate load alone. Falsify further response gating if it
  loses capture/upstream translation or fails to lower visible kinks, loads,
  and effort. Identical-snapshot replication does not establish robustness to
  a changed wake phase.
- Qualifying bearing-rate damping with positive normalized window closing
  speed is a completed semantic improvement, not merely an approach-rate
  scalar. Against the otherwise identical direct-rate success, it shortens
  capture from `149.605` to `137.357` units, improves mean distance from
  `4.358L` to `4.184L`, total command energy from `96933` to `90228`, RMS
  relative crossflow from `0.1321` to `0.1296`, and RMS force/moment from
  `15.49/308.48` to `14.75/303.02`, while preserving `-10.91L` upstream
  translation and the posterior-lagged alternating wave. The body-frame
  control implication is to treat bearing change as useful response only when
  distance history corroborates targetward translation; otherwise retain the
  persistent bearing redirect. Preserve the direct moment residual: the
  assigned parent's bearing-response gate lowered load but widened the route
  to `4.578L` mean distance, and a separate whole-episode heading-rate damper
  lowered RMS force/moment further to `14.71/298.03` but delayed capture to
  `150.832` and worsened mean distance to `4.387L`. Falsify progress-qualified
  damping if it fails to reproduce capture and distance/load benefits under a
  changed wake phase; do not infer general robustness from the common snapshot.
- Prefer normalized body-frame feedback. Wake phase, inflow, cylinder layout,
  and target position are intended held-out axes; coordinate memorization is
  not a valid solution.
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
