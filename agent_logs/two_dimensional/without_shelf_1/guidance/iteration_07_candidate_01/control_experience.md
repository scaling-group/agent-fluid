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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- Retain the positive bearing-to-posterior-tail sign, the `0.90`-period drive,
  and `10 deg` posterior authority as the current finite anchor, while treating
  heading-rate damping as a bounded gain search rather than a solved loop
  controller. With the rest of the policy fixed, normalized direct-heading-rate
  gains `0.35 -> 0.70` improve progress `0.255 -> 0.380`, closest approach
  `7.30L -> 5.33L`, and head x travel `-4.69L -> -6.93L`; mean head velocity
  `-0.130` versus local flow `-0.091` at `0.70` confirms self-propulsion. Gain
  `1.05` then regresses those metrics to `0.369`, `5.64L`, and `-6.67L`, raises
  RMS force/moment from `325/3331` to `334/3463`, and preserves the same
  `+1.20L` center-y upper exit. Thus bracket gains between `0.70` and `1.05`
  without crossing farther into sign-reversing rate feedback; falsify this
  direction if an intermediate gain does not change upper clearance or loop
  topology, even if scalar progress remains high.
- Do not reduce steady posterior authority as a desaturation shortcut for this
  topology. An inherited isolated reduction from `10` to `8 deg` at heading-
  rate gain `0.70` cuts progress `0.380 -> 0.095`, worsens closest approach
  `5.33L -> 8.22L`, and reduces upstream head travel `-6.93L -> -2.19L`, while
  leaving center-y exit essentially unchanged at `+1.20L`. Along with the
  sampled failures of target-bearing-rate and body-lateral-rate damping, this
  shows that lower loads or weaker steering are not evidence of lateral
  correction. Restore the `10 deg` anchor after such a loss and vary one
  normalized rotational sensitivity at a time; revisit bias only if a future
  result preserves approach while measurably reducing upper displacement.
