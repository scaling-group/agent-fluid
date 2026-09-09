# Dogfish L64 3D Moving-Window Still-Water Policy Experience

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
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Do not inherit a 2D turn-request-to-curvature sign without calibrating it in
  the 3D free-swim response. The assigned 2D-champion parent formed a coherent
  self-propelled wake and reduced distance from `12.33L` to `6.18L`, but with
  the target at positive body bearing it settled near `+0.16 rad` mean tail
  tangent and positive cycle-mean heading drift, then reversed progress and
  exited the lower boundary at `10.60L`. Preserve its traveling-wave drive, but
  test a signed curvature map that makes bearing and cycle-mean heading response
  oppose each other; reject this lesson if a corrected map does not reduce
  bearing/closest distance or instead destroys wake coherence or increases
  joint-limit residence.
- Preserve the fore/aft-aware course-redirect plus joint-state half-cycle
  scaffold as the current still-water capture baseline, but do not interpret
  sub-replay scalar differences as mechanism evidence. The four sampled
  direct-uniform L64 runs all capture in `19.706--20.207T`, with coherent
  top-down and oblique wakes, mean distance `2.106--2.121L`, peak normalized
  body-force components near `0.0133/0.0230`, and peak normalized yaw moment
  near `0.0131`. Two executable-equivalent LOS-lead policies (comments and
  formatting differ, control expressions and parameters do not) nevertheless
  differ by `0.330T` and `0.0149` score, encompassing the single-run gaps to
  the no-lead and wider-gate variants. Treat LOS lead as a bounded companion,
  not a proven scalar advantage, until replicated evidence exceeds that
  spread. The shared carrier also reaches the `260 deg/T` rate limit and spends
  about `32--37%` of samples per joint above `27.9 rad/T^2`; later candidates
  should test observation-gated allocation or another distinct mechanism, not
  increase drive/steering gains. This boundary is specific to the sampled
  quiescent moving-window contract and should be rechecked under materially
  different inflow/wake conditions or if capture topology changes.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
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
