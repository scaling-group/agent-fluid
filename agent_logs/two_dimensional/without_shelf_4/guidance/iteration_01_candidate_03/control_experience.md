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
- The sampled seed failure isolates missing target-relative yaw authority
  before it motivates more propulsion: the `0.55`-period, `28 deg` oscillator
  reached both `260 deg/time` joint-rate and `1800 deg/time^2` acceleration
  caps, yet its release ended at the lower boundary after `50.13` with head
  displacement `(-3.55,-13.30)L`, progress `0.024`, and a visibly tight active
  body wave. In this early lateral-exit regime, test a bounded body-frame
  bearing/turn-rate bias and a sub-cap gait before increasing frequency or
  amplitude. This result does not identify the correct feedback gain or prove
  wake-phase control; falsify the implication if bounded steering worsens the
  target-bearing trend or if a less saturated gait loses the seed's upstream
  displacement without buying materially longer survival.
- Aggregate wake severity alone is not an action calibration. The same failure
  reports RMS relative crossflow `0.175`, force `21.94`, and moment `541.70`,
  but supplies no time-aligned response contrast showing which sign of local
  flow feedback would help. Avoid adding wake-phase gains from those RMS values
  while gross heading error dominates; test them only after target-relative
  steering produces stable wake entry, or when sampled trajectories provide a
  sign-consistent flow/force-to-heading relation.
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
