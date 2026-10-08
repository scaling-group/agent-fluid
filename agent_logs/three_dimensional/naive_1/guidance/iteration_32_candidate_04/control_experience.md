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
- Direct-uniform still-water evidence separates propulsion progress from route
  control. The drive-only seed formed a coherent 3D posterior wake but reached
  only `12.078L` before upper exit. Four inherited shared/partial
  mean-curvature variants then retained `left_domain` and regressed final
  distance to `13.258--15.361L`; do not retry common, shared, or tail-biased
  moving equilibria by scalar gain changes. Anterior useful-half-cycle steering
  instead improved minimum/final distance to `11.782/11.797L`, while posterior
  half-cycle scaling and a shared residual were weaker (`12.006/12.205L` and
  `12.140/12.686L`). A later slip-aware, both-stroke anterior residual retained
  the alternating wake and improved monotonically to `10.062L`, yet all sampled
  variants still hit the `260 deg/T` rate cap and exited the upper boundary. In
  that strongest trace, bearing reversal was followed by opposite joint means
  of about `-0.081/+0.122 rad` near exit because the full biased anterior angle
  entered the `-q1` tail target. Reuse the narrow positive result—body-frame
  slip feedback and anterior steering can preserve thrust and substantially
  improve progress—but do not treat an opposite-mean posterior response or
  more drive gain as directed turning. The subsequent anterior-only curvature
  center with a zero-mean posterior lag is a real semantic improvement: all
  four sampled descendants replace the early upper hook with a long
  lower-going trajectory, preserve self-propelled 3D wake evidence, and reach
  `4.233--5.033L`. It is not yet route control. The plain center passes below
  the target with bearing near `1.13 rad` at its `5.033L` minimum and exits at
  `28.59T`. Bearing-gated posterior relief gives the narrow best result:
  minimum/mean distance improve to `4.233/8.611L`, survival extends to
  `31.87T`, and tail rate-cap occupancy falls from about `13.4%` to `5.2%`;
  nevertheless bearing is still `1.405 rad` at closest approach and the same
  lower exit remains. Target-signed slip rectification independently reaches
  `4.252L` but retains that topology, so it is not a reliable missing
  mechanism. Recent-yaw unloading reaches `4.376L` but lets joint motion,
  command effort, and the visible wake decay nearly to zero after about `18T`,
  leaving an inertial coast to the boundary. Reuse anterior/tail mean
  separation and modest posterior relief, but avoid direct recent-yaw
  unloading and further slip or relief scalar tuning as substitutes for yaw
  authority. The subsequently sampled phase-selective tests sharpen that
  boundary. An anterior redirect plus symmetric relief reaches `4.018L`, while
  adding posterior half-cycle redistribution produces the best approach,
  `3.691L`, with a coherent three-dimensional wake and about `13.7/5.5%`
  anterior/posterior rate-cap occupancy; both still pass below the target and
  exit low. In the latter trace the target passes abeam at `21.19T` and
  `3.722L`, but the folded-bearing gate starts releasing by `24.71T` at
  `4.697L` even though the full head-relative error is `2.243 rad`. A
  full-angle posterior-only descendant independently reaches `3.909L` and
  keeps its gait modulation active behind the head, yet still exits low with
  full error `2.721 rad` near `32T`; fixing target geometry is therefore not
  yaw authority by itself. The completed assigned-parent test now falsifies
  the proposed combination with the whole-body half-cycle mechanism as well.
  Full-angle activation preserves its coherent wake and `3.691L` pre-abeam
  approach exactly and lowers rate-cap occupancy slightly, but still scores
  `-10.410`, exits low at `33.65T`, and lets rear-target error rise from
  `1.60` to `2.54 rad`. During `28--32T`, its anterior/posterior means remain
  opposite-signed at about `+0.207/-0.081 rad` while mean heading rate is only
  `0.018 rad/T`: preventing false gate release leaves an S-shaped carrier with
  negligible sustained yaw. Preserve full normalized body-frame geometry for
  recovery decisions, but do not spend another test on its gate, relief, or
  phase-asymmetry gains. The sampled near-target one-sided anterior envelope
  gives a narrow reusable semantic result: it keeps the rhythmic wake active
  and lowers full error at closest approach from `1.364` to `1.291 rad`, but
  slightly worsens minimum distance to `3.712L` and retains the lower exit, so
  anterior envelope reshaping alone is not capture authority. The completed
  assigned-parent same-sign posterior C-bend is a stronger negative result and
  a useful actuator-sign calibration. It preserves the `3.692L` approach and
  realizes the intended shape by moving the `22--26T` posterior mean from
  about `-0.093` to `+0.093 rad` at nearly unchanged anterior mean, with no
  posterior rate-cap occupancy or larger load peak. Yet mean yaw moves the
  wrong way, from `-0.018` to `+0.019 rad/T`, full error grows from `1.783` to
  `2.251 rad`, and the visibly tighter curl exits low earlier at `32.23T`.
  Thus joint-mean geometric appearance is not a proxy for useful yaw: do not
  retry a same-sign C-bend or tune its magnitude. A distinct posterior load
  pathway may use the measured opposite sign before abeam, but it is reusable
  only if it produces target-signed mean yaw, improves both the `3.691L`
  distance and `1.291 rad` alignment boundaries, and preserves the established
  wake, saturation, and force/moment envelope. The subsequently sampled
  reactive-rudder test clears every one of those task-level boundaries and is
  the first capture in this lineage. It replaces the late same-sign C-bend
  with an opposite-sign posterior mean load jointly scheduled by full
  head-relative error and normalized `8.0--5.5L` proximity, preserves the
  joint-state traveling carrier, and captures at `24.338T` and `0.749625L`
  instead of exiting low. The top-down and oblique sheets retain coherent
  wake structures, anterior/posterior rate-cap occupancy stays finite at
  about `13.0/6.6%`, and peak normalized force/moment remain near
  `0.0317/0.0164`. Reuse the combined invariant—select posterior load sign
  from measured target-side yaw and recruit it before abeam while retaining
  the carrier—but do not attribute success to sign alone because onset,
  gating, and magnitude changed together. Three independent evaluations of the
  unmodified schedule now reproduce the exact `24.337509T`, `0.749625L`,
  `2.224316L` mean-distance capture and the same trajectory, which establishes
  deterministic repeatability in the released configuration. It does not
  establish held-out robustness, and the small sub-threshold final distance is
  not a useful margin statistic under first-crossing termination. Only the
  original evaluation has a complete oblique sheet; the three newer oblique
  sheets are blank render artifacts, so their top-down and numerical
  replication must not be misreported as independent 3D-wake confirmation.
  The assigned-parent terminal experiment is also a concrete negative result:
  multiplying the posterior rudder by up to `1.2` whenever one-step closing
  speed falls below `0.35L/T` preserves capture and the established peak
  force/moment and rate-cap envelope, but delays arrival to `24.4145T`, worsens
  mean distance from `2.224316L` to `2.224632L`, and tightens the crossing to
  `0.749996L`. Do not retry one-step closing-deficit rudder augmentation; its
  beat-scale signal adds tail load without useful terminal progress. A later
  approach mechanism is applicable only with complete visual evidence and a
  smoothly observed response or distinct terminal objective, and robustness
  must be tested across pose or hydrodynamic axes rather than inferred from a
  single crossing overshoot. The matched sampled relief test supplies a narrow
  positive allocation result: removing up to 20% of only the posterior rudder
  under the same closing deficit advances capture by two control steps from
  `24.337509T` to `24.326511T`, lowers mean distance from `2.224316L` to
  `2.224097L`, and reduces mean action norm inside `1.5L` from `42.948` to
  `42.934`, while peak normalized force/moment (`0.031649/0.016385`) and
  anterior/posterior rate-cap occupancy (`14.04/6.92%`) remain unchanged.
  Together with the harmful boost, this supports preserving the rhythmic
  carrier while releasing an over-allocated terminal steering offset rather
  than adding tail load. Four subsequent evaluations reproduce the broad
  relief trajectory byte for byte, including the exact `24.326511T` capture,
  `0.749329L` crossing, and `2.224097L` mean distance. Complete top-down and
  oblique sheets show its alternating mid-plane street and discrete
  three-dimensional Lambda2 structures through capture; blank oblique sheets
  in two repeats are render artifacts, not additional 3D-wake evidence. The
  completed target-side anterior-stroke qualification is a narrower positive
  mechanism: two current samples and one inherited evaluation reproduce the
  exact `24.310009T` capture, `0.749162L` crossing, and `2.223959L` mean
  distance, while peak normalized force/moment stay `0.031649/0.016385` and a
  complete two-view sheet retains the carrier wake. Near-target mean action
  rises modestly from about `42.934` to `43.000`, so this is evidence for
  phase allocation, not lower effort or greater tail load. Matched negative
  controls tightly bound its reuse: normalized translation-alignment relief
  captures later at `24.343010T`; requiring an inferred posterior
  carrier/rudder-reinforcement intersection regresses to `24.326511T` and
  `2.224136L`; and broadening relief through the lagging posterior joint keeps
  the `24.310009T` crossing step but worsens crossing/mean distance to
  `0.749469/2.224193L`. Do not replace the beat-scale closing response solely
  because another signal is smoother, nor narrow or extend the evidenced
  anterior phase interval with modeled or downstream joint phase. Preserve
  the carrier, rudder sign, 20% ceiling, response path, and anterior
  qualification; falsify reuse if capture is later than `24.310009T`, mean
  distance exceeds `2.223959L`, the preterminal route changes, or wake,
  saturation, effort, force, or moment worsens. These fixed-pose repetitions
  establish determinism rather than robustness; a pose or hydrodynamic
  perturbation is now more informative than another terminal gate refinement.
