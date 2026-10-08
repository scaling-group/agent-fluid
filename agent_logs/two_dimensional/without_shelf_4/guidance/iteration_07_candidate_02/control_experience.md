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
- Do not intensify the naive seed's `28 deg`, `0.55`-period drive. In its sampled
  rollout, nominal `A*omega` and `A*omega^2` already exceeded the `260` and
  `1800` degree-based caps, diagnostics reached both caps exactly, and the fish
  turned from `29 deg` toward `81 deg`, reached `9.01L` lateral target offset,
  and exited after `50.13` time units despite a transient `8.61L` minimum
  distance. Treat that transient approach as uncontrolled propulsion, not a
  navigation mechanism: first test a cap-feasible gait with bounded body-frame
  bearing correction. This lesson applies to oscillator settings whose
  velocity/acceleration scales exceed the envelope; falsify the proposed
  repair if cap contact or lateral ejection persists after the anterior gait is
  feasible, because posterior lag coupling or steering sign/gain is then the
  remaining suspect.
- For the `0.67`-period phase-shell family with `0.65/0.80` posterior
  lag/damping and bounded negative bearing/rate steering, anterior amplitude is
  a demonstrated wake-corridor threshold: `19 deg` survived but missed at the
  horizon (`5.812L` final, `-5.846L` head-x), `20 deg` captured at `266.255`,
  and four current fixed-prewarm samples reproduce the `20.25 deg` capture
  exactly at `244.547` while reducing mean distance from `7.218L` to `6.452L`.
  The last result improved mean upstream velocity despite slightly less
  favorable mean local flow, with an unchanged `18.26` RMS lateral force, but
  raised mean command energy and RMS moment to `695.75` and `362.21`. Treat
  `20.25 deg` as the fixed-phase propulsion anchor, not an amplitude trend:
  its maximum acceleration was already `31.055` against the `31.416
  rad/time^2` hard cap. The replicated keyframes still show broad alternating
  corrections, so test corridor-retention or bounded rate anticipation one
  axis at a time while preserving the `0.30` static bearing scale; reject such
  a test if capture/mean distance regresses or force/moment rises. This lesson
  remains limited to one certified wake phase and must be falsified on wake
  phase/layout changes or any persistent guard contact.
- Do not sharpen the successful posterior bearing response merely to shorten
  the visually broad release turn. With the `20 deg` gait held fixed, reducing
  bearing scale from `0.30` to `0.28` produced a larger down/up detour, worsened
  mean distance from `7.218L` to `8.112L` and score from `-5.190` to `-6.086`,
  and raised RMS lateral force from `18.26` to `18.58`, despite still capturing
  only `3.36` time units earlier. Prefer the demonstrated `0.30` scale; reopen
  this axis only if a held-out wake phase shows corridor loss and evaluate route
  topology and load, not arrival time alone.
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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
