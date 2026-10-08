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
- Treat an early, saturated lateral escape as a missing steering mechanism, not
  a request for more propulsion, but do not equate actuator headroom with
  control progress. The sampled seed beat actively yet left the lower boundary
  after `50.13` units with progress `0.024`; inherited evaluations then showed
  that three bearing-to-mean-curvature variants reduced peak acceleration from
  the `31.416 rad/time^2` cap to `7.87--15.03` but erased the initialized
  traveling bend, moved `+2.17--2.20L` downstream, and exited within
  `17.04--18.11`. For a startup-sensitive gait that must first overcome inflow,
  avoid further equilibrium-shift or scalar-drive tuning: preserve the
  zero-centered propulsive transient and introduce steering through a mechanism
  that does not recenter it. Revisit this only if a zero-centered scaffold also
  loses early upstream displacement.
- Steering authority must be evaluated at the actuators where it is composed,
  not inferred from the label "half-cycle asymmetry." Posterior-only variants
  `solver_785c44ad57e0` and `solver_ab5b90e78e2b` preserved seed-like upstream
  motion but still followed the lower-exit topology, reaching only `8.203L` and
  `9.294L` minimum distance. Applying bounded bearing-selected acceleration
  asymmetry across both joints in `solver_928f830d4c45` produced a meaningfully
  different upstream traverse: survival `91.25`, displacement `-9.73L`,
  progress `0.257`, and minimum distance `4.621L`. Preserve this distributed
  early steering mechanism when that topology is desired, but do not treat it
  as wake-robust capture: the run still exited below, reached the joint-1
  velocity cap, and raised RMS force/moment to `314/3430`. Later policies should
  test bounded trend or yaw damping before adding more static asymmetry; reject
  such damping if it sacrifices the evidenced early traverse without improving
  the late exit, closest approach, or load history.
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
