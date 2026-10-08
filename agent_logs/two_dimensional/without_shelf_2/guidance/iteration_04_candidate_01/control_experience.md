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
- With the successful `0.75`-period, `22 deg` energy-regulated gait fixed,
  increasing bounded positive-bearing steering from gain/limit `0.55/8 deg`
  to `0.70/10 deg` shortened capture from `130.23` to `91.61` release units,
  reduced mean distance from `3.516L` to `2.834L` and maximum lateral offset
  from `5.425L` to `4.297L`, and increased mean upstream-relative x speed from
  `0.0380` to `0.0515`. Treat `0.70/10 deg` as the current finite steering
  anchor, not a license to increase gain indefinitely: RMS force/moment rose
  from `26.34/427.54` to `38.81/550.75`, anterior angle reached `0.550 rad`,
  and both actions still touched the `28 rad/time^2` guard. A bounded
  `0.10`-horizon bearing-rate lead on the weaker pair is a concrete negative
  result—it exited right with `-0.1240` progress and `13.964L` final distance—
  so avoid derivative lead until its sign and scale are isolated at comparable
  steering authority. Falsify this lesson if the finite anchor loses capture
  on held-out wake phase/geometry or a lower-load rate term improves closure
  without domain exit or hard-limit contact.
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
