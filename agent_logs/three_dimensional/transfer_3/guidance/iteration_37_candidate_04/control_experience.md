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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
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
- Cross-candidate evidence supports geometry-gated equilibrium redirection but
  rejects replacing it with uncalibrated beat-side or course logic. The
  transferred seed formed a coherent wake yet reached only `4.780 L`, with
  raw acceleration beyond the envelope on about `71.4%/78.4%` of commands;
  geometry-gated redirection retained that wake, reduced the incidence to
  `32.1%/26.0%`, and reached `1.135 L`, whereas phase-demodulated redirection
  reached only `12.12 L` before an early exit. Preserve the outer carrier and
  target-angle redirect. This implication applies only after useful broad
  target motion is established and is falsified by a changed early trajectory,
  lost wake coherence, or return of the original boundary-exit topology.
- A fast misaligned near miss can be a joint-allocation problem rather than a
  need for more curvature gain or generic braking. Replacing the oscillatory
  carrier inside the gated terminal band with damped tracking of its same
  two-joint mean-curvature equilibrium converted the `1.135 L` pass into
  capture at `25.2615 T` (score `-0.530646`, mean distance `2.431797 L`) while
  removing joint-stop dwell and sharply reducing terminal loads. A
  closure-loss support gate produced an identical rollout because it stayed
  fully supported, so nominal noninterference is not recovery evidence. In
  contrast, bounded closure preview preserved the two-view wake and capture,
  advanced crossing to `25.1130 T`, improved score to `-0.530060` and mean
  distance to `2.430636 L`, removed terminal `|action|>30` incidence, and cut
  posterior terminal excursion from `0.7213` to `0.6620 rad`. Preserve the
  closure-previewed equilibrium as the terminal baseline; test new mechanisms
  through an independently active state gate rather than another dormant
  condition or scalar-only preview tweak. Reject a refinement if capture is
  delayed or lost, pre-terminal motion changes, coherent wake continuity
  degrades, or terminal clipping, joint-stop dwell, and force/moment spikes
  return.
- Keep response-conditioned terminal carrier release coupled across both
  joints unless rollout evidence proves a role split. Three independent
  sampled evaluations reproduce the same symmetric-release result exactly:
  score `-0.528339`, mean distance `2.429294 L`, capture at `25.11852 T`, a
  coherent outer wake, no joint-stop dwell, and no inside-`4 L` command above
  `30 rad/T^2`. Phase-selective departure reallocation captures one solver step
  earlier and lowers inside-band force/moment maxima from about
  `0.01547/0.00800` to `0.01426/0.00757`, but is marginally worse in score and
  mean distance (`-0.528376`, `2.429298 L`). Assigning settled release only to
  the posterior joint regresses to `-0.530288`, while stacking departure
  reallocation during unsettled bend formation regresses to `-0.530990` and
  mean distance `2.431337 L`. Thus tail-end propulsion theory does not justify
  a joint-role split, and two individually useful response signals should not
  be stacked in the same response regime. Preserve one coordinated,
  amplitude-normalized two-joint release; if testing response direction, make
  its activation disjoint from unsettled bend formation and reject it if the
  compact outer path changes, capture regresses, or saturation/load spikes
  return.
- Do not interpret residual terminal bearing as an isolated yaw error when
  target-relative translation is already closing the range, and do not equate
  an earlier threshold crossing with better control. Three current samples
  reproduce the v23 baseline at `25.11852 T`, score `-0.528339`, mean distance
  `2.429294 L`, and final distance `0.746410 L`. A fourth uses settled joint
  response, positive closure, target side, and helpful body-relative crossflow
  to relieve terminal equilibrium allocation only below `1.6 L`; it retains
  the capture step and coherent two-view wake while improving score to
  `-0.528108`, mean distance to `2.429111 L`, final distance to `0.746168 L`,
  and the late lateral-force maximum from about `0.00218` to `0.00204` without
  joint stops or `|action|>30`. In contrast, a broader `22%` response release
  captures one step earlier but regresses to score `-0.530433`, mean distance
  `2.430937 L`, final distance `0.748611 L`, and final commands near
  `0.138/0.328 rad/T^2`. The cue is therefore validated only for small,
  closure-supported late modulation; added carrier authority has a narrow
  budget. The subsequently sampled actuator-locus test now also rejects actual
  shared-mean unloading: reducing the redirect mean by at most `1.5%` under
  the same late cue lowers peak action but regresses to score `-0.529558`, mean
  distance `2.430257 L`, final distance `0.747693 L`, final speed
  `0.65235 L/T`, and target-course mismatch `0.3194 rad`, versus
  `-0.528108`, `2.429111 L`, `0.746168 L`, `0.65403 L/T`, and
  `0.3102 rad` for the coupled-release parent. Preserve that parent's mean
  bend and small paired carrier release; neither lower command magnitude nor
  body-alignment intuition justifies unloading or redistributing its static
  curvature. The now-completed response-location comparison further separates
  what the terminal course signal can support. Smooth course convergence below
  the same late gate, used only to add at most `3.5%` more paired allocation
  release, preserves the capture step and improves score/mean/final distance
  slightly to `-0.528103`, `2.429108 L`, and `0.746163 L`. Applying signed
  course error instead as a common half-cycle carrier multiplier preserves the
  outer wake and capture but regresses those measures to `-0.528123`,
  `2.429124 L`, and `0.746184 L`. Treat course alignment as a narrow response
  gate for coordinated release, not evidence for beat-side authority; the
  improvement is only one solver sample and about `4.6e-6` in score, so do not
  increase it or stack another same-regime mechanism without reproduction.
  This lesson applies only after a stable target-directed approach and settled
  shared bend, and is falsified by non-reproduction, slower closure, changed
  outer motion, lost capture, a loop, renewed saturation/joint-stop dwell,
  load growth, or wake degradation.