- Two later matched samples identify compatible improvements outside the
  exhausted terminal-gate family. Replacing inertial lateral speed only in the
  slow curvature request with measured water-relative sideslip advances
  capture from `24.310009T` to `24.018509T` and lowers mean distance from
  `2.223959L` to `2.206025L`; its complete top-down trace retains the route and
  lowers peak normalized force/moment to `0.030487/0.015991`, but its blank
  oblique row is a render failure and provides no new 3D-wake evidence.
  Independently, bounded anterior oscillator-energy recruitment below the
  sampled `0.45U` cruise envelope improves `2T` progress from about `0.062L`
  to `0.110L`, captures earliest at `23.985519T`, and lowers mean distance to
  `2.202000L`. Its complete two-view sheet retains the alternating 3D carrier
  and peak force/moment fall to `0.029769/0.015087`, although mean action rises
  from about `56.67` to `57.59` and exact-cap occupancy rises modestly. Three
  semantically identical sampled combinations now reproduce the exact
  `23.864521T` capture, `0.749310L` crossing, `2.192138L` mean distance, and
  `-0.294271` score. The combination therefore beats the stronger independent
  result rather than merely preserving it; mean action falls slightly to
  `57.572`, peak normalized force is `0.029479`, peak moment is `0.015344`,
  and anterior/posterior exact rate-cap occupancy remains about
  `11.75/6.41%`. Its complete top-down sheets preserve the route and
  alternating wake, but all three oblique rows are blank render failures, so
  the earlier complete speed-recovery sheet remains the only 3D-wake bound.
  Reuse the semantic allocation: local-water-relative motion belongs in the
  bounded slow route loop, while measured forward-speed deficit may
  transiently re-recruit the carrier without changing its cruise or terminal
  law. This compatibility is fixed-pose still-water evidence, not imposed-wake
  robustness; preserve the `23.864521T`/`2.192138L` arrival and mean-distance
  boundaries and reject later translations that worsen the established route,
  wake, saturation, effort, or load envelope.
