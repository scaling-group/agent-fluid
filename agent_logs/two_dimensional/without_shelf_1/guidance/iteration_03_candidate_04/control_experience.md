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
- This no-Bookshelf ablation provides no cross-domain research shelf. Derive
  mechanisms only from the task contract, inherited guidance, sampled solver
  results and logs, and current rollout evidence; do not search for or
  reconstruct the omitted shelf.
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
- Retain the `0.90`-period positive bearing-to-posterior-tail policy as the
  current finite mechanism anchor, but not its saturation: relative to the
  target-blind seed it survived `73.39` versus `50.13` release units, improved
  progress from `0.024` to `0.132` and minimum distance from `8.61L` to
  `6.34L`, and its upstream head motion occurred in near-zero mean local flow.
  Its keyframes then show a broad upper loop while the posterior angle and both
  rates/commands reach their limits and RMS force/moment rise to `196/2014`.
  Do not repair that loop by moving steering into the anterior oscillator (the
  sampled version became unstable after `1.52` with loads `61379/660629`) or by
  dropping drive to the sampled `1.10`-period, `14 deg` regime (downstream
  displacement `+2.45L`, no minimum-distance gain, exit at `19.22`). First test
  posterior-only desaturation with drive between those bounds and only modest,
  clipped rate damping; retain it only if upstream progress, minimum distance,
  and survival all persist while saturation/load fall. The inherited `9d66`
  successor lost upstream motion (`+0.08L` x, progress `-0.062`) and had RMS
  moment `5141`, but its score log does not preserve enough policy detail to
  assign that regression to one feedback term; later workers should not repeat
  an assumed mechanism from the scalar log without matching policy provenance.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
