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
- The first two generations establish a useful separation between carrier,
  redirect, response release, and command feasibility. The transferred carrier
  formed a coherent wake but missed below after reaching `4.780L`; replacing it
  with opposite-sign static posture turns produced weak-wake upper exits, one
  with `78.0%` posterior angle-limit exposure. Preserving the carrier while
  shifting its oscillator centers into the sampled same-sign, body-frame-error-
  gated C-bend instead captured at `25.388T` (mean distance `2.557L`). On that
  same capture topology, response-triggered bend release independently improved
  arrival to `25.152T` and mean distance to `2.522L`, while a component-wise
  smooth acceleration projection improved them further to `23.997T` and
  `2.438L` and kept recorded raw commands below `31.42 rad/T^2`. Therefore
  preserve the successful bend polarity and carrier, and treat response release
  and final command projection as compatible but distinct control layers rather
  than cadence gains or wholesale posture replacement. Applicability is limited
  to the present joint/observation conventions and sampled still-water pose;
  projection alone did not reduce all kinematic symptoms (`4.5%` posterior
  velocity-cap exposure and `2.922 rad/T` peak yaw), so falsify a combined design
  if capture/wake coherence regresses or joint/yaw histories worsen despite
  bounded acceleration.
- Terminal comparisons now reject repeated cue arbitration, command-pressure
  allocation, and joint-velocity phase-lag damping, while isolating an
  actuation-coupling trade. The v24 continuous
  course brake captured at `23.8315T` with mean distance `2.434073L`, but had
  `3.208 rad/T` peak yaw and `1.684 rad/T` mean absolute yaw inside `3L`.
  Hard course/yaw consensus and yaw-selected static damping arrived at
  `23.8590T`/`23.8535T` with essentially unchanged terminal yaw/load. A
  moment lead reached the boundary at `23.8260T`, but worsened mean/final
  distance to `2.435488L`/`0.748944L` without material yaw cleanup; a
  pressure-gated residual allocator likewise worsened mean distance to
  `2.435590L` and raised inside-`3L` yaw to `1.704 rad/T`. In contrast,
  half-cycle-only terminal curvature reduced inside-`3L` yaw and cross-track
  speed to `1.616 rad/T` and `0.213U`, but delayed capture to `23.9085T`.
  A posterior phase-lag damper then preserved the coherent capture topology
  but worsened mean/final distance to `2.435327L`/`0.748560L`, while changing
  inside-`3L` yaw only from `1.684` to `1.678 rad/T`.
  The assigned-parent child v29 provides the first direct intervention on the
  tail-side correlation: adding a posterior counter-tangent only on the
  yaw-supporting half-cycle improved arrival/mean distance from v24's
  `23.8315T`/`2.434073L` to `23.7930T`/`2.433953L`, but increased inside-`3L`
  mean/peak yaw from `1.684`/`3.208 rad/T` to `1.706`/`3.289 rad/T` and peak
  absolute moment from `0.01409` to `0.01512`. Thus posterior side is a
  consequential actuator coordinate, but another same-path counter-tangent is
  not a clean yaw/load remedy.
  The completed v33 reallocation supplies the positive counterpart: moving a
  phase-selected excess-yaw residual to the anterior oscillator while leaving
  posterior amplitude and lag unchanged captured at `23.8425T`, improved
  score/mean/final distance over sampled v30 to
  `-0.535091`/`2.433543L`/`0.746165L`, and reduced inside-`3L` peak yaw/moment
  from `3.2645 rad/T`/`0.014385` to `3.1848 rad/T`/`0.013730`. A subsequent
  fixed `25%` transfer of continuous course curvature to the anterior joint
  reduced yaw/load further but regressed score to `-0.535920`, mean/final
  distance to `2.434212/0.747022L`, and arrival to `23.8480T`; this falsifies
  another fixed allocation-share retune as a progress improvement. Moreover,
  replay of completed v33 shows its nominal carrier-rejected yaw still
  correlates `-0.954` with full-tail tangent velocity inside `3L` (RMS
  `0.635 rad/T` versus signed mean `0.111 rad/T`). Thus the next distinct test
  should improve fast-carrier/slow-route observation separation before adding
  steering authority: a distributed two-joint rate coordinate is admissible,
  but offline decorrelation is only a diagnostic and must retain v33-scale
  capture/progress while preserving or improving yaw/load in CFD.
  The completed observer comparisons now establish that signal scope, not
  decorrelation alone, determines whether the distributed coordinate is useful.
  Feeding `0.17*(phi_dot[1]+phi_dot[2])` into both terminal feedback roles
  reduced yaw on its inherited rollout but delayed capture to `23.8700T` and
  regressed score/mean/final distance to
  `-0.536789/2.434939L/0.747952L`. In contrast, two independently written
  sampled policies that kept the anterior-only observer for continuous course
  curvature and used the same distributed rate only for the phase-selected
  anterior residual produced bit-identical CFD trajectories: capture improved
  from v33's `23.8425T` to `23.8370T`, with score/mean/final distance improving
  to `-0.535013/2.433468L/0.746096L`. Inside `3L`, mean absolute yaw and
  target-cross-track speed improved narrowly from `1.67999 rad/T` and
  `0.23924U` to `1.67938 rad/T` and `0.23868U`, and peak moment fell from
  `0.013730` to `0.013581`, while peak yaw rose slightly from `3.18484` to
  `3.19386 rad/T`; joint-speed and smoothly projected command envelopes were
  essentially unchanged. Therefore retain the role-separated observer, but do
  not extend its distributed cue back into the course brake or promote the
  one-step benefit into a stronger gain. This lesson applies to the sampled
  direct-uniform still-water capture topology; falsify it if repeat or held-out
  CFD loses the coherent wake, v33-scale progress, mixed terminal-load balance,
  or actuator feasibility.
  Two inherited step-26 follow-ups now bound attempts to improve that mixed
  terminal defect. One-sided `12%` anterior envelope relief retained the
  `23.8370T` capture and reduced inside-`3L` peak yaw and mean/peak target-
  cross-track speed from `3.19386 rad/T` and `0.23868/0.56914U` to
  `3.18039 rad/T` and `0.23829/0.56810U`, but regressed score and scoring
  mean/final distance to `-0.535880` and `2.434158/0.746981L` and raised peak
  moment from `0.013581` to `0.013804`. Advancing the existing phase selector
  with displacement-rate quadrature also retained the same capture step, but
  regressed score and scoring mean/final distance to
  `-0.535561/2.433904/0.746654L`, raised mean yaw to `1.67990 rad/T`, and
  raised peak moment to `0.013725` while only trimming peak yaw to
  `3.19110 rad/T`. The completed follow-ups close that branch rather than
  rescuing it: a second rate-led phase selector retained the `23.8370T`
  capture and slightly reduced peak yaw/cross-track speed, but regressed
  score and mean/final distance to `-0.535363/2.433747/0.746448L` and raised
  peak moment from `0.013581` to `0.013888`; redistributing `12%` of the
  anterior envelope between half-cycles likewise kept the capture step and
  reduced mean/peak yaw to `1.67906/3.18426 rad/T`, but regressed to
  `-0.536347/2.434528/0.747467L` and raised peak moment to `0.013790`.
  Therefore reject further phase anticipation, one-sided envelope removal,
  and beat-side envelope redistribution: lower lateral motion without the
  split baseline's progress and load balance is not improvement.
  The assigned-parent local-crossflow consistency gate supplies a separate
  negative observation lesson. In the split baseline, inside-`3L` local
  crossflow correlated `-0.8015` with yaw moment but only `0.1255` with yaw;
  nevertheless, attenuating the anterior residual when that instantaneous
  flow appeared to provide helpful counter-yaw regressed score and mean/final
  distance from `-0.535013/2.433468/0.746096L` to
  `-0.536241/2.434443/0.747358L`. Mean/peak cross-track speed worsened from
  `0.23868/0.56914U` to `0.23894/0.57061U`, mean yaw rose from `1.67938` to
  `1.67952 rad/T`, and peak moment rose from `0.013581` to `0.013650`; only
  peak yaw fell marginally from `3.19386` to `3.19158 rad/T`, with essentially
  unchanged joint/command envelopes and wake topology. Thus offline
  correlation and plausible sign do not establish a causal actuator role for
  an instantaneous flow proxy. Avoid another local-flow gate or scalar retune
  of it; preserve or restore the replicated split observer unless a distinct
  mechanism improves progress, yaw, and load together in CFD. This boundary
  applies to the sampled direct-uniform still-water approach; a flow cue may be
  reconsidered only under a held-out disturbance where it predicts a semantic
  trajectory change rather than the same capture path.
  Three independently sampled v37 texts then reproduced a bit-identical
  `23.8370T` capture at `-0.535013/2.433468/0.746096L`, whereas the rate-led
  phase selector, half-cycle envelope redistribution, and local-flow gate all
  kept that capture step while worsening mean/final distance and peak moment.
  This repetition makes unchanged capture timing plus a tiny lateral or yaw
  reduction a branch-termination signal, not progress: do not add another
  fast-signal gate to the anterior residual. The completed target-relative
  cadence and handoff comparisons now resolve a useful propulsion-side role.
  Qualifying the small cadence reserve by positive body-frame target-radial
  translation captured at `23.3750T`, and the four current samples share the
  same trajectory through their first `3L` crossing. Keeping that reserve
  everywhere scored `-0.505158` with mean/final distance
  `2.402131/0.748882L`; withdrawing it monotonically with proximity regressed
  to `-0.505421/2.402386/0.749093L`, while a middle-band distance window only
  partly recovered to `-0.504742/2.401955/0.748290L`. In contrast, yielding
  the reserve in proportion to the existing bounded terminal course-brake
  demand was best at `-0.503415/2.400748/0.747085L`, retained the full-release
  capture time, and reduced inside-`3L` peak yaw from `3.29199` to
  `3.27552 rad/T`. It did not solve loads: mean yaw stayed essentially flat
  and peak moment rose from `0.014507` to `0.014923`. Therefore retain radial
  progress as a propulsion qualification and prefer measured stabilization
  demand over distance alone for handing off only reserve cadence; do not
  retune another monotone or bell-shaped distance schedule. A successor may
  protect the demand handoff with closing quality, but must preserve the
  shared pre-`3L` trajectory and the demand sample's score/final-distance
  gain while bounding yaw, moment, cross-track motion, and actuator exposure.
  This implication is limited to the sampled direct-uniform still-water
  capture topology and does not establish benefit under imposed inflow or
  wake disturbances.
  Therefore preserve v24's continuous target-course curvature and coherent
  carrier; avoid another sign gate, moment lead, acceleration-headroom
  allocator, joint-velocity phase-lag residual, or stronger posterior counter-
  tangent, fixed course-curvature transfer, or another posterior relief share.
  If terminal yaw is targeted, preserve the split observer's anterior-only
  course response, distributed phase classification, anterior phase-selected
  correction, and posterior traveling wave. This implication is limited to the
  sampled direct-uniform still-water capture topology; falsify any successor if
  it loses the coherent alternating wake, split-observer-scale capture/progress,
  or terminal yaw/load performance, regardless of improved signal processing.
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
