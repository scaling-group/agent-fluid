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
- Across the seed and four first-generation feedback results, the only policy
  with meaningful positive progress used positive body-frame bearing curvature:
  it moved `-3.59L` upstream and reached `9.01L` minimum range, versus downward
  or downstream exits for three negative-curvature variants. That useful
  direction was not a viable controller by itself: it hit both acceleration
  caps and failed as unstable dynamics after `33.06` time with `20023.6` RMS
  lateral force and `314391` RMS moment. A negative-curvature phase-radius
  variant independently showed that a slower regulated gait can stay below the
  action caps with low loads, although it swam downstream and exited. Preserve
  the empirically useful curvature direction while testing regulation and a
  lower actuation envelope; avoid either sign reversal or merely strengthening
  the target-blind gait. This is a coupled-policy comparison, not an isolated
  sign or regulator experiment: falsify the implication unless their combination
  sustains negative relative-flow x, adds target-directed lateral travel, remains
  finite past the seed's `50.13` time, and reduces cap contact and load spikes.
- Two later phase-radius-regulated, positive-bearing follow-ups show that low
  loads alone are not evidence of a useful gait. The `0.82`-period, `21 deg`
  policy with a `tanh` acceleration limiter moved `(+2.24,-2.79)L`, never beat
  its initial `12.42L` range, and exited after `24.94` time; the unbounded but
  slower `0.90`-period, `18 deg` policy moved `(+2.27,-4.79)L` and exited after
  `42.07` time. Both kept RMS force/moment near `20`/`380`, but the latter's
  mean x velocity `0.0523` nearly matched local-flow x `0.0540`, confirming an
  advection-dominated trajectory. Preserve phase-radius regulation only while
  restoring enough nominal gait authority to produce upstream velocity relative
  to local flow; falsify that combination if stronger commands merely renew cap
  contact/folding or if final and minimum range still do not improve. Do not
  treat a finite, low-load domain exit as progress.
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
