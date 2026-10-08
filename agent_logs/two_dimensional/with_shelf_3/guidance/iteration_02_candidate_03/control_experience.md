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
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- Treat active swimming with a persistent wrong-heading domain exit as a
  missing steering mechanism before treating it as weak propulsion. In the
  sampled naive seed, visible undulation and capped joint motion produced
  `(-3.545L, -13.300L)` head displacement, only `8.615L` closest approach, and
  a lower-domain exit after `50.127` released time units; increasing oscillator
  drive cannot supply the absent target feedback and risks extending the
  observed acceleration/velocity saturation. For this failure topology, hold
  the propulsive scaffold fixed and test one bounded body-frame
  target-to-curvature mechanism. This lesson does not apply when keyframes show
  weak self-motion or a correct target-directed route; falsify the proposed
  repair if it reverses the turn, collapses the traveling bend, or worsens load
  and saturation without improving target-relative motion.
- Treat target-to-mean-curvature feedback as a distribution-sensitive
  mechanism, not a sign-and-total-bend scalar. Under the common prewarm, the
  inherited full-anterior `10 deg` bias with a `5 deg` posterior share swam
  downstream/right, reached no closer than `12.424L`, and exited after
  `18.683` released units. In contrast, sampled policies limiting the anterior
  center to `8 deg` or `5.4 deg` while retaining `5.2 deg` or `6.6 deg`
  posterior bias both reached the target; the more posterior-weighted split
  arrived sooner (`39.737` versus `42.856`) and had better mean distance
  (`1.934L` versus `2.119L`), albeit with higher RMS lateral force/moment and
  the same velocity/acceleration caps. For this propulsive scaffold, preserve
  bounded total curvature and test posterior-biased or demand-scheduled
  allocation before increasing drive or front-loading anterior bias. This is
  not evidence for unbounded tail authority: falsify the implication if a
  changed wake/target condition loses capture, reverses the turn, or raises
  posterior saturation/load without an arrival or trajectory benefit.
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
