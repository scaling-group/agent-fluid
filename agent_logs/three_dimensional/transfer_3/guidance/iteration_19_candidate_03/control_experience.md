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
- Steering polarity is necessary but not sufficient in a cross-dimensional
  port. The coherent clean-B carrier reached `6.138L` before wrong-sign yaw
  caused a lower exit, but two correct-sign posterior mean-curvature variants
  also failed: a yaw-rate loop reached `9.175L` and a static `4 deg` bias only
  `11.878L`, both crossing the target line and growing roughly `1.3 rad` of
  opposite-side bearing before upper exits. The nominally envelope-safe
  half-cycle carrier produced a visibly weaker wake and reached only
  `12.165L`. Moreover, `turn_rate_recent` spans seven integration samples
  (about `0.0385T`, not a `0.55T` beat average) and oscillates near
  `+/-2 rad/T`, so high-gain feedback on it does not establish yaw braking.
  Preserve a coherent carrier while testing a bounded geometry-response
  release or a genuinely beat-scale response signal; avoid treating static
  correct-sign bias or this sub-beat rate as complete pursuit. This applies
  when local flow is small (`about 0.02--0.03U`) and route overshoot dominates;
  falsify it if response-led release reduces neither boundary bearing nor
  route loss despite retaining propulsion, which would implicate actuator
  authority or carrier-induced yaw rather than release semantics.
- Heading alignment is not route alignment, but neither raw course nor recoil
  projection is a complete steering mechanism under this carrier. Low-speed-
  gated course and raw-slip candidates improved closest approach from the
  phase-conditioned reference's `5.658L` to `4.358L` and `4.158L`, yet passed
  the target's x station and exited left at final distances `9.767L` and
  `9.037L`. The fixed projection
  `v_y_slow = v_y + 0.11*phi_dot1 - 0.035*phi_dot2` does reduce body-lateral
  RMS from `0.269--0.385U` to `0.086--0.140U` while preserving late mean
  drift, but its completed mean-curvature rollout reaches only `4.128L` and
  repeats the left exit at `9.051L` final range. A different actuator alone is
  also insufficient: direct projected-course-to-half-cycle asymmetry on the
  same `28 degree`, `0.55T` carrier makes a tight turning wake, reaches only
  `11.994L`, and exits upward at `8.66T`. Sampled evidence now distinguishes
  that failed actuator from response-reversing half-cycle steering. Scaling
  only the posterior traveling-wave component by joint-state beat side and
  phase-conditioned yaw error preserves the coherent wake in two completed
  samples, captures at `18.931T` and `19.052T`, and scores `-0.15357` and
  `-0.16031`; the timing spread cautions against treating the fastest sample as
  a deterministic gain. A fixed-coefficient-norm posterior phase rotation on
  the same half-cycle controller also preserves capture (`18.997T`, score
  `-0.15967`) while lowering action RMS to `24.55/28.59 rad/T^2`, force/moment
  RMS to `0.01317/0.00685`, and limit occupancy to `41.3%/74.1%`, versus
  `25.22/28.86`, `0.01357/0.00707`, and `44.8%/76.1%` in the fastest half-cycle
  sample. Its `16T` path is lower but slightly farther from capture, so phase
  steering is a useful lower-demand trajectory variant rather than a proven
  arrival improvement. In contrast, the sampled instantaneous slow-curvature
  allocator is behind at `16T` (`3.096L`) and captures only at `19.239T`; the
  assigned parent's allocator likewise captured at `19.751T`, nearly unchanged
  from its `19.739T` feasible-C-bend parent. Preserve the projection and
  bounded response-reversing half-cycle mechanism; when load margin matters,
  test fixed-norm response-reversing phase rotation before another memoryless
  allocation gate, projected-course mean-curvature loop, or clocked imbalance.
  This applies to the completed LOS-rate C-bend in quiescent flow; falsify the
  phase implication if it fails to replicate capture within the observed
  `18.931--19.052T` half-cycle band, raises posterior occupancy above `76.1%`,
  increases loads, or loses coherence under stronger local-flow disturbance.
- A rotation-invariant line-of-sight-rate response is the first sampled
  release mechanism to materially change the high-pass trajectory without
  sacrificing the coherent carrier. Relative to raw-slip pursuit, the
  completed LOS-rate candidate improves closest approach from `4.158L` to
  `3.369L`, lowers the center at the target x station from `13.735L` to
  `12.895L`, and remains finite with a long alternating wake until `30.12T`;
  local-flow RMS stays only `0.020U`. It is not a complete controller: the fish
  still crosses about `3.4L` high at roughly `0.88U` body speed and exits left
  at `8.689L` final range. Preserve this response path as a useful broad-
  approach baseline, but do not claim success or increase far-field carrier
  effort: raw acceleration already exceeds the envelope in about `58%/74%`
  of anterior/posterior rows. When this topology is sampled, test a continuous
  normalized-range approach mode that reduces excess advance while retaining
  steering; falsify that implication if drive relief stalls outside capture,
  weakens the far-field wake, or fails to lower the `3.369L` miss, in which
  case the posterior-curvature actuator rather than approach time is limiting.
- Response-conditioned anterior steering is a replicated capture mechanism,
  and instantaneous terminal gates are not a reliable substitute for keeping
  it closed. Two identical explicitly bounded samples capture at
  `19.233--19.283T` with scores `-0.17657--0.18218`; an unbounded-output
  replication captures at `19.888T`, and the collision-course gate captures
  later at `19.784T` with score `-0.20824`. All show coherent alternating
  wakes and local-flow magnitude RMS near `0.018U`. Because the episode applies
  the same componentwise acceleration limit, retain the explicit projection as
  contract clarity but do not attribute the timing spread to that redundant
  clamp. Allocation evidence sharpens the boundary: gate-only removal of
  `75%` of posterior mean curvature loses capture at `3.191L`, whereas signed
  curvature-conserving allocation captures at `20.020T` and reduces action RMS
  from `25.19/28.56` to `15.71/18.97 rad/T^2`, force-magnitude RMS from
  `0.01322` to `0.00816`, and moment RMS from `0.00690` to `0.00432`. Yet
  restricting the same transfer to a smooth near-range gate is a concrete
  negative result: it passes at `1.62L` near `20T`, loops out to `7.35L`, and
  captures only at `49.742T` with score `-1.38708`, mean distance `3.337L`,
  and local-flow RMS increased to `0.0278U`. Preserve the response-triggered
  two-joint route closure as the reliable baseline; avoid another memoryless
  range or predicted-miss allocation gate merely to reduce effort. Revisit
  allocation only with a beat-response discriminator that preserves the
  evaluated direct trajectory, and falsify it if arrival exceeds `20.020T`,
  capture is lost, or loads do not improve. These load claims apply to the
  coherent still-water carrier and require retesting under stronger local-flow
  disturbance.
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