- Prefer a bounded predicted-intercept corridor based on center translation
  to raw course-angle, instantaneous-force, or reconstructed head-point-rate
  gating of the optional late paired release. Four current sampled evaluations
  of the same center-intercept policy reproduce exactly:
  capture at `25.11852 T`, score `-0.52807723`, mean distance `2.42908721 L`,
  and final distance `0.74613529 L`, improving the reproduced course-angle
  release (`-0.52810322`, `2.42910773 L`, `0.74616265 L`) without changing the
  visible compact trajectory, coherent top-down wake, or finite oblique
  Lambda2 structures. Adding a smooth target-opposing lateral-force veto to
  that intercept support preserves the capture step but regresses to
  `-0.52807785`, `2.42908771 L`, and `0.74613595 L`; applying the same veto to
  course-angle support is worse at `-0.52808618`. The inherited head-point
  predictor is a distinct completed negative result: it reconstructed the
  capture-point miss from range closure and matched-window line-of-sight rate,
  changed 118 of 226 stored terminal commands without affecting the outer
  path or increasing the `3.5%` release ceiling, yet regressed in CFD to
  `-0.52819594` and final distance `0.74626029 L` while retaining capture.
  Conceptual agreement between predictor and capture point is therefore not
  sufficient evidence when it introduces a rate reconstruction; later workers
  should retain the directly observed center-course corridor unless they can
  separately establish a less noisy capture-point response. In this direct
  still-water terminal regime, neither instantaneous force nor reconstructed
  head rate should override an already closure-, crossflow-, proximity-, and
  settled-response-supported geometric intercept. Preserve the shared mean
  bend and small coupled release; do not add force cancellation, larger
  authority, body-heading damping, beat-side logic, or a joint-role split.
  This lesson applies only after useful outer target motion and a settled
  terminal bend exist, and is falsified by an independently reproduced
  capture-point predictor that improves distance without changing outer
  commands or release authority, or by failed center-intercept reproduction,
  a different approach topology, delayed or lost capture, worse predicted
  miss or distance, renewed terminal oscillation or joint-stop dwell, load
  growth, instability, or wake degradation.
- Do not recover propulsive cadence inside the already settled
  intercept-supported terminal glide. The completed `3%` cadence-recovery
  mechanism was independently active on 160 of 226 below-`1.6 L` states and
  left the outer trajectory, capture step, actuator extrema, and coherent
  two-view wake unchanged, yet it regressed from the reproduced
  center-intercept result (`-0.52807723`, mean `2.42908721 L`, final
  `0.74613529 L`) to score `-0.52812468`, mean `2.42912466 L`, and final
  `0.74618530 L`. Together with the rate-reconstructed head-point regression,
  this rejects both more terminal rhythm and a more elaborate terminal
  predictor as routes out of the current plateau. Preserve the quiet held-bend
  approach and move a next mechanism to an independently active locus. One
  evidence-backed locus is outer command coordination: the reproduced winner
  reaches its software acceleration cap on about `39.2%/31.4%` of anterior and
  posterior commands but never reaches it inside `4 L`, so a bounded coupled
  limiter can test traveling-bend preservation without touching the validated
  terminal regime. This implication applies to the current compact captured
  topology and is falsified by a reproduced cadence or head-point mechanism
  that improves distance, or by outer limiter coupling that changes terminal
  commands, weakens progress or wake coherence, raises loads, or loses capture.
