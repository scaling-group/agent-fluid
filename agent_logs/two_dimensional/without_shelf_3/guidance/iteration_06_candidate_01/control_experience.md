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
- Sampled target-feedback results narrow that far-field steering lesson.
  Positive bearing-only curvature was the sole variant to retain upstream
  travel (`-3.59L` head x, `0.259` progress), but it hit both acceleration caps
  and failed unstable with RMS force/moment `20024/314391`. Reversing the sign
  while adding turn-rate and moment feedback kept loads near `21/430` yet moved
  `+2.74L` downstream and exited after `15.86` time; adding bearing-window-rate
  feedback in another architecture drove joint one to `0.781rad` and failed
  unstable after `1.66` time. Therefore treat positive bearing curvature as a
  conditional direction signal, retain the progress-producing angle-only
  rhythm behind policy-owned joint/action guards, and avoid unbounded
  derivative/load feedback. Full-orbit radial phase-energy regulation is not
  a default substitute: sampled descendants stayed finite and low-load but
  moved about `+2.25L` downstream with mean x velocity nearly equal to local
  flow. This boundary applies only before useful wake entry; falsify it if a
  guarded positive-sign controller loses upstream progress, or if an isolated
  radial regulator preserves active upstream travel in a later controlled
  comparison.
- Recent-turn damping is non-monotone and should be scheduled only as a
  falsifiable course experiment, not increased globally or near target by
  default. The guarded gain-`0.04` anchor self-propelled `-4.08L` upstream,
  reached `6.71L`, and stayed finite for `65.47` time before an upper U-turn;
  adding `0.02` damping only inside roughly `8L` shortened the run to `53.97`,
  reduced upstream travel to `-2.48L`, and worsened minimum range to `8.59L`
  at similar loads. Uniform `0.06` instead reached a closer `5.41L` transient
  minimum but later looped below the target and reversed `+2.62L` downstream,
  while lowering bearing gain from `0.60` to `0.45` nearly erased progress.
  Preserve the gain-`0.60` guarded gait as the comparison anchor; if damping
  is revisited, test relief rather than reinforcement on close approach and
  reject any schedule that trades one lateral loop for the other. This lesson
  applies before useful wake entry and is falsified by a finite scheduled run
  that preserves upstream propulsion while passing inside `6.71L` without
  upper or lower domain exit.
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
