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
- Response-triggered distributed C-bend steering is a semantic success but its
  robust form is phase-selective rather than a larger slow bend. The same
  response-reversing posterior half-cycle hash now captures twice at
  `18.9310T` and `19.0520T`, preserves coherent top-down and oblique wakes, and
  holds mean distance to `2.0418--2.0486L`. Across the replications, action RMS
  is `24.85--25.22/28.75--28.86 rad/T^2`, force/moment RMS is
  `0.01330--0.01357/0.00692--0.00707`, and local-flow RMS is
  `0.01825--0.01843U`; this supports the mechanism beyond a single favorable
  score. Its remaining concern is posterior clipping at `75.0--76.1%`, close
  to the `76.4%` assigned-parent high-pass failure with
  `0.01574/0.00810` force/moment RMS. An always-active fixed-coefficient-norm
  phase rotation captures at `18.9970T` and lowers posterior occupancy to
  `74.1%` and force/moment RMS to `0.01317/0.00685`, but its arrival and mean
  distance `2.0480L` lie inside rather than improve the half-cycle replicate
  band. Likewise, demand-gated total-curvature reallocation lowers action/load
  yet slows capture to `19.2390T` and raises mean distance to `2.0610L`; the
  inherited conservative allocator (`20.020T`) and near-range allocator
  (`49.742T` after a `1.62L` pass and `7.35L` loop) reinforce that negative
  result. Preserve normalized LOS-rate feedback, response-reversing half-cycle
  authority, and continuous two-joint closure. Avoid claiming always-active
  phase rotation, curvature redistribution, terminal coasting, predicted-miss
  release, or range-only allocation as improvements. If phase timing is tested
  again, gate it from observed actuator or response state and falsify it unless
  capture remains in the `18.931--19.052T` band with a material clipping/load
  reduction, or arrives earlier without exceeding `76.4%` posterior occupancy
  and `0.01574/0.00810` force/moment RMS. These bounds apply to the coherent
  still-water carrier near `0.02U` local flow and require retesting under
  stronger disturbance.
- Treat sub-`0.34T` timing differences among posterior-phase selectors as
  unresolved until replicated. The exact actuator-consistent hash now captures
  at `18.6725T`, `18.7385T`, and `19.0080T`, a `0.3355T` spread. A sampled raw-
  moment amplitude release posts the best single arrival, `18.6560T`, but its
  `0.0165T` lead over the fastest parent and its action RMS
  `24.71/28.77 rad/T^2`, occupancy `40.7%/75.7%`, and force/moment RMS
  `0.01328/0.00691` are inside the parent replicate ranges. Raw-moment phase
  release (`18.7880T`) and error-conditioned release (`18.7715T`) likewise do
  not separate. All preserve the same coherent top-down and oblique wake at
  `0.01798--0.01828U` local-flow RMS, so scalar ordering is not evidence of a
  better route or propulsor. The negative boundary is mechanistic: raw moment
  predicts next-sample yaw acceleration at correlation `0.972` but is itself
  carrier dominated (about `0.842` correlation with anterior angle), and a
  raw-moment forecast slows capture to `18.9860T`, raises force/moment RMS to
  `0.01355/0.00705`, and leaves posterior occupancy at `75.87%`. Subtracting
  an odd joint-phase carrier estimate leaves about `0.0024` moment-residual RMS
  and only `0.234--0.237` correlation with next-sample yaw acceleration, but
  using that residual as a small phase allocator now has a replicated positive
  boundary: captures at `18.7165T` and `18.7605T` retain the coherent wake while
  posterior acceleration occupancy falls to `74.17--74.44%`, action RMS to
  `24.46--24.49/28.56--28.60 rad/T^2`, and force/moment RMS to
  `0.01309--0.01311/0.00682`. This is reproducible load relief, not a faster
  route: both arrivals remain inside the parent spread and their distance
  integrals are `2.0234--2.0330L`. Moving the same demodulated residual onto
  half-cycle-amplitude relief is a completed negative result: it slows capture
  to `19.1070T`, raises the distance integral to `2.0511L`, and returns
  force/moment RMS to `0.01326/0.00691`; avoid that allocation and another
  memoryless raw-moment release, forecast, or scalar tuning. Preserve the
  normalized LOS, response-reversing half-cycle, persistent same-side stress
  gate, and demodulated residual on phase recruitment. Its remaining actuator
  boundary is posterior velocity-limit occupancy `7.73--7.83%`, slightly above
  the actuator-consistent parent's `7.43--7.51%`; if phase timing is revisited,
  withdraw only the incremental phase acceleration aligned with already near-
  limit velocity, and falsify it unless capture stays in `18.67--19.01T`,
  velocity occupancy falls below `7.5%`, posterior acceleration occupancy stays
  below `75.0%`, and force/moment RMS stays below `0.01320/0.00690`. Genuine
  beat-scale history remains unavailable from the seven-sample (`about
  0.0385T`) observation window. These bounds apply only to the sampled self-
  generated still-water wake and require retesting under stronger disturbance.
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
