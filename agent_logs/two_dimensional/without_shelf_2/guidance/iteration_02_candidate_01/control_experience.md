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
- The target-blind `0.55`-period seed is already an over-actuated failure, not a
  weak-drive baseline: it hit both `260 deg/time` velocity and `1800
  deg/time^2` acceleration caps, produced RMS lateral force/moment
  `21.94/541.70`, and exited the lower boundary after `50.13` time units with
  head displacement `(-3.55,-13.30)L`; mean velocity also stayed close to
  local flow, while distance improved only transiently (`8.61L` minimum,
  `12.12L` final). Do not increase target-blind oscillator strength on this
  failure topology. First test bounded target-bearing/turn feedback with less
  clipping, and reject that mechanism if it does not reduce lateral versus
  streamwise displacement and convert the transient minimum into sustained
  distance progress.
- Slowing the gait is not sufficient by itself: three target-aware
  `1.0--1.1`-period, `12--24 deg` variants all exited the downstream boundary
  after only `16.27--16.73` released time units, with x displacement
  `+2.18--+2.36L`, negative progress, and mean fish-flow x separation only
  `0.016--0.023`, despite low mean command energy `0.218--1.513`. Each also
  used positive curvature for positive bearing, contrary to the exposed
  head-to-tail convention. The inherited opposite-sign variant cannot prove
  the correction because its unbounded action became unstable after `1.009`
  time units with RMS force/moment about `94643/1296292`. Avoid choosing
  between passive under-drive and unbounded bearing steering: test an
  intermediate energy-regulated gait with a smooth action bound and negative
  curvature for positive bearing. Falsify it if it still exits downstream
  before developing flow-relative upstream motion, or if bounded action still
  produces unstable loads.
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
