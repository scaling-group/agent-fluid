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
- The sampled siblings now validate one narrow steering translation: adding a
  bounded, same-sign body-frame bearing residual directly to the seed's
  `0.55`-period acceleration carrier reached `0.7496L` after `62.304` time
  units with head displacement `(-10.922,-4.153)L`. The target-blind seed
  instead exited downward after `50.127`; an opposite-signed curvature-center
  translation exited after `13.915` with negative progress; and a wholesale
  slower/smaller curvature-center carrier became unstable after `121.517`
  with RMS force/moment `16749.8/290421`. Preserve the successful carrier,
  steering sign, and acceleration-residual interface before testing a new
  mechanism; avoid interpreting slower scalar gait settings or an abstract
  curvature bias as interchangeable with the validated residual. This lesson
  is bounded to the shared prewarm case and is falsified if a later wake phase
  loses target reach with the same residual topology.
- A clean same-prewarm comparison validates steering-prioritized saturation
  allocation for this clipped carrier: reserving `0.20` of the same bearing
  residual and fitting the rest of carrier plus residual inside a `30.0`
  envelope preserved target reach while reducing arrival from `62.304` to
  `49.142`, mean distance from `2.4600L` to `2.1560L`, and command-energy mean
  from `1436.3` to `1272.3`. Interpret this as bounded half-cycle directional
  authority, not as evidence for scalar drive reduction: the slower/smaller
  carrier failed unstably. The benefit trades against RMS force/moment rising
  from `27.25/525.8` to `39.05/617.1`, and joint speed still touched its cap;
  compact maxima do not establish saturation duty cycle. Reuse this allocation
  only while success, earlier alignment, and effort gains repay the load rise,
  and falsify it if another wake phase loses target reach or retains higher
  loads without the arrival/distance benefit.
- Parallel same-parent samples separate two useful feedback roles without
  supporting another carrier retune. Adding a normalized body-velocity
  course-slip residual to the fixed-reserve controller shortened arrival from
  `49.142` to `48.032`, improved mean distance from `2.1560L` to `2.1003L`,
  and slightly lowered RMS force/moment from `39.05/617.1` to `37.92/605.4`;
  making reserve authority grow continuously with bearing error instead reached
  in `46.035`, improved mean distance to `2.0695L`, and lowered total/mean
  command energy to `56.9k/1237.1`, but raised RMS force/moment to
  `51.40/761.5`. The keyframes show both retain the parent's coherent left/down
  traversal, and all three still touch acceleration and joint-speed maxima.
  Treat measured course and error-scheduled authority as distinct compatible
  mechanisms: if combined, schedule extra authority from the slip-corrected
  route error so useful lateral motion can release it. The components are
  validated independently, not jointly; falsify the combination if capture or
  arrival regresses, or if the scheduled branch's load rise survives without a
  progress or effort benefit. Do not infer saturation duty cycle from maxima.
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
