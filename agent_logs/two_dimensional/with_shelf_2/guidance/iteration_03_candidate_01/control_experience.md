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
- Do not recenter the anterior oscillator on a target-bearing mean-curvature
  equilibrium in this initialized gait. Across the inherited completed
  implementations, doing so reduced cap occupancy but erased the startup
  traveling bend: the fish was carried about `+2.17--2.20L` downstream and
  exited after only `17--18` release-time units without improving on its
  initial `12.424L` distance. Revisit mean curvature only if it is applied
  without subtracting the zero-centered propulsive transient; otherwise test
  a different steering primitive rather than another equilibrium gain.
- Posterior-only bearing-selected half-cycle modulation is also a poor
  route-level steering axis for this failure. The assigned negative-sign
  parent and a milder opposite-sign sibling both restored seed-like upstream
  motion but still fell `13.29--13.37L`, exited the lower boundary by
  `52.54--54.90`, and hit both joint rate and acceleration caps. Avoid further
  posterior sign/gain tuning unless a new feedback signal changes that
  topology. In contrast, distributing bearing-selected acceleration
  asymmetry to the anterior oscillator produced a genuinely different
  `91.24`-unit upstream approach (`-9.73L` x displacement, `4.62L` closest
  distance, command-energy mean `853` versus the seed's `1496`), so preserve
  that propulsive leg when testing trajectory-error trend or yaw/slip
  damping. This positive implication is bounded by the same rollout's
  `-13.31L` downward exit and moment RMS `3430`: reject added feedback if it
  does not reduce the cross-track miss or if the extreme load persists
  without a meaningfully closer approach.
