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
- Completed descendants sharpen that lesson: putting bearing error into a
  static oscillator center is not enough.  An amplitude-regulated version
  improves `left_domain` to a full `300`-unit horizon and halves RMS yaw moment
  (`541.70` to `270.96`), but keyframes show a far-right loop with only `1.19L`
  upstream displacement and a `10.28L` closest approach.  Two simpler centered
  biases instead leave the downstream boundary within `16.63`--`19.87` units,
  each moving about `+2.2L` downstream.  Therefore neither horizon survival
  nor large joint motion validates route control; avoid scalar-only tuning of
  this static-bias architecture when the loop/advection topology persists.
- Phase-dependent half-cycle steering is now a replicated positive mechanism,
  not merely a proposal.  Two independently completed zero-mean variants both
  reach the target after the static-bias failures: one arrives in `179.22`
  units with `5.04L` mean distance and `-10.93L` upstream displacement, while
  the other arrives in `268.49` units with `8.04L` mean distance and `-10.92L`
  upstream displacement.  Their keyframes retain alternating bends throughout
  broad targetward arcs into the interacting wakes.  Preserve state-encoded
  phase, zero crossings, and posterior lag when extending this controller;
  falsify an extension if it loses capture, upstream translation, or the
  alternating wave.  The faster variant also raises RMS moment from `273.01`
  to `338.91` and command-energy mean from `351.62` to `653.20`, and the two
  policies differ in several gait and tail parameters, so this comparison does
  not identify a causal scalar gain.  Treat bounded load/yaw rejection as a
  separately falsifiable extension and require it to preserve arrival, rather
  than inferring that lower effort alone is an improvement.
- Direction-response refinements on the fixed `0.72`-period half-cycle and
  direct-moment scaffold now support a causal hierarchy. Adding only bounded
  `bearing_window_rate` feedback preserves roughly `149.6`-unit capture while
  improving mean distance from `4.384L` to `4.358L`, mean command energy from
  `681.91` to `647.93`, and RMS force/moment from `16.22/314.99` to
  `15.49/308.48`. Qualifying that rate term only when normalized closing speed
  is positive then shortens capture to `137.36`, improves mean distance to
  `4.184L`, and lowers RMS force/moment again to `14.75/303.02`; it raises
  mean command energy to `656.89`, so progress qualification is a route
  mechanism rather than free efficiency. Preserve bearing-rate damping,
  closing-progress qualification, and the direct moment residual when testing
  a separate route-observation mechanism. Falsify an extension if it loses
  capture or upstream translation, erases those distance/load gains, or
  increases the already near-cap anterior acceleration (`30.85` versus a
  `31.42 rad/time^2` limit). Inherited boundaries also argue against adding
  heading-rate damping or gating the moment residual from bearing response
  merely to lower loads: those variants capture later or widen the route and
  worsen score despite modest load reductions.
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
