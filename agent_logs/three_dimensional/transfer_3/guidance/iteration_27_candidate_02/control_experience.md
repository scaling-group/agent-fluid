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
  `0.02667/0.01348`, although global maxima stay close and finite. The now
  completed response-exclusive allocator validates the complementary control
  implication rather than either branch alone: it assigns common-limit
  support during poor posterior response and transfers the same convex
  priority to the drive-first target residual as that response settles. It
  captures at `19.612991 T`, scores `-0.28294122`, and improves mean distance
  to `2.17243510 L`, outperforming both the response-only and residual-only
  samples while retaining coherent top-down shedding and finite oblique
  structures. Preserve this response-state arbitration and do not stack the
  two priorities or replace it with rate-magnitude attenuation.

  The faster result also sharpens the boundary: it remains undulatory through
  capture, has `508/589` high-command samples below `4 L`, local force/moment
  maxima about `0.02847/0.01519`, and captures at joint rates
  `-4.498/1.538 rad/T` and yaw rate `2.858 rad/T`. A dormant terminal-distance
  branch therefore cannot guarantee a quiet realized handoff, but lower loads
  alone do not justify forcing the slower held-bend topology. If refining the
  selector, use an independently normalized response or route-urgency cue to
  transfer the existing exclusive priority, not to add authority. This lesson
  applies only to the established compact self-propelled topology and remains
  based on one CFD sample per new allocator. It is falsified by failed
  reproduction, dormant partitioning, slower or lost capture, worse distance
  integral, joint-stop dwell or material global load growth, instability, or
  degradation of either wake view; future workers must audit realized
  terminal trajectories rather than treating same-state command identity
  below a distance gate as noninterference proof.

  The completed course-supported child now validates normalized route urgency
  as an independently active selector cue, but also bounds what may be claimed
  from it. Against three byte-identical v37 reproductions (`19.612991 T`, score
  `-0.28294122`, mean `2.17243510 L`, final `0.74866050 L`), one v38 sample
  transfers the same exclusive priority toward the target residual only under
  established translation and severe body-frame course miss. It preserves
  capture and the compact coherent top-down and finite oblique wake, improves
  score/mean/final distance to `-0.27158268`, `2.16212422 L`, and
  `0.74727231 L`, and reaches `4 L` slightly earlier. It also changes the
  realized approach: capture is later at `19.998001 T`, but below-`4 L`
  high-command counts fall from `508/589` to `322/390`, local lateral-force
  and yaw-moment maxima fall from about `0.02692/0.01519` to
  `0.02485/0.01384`, and final yaw rate falls from `2.858` to `0.649 rad/T`.
  Thus route error may transfer an existing exclusive allocation budget
  without adding authority; it is not evidence for larger turn gains,
  simultaneous priorities, or beat-side control. Because global force/moment
  maxima rise slightly and anterior excursion reaches `0.7378 rad`, future
  refinements should release the transfer from a separately normalized
  achieved-response cue rather than intensify it. This implication is limited
  to the established self-propelled compact topology and one course-supported
  CFD sample. It is falsified by non-reproduction, lost capture, worse distance
  integral, a harmful path change, increased joint-envelope dwell or global
  loads, instability, or degradation of either wake view; evaluate crossing
  delay and low-load terminal state separately rather than calling either one
  uniformly superior.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
