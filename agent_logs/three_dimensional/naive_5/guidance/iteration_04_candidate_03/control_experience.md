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

- This is a fresh 10-iteration lineage with no solver or optimizer population
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
- In the direct-uniform still-water parent, a visually coherent alternating
  wake did not make the naive carrier controllable: it changed heading by
  `-1.288 rad`, exited the upper boundary at `8.547T`, and improved distance by
  only `0.250L` before regressing. Raw acceleration exceeded the
  `1800 deg/T^2` envelope on `52.4%` of samples, despite joint angles remaining
  below `26.7 deg`. When this failure topology appears, retain the evidenced
  posterior-lagged rhythm but create actuator headroom and put target feedback
  into a bounded mean-curvature target; avoid merely adding steering
  acceleration to an already clipped carrier. Falsify this implication if a
  later unclipped carrier still shows the same wrong-way curl, or if curvature
  feedback destroys coherent thrust instead of improving survival and distance.
- Across the sampled descendants, the first useful topology change came from
  anterior phase injection, not from a better scalar steering gain. The
  anterior half-cycle policy preserved a coherent alternating 3D wake, survived
  `39.088T`, and reached `5.156L`, while the seed, a low-authority
  bearing-persistent variant, and an instantaneous course-error variant all
  repeated the upper curl at `8.55--9.30T` with minima no better than
  `11.954L`. However, the long rollout remained in `y=13.780--14.961L`, passed
  the target longitudinally, and touched the `45 deg` angle and `260 deg/T`
  speed limits. In all four rollouts, beat-scale heading rate has nearly the
  same joint-speed coupling (`heading_rate/phi_dot1` regression slope
  `-0.417` to `-0.452`, correlation magnitude `0.906--0.933`), so raw yaw
  feedback mostly recovers gait phase; instantaneous course feedback is also
  not an evidenced replacement because it restored the early curl. Preserve
  the long policy's anterior phase support explicitly, but keep it separate
  from target-directed half-cycle asymmetry and reject the sampled
  `phi_dot1`-correlated yaw component before interpreting turn response. This
  lesson applies to this state-feedback traveling-bend family; falsify it if a
  phase-separated controller loses the coherent long trajectory, cannot leave
  the inherited high-y corridor, or still requires material limit occupancy.
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