- Separate outer saturation objectives by observed joint response; clipping
  counts alone do not identify useful allocation. Two current samples exactly
  reproduce the direction-conditioned limiter at `21.912008 T`, score
  `-0.32465929`, mean distance `2.21894719 L`, and final distance
  `0.74768060 L`, while the inherited whole-vector rate-headroom attenuation
  regressed to `22.038506 T` and `-0.32763343` without reducing rate contact.
  The completed target-residual test now answers the next allocation question:
  limiting the traveling drive before adding its bounded body-frame turn
  residual improves capture to `21.735992 T`, score to `-0.30126617`, and mean
  distance to `2.19485723 L`, while reducing outer `|action|>30 rad/T^2`
  incidence from `1190/1757` to `961/612` anterior/posterior samples and
  retaining the quiet held-bend capture. Conditioning three additional points
  of common-scale support instead on normalized posterior lag-target error is
  the stronger but different mechanism: it improves capture to `20.096998 T`,
  score to `-0.29756859`, and mean distance to `2.18831161 L`, with coherent
  top-down shedding and finite oblique structures, but enters a distinct
  upper-side approach and remains actively undulatory through capture.
  Consequently its outer-only same-state gate does not preserve the terminal
  rollout regime: below-`4 L` `|action|>30` incidence becomes `387/486`, and
  local force/moment maxima rise from about `0.01271/0.00713` to
  `0.02667/0.01348`, although global maxima stay close and finite. Preserve
  response-conditioned traveling-bend coordination when posterior tracking is
  poor, preserve target residual headroom after that response settles, and do
  not apply both as full-strength priorities on the same overloaded state.
  This implication applies only to the established compact self-propelled
  topology and is based on one CFD sample of each new allocator. It is
  falsified by failed reproduction, dormant response partitioning, slower or
  lost capture, worse distance integral, joint-stop dwell or material global
  load growth, instability, or degradation of either wake view; future workers
  must also audit realized terminal trajectories rather than treating
  same-state command identity below a distance gate as noninterference proof.
- Once signed geometry/course allocation has established the compact approach,
  a directly observed center intercept can support a small terminal handoff to
  the existing damped two-joint mean-bend posture even when the large-angle
  redirect is quiet. Relative to the sampled `v39` parent (capture
  `19.783508 T`, score `-0.26217996`, mean/final distance
  `2.15193349 L`/`0.74906743 L`), the closure- and intercept-supported posture
  handoff preserves the identical `4 L` crossing, captures at `19.684490 T`,
  and improves score and mean/final distance to `-0.26138429`,
  `2.15109279 L`, and `0.74830240 L`. It reduces below-`4 L` high-command
  incidence from `318/373` to `229/302` anterior/posterior samples while
  retaining the same compact self-propelled trajectory, coherent alternating
  top-down wake, and finite localized oblique structures; terminal
  lateral-force/yaw-moment maxima remain essentially level at about
  `0.02753/0.01567` versus `0.02724/0.01564`. Four current solver evaluations
  and the assigned-parent selection reproduce the `19.684490 T`,
  `-0.26138429` result with byte-identical trajectories and two-view
  keyframes: three sampled policies and the parent use the identical `v40`
  law, while sampled `v41` is only source-level variation. Its nominal
  course/yaw support peaks near `0.240`, so `max` composition never lets it
  exceed the existing `0.82` terminal-allocation floor or change a command.
  This is a concrete structural-redundancy result: remove the dead branch and
  its parameters rather than count it as a second mechanism or retune its
  thresholds merely to force activity. Completed active response tests reject
  conditioning the handoff in either direction: extra
  posture
  during outward joint response captures at `19.722988 T` with score
  `-0.26185631`; retaining extra carrier during that response (the assigned
  parent) captures at `19.711988 T`, scores `-0.26182224`, and lengthens the
  path from `12.951133 L` to `12.984927 L`; extra posture while the coupled
  posture-error energy is already decreasing still captures one step later
  and scores `-0.26180675`. Lower command or load measures in these variants
  do not outweigh worse course and distance integral. Preserve the flat small
  supported posture share; do not retry joint-response direction or
  error-energy gates, widen its distance gate, or restore cadence after
  support is lost. A separately completed signed course/yaw test sharpens this
  boundary: adding only a four-point posture increment during the final
  course-worsening yaw reversal preserves the capture step and visually
  indistinguishable coherent wake, yet regresses score, mean distance, and
  final distance to `-0.26139057`, `2.15109782 L`, and `0.74830866 L` from
  `-0.26138429`, `2.15109279 L`, and `0.74830240 L`. Thus correct sign
  calibration and selective equal-state activity do not make residual
  terminal yaw a useful handoff signal; the head can cross the capture circle
  while center-course yaw appears to worsen. Together, dormant `max`
  composition and worse additive composition close this selector locus rather
  than inviting a larger threshold or authority. Later workers should not
  retry course/yaw-conditioned posture, retain redundant selector schemas, or
  infer a head-capture benefit from center course alone. This implication is
  specific to the reproduced compact
  approach and reflected body-frame convention, and is falsified by a directly
  observed head-response signal that improves capture or distance without
  changing the outer trajectory, reviving joint stops or loads, or degrading
  either wake view.

  The inherited outer phase-lag feasibility governor is a separate, stronger
  negative result. A bounded response- and clipping-gated reduction of the
  derivative-defined posterior lag remained finite and eventually captured,
  but changed the compact approach into a large loop: capture moved to
  `46.145020 T`, score to `-0.91560550`, mean distance to `2.85798609 L`, path
  length to `31.012702 L`, and moving-window shifts from `243` to `607`. Its
  initially alternating wake bends into long paired top-down vorticity bands,
  with sparse separated late oblique structures. Thus reduced saturation or
  bounded same-state activity does not establish traveling-wave preservation;
  later workers should avoid outer lag shortening on this controller unless a
  distinct response signal can first falsify this looping topology. This
  lesson applies to the established still-water compact approach and is
  falsified by failed reproduction of the supported baseline or by an
  independently reproduced mechanism that improves capture and distance
  integral without a loop, joint-stop dwell, material load growth,
  instability, or degradation of either wake view.
