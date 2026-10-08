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
  The completed near-field anterior-redirect response release sharpens that
  boundary. Gating only the additive redirect inside `1.5--1.0L` by normalized
  target-relative bearing-window recovery preserves the same visible S-route,
  coherent two-view wake, and peak normalized force/moment
  (`0.031649/0.016385`), and lowers mean action inside `1.5L` from about
  `43.000` to `42.624`; nevertheless it captures two steps later at
  `24.321011T` and raises mean distance from `2.223959L` to `2.223987L`.
  Reduced terminal action is therefore not a proxy for better allocation when
  it removes anterior yaw authority. Do not retry derivative response release
  on the anterior redirect or another scalar terminal gate; a later mechanism
  should change a physically distinct observation or disturbance pathway and
  must preserve or beat both fixed-pose capture boundaries. Two current
  observation-level tests meet that requirement independently. Replacing
  inertial lateral speed in the slow curvature request with sign-equivalent
  body-minus-local-water sideslip preserves the top-down S-route and advances
  capture from `24.310009T` to `24.018509T`, lowers mean distance from
  `2.223959L` to `2.206025L`, and slightly reduces mean action and peak
  normalized force/moment, with rate-cap occupancy near baseline. Separately,
  recruiting anterior oscillator energy only under a normalized forward-speed
  deficit advances capture to `23.985519T`, improves distance at `2T` from
  `12.267558L` to `12.218429L` and mean distance to `2.202000L`, and retains a
  coherent complete two-view wake with lower peak force/moment, although mean
  action and rate-cap occupancy rise modestly. Their composition is now a
  verified positive result rather than an untested assumption: three
  comment-only variants reproduce exactly the same `23.864521T` capture,
  `2.192138L` mean distance, and `-0.294271` score, beating both components
  while preserving the visible top-down S-route. Mean action remains about
  `57.57`, anterior/posterior rate-cap occupancy about `11.75/6.41%`, and peak
  normalized force/moment about `0.02948/0.01534`, so reuse the two loops as
  compatible but physically separate water-relative route sensing and
  feedback-gated locomotor recovery, not as permission for scalar steering or
  drive tuning. Falsify reuse if capture is later than `23.864521T`, mean
  distance exceeds `2.192138L`, or action, saturation, load, route, or wake
  envelopes worsen. All three composed-policy oblique sheets are black render
  artifacts; the complete speed-recovery control still bounds the inherited
  three-dimensional wake class, but the composition does not establish new 3D
  wake robustness. Actual inflow, wake, or pose variation with complete visual
  evidence remains the relevant held-out test. The completed axial-observation
  translation is a further semantic improvement: two independently authored
  policies that replace inertial forward speed with sign-equivalent normalized
  body-minus-local-water speed reproduce exactly the same `23.424515T`
  capture, `2.184349L` mean distance, and `-0.287480` score, beating the
  inertial-speed composition's `23.864521T`, `2.192138L`, and `-0.294271`
  without changing its visible top-down S-route. Reuse local-water-relative
  axial recovery as the locomotor baseline, but retain its measured cost
  boundary: mean/near-target action rise to about `58.289/45.013`, rate-cap
  occupancy remains about `11.74/6.65%`, and peak normalized force/moment are
  `0.029780/0.015287`. An independently sampled fast load pathway also survives
  a matched test. Adding a small posterior residual only when normalized yaw
  moment opposes the target-side turn advances the inertial-speed baseline to
  `23.545517T`, lowers mean distance to `2.188316L`, and improves score to
  `-0.291201`, while peak force/moment fall slightly to
  `0.029290/0.015223`; this supports separating measured adverse load from the
  slow route request, not increasing rudder gain or cancelling every moment.
  Their composition is not yet evaluated. Falsify it unless it preserves or
  beats the reproduced `23.424515T`, `2.184349L`, and `-0.287480` boundaries
  without worsening action, saturation, load, route, or wake envelopes. Every
  assigned oblique row for these newest samples is a black render artifact, so
  neither positive result expands the inherited 3D-wake or held-out robustness
  claim.
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
