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
- Bearing feedback alone is not a sufficient architecture label: with the same
  `0.55`-period, `28 deg` state-feedback oscillator and posterior lag, two
  bounded mean-curvature variants reached the target in `39.737` and
  `42.856` release-time units, while the assigned parent's full `10 deg`
  anterior equilibrium plus `5 deg` posterior share exited downstream after
  `18.683` units with negative progress. The successful variants limited the
  anterior mean equilibrium to `5.4 deg` through a `45/55` partition of one
  total-curvature budget, or to `8 deg` with a smaller direct anterior cap.
  For this gait family, prefer an explicitly owned and bounded curvature budget
  whose joint allocation limits anterior static bend; do not infer that a
  larger full anterior bias means stronger useful steering. This comparison
  does not isolate a universal threshold and is falsified by a different gait
  or wake condition that preserves capture with larger anterior bias. Both
  successes still hit the joint velocity and acceleration envelopes, so they
  establish navigation topology, not actuator efficiency.
- Treat exact repeats under the certified prewarm snapshot as a regression
  anchor, not independent robustness evidence. Four current samples reproduce
  the same released keyframe sheet, `39.737`-unit capture, `1.934L` distance
  integral, `1278.79` mean command energy, and joint velocity/acceleration
  envelopes; their only metric difference is wall time. In contrast, the
  inherited global gait relief to `0.9` period and `20 deg` amplitude cut mean
  command energy to `17.02` but moved the head downstream, never beat the
  `12.424L` starting distance, and exited after `16.984` units. Preserve the
  repeated total-curvature navigation scaffold when testing propulsion or
  effort mechanisms, and require earlier capture or a lower distance integral
  without greater saturation/load residence. This implication is falsified by
  a globally weaker gait that retains capture, or by repeats across changed
  wake phase and target geometry that demonstrate robustness rather than
  same-snapshot determinism.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
