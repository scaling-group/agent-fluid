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
- Response-triggered distributed C-bend steering is a replicated semantic
  success but not yet a robust one. Combined bearing-plus-LOS recruitment with
  posterior mean correction produces four sampled captures at
  `19.2335--19.8880T` (scores `-0.17657-- -0.20397`), yet an assigned-parent
  rollout of the exact same policy hash misses `1.845L` high and exits left at
  `28.875T`. Both outcomes retain coherent self-generated wakes in top-down
  and oblique views, and the failure still has low local-flow RMS (`0.0208U`),
  so wake survival or repeated source identity alone is not evidence of route
  robustness. In the failure the target demand and anterior redirect are
  already saturated by `16T`, while acceleration-limit occupancy rises to
  `60.8%/76.4%` from the fastest capture's `44.9%/73.6%`; force/moment RMS also
  rises from `0.01322/0.00690` to `0.01574/0.00810`. More clipped mean bend is
  therefore not the missing authority. A sign-coherent, total-curvature-
  conserving allocation captures at `20.020T` with much lower action/load,
  but restricting it by instantaneous near range yields a `1.62L` first pass,
  a `7.35L` loop, and only a `49.742T` capture. Preserve normalized LOS-rate
  feedback and continuous two-joint route closure; avoid gain-only authority,
  terminal coasting, predicted-miss release, or memoryless range allocation.
  Test response-reversing beat-phase or genuine beat-history authority to
  widen the capture basin, and falsify it unless repeated runs retain capture
  without exceeding the failed branch's load and limit occupancy; this bound
  currently applies to the coherent still-water carrier near `0.02U` local
  flow and must be retested under stronger disturbance.
- Response-reversing beat-side feedback now survives a same-hash replication
  and two compatible actuator variants. The assigned-parent half-cycle policy
  and its inherited-log repeat capture at `18.931T` and `19.052T` (scores
  `-0.15357` and `-0.16031`); a coefficient-norm-preserving posterior phase
  rotation captures at `18.997T` and `-0.15967`, within that timing spread.
  All three retain coherent alternating wakes in top-down and oblique views
  with local-flow RMS `0.01825--0.01843U`, so this mechanism is self-propelled
  route control rather than passive advection. Phase rotation modestly lowers
  posterior acceleration-limit occupancy from `75.4--76.4%` to `74.3%` and
  force/moment RMS from `0.01330--0.01357` / `0.00692--0.00707` to
  `0.01317` / `0.00685` without a resolved arrival penalty. In contrast,
  instantaneous curvature allocation lowers anterior occupancy to `34.0%`
  and loads to `0.01250` / `0.00654` but slows capture to `19.239T` and the
  worst sampled score, `-0.17198`. Preserve the LOS-rate C-bend and reversible
  beat-side path; when clipping is the next limitation, prefer bounded phase
  recruitment over wholesale curvature transfer or another gain increase.
  Falsify this implication if phase recruitment loses capture, breaks wake
  coherence, leaves the `18.931--19.239T` sampled band, or does not reduce
  saturation/load; disturbance robustness remains untested above about
  `0.018U` local-flow RMS.
- Carrier-demodulated moment is channel-sensitive: allocating its helpful
  residual to half-cycle amplitude is now a concrete negative result, not a
  safer substitute for phase modulation. The persistent same-side phase parent
  captures at `18.6725T` (with an identical-hash repeat at `19.0080T`), mean
  distance `2.02129L`, posterior limit occupancy `76.11%`, and
  `0.01350/0.00703` force/moment RMS. Direct demodulated phase modulation
  captures at `18.7165T` and slightly raises mean distance to `2.02337L`, but
  materially lowers posterior occupancy to `74.14%`, action RMS to
  `24.46/28.56 rad/T^2`, and loads to `0.01309/0.00682`; this supports only an
  effort benefit pending replication. In contrast, the two inherited
  demodulated-amplitude implementations capture much later at `18.9750T` and
  `19.1070T`, raise mean distance to `2.04497L` and `2.05106L`, and score
  `-0.15631` and `-0.16256` even though occupancy falls to `74.20--74.84%` and
  loads remain about `0.01312--0.01326/0.00683--0.00691`. Their top-down and
  oblique wakes remain coherent at `0.01808--0.01844U` local-flow RMS, so this
  is route degradation rather than wake collapse or advection. Preserve the
  normalized LOS route, persistent phase gate, and traveling carrier; avoid
  another raw-moment gate, command-deficit multiplier, global handoff,
  gain-only retune, or demodulated amplitude release. If moment is reused in
  this low-flow lane, replicate the bounded demodulated phase result and reject
  it unless capture stays within about `19.052T`, mean distance stays at or
  below `2.02337L`, posterior occupancy stays near or below `74.3%`, and loads
  stay near or below `0.01317/0.00685` with both wakes intact. If that effort
  separation does not replicate, abandon moment allocation until a genuinely
  beat-scale response signal is available; none of these still-water results
  establishes external-disturbance rejection.
- Instantaneous counter-LOS response is not evidence that anterior redirect
  has become redundant. The completed anterior-release candidate preserves
  coherent top-down and oblique wakes at `0.01800U` local-flow RMS and reduces
  anterior/posterior acceleration-limit occupancy from the actuator-consistent
  baseline's `42.24%/76.14%` to `39.51%/73.74%`, action RMS from
  `24.95/28.85` to `24.24/28.50 rad/T^2`, and lateral-force/moment RMS from
  `0.01256/0.00703` to `0.01205/0.00675`. Those effort reductions are not a
  control improvement: capture slows from `18.6725T` to `18.9310T`, mean
  distance rises from `2.02129L` to `2.04457L`, and score falls from
  `-0.13362` to `-0.15658`. In this coherent still-water route, a sub-beat LOS
  opposition signal can coincide with curvature that is still useful for
  broad closure; avoid using it to withdraw anterior C-bend authority or
  scalar-tuning the release. Revisit anterior release only with a genuinely
  beat-scale response observation and falsify it unless route cost stays at or
  below `2.02337L` while the measured effort reduction survives; this boundary
  does not rule out history-based release under stronger external disturbance.
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
