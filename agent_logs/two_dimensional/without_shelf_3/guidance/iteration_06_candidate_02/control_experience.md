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
- The target-blind seed's early leftward motion is genuine but insufficient
  propulsion evidence: it reached `8.61L` range, then its head moved
  `-13.30L` laterally and exited after `50.13` released time while mean lateral
  velocity (`-0.263`) nearly followed local flow (`-0.241`) and both joint-rate
  caps were touched. Preserve the state-encoded gait only behind bounded
  target-relative course correction, and size nominal rhythm below the hard
  velocity/acceleration limits; do not mistake a transient minimum distance or
  visible body wave for wake rejection. This lesson applies to the far-field
  domain-exit regime; it does not establish steering sign, wake-entry quality,
  or tight-radius capture until a feedback candidate is evaluated.
- Localized joint-state protection is now the supported way to retain the
  progress-producing angle-only gait: restoring the `0.75`-period oscillator
  with guards converted the `33.06`-time folded instability (`-3.59L` head x,
  RMS force/moment `20024/314391`) into a finite `47.35`-time upstream rollout
  (`-2.45L`, `350/5007`). A second guarded policy with reduced bearing demand
  and `0.04` opposing recent-turn-rate feedback remained finite for `65.47`,
  moved `-4.08L` upstream, reached `6.71L` range, and reduced loads to
  `66.5/958`; in contrast, the inherited full-orbit radial regulators stayed
  low-load but moved about `+2.25L` downstream. Retain the guarded angle-only
  architecture as the far-field anchor; falsify it if a later guarded variant
  loses negative x or repeats cap contact and folding.
- Far-field course has a narrow recent-turn-damping boundary, not a supported
  lower-bearing-gain fix. With the same guarded gain-`0.60`, `12 deg` law,
  uniform damping `0.04` moved the head `(-4.08,+1.80)L` and reached `6.71L`
  before an upper U-turn; its exact `0.06` continuation lasted longer and
  reached `5.41L`, but then reversed to `(+2.62,-7.92)L` and finished `14.73L`
  away. Raising damping from `0.04` toward `0.06` below an `8L` range gate
  instead degraded the pass to `(-2.48,+1.77)L` with an `8.59L` minimum, while
  lowering bearing gain to `0.45` retained `+1.79L` upward travel but cut
  upstream displacement to `-0.73L`. Avoid lower bearing gain and early
  range-gated damping as course fixes; a uniform gain strictly between `0.04`
  and `0.06` is the remaining isolated interpolation. This boundary applies
  only before wake entry and is falsified if an intermediate gain cannot retain
  negative x while shifting the upper-exit course, or if loads/cap contact grow.
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
