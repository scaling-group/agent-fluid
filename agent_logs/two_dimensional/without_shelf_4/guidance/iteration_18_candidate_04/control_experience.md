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
  demonstrated `20.25 deg` gait. Four current samples reproduce its
  `244.547` capture and `6.452L` mean distance, whereas otherwise matched
  inherited leads of `0.20` and `0.30` captured later at `258.621` and
  `270.446`, worsened mean distance to `8.041L` and `8.499L`, and raised RMS
  lateral force from `18.263` to `18.629` and `18.958`. The `0.20` sheet shows
  wider, jagged reversals and reduces controller-relative upstream transport
  from `0.00793` to `0.00556`; its slightly lower RMS moment is not a useful
  trade. Do not spend another evaluation on a globally constant lead inside
  the tested `0.20--0.30` interval. If rate timing is revisited, isolate a
  bounded convergence/divergence phase or use a distinct evidenced body-frame
  corridor signal, and falsify it on later capture, higher mean distance/load,
  switching, or lost upstream transport. This boundary is established only
  for the fixed-prewarm wake phase and retained gait/static-bearing bundle.
- Do not accept earlier capture alone as evidence that heading-rate damping
  improves the route. Relative to the replicated `0.25`-lead anchor, applying
  a bounded `0.05` heading-rate correction only during turn-away rotation
  crossed `5.990` earlier at `238.557`, but worsened mean distance from
  `6.452L` to `7.077L`, score from `-4.439` to `-5.068`, and RMS lateral force
  from `18.263` to `18.354`; controller-relative upstream transport fell from
  `0.00793` to `0.00476`, while moment fell only from `362.214` to `360.851`.
  Its sheet shows the cost in the large-error far-field loop before the aligned
  approach. Together with inherited global heading damping, which captured
  later at `259.160` and raised mean distance to `6.502L` despite lower loads,
  this rules out global or turn-away-only heading-rate correction for this
  gait and fixed-prewarm phase. Revisit body-rotation feedback only behind a
  separately normalized alignment/corridor gate that preserves large-error
  acquisition, and reject it on worse mean distance/score, later or lost
  capture, lower upstream margin, or higher crossflow/load; a held-out wake
  phase can falsify the scope of this boundary.
- Prefer pure rolling closing-speed phase selection over constant,
  drift-magnitude, or interpolated counter-drift scheduling for the retained
  `20.25 deg` gait, and treat `0.015L/time` as its local transition-scale
  anchor rather than evidence for monotonic sharpening. Three sampled results
  and one inherited optimizer rollout reproduce the `0.015` keyframes and
  metrics exactly: relative to the successful `0.020` parent, capture improves
  from `213.659` to `210.370`, score/mean distance from `-3.863/5.856L` to
  `-3.528/5.519L`, controller-relative upstream transport from `0.01261` to
  `0.01672`, and effort from `148694.7` to `147846.5`, with unchanged `4.293L`
  excursion and `31.055 rad/time^2` anterior acceleration. The timing benefit
  raises RMS force/moment from `17.761/354.838` to `18.426/363.057`, so a
  narrower transition is only a controlled bracket test, not an automatic
  improvement. An inherited byte-identical `0.020` policy/prewarm also came
  within `0.960L` before rebounding to a `2.904L` horizon miss, while a bounded
  `75%/25%` progress/drift blend missed at minimum/final distances
  `3.381/3.689L`; neither had gait loss, collision, exit, or instability.
  Preserve pure progress timing and distrust mixed selectors or load-only
  gains. This anchor applies only to the retained gait, `0.07--0.08` envelope,
  and certified wake phase; reject further sharpening on lost/later capture,
  worse route integral or upstream margin, switching, guard contact, larger
  excursion, or load growth that outweighs the route gain, and require a
  held-out-phase comparison before claiming transfer.
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
