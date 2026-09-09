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
- Do not retain the target-blind `0.55`-period seed unchanged in this wake: its
  nominal `28 deg` harmonic command exceeds both velocity and acceleration
  envelopes, and the sampled rollout saturated both accelerations while moving
  `-13.30L` laterally versus only `-3.55L` upstream before a lower-domain exit.
  Preserve the useful upstream component, but test target-relative bounded
  steering together with a period whose nominal command fits the hard caps.
  This implication is falsified if desaturation removes upstream progress or
  the same steering sign increases bearing/lateral escape; later workers should
  then isolate gait period from steering sign rather than increasing either
  gain blindly.
- Treat the `0.90`-period, `28 deg`, positive posterior-only bearing controller
  as the finite propulsion anchor, but not as solved steering: it self-propelled
  upstream against near-zero mean local x-flow, survived `73.39` release units,
  and reached `6.34L`, then made a broad upper loop while the posterior joint
  and both rates/commands saturated. Additive `bearing_window_rate` repairs do
  not yet survive the evidence. A subtracted-rate sample still hit the same
  limits, exited sooner at `53.53`, and reached only `7.90L`; a small look-ahead
  combined with a weaker drive reached only `9.31L` and raised RMS force/moment
  to `388/5262`; an inherited `0.35` look-ahead moved `2.24L` downstream and
  exited after `22.61`. Preserve the anchor gait and do not let rate feedback
  reinforce or reverse the geometric steering request. Test rate only as a
  bounded, sign-preserving brake while bearing is closing, or isolate a lower
  static posterior bias. This implication is falsified if such braking loses
  upstream displacement before the first bearing crossing; then remove rate
  feedback and vary only static bias rather than weakening propulsion again.