- The next completed observation translation and its failed composition set a
  stronger compatibility boundary. Replacing only inertial axial speed in the
  combined controller's bounded recovery gate with sign-correct body-minus-
  local-water speed is reproduced by two comment-only variants: both advance
  capture from `23.864521T` to `23.424515T`, lower mean distance from
  `2.192138L` to `2.184349L`, and improve score from `-0.294271` to
  `-0.287480`. Their complete top-down sheets retain the same self-propelled
  S-route and attached alternating street, although every current oblique row
  is blank and supplies no new 3D-wake evidence. Reuse through-water axial
  speed as locomotor feedback rather than treating inertial transport as
  propulsion recovery; this is not permission to increase its gain. In the
  newest inherited logs, three executable-identical descendants then compose
  the independently positive adverse-yaw-moment posterior residual with that
  through-water parent and reproduce the same regression: capture moves to
  `23.853519T`, mean distance rises to `2.194872L`, and score falls to
  `-0.297049`. Capture, stability, and the top-down wake survive, so the
  negative result is specifically actuator-path non-additivity rather than a
  general load-feedback failure. Do not retry the unqualified moment residual
  on the through-water carrier or assume independently positive feedback loops
  compose. A later load-path test needs a distinct allocation or causal gate
  and must beat `23.424515T/2.184349L` without worsening the established
  action, saturation, force, moment, route, or wake envelopes.
