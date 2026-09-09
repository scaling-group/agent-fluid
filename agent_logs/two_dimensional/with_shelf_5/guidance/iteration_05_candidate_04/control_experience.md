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
- In the common seed failure, the fish left the lower boundary after only
  `50.127` released time with head displacement `(-3.545,-13.300)L`, while
  mean velocity differed from mean local flow by only about `0.038U` and both
  joint velocity and acceleration limits were reached. Large world displacement
  is therefore not evidence of useful propulsion when local-flow advection
  explains most of it. For a target-blind, advection-dominated failure with no
  visible recovery turn, test bounded body-frame target-bearing mean curvature
  before increasing drive or adding an uncalibrated wake residual; this lesson
  does not apply once target-directed turning is visible, and is falsified for
  this controller family if the added bias leaves the turn sign and
  lower-boundary trajectory topology unchanged.
- Once the bounded `8 deg` bearing-to-mean-curvature carrier reaches the
  `0.75L` target in about `93.03` time, do not infer a useful terminal mechanism
  from tiny scalar deltas. An amplitude taper, lateral-miss steering blend, and
  bearing-rate lead confined inside `2.5L` all retained essentially the same
  route, arrival, `972.3--972.5` mean command effort, and `95.5/1147` RMS
  lateral force/moment. Direct soft acceleration relief was worse: it stopped
  at `0.803L`, became unstable near the former capture time, and increased RMS
  force/moment to about `16457/157725`. For this cap-dominated first-crossing
  regime, preserve terminal restorative authority and test a distinct
  actuator-distribution or feedback mechanism upstream rather than another
  terminal scalar schedule. This boundary is falsified if time-resolved
  evidence identifies terminal oversteer or a localized mechanism materially
  lowers arrival, effort, or load while retaining capture and the far route.
- Posterior steering distribution can escape that terminal-scalar plateau. A
  target-favored, joint-state-gated posterior half-cycle boost changed the
  released topology from the `~93.03` policies' broad triangular redirect to a
  sharp initial hook followed by a nearly direct upstream traverse, reaching
  in `43.9505` with mean distance `2.139L` instead of about `4.031L`. Relative
  streamwise motion (`0.1129U`) confirms self-propulsion. Total command energy
  fell from about `9.05e4` to `5.31e4`, and RMS lateral force/moment fell from
  about `95.5/1147` to `49.4/701`, despite higher mean command/power and the
  same joint-rate/acceleration caps. Preserve this phase-gated asymmetry before
  retuning the carrier or static curvature; test response-conditioned release
  or another bounded redistribution if the visible initial hook, cap contact,
  or mean effort is the next limitation. This lesson currently applies only
  to the common certified wake realization and first-crossing objective, and
  is falsified as a robust primitive if later wake phases lose capture or if
  relieving asymmetry restores the slow topology without reducing overshoot,
  effort, or loads.
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
