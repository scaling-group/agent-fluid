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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- Body-frame bearing feedback is effective when it requests one bounded total
  curvature shared coherently across the two joint attractors, rather than a
  full anterior offset with an extra tail share. Two sampled shared-curvature
  policies preserved the `0.55`-period, `28 deg` traveling-bend scaffold and
  reached the `0.75L` target in `39.737` and `42.856` released time units, with
  `1.934L` and `2.119L` mean distance. In contrast, the inherited full-anterior
  bias prefill produced only `0.249/0.191 rad` peak joint excursions, moved
  `2.195L` in the wrong streamwise direction, and exited after `18.683` time
  units. Reuse the successful structure as a total curvature budget with a
  roughly balanced, slightly posterior-weighted split; falsify it under changed
  wake phase or target geometry if turn sign, propulsion, or capture is lost.
- Do not weaken the propulsive rhythm merely to create nominal actuator
  headroom before preserving reachability. An inherited candidate that changed
  the seed from `0.55/28 deg` to `0.9/20 deg` reduced mean command energy from
  the successful policies' `1176--1279` range to `17.02`, but it moved
  `(+2.185,-0.917)L`, made no meaningful approach (`12.424L` minimum distance),
  and exited after `16.984` time units. Later workers should first retain the
  evidenced traveling bend and change one steering or disturbance mechanism;
  revisit gait relief only if it preserves upstream propulsion while reducing
  saturation/load on a still-successful trajectory.
- Count equation-level diversity, not artifact count. Three current samples
  are deterministic replays of the filtered `40/60` shared-curvature policy:
  each captures at `35.6895`, with `1.7619L` mean distance, `50,871` total
  command energy, `59.28` force RMS, and `821.23` moment RMS. The distinct
  sample smoothly shifts the same bounded curvature budget from `40/60` toward
  `35/65` as persistent body-frame bearing grows; it preserves the compact
  direct-capture topology while improving arrival to `35.0625`, mean distance
  to `1.7339L`, total command energy to `50,175`, force RMS to `56.57`, and
  moment RMS to `793.76`. Reuse small bearing-conditioned posterior
  redistribution when filtered shared-curvature steering already propels and
  captures but the initial redirect remains large. This does not create
  actuator headroom: both joints still touch velocity and acceleration limits,
  while mean command energy and power rise slightly. Falsify the mechanism if
  changed wake phase or target geometry loses capture, reverses the direct
  trajectory, or removes the navigation/load advantage.
- Apply half-cycle steering to the propulsive posterior wave, not to the
  anterior/posterior split of the mean-curvature budget. From the same filtered
  bearing and `40/60 -> 35/65` scheduled-curvature parent, a bearing-gated `8%`
  gain on only the target-helping posterior wave half-cycle preserved direct
  capture while improving arrival from `35.0625` to `32.4720`, mean distance
  from `1.73388L` to `1.64761L`, and total command energy from `50,175` to
  `46,288`. A distinct half-cycle modulation of curvature allocation instead
  regressed to `35.4310`, `1.75151L`, and `50,815`, despite lower force and
  moment RMS. The useful posterior-wave mechanism raises force and moment RMS
  by `21.4%` and `17.4%` over its parent and both joints still touch velocity
  and acceleration limits, so treat it as a faster-navigation tradeoff rather
  than actuator relief or proven efficiency. Retain slow bearing for bounded
  mean turn and joint-state phase for sign-symmetric wave asymmetry; do not
  reintroduce the inherited route-rate path that collapsed propulsion. Falsify
  this lesson if held-out wake phase or target geometry loses the direct
  topology, if the arrival advantage disappears, or if the higher loads cause
  instability.
