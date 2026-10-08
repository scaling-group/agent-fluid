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
- Preserve the narrow `0.67`-period, `0.65/0.80` posterior lag/damping, negative
  bearing/rate-bias family as the fixed-prewarm local incumbent, and treat
  anterior amplitude as a corridor-selection control rather than a monotone
  thrust knob. In matched evidence, `19 deg` survived the full horizon but
  stopped at its `5.812L` minimum with `-5.846L` head-x travel; changing only
  the shell to `20 deg` produced capture at `266.255`, `0.749L` final/minimum
  distance, and `-11.031L` head-x travel. The new one-axis interpolation to
  `20.25 deg` retains the scale-`0.30` route topology but straightens and
  advances through the wake sooner: capture improves to `244.547` and mean
  distance from `7.218L` to `6.452L`, while mean upstream velocity rises from
  `-0.04144` to `-0.04443`. Its `31.055 rad/time^2` maximum stays below the
  `31.2` policy guard and `31.416` episode cap; RMS force remains `18.263`, but
  RMS moment increases from `353.21` to `362.21`, so retain that load increase
  as a tradeoff rather than claiming free thrust. At this period `20.5 deg`
  already has nominal acceleration beyond the hard envelope: use `20.25 deg`
  as the upper demonstrated shell and do not extrapolate amplitude without a
  distinct cap-feasible mechanism. Separately, sharpening only bearing scale
  from `0.30` to `0.28` at `20 deg` reaches `3.36` units earlier but worsens
  mean distance by `0.894L` and score by `0.896`, with a visibly longer lower
  excursion; avoid combining that scale change with amplitude and restore
  `0.30` for local tests. Stronger `0.78/0.72` posterior lag/damping produced
  only `+0.058L` head-x travel, while a coupled `21 deg`, `0.69`-period,
  scale-`0.38` variant rebounded from `3.246L` to a `3.610L` miss. Two sampled
  `20 deg` sheets are exact fixed-prewarm duplicates, not independent phase
  trials. Require capture, inactive guard, retained negative head-x transport,
  and no late rebound; require a distinct wake phase before claiming robustness.
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
