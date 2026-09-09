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
  `11.994L`, and exits upward at `8.66T`. Preserve the projection as an
  observation transform, but avoid another projected-course mean-curvature
  loop or undamped course-to-half-cycle command. If half-cycle steering is
  revisited, make observed phase-separated yaw response reverse the imbalance
  when the turn outruns demand; falsify that architecture if it retains either
  the short upper-turn exit or the more-than-`4L` high left pass, in which case
  test genuine history or phase-lag modulation rather than scalar gains.
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
- Response-conditioned distributed steering closes the gap between the earlier
  high and low misses; a closest-pass gate does not improve it in quiescent
  flow. The earlier bearing-triggered anterior shift reached `1.897L` high,
  while static sharing crossed low at `2.317L`; sustaining recruitment when
  either bearing or bounded LOS response is large subsequently captures in
  three sampled runs. The uncapped response-triggered form captures at
  `19.888T` (score `-0.2034`), and the explicitly bounded form repeats capture
  with the same policy hash at `19.283T` and `19.234T` (scores `-0.1822` and
  `-0.1766`), retaining a coherent alternating wake and local-flow RMS near
  `0.018U`. Adding collision-course/range/miss activation also captures but is
  worse: `19.784T`, score `-0.2082`, mean distance `2.098L` versus
  `2.065--2.071L`, with a higher final center (`10.469L`) and lateral velocity
  magnitude `0.581L/T` versus `0.182--0.369L/T`. Preserve the continuous
  bearing-or-LOS-response recruitment/release and avoid another intercept-range
  or closest-pass gate when local flow is this small. The bounded repeat still
  sits exactly on the acceleration limit for `44.9--47.8%` of anterior and
  `73.6--74.9%` of posterior samples, so test a distinct phase/wave-preserving
  allocation mechanism rather than more curvature or activation gains.
  Falsify this lesson under stronger wake forcing if intercept prediction then
  improves clearance, capture time, or load history without destroying the
  carrier; still-water evidence alone does not rule out that regime.
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
