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
- Treat the sampled target-blind gait as a negative saturation anchor, not a
  propulsion template to preserve unchanged: its `0.55`-period, `28 deg`
  oscillator drove both joints to the `1800 deg/time^2` acceleration and
  `260 deg/time` velocity caps, produced `541.7` RMS moment, and actively swam
  `13.30L` downward into a boundary exit after only `50.13` release-time units.
  Successors should combine directional feedback with a slower nominal gait
  whose `omega^2 * amplitude` and expected joint speed fit inside the envelope;
  falsify that prescription if reduced saturation also destroys propulsion or
  sustained distance closure.
- A `0.75`-period, `22 deg` energy-regulated oscillator with posterior phase
  lag and a `28 rad/time^2` guard is the demonstrated propulsion anchor, but
  its static bearing response has an interior same-snapshot optimum rather
  than a monotone "more steering is better" trend. With the same `10 deg`
  limit and otherwise identical policy, gains `0.70`, `0.75`, and `0.82` all
  captured in `91.61`, `74.23`, and `83.83` release units with mean distances
  `2.834L`, `2.561L`, and `2.668L`; the middle gain also had the lowest RMS
  force/moment at `22.39/393.08`, versus `38.81/550.75` and `36.11/515.17`.
  An `0.80/11 deg` package was slower (`87.63`, `2.760L`) and much more loaded
  (`52.88/687.45`), although its simultaneous limit change prevents assigning
  that regression to gain alone. Preserve the gait and `10 deg` envelope and
  refine gain only inside the demonstrated `0.70--0.82` bracket; distrust
  extrapolation to a larger bend limit. This narrow optimum is established
  only for the common wake snapshot and is falsified if held-out wake phase or
  inflow moves the capture/load optimum, or if a fine interpolation regresses
  from the directly evaluated `0.75` anchor.
- Do not add the sampled positive bearing-window-rate lead to the successful
  `0.55/8 deg` controller: a bounded `0.10`-horizon, `0.45 rad/time` rate term
  was the only policy change, yet target capture became a downstream-domain
  exit with `+2.200L` center displacement, `-0.1240` progress, and
  `13.964L` final distance. Joint amplitude and speed remained comparable to
  the bearing-only success while mean effort and loads fell, so lower actuation
  alone is not evidence of useful wake propulsion. Avoid this rate lead at the
  tested scale/sign; retest derivative steering only after its phase relation
  is isolated, and require sustained negative-x motion and distance closure.
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
