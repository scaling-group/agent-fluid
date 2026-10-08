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
- An anterior or two-joint target-to-mean-curvature equilibrium is a concrete
  negative result for this near-downstream-boundary release. Four completed
  variants spanning periods `0.55--0.90`, amplitudes `15--28 deg`, split versus
  anterior bias, and optional soft acceleration limiting all reduced effort
  and cap contact, but each was advected about `+2.2L` to the downstream margin
  within `16.73--18.11` time units without beating its initial `12.42L` target
  distance. By contrast, the saturated target-blind seed produced a visible
  traveling wake and `-3.55L` upstream displacement before its separate
  lower-boundary steering failure. Do not keep tuning curvature magnitude or
  gait scalars around that recentered architecture; first preserve the
  anterior propulsive transient and test target steering through posterior
  half-cycle/duty asymmetry or another mechanism that does not weaken initial
  restoring acceleration. This lesson is falsified if an equilibrium-shift
  policy restores negative-x motion before the downstream margin and improves
  distance history without returning to cap-dominated loads.
- Half-cycle steering is sensitive to where asymmetry enters, not merely its
  sign or scalar strength. Two posterior-target multiplicative variants kept
  the seed's lower-exit topology: only `-4.24L` to `-4.56L` upstream motion,
  `8.20--9.29L` closest approach, exit by `52.54--54.90`, and mean command
  energy `1493--1504`, with both joint rates and accelerations at their hard
  caps. A distributed acceleration-level variant instead preserved the
  zero-centered traveling bend and improved upstream motion to `-9.73L`,
  closest/mean distance to `4.62L`/`9.14L`, survival to `91.24`, and mean
  command energy to `853`. Its benefit is provisional because it still exited
  low after reaching `0.73` rad anterior bend and raised force/moment RMS from
  about `22/535` to `314/3430`. Preserve this distributed propulsive scaffold,
  but add bounded observed-turn or load response before increasing asymmetry or
  repeating posterior sign/gain swaps. This implication is falsified if such
  response feedback cannot retain the upstream/closest-approach gains while
  reducing the downward arc and load symptoms; then test a separately scaled
  wake-disturbance residual or a different steering primitive.
- Magnitude-gating a distributed half-cycle steering residual with normalized
  yaw moment is positive evidence for separating route demand from wake-supplied
  turning. Two otherwise matched response-damped policies isolate the gate:
  without it, the fish visibly passed below the target, reached only `1.65L`,
  and exited laterally at `75.09` with force/moment RMS `487/4680`; with a
  smooth gate and nonzero steering floor, it followed a direct diagonal,
  reached the `0.75L` target at `51.47`, improved mean distance to `1.82L`, and
  lowered RMS loads to `426/4085`. The assigned posterior-curvature parent also
  missed at `2.43L` and exited laterally, consistent with inherited warnings
  that mean bias does not solve this topology. Preserve the zero-centered
  traveling bend and attenuate only the target-steering residual when absolute
  body-frame yaw load is large; do not interpret the gate as cancelling wake
  motion or as general load protection. This lesson is falsified if it loses
  capture or upstream displacement under a changed wake phase, or if peak-load
  and saturation histories remain worse than the ungated controller despite
  lower rollout RMS.
- Three independently materialized copies of that gated controller reproduce
  the same target crossing at `51.47`, `1.82L` mean distance, `-11.28/-4.94L`
  displacement, and `426/4085` force/moment RMS under the certified prewarm
  snapshot. This strengthens same-initial-condition reproducibility but adds no
  evidence about changed wake phase and does not show that directly injecting
  the steering residual into both joints is necessary: the posterior target
  already inherits anterior steering through its lagged state target. After
  exact duplicate successes, prefer a structural actuator-allocation test that
  preserves anterior target response and yaw gating while isolating posterior
  traveling-wave propulsion; do not count more duplicate rollouts or scalar
  gate retuning as a new control lesson. The allocation implication is
  falsified if removing direct posterior steering loses capture, degrades the
  `51.47`/`1.82L` arrival baseline, or returns the broad lateral-exit topology;
  claims of load relief additionally require improved peak/cap histories, not
  merely lower rollout RMS.
