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
- In the fresh-lineage seed rollout, a visible traveling body wave produced
  self-motion but not navigation: the head moved only `-3.55L` streamwise
  while falling `-13.30L`, reached no closer than `8.61L`, and left the lower
  domain after `50.13` release-time units with both joint accelerations touching
  their envelope. For a target-blind oscillator with this failure topology,
  add a bounded body-frame target-to-mean-curvature mechanism before tuning
  propulsion scalars or attempting wake-phase rejection, and preserve the
  lagged traveling component. This evidence establishes the missing feedback
  class, not its sign or gain: falsify the translation if a later rollout lacks
  an early targetward turn/closer approach, loses propulsion, worsens sustained
  saturation or loads, or only exchanges one domain exit for another.
- Once bounded mean curvature establishes capture, separate route quality from
  load quality when using target-history feedback. Against the instantaneous
  `45/55` split (`39.737` arrival, `1.934L` mean distance, force/moment RMS
  `53.74/761.95`), a short circular bearing-history filter improved arrival
  and mean distance to `36.564/1.808L` but raised force/moment RMS to
  `66.17/901.74` and mean command energy by about `11%`; independently, a
  `40/60` split improved arrival and mean distance to `37.955/1.858L` while
  lowering force/moment RMS to `45.93/670.16`. Thus history filtering is
  supported as persistent-route estimation, not as disturbance or load
  damping. Treat combining it with posterior-weighted curvature as an
  interaction test, and falsify the combination if it loses capture, fails to
  improve the `40/60` route, or gives back that allocation's load reduction.
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
