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
- For this fixed prewarm, preserve the demonstrated narrow upstream/capture
  anchor: with `0.67` period, `0.65` posterior lag, `0.80` damping, and the same
  bounded negative bearing/rate bias, increasing only the anterior phase shell
  from `19` to `20 deg` changes a full-horizon `5.81L` miss (`-5.85L` head-x,
  `0.532` progress) into capture at `266.26` (`-11.03L` head-x, `0.940`
  progress). The successful run remains inside the joint envelope and has
  lower RMS crossflow/force/moment (`0.132/18.26/353.21`) than the coupled
  `21 deg`, `0.69`-period, softened-bearing near-miss
  (`0.140/19.15/363.27`), which rebounds from `3.25L` minimum to `3.61L`
  final distance. Do not infer that more amplitude, a softer bearing scale, or
  extra posterior wave authority is monotone: changing lag/damping to
  `0.78/0.72` with the `19 deg` shell erased upstream travel (`+0.06L` head-x,
  `0.057` progress). Isolate later changes around the `20 deg` anchor and
  require retained target-row correction, negative head-x travel, decreasing
  late distance, and no persistent guard/cap contact. This is phase-specific
  evidence; falsify portability if those conditions fail under another wake
  phase rather than encoding a route or coordinates.
- Treat the four current `20 deg`, `0.67`-period successes as one deterministic
  mechanism replication, not four independent parameter comparisons: their
  released and prewarm sheets are pixel-identical and all physical metrics
  agree despite source-only naming/comment differences. They establish that
  the `0.65/0.80` posterior lag/damping, negative `10 deg` bearing bias, and
  `0.30` bearing scale reproducibly capture at `266.26` under the certified
  snapshot, but they provide no evidence that nearby gains are monotone. The
  reusable control implication is to preserve that bundle and isolate one
  bounded transient-feedback axis when seeking a shorter, less circuitous
  approach. This boundary is limited to the fixed wake phase; falsify it with
  materially different rollout metrics or path topology under a changed
  phase, rather than counting equivalent source variants as broader support.
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
