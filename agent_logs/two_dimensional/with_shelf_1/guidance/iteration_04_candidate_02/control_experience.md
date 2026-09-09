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
- A sampled steering-prioritized allocator materially improved the assigned
  raw residual parent without changing its carrier, steering sign, or route
  contract: both reached `0.75L`, while reserving `20%` of steering inside a
  `30.0` acceleration envelope reduced arrival from `62.304` to `49.142`, mean
  distance from `2.4600L` to `2.1560L`, total command energy from `89487` to
  `62522`, and mean command energy from `1436.3` to `1272.3`. Preserve this
  carrier/residual allocation as the current evidence-backed base, but do not
  claim full saturation relief: both successes still touched the joint-speed
  limit, maximum lateral target offset remained `4.293L`, and allocator RMS
  force/moment rose from `27.25/525.79` to `39.05/617.13`. Falsify its reuse if
  another wake phase loses target reach or the extra loads grow without the
  arrival and effort benefits.
- Repeated materialization is a reproducibility check, not a new controller
  result: the assigned parent and three sampled siblings with the same
  steering-reserve policy all reached at `49.142` with mean distance `2.1560L`,
  command-energy mean `1272.3`, RMS crossflow `0.230`, and RMS force/moment
  `39.05/617.13`.  After such a fixed-seed plateau, do not spend another
  iteration on comment-only rematerialization or use repetition to claim
  wake-phase robustness; preserve the validated carrier/allocator and test one
  new bounded observation-to-control mechanism.  This lesson applies only to
  the shared prewarm snapshot, perturbation seed, and task configuration, and
  is falsified as a robustness claim until a changed wake phase reproduces the
  success.
- Do not select a controller by low command effort in isolation. A slower,
  smaller curvature-equilibrium variant had mean command energy only `419.1`
  yet stayed at least `9.238L` from the target and terminated unstable after
  `121.517`, with RMS relative crossflow `1.138` and force/moment
  `16749.8/290421`. Avoid broad carrier replacement or scalar slowdown for this
  failure topology; first preserve the validated traveling-bend carrier and
  bearing-residual interface, then change one bounded allocation or feedback
  mechanism at a time.
- In the common seed, early diagonal progress to 8.615 L minimum distance did
  not imply usable navigation: the target-blind 0.55-period oscillator then
  curled downward, displaced the head -13.300 L in y, hit both joint speed and
  acceleration limits, and exited after 50.127 time units. For this failure
  topology, test bounded body-frame target-to-mean-curvature feedback with
  saturation headroom before adding wake-phase rejection or increasing gait
  gains. Distrust this implication if steering destroys the initial leftward
  progress or if a later controller still shows the same lower-exit trajectory;
  that would require a different steering primitive or evidenced disturbance
  residual rather than more scalar authority.
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
