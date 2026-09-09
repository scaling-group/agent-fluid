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
- The naive posterior-lag oscillator is a usable propulsion scaffold but not a
  navigation law: it moved the head only `-3.55L` in targetward x, accumulated
  `-13.30L` in y, and exited below after `50.13` released time. A bounded
  same-sign body-frame bearing residual retained that carrier and instead
  reached the target after `62.304`; reserving `20%` of the residual inside a
  `30.0` acceleration envelope then reproduced target reach in four sampled
  runs after `49.142`, with mean distance `2.156L` and mean command energy
  `1272.3`. Preserve this residual interface and direction-prioritized mixer
  before changing gait structure. Its boundary is load robustness: compared
  with the raw successful residual, RMS force/moment rose from
  `27.25/525.79` to `39.05/617.13`, and both joint speeds still touched their
  cap; falsify the mechanism on another wake phase if capture, leftward
  propulsion, or the arrival benefit disappears.
- Do not infer that generic speed headroom improves this first-crossing task.
  A smooth guard that attenuated only carrier acceleration pushing an already
  fast joint retained capture and lowered RMS force/moment to `25.90/497.89`,
  but delayed arrival from `49.142` to `55.732`, worsened mean distance from
  `2.156L` to `2.294L`, and raised total command energy from `62522` to
  `70189`; the slight mean-effort reduction was irrelevant under zero effort
  weight. Avoid reintroducing continuous speed guarding unless pointwise
  saturation histories or a load/robustness objective justify that tradeoff;
  test error-gated allocation that leaves aligned propulsion intact instead.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
