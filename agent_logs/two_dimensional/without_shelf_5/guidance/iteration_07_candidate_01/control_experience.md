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
- In this shared-prewarm task, preserve the vigorous seed gait and the smooth
  positive body-frame bearing center while changing one bounded axis at a time.
  That mechanism converted the target-blind seed's lower-boundary exit at
  `50.127` and final distance `12.123L` into capture; gain `1.5` reached at
  `41.316` with mean distance `1.919L`, while four identical gain-`1.7`
  samples reached at `39.710` with mean distance `1.874L`, total command energy
  `54703.2`, relative-crossflow RMS `0.2265`, and force/moment RMS
  `38.40/618.59`. Do not extrapolate or interpolate this trend: otherwise
  identical gains `1.725` and `1.9` still captured along visibly similar paths
  but regressed to arrivals `40.832/40.034`, mean distances `1.915/1.901L`,
  energy `56614.5/54954.5`, crossflow RMS `0.2364/0.2329`, and force/moment RMS
  `42.50/674.61` and `41.31/657.28`; their joint excursions also increased
  while all gains touched the same rate and acceleration caps. Therefore retain
  exact gain `1.7` as the measured recovery anchor and avoid further tiny gain
  fits until it is repeated under a changed wake phase or start pose. This is a
  local boundary, not a universal optimum: falsify the anchor on loss of
  capture or material failure to reproduce its arrival, distance, crossflow,
  and load envelope. Slower policies that also changed steering distribution
  or added velocity/moment feedback exited or became unstable, so those
  mechanisms require separately scaled tests rather than combination here.
- Exact repeats under the certified shared snapshot establish deterministic
  materialization, not robustness to a changed wake phase or start pose. The
  four gain-`1.7` samples reproduce not only capture metrics but the same
  `0.507/0.528`-rad anterior/posterior peak-angle imbalance; the gain-`1.725`
  and `1.9` regressions increase both peaks to `0.526/0.556` and
  `0.523/0.548` rad while also increasing crossflow and force/moment loads,
  despite unchanged outer steering and identical rate/acceleration caps. Thus
  do not amplify the bearing gain to address joint loading. A separately
  scaled redistribution of the existing positive bounded steering center is a
  defensible next axis because it can preserve the total quasi-static steering
  command and propulsion; accept that mechanism only if it preserves capture
  and the `39.710/1.874L` arrival/mean-distance envelope while reducing the
  posterior excursion without increasing crossflow, effort, or loads. Restore
  the `0.40` distribution if that boundary fails; the prior mixed-feedback
  instability does not by itself falsify a small distribution-only test.
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
