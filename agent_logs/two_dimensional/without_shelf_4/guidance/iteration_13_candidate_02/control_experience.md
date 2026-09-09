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
- Treat `0.30` static bearing scale with `0.25` rate lead as a local steering
  anchor, not a broad-turn defect repaired by a scalar sweep. At `20 deg`,
  sharpening scale to `0.28` enlarged the detour, worsened mean distance from
  `7.218L` to `8.112L`, and raised RMS lateral force from `18.262` to `18.583`.
  At `20.25 deg`, three sampled sheets reproduce the better `244.547` capture
  and `6.452L` mean distance, whereas inherited closing-speed relief and a
  constant `0.20` lead delayed capture to `256.663` and `258.621`, worsened
  mean distance to `7.394L` and `8.041L`, and raised RMS force to `18.426` and
  `18.629`. Lower load alone is not a repair: another inherited branch missed
  the horizon at `3.290L` minimum and `3.632L` final distance while reducing
  RMS force to `17.349` and raising mean command energy to `708.034`. Preserve
  the static scale/rate-lead bundle for this fixed shell and wake phase; a later
  steering test must isolate a distinct bounded body-frame signal and improve
  capture, mean distance, upstream margin, and loads together. Falsify this
  boundary only with a controlled held-out wake phase or shell comparison.
- Treat direct heading-rate damping as exhausted for this fixed-prewarm gait,
  even though it can change arrival time and loads. An inherited global `0.05`
  correction lowered RMS force/moment to `18.202/357.284` but delayed capture
  from `244.547` to `259.160`, raised mean distance from `6.452L` to `6.502L`,
  and reduced controller-relative upstream transport from `0.00793` to
  `0.00359`. Restricting the same correction to measured turn-away rotation
  produced the fastest sampled capture at `238.557` and lowered mean moment and
  command effort, but still worsened mean distance to `7.077L`, reduced the
  upstream margin to `0.00476`, and raised RMS force to `18.354`. Thus neither
  global nor sign-gated rotation damping improves the composite route: do not
  select by arrival or load alone, and do not spend another evaluation retuning
  this heading-lead axis without time-resolved evidence. Test a distinct
  bounded body-frame corridor or translational signal while preserving the
  anchor elsewhere; require capture, mean distance, upstream margin, and loads
  to improve together. This boundary applies to the retained `20.25 deg`,
  `0.67`-period, `0.30/0.25` bundle and is falsified only by a controlled wake-
  phase or gait comparison that improves those metrics jointly.
- Treat sign-gated body-frame lateral translation as the first demonstrated
  positive corridor-retention signal for the retained gait, not as generic
  lateral damping. Against the otherwise identical `20.25 deg`, `0.67`-period,
  `0.30/0.25` anchor, a `0.08` lookahead using lateral velocity clamped at
  `0.10` only while `-bearing * velocity_body_U[2] > 0` advanced capture from
  `244.547` to `224.488`, improved mean distance from `6.452L` to `6.311L`,
  doubled controller-relative upstream margin from `0.00793` to `0.01602`, and
  reduced RMS force/moment from `18.263/362.214` to `17.943/361.014`. The
  released sheets still show a broad initial turn and the maximum lateral
  target offset remains `4.293L`, so this evidence supports recovery from
  measured away-drift rather than claiming elimination of release transients.
  Preserve the sign gate and the propulsion/static-bearing bundle; falsify
  gain transfer on later or lost capture, corridor rebound, reduced upstream
  margin, load growth, guard contact, or chatter near zero bearing. This result
  is local to the fixed prewarm phase until a controlled phase or layout test
  reproduces the joint improvement.
- Do not minimize RMS relative crossflow in isolation for this wake corridor.
  The sampled sign-gated lateral-velocity policy improved capture from
  `244.547` to `224.488`, mean distance from `6.452L` to `6.311L`, upstream
  margin from `0.00793` to `0.01602`, and force/moment loads from
  `18.263/362.214` to `17.943/361.014`, while RMS relative crossflow barely
  changed from `0.13437` to `0.13427`. Conversely, an inherited score-only
  branch lowered crossflow further to `0.13295` but captured at `263.346` with
  `6.974L` mean distance and `18.310` RMS lateral force. Use crossflow as a
  stability/load diagnostic, not a surrogate for useful lateral motion or
  route quality; preserve productive wake-band crossings and require capture,
  distance, upstream margin, and loads to improve jointly. This boundary is
  local to the retained gait and certified prewarm phase, and is falsified by
  a controlled variant that couples lower crossflow to improvement in all four
  route criteria.
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