- Matched posterior-recovery samples now isolate which carrier quadrature can
  reuse the through-water speed-deficit response. Three whole-carrier repeats
  capture at `23.331013T`, with mean distance `2.135772L` and score
  `-0.239045`; moving the same bounded share from whole-carrier scaling to only
  the anterior-velocity tail-lag term advances capture to `23.122009T`, lowers
  mean distance to `2.133413L`, and improves score to `-0.237071`. The latter
  crosses from behind at `9T` to ahead by `12T` and lowers peak normalized
  force/moment from `0.030861/0.016213` to `0.030360/0.015861`, supporting a
  later route benefit from posterior phase allocation rather than faster
  startup. It also raises mean action from `59.044` to `60.062` and rate-cap
  occupancy from about `11.34/6.27%` to `11.92/7.06%`, so do not describe the
  phase-lag result as lower-effort propulsion or increase its scalar gain. Both
  top-down sheets retain the captured S-route and alternating wake, but the
  phase-lag oblique row is blank; the complete whole-carrier sheet remains the
  3D-wake bound. An independent attempt to qualify whole-carrier recovery by
  the instantaneous `lagged_carrier * qd2` work sign regresses score to
  `-0.247507` despite retaining capture. Avoid that unvalidated power proxy;
  a later state qualification must preserve the `23.122009T/2.133413L`
  arrival and mean-distance boundaries, improve rather than merely trade
  early progress for route, and keep action, saturation, loads, and a complete
  two-view wake within the established envelopes. The completed assigned-parent
  angle-quadrature composition sharpens that boundary: adding course-aligned
  posterior amplitude to the successful velocity-quadrature recovery preserves
  capture and a coherent complete two-view wake, but delays it to `23.265013T`,
  raises mean distance to `2.137810L`, regresses score to `-0.241061`, and
  raises peak normalized force to `0.031321` even though mean action falls to
  about `58.970`. Do not stack posterior angle amplitude onto the phase-lag
  recovery or interpret lower action alone as better locomotor allocation. A
  newly completed measured-state qualification rules out the most obvious
  alternative. Smoothly removing only the phase-lag increment as posterior
  rate rises from `0.95` to `1.0` of its physical ceiling lowers mean action
  from `60.062` to `59.301`, posterior exact-cap occupancy from `7.06%` to
  `6.65%`, and peak normalized force/moment from `0.030360/0.015861` to
  `0.030257/0.015625`; nevertheless it delays capture to `23.314514T`, raises
  mean distance to `2.136120L`, and regresses score to `-0.239352`. Its
  complete two-view sheet retains the coherent wake, so the loss is a route
  and phase-allocation failure rather than instability or wake collapse.
  Exact-cap occupancy is therefore not evidence that a velocity-quadrature
  command is dispensable: preserve that increment across the measured rate
  envelope, and do not retry tail-rate headroom unloading or the aligned angle
  quadrature. A later state allocation must beat the `23.122009T/2.133413L`
  arrival and distance boundaries without worsening the established route,
  action, saturation, force, moment, or complete-wake envelopes. The newly
  completed inherited target-side half-cycle redistribution also fails that
  boundary: moving at most 15% of the same velocity-quadrature increment
  between anterior stroke signs retains capture and the broad top-down wake,
  but delays arrival to `23.452015T`, raises mean distance to `2.142002L`,
  regresses score to `-0.244905`, and raises peak normalized force/moment to
  `0.031112/0.016113`; its oblique row is blank, despite the originating note's
  complete-wake claim. Do not retry posterior phase-recovery half-cycle
  redistribution or count a black labeled oblique sheet as 3D evidence. A
  sibling observation correction supplies a distinct warning: subtracting a
  fitted anterior-velocity estimate from lateral through-water sideslip turns
  the same capture family into a `0.813329L` near miss followed by domain exit
  at `36.409981T` and `6.290125L` final distance. Its valid two-view sheet keeps
  discrete Lambda2 structures and a rhythmic street through the miss, so the
  `-7.210659` regression is route corruption rather than wake collapse. Avoid
  fitted beat-synchronous self-motion subtraction and further phase-local
  recovery modifiers; a later recovery test should use a bounded mutually
  exclusive allocation or a separately observed slow causal gate, and must
  beat `23.122009T/2.133413L` without worsening the established actuator,
  load, route, and valid two-view-wake bounds.
