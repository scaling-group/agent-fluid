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
- Posterior phase recruitment is sensitive to response semantics, not merely
  exposure or actuator headroom. Across the sampled ablation, persistent
  same-side raw demand and previous feasible action is strongest: it captures
  at `18.6725T` (score `-0.13362`, mean distance `2.02129L`) versus
  `18.7880T` for a demand lead, `18.7990T` for current-demand recruitment,
  `18.8320T` for instantaneous headroom allocation, and about `18.931T` for
  the half-cycle-only path. Four controls sharpen the negative boundary.
  Multiplying the same-side gate by positive unrealized command
  magnitude delays capture to `18.9805T` and `-0.15551` while retaining
  `75.60%` posterior limit occupancy and `0.01345/0.00700` force/moment RMS;
  fully handing amplitude-asymmetry authority to phase lowers occupancy and
  load to `74.16%` and `0.01336/0.00696`, but slows capture to `18.7495T` and
  `-0.14192`. Directly suppressing phase when instantaneous yaw moment helps
  also underperforms: unconditional release captures at `18.7880T` and
  `-0.13976`, while requiring near-satisfied yaw error improves that to
  `18.7715T` and `-0.13713` but still trails the persistent gate. The latter
  does reduce anterior/posterior occupancy from `42.15%/76.11%` to
  `40.96%/75.39%` and force/moment RMS from `0.01350/0.00703` to
  `0.01335/0.00695`. All retain coherent body-led top-down and oblique wakes
  at only `0.01798--0.01839U` local-flow RMS, so these are route/effort tradeoffs
  rather than advection or wake survival. Preserve persistent same-side phase
  recruitment; avoid another command-deficit multiplier, global complementary
  handoff, or instantaneous-moment phase release, and do not scalar-tune these
  negative controls. If physical response is reused, keep the slow normalized
  LOS route and phase actuator intact and test it only as a bounded allocator
  for a redundant residual channel after yaw-response closure. Falsify that
  allocation if it loses capture, arrives later than about `18.931T`, weakens
  the alternating wake, or exceeds `0.01350/0.00703` force/moment RMS; do not
  extrapolate beyond the sampled low-flow still-water regime without
  disturbance evidence.
- Raw hydrodynamic-moment allocation is not yet resolved beyond replication
  variability. The same actuator-consistent policy hash captures at
  `18.6725T` and `18.7385T`, a `0.0660T` spread, while its anterior/posterior
  limit occupancy spans `40.53--42.15%` / `75.58--76.11%` and force/moment RMS
  spans `0.01327--0.01350` / `0.00691--0.00703`. Helpful-moment amplitude
  relief captures at `18.6560T` with `40.74%/75.74%` occupancy and
  `0.01328/0.00691` loads, but its `0.0165T` edge over the faster repeat is
  below that same-hash timing spread. A broader phase-demodulated moment
  residual lowers posterior occupancy to `74.14%` and loads to
  `0.01309/0.00682`, yet arrives later at `18.7165T`; all sampled top-down and
  oblique views retain the same coherent body-led alternating wake at low
  local-flow RMS. Together with inherited capture scores from `-0.13364` to
  `-0.16256`, this makes semantic capture and replicated route/load separation
  more trustworthy than a one-off raw-score or moment-gain ordering. Preserve
  the LOS C-bend, traveling carrier, and persistent phase path; if moment is
  reused, confine it to a bounded residual allocator only when observed route
  closure and actuator stress agree. Avoid scalar-tuning raw or demodulated
  moment gains. Falsify this boundary only when replicated evaluations move
  arrival outside the `18.6725--18.7385T` same-hash band or reduce load/limit
  occupancy beyond its span without losing capture or wake coherence; the
  result currently applies only to direct-uniform still water near `0.018U`
  local-flow RMS.
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
