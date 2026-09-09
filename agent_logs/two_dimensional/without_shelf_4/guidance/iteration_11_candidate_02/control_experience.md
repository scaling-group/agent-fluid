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
  monotone thrust knob. In the `0.67`-period, `0.65/0.80` posterior family,
  inherited `19 deg` evidence survived the horizon but stopped at its `5.812L`
  minimum, the matched `20 deg` controller captured at `266.255` with mean
  distance `7.218L`, and the isolated `20.25 deg` increase captured at
  `244.547` with mean distance `6.452L`. Four current fixed-prewarm samples
  reproduce the `20.25 deg` trajectory and metrics exactly. Its mean upstream
  velocity `-0.04443` exceeds the magnitude of mean local-flow x `-0.03649`,
  while maximum anterior acceleration is already `31.055 rad/time^2` against
  a `31.2` policy guard and `31.416` hard cap. Preserve this propulsion,
  phasing, and bounded negative bearing/rate bundle as the demonstrated local
  anchor; do not extrapolate amplitude to `20.5 deg`, whose nominal
  acceleration exceeds the hard envelope, or generalize fixed-phase
  replication to other wake phases. Falsify transfer on lost/later capture,
  guard contact, corridor rebound, or material load growth, then test bounded
  corridor-retention feedback rather than more drive.
- Treat `0.30` static bearing scale with `0.25` bounded rate lookahead as a
  local steering bundle, not a broad-turn defect repaired by another scalar
  sweep. At `20 deg`, sharpening scale to `0.28` enlarged the visible detour,
  worsened mean distance from `7.218L` to `8.112L`, and raised RMS lateral
  force from `18.262` to `18.583`. At `20.25 deg`, four sampled fixed-prewarm
  sheets reproduce capture at `244.547`, `6.452L` mean distance, `4.293L`
  maximum lateral offset, and `18.263` RMS force. Inherited `0.20`-lead and
  closing-relief branches captured later at `256.663/258.621`, with worse
  `7.394/8.041L` mean distance and `18.426/18.629` RMS force; another branch
  crossed earlier at `238.557` but still worsened mean distance to `7.077L`
  and force to `18.354`. Lower load alone is also insufficient: an inherited
  horizon miss reduced RMS force to `17.349` while stopping at `3.290L`
  minimum distance and raising mean command energy to `708.034`. Preserve the
  static scale/rate-lead bundle for this shell and wake phase. A route-retention
  test must isolate a distinct bounded body-frame signal and improve capture,
  mean distance, lateral offset/load, and upstream margin together; reject it
  on delayed/lost capture, switching, guard contact, or load/effort growth.
  Falsify this boundary only with a controlled shell or held-out wake-phase
  comparison.
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
