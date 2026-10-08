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
- Sampled target-feedback results narrow that far-field steering lesson.
  Positive bearing curvature with the `0.75`-period angle-only oscillator was
  the sole variant to retain active upstream travel (`-3.59L` head x and
  `0.259` progress), but it hit both acceleration caps and failed folded-body
  unstable with RMS force/moment `20024/314391`. Two slower radial-phase
  variants stayed finite and low-load yet moved about `+2.2L` downstream with
  mean x velocity nearly equal to local flow, so continuously replacing the
  angle-only drive with the sampled radial regulator is negative propulsion
  evidence, not a stability solution. Preserve the demonstrated rhythm when
  isolating steering changes, and falsify it if negative head-x displacement
  and relative-flow x do not survive below the hard caps.
- Policy-owned guards remain an actuation envelope, not navigation: the guarded
  `0.80`-period bearing loop stayed finite for `63.55` time but flowed
  downstream through a broad off-wake turn. Restoring the demonstrated
  `0.75`-period angle-only gait and adding `0.04` opposing heading-rate feedback
  produced the strongest finite sample (`-4.08L` head x, `6.71L` minimum range,
  `65.47` time) below the acceleration caps and with RMS force/moment only
  `66.5/958`. The keyframes nevertheless show another broad upward reversal
  and exit at `+1.80L` head y, so small yaw damping is compatible with active
  propulsion but is not yet course convergence. Keep the gait/protection bundle
  fixed when varying yaw damping, and reject a change if upstream displacement
  or the finite load envelope is lost, or if the upper loop persists. Because
  period restoration and the `0.04` term entered together, attribute neither
  the gain nor the improvement to derivative feedback alone until a one-factor
  continuation reduces lateral overshoot. This boundary applies before wake
  entry; it does not establish wake exploitation or tight-radius capture.
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
