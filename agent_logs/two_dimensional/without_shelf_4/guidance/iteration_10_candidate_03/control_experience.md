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
- Do not sharpen the successful posterior bearing response merely because its
  keyframes contain a broad release turn. With the `20 deg` gait held fixed,
  reducing bearing scale from `0.30` to `0.28` made the visible down/up detour
  larger, worsened mean distance from `7.218L` to `8.112L`, and raised RMS
  lateral force from `18.262` to `18.583`, despite crossing only `3.36` time
  units earlier. Retain the `0.30` response whenever the fish is stalled or
  receding. If testing route straightening, use a bounded rolling-window,
  body-frame retention signal and judge mean distance, lateral offset/load,
  switching, and capture together; reject it if weaker steering delays wake
  acquisition. This implication is local to the demonstrated gait and wake
  phase until a controlled held-out comparison reproduces it.
- Treat `0.25` as the local constant bearing-rate-lead anchor for the
  demonstrated `20.25 deg` gait, and do not use bearing-error divergence as a
  safe phase gate. Four current samples reproduce its `244.547` capture,
  `6.452L` mean distance, and `0.00793` controller-relative upstream transport;
  inherited constant leads of `0.20` and `0.30` instead captured at `258.621`
  and `270.446`, raised mean distance to `8.041L` and `8.499L`, and raised RMS
  force from `18.263` to `18.629` and `18.958`. More decisively, reducing lead
  from `0.25` toward `0.20` only when `bearing * bearing_rate > 0` missed the
  horizon: minimum/final/mean distances were `3.290/3.632/8.447L`, maximum
  lateral offset grew from `4.293L` to `4.703L`, and absolute upstream velocity
  fell from `-0.04443` to `-0.02667`, despite unchanged gait acceleration and
  no collision, exit, or instability. A distinct global `0.05` heading-rate
  correction retained capture and reduced RMS force/moment from
  `18.263/362.214` to `18.202/357.284`, but delayed arrival to `259.160`, raised
  mean distance/crossflow to `6.502L/0.13610`, and cut relative-upstream
  transport to `0.00359`. Thus body-rotation feedback has a real load/route
  tradeoff, but damping useful targetward rotation is not supported. Do not
  retry constant-lead interpolation, bearing-divergence gating, or global
  heading damping for this fixed-prewarm gait. If rotation is revisited, the
  remaining bounded test is to act only on measured turn-away rotation while
  leaving targetward turns exactly on the anchor; falsify it on later/lost
  capture, higher mean/lateral distance or crossflow/load, chatter, or reduced
  upstream transport. This boundary remains local to the retained gait,
  static-bearing bundle, and wake phase.
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
