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
- Localized joint-state protection is now supported for retaining the
  progress-producing angle-only gait. The unguarded positive-bearing oscillator
  folded after `33.06` released time despite `-3.59L` upstream travel, with RMS
  force/moment `20024/314391`; the assigned guarded parent remained finite for
  `47.35`, moved `-2.45L`, and reduced those loads to `350/5007`. A descendant
  with the same `0.75`-period rhythm, `34 deg`/`200 deg/time` guards, a
  `1600 deg/time^2` soft bound, `12 deg` steering ceiling, and `0.04` opposing
  recent-turn feedback remained finite for `65.47`, moved `-4.08L`, reached
  `6.71L` range, and reduced loads again to `66.5/958`. In contrast, inherited
  full-orbit radial regulators stayed low-load but moved about `+2.25L`
  downstream. Retain the guarded angle-only architecture as the far-field
  propulsion anchor; falsify this implication if a later guarded variant loses
  negative x relative to local flow or repeats cap contact and folded-body
  loads.
- Do not escalate recent-turn damping or lower peak static steering authority
  merely because the finite keyframes show a late loop. The fixed `0.04`,
  `12 deg` sample is the strongest finite result (`-4.08L` head x, `6.71L`
  minimum range). Adding up to `0.02` more damping inside roughly `8L` preserves
  almost identical joint extrema but starts the same upper-boundary loop
  earlier (`-2.48L`, `8.59L` minimum); inherited uniform `0.10` damping is worse
  again (`-0.73L`, `9.90L` minimum). Reducing the fixed ceiling to `10 deg` at
  `0.04` damping also falls to `-1.43L` and `9.00L`. All guarded sampled
  variants end with about `+1.8L` head-y displacement, so their remaining
  failure is target-relative course rather than nonfinite propulsion. Before
  useful wake entry, keep the demonstrated ceiling and small fixed damping and
  isolate the unsaturated static bearing response or gait guards; revisit rate
  or load additions only after a finite static loop reaches the wake corridor
  and measured course/load growth justifies them. This boundary is falsified if
  a controlled damping increase or lower ceiling preserves the `-4.08L` travel
  while reducing the terminal lateral exit.
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
