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
  trades away thrust. The faster success has higher RMS crossflow/moment
  (`0.133/338.9` versus `0.107/273.0`) and mean command effort (`653.2` versus
  `351.6`), so only a small normalized load-feedback residual is warranted as
  the next disturbance-rejection test; exact wake-phase tracking is not. This
  lesson is falsified if half-cycle variants lose upstream translation or
  success, or if load feedback reacts to self-generated beat torque without
  reducing visible yaw reversals and load metrics.
- Do not gate the direct yaw-moment residual with a bearing/rate classifier on
  this successful half-cycle scaffold. Relative to the ungated rate-damped
  success, the inherited directional-authority gate still captures and lowers
  RMS force/moment slightly (`15.30/306.15` versus `15.49/308.48`), but its
  wider middle arc worsens mean distance from `4.358L` to `4.578L` and score
  from `-2.4084` to `-2.6293` despite arriving `0.90` units sooner. This is a
  route-quality regression, not evidence that less moment rejection is
  generally better. Preserve the direct residual unless a later controlled
  comparison shows a gate improves distance as well as loads; test a separate
  measured-response damping channel rather than another heuristic
  helpful-versus-harmful wake classifier.
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
