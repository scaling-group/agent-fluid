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
- Do not treat the target-blind `0.55`-period seed as a safe propulsion anchor
  under the common prewarm. Its only sampled rollout hit both acceleration
  limits, spent `1496.25` mean command energy, and was entrained down the local
  flow: the keyframes and `(-3.55L, -13.30L)` head displacement show a bottom
  exit at release time `50.13` after the distance first improved to `8.61L` and
  then worsened to `12.12L`. A next architecture should add bounded body-frame
  bearing correction and test an unsaturated gait before tuning propulsion
  alone. This lesson applies to the current actuator envelope and initial wake;
  falsify it if bearing feedback reproduces the exit or a comparably evaluated
  target-blind, unsaturated gait maintains approach without lateral ejection.
- Do not optimize posterior bearing-bias sign independently of the propulsion
  regime. A positive `15 deg` posterior bias with an `11 deg`/`0.75` gait
  exited down/right at `24.37` with `+2.41L` head-x displacement, and a
  negative `8 deg` bias with an `18 deg`/`0.65` gait eventually exited at
  `143.45` with `+2.19L` head-x displacement; inherited negative-bias
  `0.80`-period branches also left downstream near release time `16`. In
  contrast, the zero-centered `19 deg`/`0.67` energy-shell gait with a bounded
  negative `10 deg` bearing-rate lead survived the full `300`, moved the head
  `-5.85L` upstream and `-4.28L` laterally, monotonically reduced distance to
  `5.81L`, and avoided hard cap contact with lower force/moment and mean effort
  than the seed. Use that combined gait/steering structure as the current
  finite anchor and vary propulsion locally before retrying sign flips or
  shared mean curvature. This applies to posterior-only biases under the
  common four-cylinder prewarm; falsify it if matched zero/opposite-bias runs
  at the same finite gait reproduce full-horizon negative-x closure, or if the
  anchor loses bounded lateral progress under wake-phase held-outs.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
