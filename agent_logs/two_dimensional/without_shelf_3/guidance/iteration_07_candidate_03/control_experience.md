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
- The target-blind seed's early leftward motion is genuine but insufficient
  propulsion evidence: it reached `8.61L` range, then its head moved
  `-13.30L` laterally and exited after `50.13` released time while mean lateral
  velocity (`-0.263`) nearly followed local flow (`-0.241`) and both joint-rate
  caps were touched. Preserve the state-encoded gait only behind bounded
  target-relative course correction, and size nominal rhythm below the hard
  velocity/acceleration limits; do not mistake a transient minimum distance or
  visible body wave for wake rejection. This lesson applies to the far-field
  domain-exit regime; it does not establish steering sign, wake-entry quality,
  or tight-radius capture until a feedback candidate is evaluated.
- Sampled target-feedback results separate a useful steering sign from a
  useful propulsion regulator. The positive-bearing angle-only oscillator was
  the sole variant with meaningful upstream travel (`-3.59L` head x, `0.259`
  progress), but it reached both acceleration caps and failed unstable with
  RMS force/moment `20024/314391`. Two later positive-bearing policies replaced
  that drive with radial phase-energy regulation and remained finite with RMS
  force near `20--22` and moment near `377--379`, yet both almost followed
  local flow, moved about `+2.25L` downstream, never improved their initial
  range, and exited. Do not treat full-orbit radial regulation as a proven way
  to stabilize the progress-producing gait; first test bounds or guards that
  are inactive on its nominal angle-only orbit. This is coupled evidence
  because period, amplitude, and steering limit also changed, so falsify the
  implication if an angle-only gait with localized guards still loses upstream
  motion or repeats the folded-body load event.
- Derivative and compound load feedback remain unsupported before useful wake
  entry. Reversing curvature while adding turn-rate and moment feedback kept
  loads near `21/430` but moved `+2.74L` downstream and exited after `15.86`
  time; a bearing-window-rate architecture drove joint one to `0.781rad` and
  failed unstable after `1.66` time. Avoid those additions until a bounded
  bearing-only loop is finite; revisit this boundary only if a derivative-free
  candidate enters the wake corridor but then exhibits measured course-rate or
  load growth that static joint-state guards cannot arrest.
- For the guarded `0.75`-period, `22 deg`, gain-`0.60`, `12 deg` angle-only
  architecture, course response is sharply bracketed by uniform recent-turn
  damping: `0.04` produced the strongest finite upstream leg
  (`-4.08L` head x, `6.71L` minimum range) but exited upward at `+1.80L` y,
  whereas `0.05` reached a similar `6.83L` minimum before exiting far below
  and downstream at `(+0.33,-13.31)L`. Do not seek the midpoint by lowering
  the steering ceiling or activating damping through the sampled `8L` range
  gate: `10 deg` retained the upper exit while degrading head x/minimum range
  to `-1.43/9.00L`, and the gated `0.04`--`0.06` policy degraded them to
  `-2.48/8.59L`. Test interior *uniform* damping values while preserving the
  `12 deg` propulsion anchor. This implication is local to the same guarded
  far-field gait and is falsified if interior gains do not interpolate the
  lateral topology or if a later policy reaches the wake corridor, where new
  flow interaction may invalidate the far-field bracket.
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
