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
- Treat anterior amplitude as a narrow wake-corridor selector, not a monotone
  thrust knob, within the `0.67`-period, `0.65/0.80` posterior family. The
  inherited `19 deg` controller survived but ended at its `5.812L` horizon
  minimum; `20 deg` captured at `266.255` with mean distance `7.218L`; and
  increasing only the shell to `20.25 deg` captured at `244.547` with mean
  distance `6.452L`. Four current samples reproduce that last released sheet
  and every physical/scoring field exactly, so count them as one certified-
  prewarm result, not four phase trials. The `20.25 deg` mean velocity x
  (`-0.04443`) is more upstream than mean local-flow x (`-0.03649`), confirming
  both active transport and useful reverse-flow-corridor acquisition, but its
  anterior acceleration already reaches `31.055 rad/time^2` against a `31.2`
  policy guard and `31.416` hard cap. Preserve this propulsion anchor for
  steering comparisons; do not extrapolate amplitude, and falsify transfer on
  lost/later capture, corridor rebound, guard contact, or material load growth.
- Preserve `0.30` static bearing scale and treat `0.25` bearing-rate lead as
  the evaluated fixed-prewarm steering anchor; three nearby changes retained
  capture but made the route worse. Static sharpening `0.30 -> 0.28` at
  `20 deg` increased mean distance `7.218 -> 8.112L`. At `20.25 deg`, relaxing
  scale toward `0.32` when closing delayed capture `244.547 -> 256.663` and
  raised mean distance to `7.394L`; positive rolling-window closure is not a
  reliable gate for reducing bearing authority. Increasing only rate lead
  `0.25 -> 0.30` added a visible upper reversal, delayed capture to `270.446`,
  raised mean distance to `8.499L` and RMS lateral force `18.263 -> 18.958`,
  and changed mean relative-flow x `+0.00793 -> -0.00055` despite identical
  anterior gait maxima. Avoid more rate anticipation or closure-gated steering
  relief in this gait. An isolated opposite-direction lead test is admissible,
  but reject it on later/lost capture, wider excursion, worse mean distance, or
  load growth; require another wake phase before generalizing any local result.
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
