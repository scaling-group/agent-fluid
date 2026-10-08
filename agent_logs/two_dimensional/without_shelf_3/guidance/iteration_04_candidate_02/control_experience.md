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
- In the sampled seed rollout, the 0.55-period, 28-degree oscillator reached
  both joint-acceleration caps while the fish moved -13.30 L laterally but only
  -3.55 L upstream and exited the lower domain after 50.13 time units; its
  8.61 L minimum distance and 0.024 progress show that self-propulsion alone
  was not directional control. Do not continue this target-blind, cap-demanding
  gait by propulsion-only retuning: test bounded body-frame target steering and
  keep nominal gait demands inside the actuator envelope. This is a negative
  boundary from one initial-condition rollout, not evidence that any particular
  steering gain or slower frequency succeeds; falsify the proposed remedy using
  target-distance progress, x/y trajectory topology, termination, and measured
  saturation together.
- Positive bearing curvature with the angle-only oscillator is the only sampled
  combination that produced active upstream motion: the 0.75-period policy
  moved -3.59 L in x and reached 0.259 progress, but folded at 33.06 time units
  with both acceleration caps touched and extreme force/moment loads. Merely
  adding safety is insufficient: its guarded 0.80-period descendant stayed
  finite for 63.55 units and below the action caps, yet curled back on itself,
  finished at (+0.43,+1.80) L displacement, and regressed to -0.090 progress.
  Meanwhile the inherited phase-radius and weakened angle-only/yaw-damped
  variants exited downstream with no range gain. Preserve the active angle-only
  gait when testing course-loop suppression, grade rather than persistently
  saturate bearing curvature, and judge the result by relative streamwise
  motion plus loop topology as well as stability. This implication is
  falsified if a matched graded-curvature change still loops or removes the
  upstream component; the existing multi-change yaw-damped failures do not by
  themselves falsify yaw damping.
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
