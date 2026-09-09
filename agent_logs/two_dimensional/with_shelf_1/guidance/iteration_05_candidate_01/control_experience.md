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
- Direct bounded bearing feedback has now separated navigation from the seed's
  propulsion failure topology: adding a positive `tanh(bearing/scale)`
  acceleration residual to both joints (with a smaller posterior share) kept
  the posterior-lag carrier, moved the head `(-10.92,-4.15)L`, and reached the
  `0.75L` target boundary in `62.30` time with mean distance `2.46L`. The
  target-blind seed instead moved `(-3.55,-13.30)L` and exited after `50.13`,
  while an opposite-sign centered-curvature interpretation moved right
  (`+2.75L` in x), made negative progress, and exited after `13.92`. Thus infer
  the bearing-to-actuator sign from comparative rollouts, not a guessed body
  axis convention, and prefer a bounded acceleration residual over scalar gait
  tuning for this wrong-heading topology. This lesson establishes directional
  authority, not effort or phase robustness: the successful run touched joint
  speed/acceleration limits, so falsify or refine it if later phases lose
  capture, sustain saturation, or reproduce either exit trajectory.
- After the correct-sign residual and fixed `0.20` steering reservation had
  established a deterministic `49.142`-time capture baseline, two sampled
  structural refinements exposed a route/load tradeoff. Subtracting `0.10`
  times normalized body-frame lateral course from bearing shortened arrival
  to `48.032` and lowered RMS force/moment from `39.05/617.13` to
  `37.92/605.38`, although mean command energy rose from `1272.3` to `1299.7`.
  Scheduling extra reservation from large absolute bearing instead shortened
  arrival to `46.035`, lowered mean distance to `2.0695L` and total/mean
  energy to `56948/1237.1`, but raised RMS force/moment to `51.40/761.46` and
  joint excursions. Thus, once capture and steering sign are secure, prefer a
  bounded response-conditioned redirect that releases high-error authority as
  measured targetward course develops; do not add uncalibrated force or
  crossflow cancellation from these aggregate RMS values. This implication is
  limited to the shared wake phase and maxima do not reveal saturation duty
  cycle; falsify it if a combined controller loses capture, exceeds the
  fixed-reserve arrival, or retains the bearing-only load increase.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
