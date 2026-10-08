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
- Treat anterior shell amplitude as a narrow wake-corridor selector, not a
  monotone thrust knob. In inherited fixed-prewarm logs, a finite but weak
  `14 deg`, `0.80`-period controller was advected `+2.172L` downstream and
  exited after `16.747`, while the matched negative-posterior-bias family at
  `0.67` period moved upstream: `19 deg` survived the horizon but stopped at
  its `5.812L` minimum, `20 deg` captured at `266.255` with mean distance
  `7.218L`, and changing only the shell to `20.25 deg` captured at `244.547`
  with mean distance `6.452L`. Four current samples reproduce the `20.25 deg`
  trajectory and metrics exactly. Its mean velocity x `-0.04443` versus mean
  local-flow x `-0.03649` shows wake-assisted corridor selection with a
  smaller active upstream component, while maximum anterior acceleration is
  already `31.055 rad/time^2` against the `31.2` policy guard and `31.416`
  episode cap. Preserve the `0.67` period and `0.65/0.80` posterior
  lag/damping; do not extrapolate to `20.5 deg`, whose nominal acceleration is
  above the hard envelope, or generalize fixed-phase replication to other wake
  phases. A coupled `21 deg`, `0.69`-period variant rebounded from a `3.246L`
  minimum to a `3.610L` miss. Falsify transfer on later/lost capture, guard
  contact, corridor rebound, or increased lateral load; then restore the
  `20.25 deg` fixed-phase anchor and test feedback rather than more drive.
- Preserve the demonstrated `0.30` static bearing scale and `0.25` bounded
  rate lookahead; four controlled steering variants now bracket them as a local
  optimum. At the `20 deg`
  gait, static scale `0.30 -> 0.28` enlarged the visible down/up detour,
  worsened mean distance `7.218 -> 8.112L`, and raised RMS lateral force
  `18.262 -> 18.583` despite a slightly earlier crossing. At the `20.25 deg`
  gait, softening scale only during positive closure toward `0.32` delayed
  capture `244.547 -> 256.663`, worsened mean distance `6.452 -> 7.394L`, and
  raised RMS relative crossflow `0.13437 -> 0.13733`; increasing only rate
  lookahead `0.25 -> 0.30` produced visibly sharper repeated reversals, delayed
  capture to `270.446`, worsened mean distance to `8.499L`, and raised RMS
  lateral force to `18.958`. The inherited isolated lower-lookahead test
  `0.25 -> 0.20` also retains capture but visibly delays steering unwind:
  arrival moves to `258.621`, mean distance to `8.041L`, command energy to
  `179926`, and RMS lateral force to `18.629`. Its small reductions in RMS
  relative crossflow (`0.13437 -> 0.13419`) and moment (`362.214 -> 360.028`)
  are not benefits when route length, arrival, effort, and lateral loading
  regress. Stop tuning bearing scale/lookahead at this fixed wake phase; test a
  distinct, bounded normalized body-frame corridor-retention signal, and reject
  it on later/lost capture, wider switching, or increased route/load. This
  implication is limited to the demonstrated gait and certified wake phase
  until held-out phases reproduce it.
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
