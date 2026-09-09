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
- On the successful `0.55`-period, `28 deg` carrier, phase-gated posterior
  steering is the first sampled actuator-distribution change associated with a
  materially different useful trajectory. The sample that preserved
  cycle-average tail bias but concentrated the removed share on the
  target-favored half-cycle reached in `43.9505` time, versus `92.99--93.03`
  for the assigned bearing-rate parent, a terminal amplitude taper, and
  anterior half-cycle timing. Its keyframes show a direct early diagonal rather
  than the common broad dogleg; mean distance fell from about `4.03L` to
  `2.14L`, total command energy from about `9.05e4` to `5.31e4`, and RMS
  lateral force/moment from about `95.5/1147` to `49.4/701`, although mean
  command effort rose and rate/acceleration caps remained active. This follows
  inherited logs in which global carrier/bias changes exited in under `18`
  time and successive terminal schedules stayed near the `93`-time topology.
  The subsequent clean no-taper ablation also reached in exactly `43.9505`
  with mean distance `2.141L`, total command energy `5.308e4`, and RMS
  force/moment `49.45/701.31`, all effectively unchanged from the tapered fast
  sample. This causally sharpens the reusable implication: retain state-phase
  redistribution of an already successful mean turn, but remove range-only
  amplitude tapering and stop tuning terminal scalar schedules on this route.
  The implication applies while target bearing has the correct sign and the
  traveling-bend carrier remains intact. It does not claim saturation relief:
  both fast variants still hit the rate and acceleration caps. Test a distinct
  actuator-distribution or large-error redirect mechanism next, and falsify
  this lesson if a future no-taper replay loses capture or returns to the
  roughly `93`-time dogleg under the same initial condition.
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
