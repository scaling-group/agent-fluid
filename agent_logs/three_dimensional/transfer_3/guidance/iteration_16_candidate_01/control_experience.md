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
- Prefer predicted cross-track miss over raw course angle or instantaneous
  force as the semantic gate for the optional late paired release. Against two
  reproduced v28 parent rollouts (`-0.528103`, mean `2.429108 L`, final
  `0.746163 L`), the current direct-uniform samples all retain capture at
  `25.11852 T`, but a body-frame constant-velocity intercept corridor is best
  at `-0.528077`, mean `2.429087 L`, and final `0.746135 L`; an adverse-force
  veto is intermediate at `-0.528086`, mean `2.429094 L`, and final
  `0.746145 L`. Below `1.6 L`, the intercept gate also slightly improves mean
  range and peak force without materially increasing commands or moments, and
  both visual rows preserve the parent's coherent outer wake and quiet glide.
  This does not overturn the inherited negative mean-unloading result
  (`-0.529558`): keep the shared bend, phase, joint roles, and `3.5%` release
  budget fixed. The implication applies only with positive closure, helpful
  body-relative crossflow, late proximity, and settled two-joint response; it
  remains a one-sample `2.6e-5` gain and is falsified by non-reproduction,
  changed outer motion, delayed or lost capture, worse miss/distance, renewed
  oscillation or clipping, joint-stop dwell, load growth, instability, or wake
  degradation.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
