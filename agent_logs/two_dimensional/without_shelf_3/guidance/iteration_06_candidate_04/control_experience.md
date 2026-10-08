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
- Recent-turn-rate feedback has a narrow, architecture-specific useful range
  once the progress-producing angle-only gait is guarded. On an otherwise
  identical `0.75`-period, `22 deg`, gain-`0.60`/limit-`12 deg` controller,
  uniform opposing gain `0.04` retained active upstream motion (`-4.08L` head
  x versus `-2.99L` from mean local flow), reached `6.71L`, and remained finite
  at RMS force/moment `66.5/958`, but made an upper U-turn; gain `0.06` reached
  `5.41L` before overcorrecting to a `(+2.62,-7.92)L` downstream/lower exit.
  Reducing bearing gain to `0.45` or smoothly raising damping toward `0.06`
  below `8L` regressed minimum range to `9.90L`/`8.59L` while retaining about
  `+1.8L` upward displacement. For this far-field regime, keep the gait and
  guards fixed and test only unscheduled interpolation strictly inside the
  `0.04--0.06` bracket; avoid bearing-gain reduction and range gating until an
  interpolation removes both U-turns. This does not rehabilitate compound
  turn-rate/moment or bearing-window-rate laws, whose sampled results were
  downstream or immediately unstable, and it does not establish wake-entry
  control. Falsify the bracket if an interior gain loses active relative-
  upstream motion or repeats either boundary exit.
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