- Course/geometry sign agreement is a consent signal for the established
  residual allocator, not evidence that the large-angle redirect equilibrium
  should be introduced during startup. The completed outer mean-curvature test
  changed 220 reconstructed commands only from release to `9.858 L` and left
  the protected terminal law untouched, yet it delayed capture from
  `19.684490 T` to `23.375013 T`, regressed score/mean distance from
  `-0.26138429`/`2.15109279 L` to `-0.40118212`/`2.29800262 L`, and lengthened
  the compact path from `12.951133 L` to `13.529185 L`. Its initially coherent
  alternating wake develops longer paired top-down bands and a pronounced late
  turn while the oblique structures remain finite, identifying stable
  mis-steering rather than lost propulsion or instability. Preserve the
  existing large-angle gate and use course agreement only for bounded residual
  allocation; avoid another small-angle startup bend merely because it is
  selective and nonterminal. This boundary applies to the reproduced compact
  still-water topology and is falsified only by an independently reproduced
  startup steering mechanism that improves arrival and distance integral
  without a late turn, loop, joint-stop dwell, material load growth,
  instability, or degradation of either wake view.
- Separate slow momentum acquisition from a steering defect before changing
  the established outer route. Four byte-identical sampled trajectories of the
  `v40` winner remain above `12 L` through `3.801 T`, averaging only about
  `0.179 L/T` center speed and `0.085 L/T` windowed closure in that interval,
  before building to about `0.650 L/T` from `12 L` to `8 L` and about
  `0.88 L/T` from `6 L` to `4 L`; their two-view wake develops from quiescent
  water into coherent alternating top-down shedding and finite localized
  oblique structures. The slow interval is not unused actuator headroom:
  `205/326` anterior/posterior commands already exceed `30 rad/T^2` while
  distance is above `12 L`. Meanwhile the completed startup mean-curvature
  test delayed capture to `23.375013 T` through stable mis-steering, and the
  posterior-lag governor produced a `31.012702 L` loop and capture only at
  `46.145020 T`. Therefore an independently active startup experiment should
  modulate only propulsive recruitment from normalized measured translation,
  preserve the fixed wave lag and target-owned mean bend, yield to large-angle
  redirect, and become exactly inactive before the validated sub-`4 L` law;
  do not infer that more bend, shorter lag, or unconditioned cadence follows
  from a slow release. This implication applies to direct-uniform still-water
  starts with the reproduced compact topology. It is falsified by an
  independently reproduced startup steering or lag mechanism that improves
  arrival without a loop, or by response-gated propulsive recruitment that
  fails to advance speed/distance crossings, changes terminal commands,
  materially raises clipping or loads, loses capture, destabilizes the fish,
  or degrades either wake view.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