- The completed parent and sibling tests establish two individually positive
  state allocations and now also establish their compatibility. Full-angle
  target-error allocation of the fixed `0.12` posterior recovery share between
  whole-carrier amplitude and velocity-quadrature lag preserves the
  `23.122009T` capture while lowering mean distance from `2.133413L` to
  `2.127679L`, score from `-0.237071` to `-0.231273`, and mean action from
  `60.062` to `58.990`; it leads at `4--8T` but trails the phase-only
  recovery by `20T`. Separately, bounded
  `bearing_window_rate - turn_rate_recent` lead only in the rudder gate
  advances capture to `22.572023T` and lowers mean distance to `2.127978L`,
  at the cost of mean action rising to `60.545`. Three executable-identical
  compositions reproduce the stronger result exactly: capture at
  `22.500492T`, `2.120233L` mean distance, `0.749267L` crossing, and score
  `-0.225086`. They retain the allocation policy's `4/8/9T` distances, then
  improve distance by `16/20/22T` to `4.095/2.002/0.970L`; full target error
  at crossing falls from about `1.202` to `0.760 rad`, and target-directed
  radial speed rises from approximately `-0.009` to `+0.380L/T`. Peak
  normalized force/moment stay at `0.030527/0.015817`, while mean action and
  anterior/posterior rate-cap occupancy rise modestly to about
  `59.671` and `12.05/6.58%`. All three top-down sheets retain the
  self-propelled S-route and alternating street; one valid oblique sheet shows
  discrete 3D Lambda2 structures through capture, while the other rows are
  blank render artifacts and add no 3D evidence. Reuse the semantic
  separation and compatibility—slow full-angle geometry can allocate one
  fixed locomotor budget while de-yawed target-line rate leads bounded
  steering—but do not call the lead lower-effort propulsion or increase either
  authority. A later coordination mechanism must beat
  `22.500492T/2.120233L/-0.225086`, preserve the early allocation lead and
  late pursuit benefit, and remain inside these action, saturation, load,
  route, and valid two-view-wake bounds. Exact fixed-pose repeats establish
  determinism and compatibility, not robustness to changed pose, inflow,
  hydrodynamics, or external wakes.
- Three current executable-identical descendants now show that the bounded
  one-cycle target-line prediction is useful beyond rudder recruitment: using
  predicted full-angle error to allocate the same fixed `0.12` posterior
  recovery budget reproducibly advances capture from `22.500492T` to
  `22.307997T`, lowers mean distance from `2.120233L` to `2.107401L`, and
  improves score from `-0.225086` to `-0.212396`. A complete two-view sheet
  retains the self-propelled S-route, attached alternating mid-plane street,
  and discrete three-dimensional Lambda2 structures through capture. The gain
  is not free: mean action is about `59.675`, exact anterior/posterior rate-cap
  occupancy is about `11.54/6.36%`, and peak normalized force rises modestly
  from `0.030527` to `0.030897` while peak moment is `0.015839`. Reuse the
  invariant that slowly predicted body-frame geometry can move an existing
  mutually exclusive posterior gait budget without stacking authority, but
  require a later coordination mechanism to beat
  `22.307997T/2.107401L/-0.212396` without exceeding those actuator and load
  envelopes. A sibling that captures later at `22.423492T` and
  `2.117908L` simultaneously restores current-error recovery allocation and
  adds proximity-dependent rudder look-ahead; its black oblique row is a
  render failure, and the two simultaneous edits make it invalid evidence
  against proximity lead alone. Do not discard the reproduced predictive
  allocator or infer a single cause from that confounded regression.
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
