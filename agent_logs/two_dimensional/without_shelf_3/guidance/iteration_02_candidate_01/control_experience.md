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
- The sampled `0.55`-period target-blind seed saturated both joint acceleration
  (`31.4159`) and velocity (`4.53786`) while its mean fish velocity
  `(-0.0725,-0.2633)` stayed close to local flow `(-0.0414,-0.2414)`; it then
  exited downward after `50.13` with only `0.0243` progress. When hard-limit
  contact coincides with small relative-to-flow motion and cross-wake exit, do
  not increase oscillator drive as a drift repair: first fit the nominal gait
  inside the actuator envelope and test bounded body-frame target steering.
  This is a one-rollout negative result, not proof that lower-frequency gaits
  are universally better; falsify it if an unsaturated gait loses upstream
  progress or the steering sign makes bearing error grow.
- Within the sampled split-curvature oscillator family, positive body-frame
  bearing mapped to positive cumulative joint curvature is the only tested
  steering convention with sustained upstream-relative travel: it moved the
  head `(-3.593,+0.146)L` and reached `0.259` progress, whereas two negative-
  curvature variants moved downstream and/or exited downward with negative
  progress. Preserve this sign when isolating course control, but do not reuse
  the positive sample's aggressive `0.75`-period, `22 deg` position-only drive:
  it hit both acceleration caps and terminated unstable with RMS force/moment
  `20023.6/314391`. This is an early far-field topology result, not evidence of
  wake entry or capture; falsify it if a separately amplitude-regulated gait
  makes bearing error grow or loses upstream motion relative to local flow.
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
