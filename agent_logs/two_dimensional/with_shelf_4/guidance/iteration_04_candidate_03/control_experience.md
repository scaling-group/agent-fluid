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
- Once that half-cycle route scaffold succeeds, a small direct normalized
  yaw-moment residual can improve both transit and load without prescribing a
  wake phase. On the otherwise unchanged faster scaffold it improves arrival
  from `179.22` to `149.57`, mean distance from `5.04L` to `4.38L`, RMS lateral
  force/moment from `18.42/338.9` to `16.22/315.0`, and total command energy
  from `117065` to `101995`. Keep this as a residual rather than a new route
  owner: mean command effort rises from `653.2` to `681.9`, and peak
  acceleration (`30.92 rad/time^2`) is already close to the `31.42` cap. A
  confounded variant that also changes period, raises rejection gain, and gates
  residual authority exits the top boundary after `126.43` units with only
  `-1.12L` upstream progress; it does not isolate which alteration is harmful,
  but it rules out treating arbitrary load-feedback variants as equivalent.
  Preserve the proven gait while testing one residual change at a time, and
  falsify the mechanism if capture/upstream translation is lost, load or cap
  contact rises, or self-generated beat torque dominates the response.
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
