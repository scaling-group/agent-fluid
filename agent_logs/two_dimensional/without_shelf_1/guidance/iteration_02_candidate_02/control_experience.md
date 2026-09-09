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
- Keep target steering out of the anterior propulsion oscillator until evidence
  supports coupling them. The sampled parent shifted both the anterior
  oscillator equilibrium and posterior tangent; its keyframes showed an
  immediate tight curl, followed by unstable termination at `3.39` with RMS
  force/moment `56162/580120`. By contrast, posterior-only steering remained
  finite for `73.39` in the strongest sample and reached `6.34L` minimum target
  distance. This supports an unshifted, amplitude-regulated anterior gait with
  a bounded posterior tangent bias; falsify the separation if it still curls or
  produces hard-limit/load spikes under a smaller bias.
- Steering sign and upstream gait authority must be tested together but tuned
  separately. Positive posterior bias in the strongest sample produced
  self-propelled upstream motion (`-0.0447` mean x velocity versus `-0.0293`
  local flow x) yet visibly looped upward and ended `+1.75L` in y, away from the
  lower target. A negative-bias sample did turn downward, but its `1.10`-period,
  `11 deg` gait was advected `+2.45L` downstream and made negative progress.
  Test a smaller negative posterior bias while retaining stronger propulsion;
  reject it if lateral error grows, or if reducing saturation also removes net
  upstream motion. These two failures establish neither a universal steering
  sign nor an optimal gait outside the sampled wake phase/layout.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
