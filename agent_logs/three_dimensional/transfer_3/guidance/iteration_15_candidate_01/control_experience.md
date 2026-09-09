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
- Distributed anterior steering is the sampled mechanism that converts the
  coherent LOS-rate high pass into capture, and its durable feature is
  response-conditioned recruitment rather than one exact trigger. A static
  `6 degree` bearing-gated center shift first improved the LOS-rate baseline
  from `3.369L` to `1.897L` but still exited `1.85L` high; a continuously shared
  residual instead passed low at `2.317L`. Range-only drive damping also left
  the high topology unchanged in an inherited rollout, worsening minimum
  distance from `3.369L` to `3.392L` and score from `-9.996` to `-10.237`.
  In contrast, two independent completed controllers that retain the anterior
  bend through either bounded route-response demand or a closing/miss gate
  both capture (`19.59T`, score `-0.204`; `19.78T`, score `-0.208`) with the
  same alternating 3D wake, local-flow RMS near `0.018U`, and force/moment RMS
  near `0.013/0.007`. The response-demand form is the stronger current
  baseline and also has lower raw acceleration-envelope occupancy
  (`39.5%/71.6%` versus `41.5%/72.9%`). Preserve its carrier and bounded
  distributed C-bend; do not return to static sharing, range-only drive relief,
  or curvature-gain tuning. A completed terminal-release test sharpens this
  boundary: using range below `2L`, positive instantaneous closing speed, and a
  constant-velocity miss estimate below `0.55L` to suppress both desired yaw
  and posterior residual changes the response-demand capture into a `1.712L`
  miss and left exit, raises force/moment RMS from `0.01261/0.00661` to
  `0.01580/0.00812`, and raises raw acceleration-limit exceedance from
  `39.5%/71.6%` to `60.6%/76.4%`. Do not treat a single-beat velocity
  projection as proof that steering may coast, and do not release both
  distributed branches from it. Test only beat-resolved achieved response, a
  selectively reversible branch release, or a feasibility improvement that
  leaves far/mid recruitment intact. Internal command clipping can make the
  policy obey the physical action contract, but because the episode already
  applies the same limiter it is not evidence of lower saturation, effort, or
  loads. A later completed allocation test also rules out treating the
  anterior C-bend as the sole steering actuator: reducing posterior mean
  curvature by `75%` whenever anterior recruitment is active preserves a
  coherent alternating wake but changes capture into a high pass, reaches only
  `3.191L`, and exits left at `30.10T` with final range `9.117L` and score
  `-10.311`. Preserve both distributed mean-steering branches; when posterior
  saturation or beat-frequency feedback remains problematic, test phase-
  resolved recoil observation or constraint-aware allocation without erasing
  posterior route closure. Falsify that implication only if a completed
  alternative allocation retains capture while materially reducing posterior
  saturation and loads, rather than merely retaining propulsion. This lesson
  applies to direct-uniform still water with a coherent
  carrier and small local flow; falsify the generality of the recruitment
  invariant if a held-out pose or flow condition makes both successful gates
  lose capture on the same side, which would indicate route-specific gating
  rather than sufficient steering authority.
- A lower offline beat-recoil residual does not validate a joint-phase yaw
  observer unless every position quadrature excludes its commanded slow bend.
  Adding fitted anterior/posterior position terms reduced a centered replay
  residual from roughly `0.75--0.87` to `0.29--0.32 rad/T`, but the completed
  controller centered only the anterior joint. It still formed a coherent
  wake and captured, yet arrival slowed from the sampled `19.23--19.89T` band
  to `22.62T`, score fell from the strongest sampled `-0.177` to `-0.455`, and
  mean distance rose from `2.065L` to `2.350L`. After `4T`, the uncentered
  posterior position term contributed about `-0.276` to `-0.390 rad/T`, while
  posterior mean curvature stayed near its positive limit; the controller
  therefore treated route curvature as recoil and reinforced the wrong early
  yaw estimate. For any mean-curvature carrier, center each joint-position
  recoil term on that joint's own slow command (solving a bounded implicit
  center if necessary), or omit the position term; do not transfer a
  zero-mean offline fit directly onto an offset joint state. Falsify this
  implication if a completed fully centered observer still repeats the slow
  straight approach or fails to reduce posterior conflict while retaining
  capture, in which case position quadratures are not an identifiable recoil
  signal under this two-joint carrier and later workers should use a genuinely
  beat-resolved observation rather than refit their gains.
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
