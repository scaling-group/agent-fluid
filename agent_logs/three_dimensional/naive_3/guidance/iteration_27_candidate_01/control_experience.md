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
- The common naive oscillator/posterior-lag carrier is already self-propelling
  in direct-uniform still water, but that does not establish useful navigation:
  the sampled seed traveled about `1.52L` with a coherent 3D wake yet improved
  target distance by only `0.258L`, accumulated `1.252 rad` heading error, and
  exited the upper boundary at `8.602T`. When this zero-steering topology
  recurs, test bounded body-frame target-error-to-mean-curvature feedback while
  preserving the lagged carrier before changing scalar drive gains. This
  implication applies only when the wake and displacement confirm propulsion;
  a wrong-sign turn, lost wake coherence, or worse actuator-limit residence
  falsifies the curvature sign or joint split and should be corrected before
  adding flow or force compensation.
- Once restrained target-relative curvature establishes a coherent approach,
  preserve its cruise scaffold and diagnose the near miss by relative geometry
  and motion rather than proximity alone. In the completed samples, posterior
  bearing gating improved closest approach from `4.067L` (plain `7 deg`
  curvature) and `3.587L` (toward-bend half-cycle boost) to `2.443L`, with a
  coherent wake and survival to `31.097T`. Across the three closest sampled
  approaches, median closing response fell consistently from about
  `0.586--0.606 L/T` between `3--4L` to `0.131--0.163 L/T` inside `2.7L`; at
  the best minimum the full body-frame direction error was about `1.42 rad`
  while translational speed remained about `0.669 U`, after which the fish
  receded to a lower-boundary exit. A distance-only energy envelope (`2.845L`),
  full-direction posterior gating alone (`2.494L`), and away-half-cycle braking
  (`2.501L`) all preserved that topology. Two inherited attempts to repair the
  course earlier also failed: matched-window target-ray lead worsened minimum
  and mean distance from `2.443/8.443L` to `3.167/8.602L`, and an earlier
  wrong-side lateral-velocity posterior guard reached only `2.697L`; both
  retained the powered lower exit. Direct sideslip-to-curvature feedback was
  worse still, reversing the useful release into an upper exit with only
  `12.150L` closest approach. Later completed evidence nevertheless separates
  posterior sign and persistence: a sampled `7 deg` opposite-sign posterior
  counterbend improved minimum distance from `2.443L` to `2.187L`, kept mean
  distance nearly unchanged (`8.446L` versus `8.443L`), and preserved the long
  coherent wake, whereas the assigned parent's approach-localized same-sign
  response-gated posterior redirect reached only `2.601L`; both still exited
  low. In the `2.187L` trace, its instantaneous lateral-velocity gate exceeded
  `0.05` on only `57%` of samples inside `3L` and repeatedly released while
  normalized lateral target error remained `0.7--1.0`. Since the carrier
  already clamped anterior/posterior acceleration for about `0.746/0.354` of
  its samples, avoid more scalar relief, isolated half-cycle effort, persistent
  early line-of-sight/slip correction, another same-sign posterior redirect,
  or treating a single corrective velocity half-cycle as completed recovery.
  That provisional opposite-sign test is now closed: making the posterior
  S-bend persist with lateral target geometry reached only `2.484L` and kept
  the same powered lower exit. Posterior sign was informative for the earlier
  velocity-gated action, but did not transfer into a useful persistent
  equilibrium mechanism.
- Treat measured yaw as a gait-half-cycle selector, not a slow course estimate,
  in this coherent powered-below-target topology. Weakening the posterior wave
  only while signed yaw grows the target-direction error modestly improves the
  alignment carrier from `2.443/8.443L` to `2.385/8.436L` minimum/mean distance,
  but every later equilibrium or posterior-reallocation variant retains the
  lower exit: geometry-persistent posterior shift reaches `2.484L`,
  response-gated equilibrium reallocation about `2.444L`, posterior polarity
  reversal `2.406L`, gait-yaw residualization `2.541L`, closure-gated anterior
  equilibrium redirect `2.569L`, and course-selected differential S-bend
  `2.469L`. Do not spend another iteration on scalar brake thresholds, static
  C/S-bend allocation, posterior counterstroke, or using beat-locked yaw as
  mean heading feedback. Across the four current samples, signed target-ray to
  translational-course error instead persists on every state inside `3L`
  (median about `1.53 rad`) while speed remains finite, so it remains a useful
  slow selector; however, the sampled course-selected anterior duty action now
  closes one proposed rhythmic branch. Relative to the yaw-selected brake, it
  changed mean distance only from `8.436L` to `8.434L`, worsened closest
  approach from `2.385L` to `2.433L`, and retained the same coherent powered
  lower exit. Do not retune that duty asymmetry, its distance envelope, or its
  anterior restoring scale. Preserve the brake as a baseline and, if the slow
  course selector is reused, change the non-equilibrium actuator topology—for
  example posterior wave phase rather than anterior duty—and require capture,
  recovery toward the target, or a useful new termination class instead of a
  scalar-only shift. This implication applies only to coherent lateral near
  misses with a stable course mismatch; it is falsified if a later duty action
  yields semantic improvement, or if a new rhythmic mechanism changes sign at
  beat scale, degrades cruise wake/progress, raises actuator residence, or
  leaves the same minimum and lower-exit class.
- After a full-direction C-turn converts the powered lower exit into coherent
  horizon survival, preserve that semantic scaffold and use translational
  course response—not another carrier-amplitude or static-allocation edit—to
  reshape the residual orbit. Inherited logs establish the first horizon
  baseline at `2.346/4.714/3.902L` minimum/mean/final distance. In the current
  samples, nonclosing carrier contraction (`2.484/4.544/4.673L`), a
  response-held C-turn (`2.377/4.458/4.163L`), and response-selected posterior
  counterbend (`2.249/4.355/3.701L`) all retained noncapturing broad loops. A
  bounded same-sign equilibrium reserve selected by target-behind geometry,
  finite speed, and poor normalized target-ray/course closure instead produced
  successive passes near `1.616`, `1.314`, and `1.344L`, improving
  minimum/mean/final distance to `1.314/4.056/3.077L` while reducing total
  anterior clamp residence from `0.727` to `0.249` and leaving posterior
  residence near `0.10`. Thus, for a coherent powered horizon orbit with a
  persistent tangential course mismatch, retain the carrier and base redirect
  and add response-selected turn authority before revisiting drive relief or
  counterbend. Once this mechanism reaches the sub-`2L` regime, localize the
  next change to terminal release/alignment: do not disturb its release or
  first pass without capture, an inward recovery, or another semantic gain.
  The latest terminal comparisons close same-sign equilibrium persistence as
  that next mechanism. An ahead-only response bridge reached `1.371L` and
  spent only `5.62T` inside `2L`; a broader terminal course hold improved the
  late minimum/final distance to `1.241/2.082L`, but worsened mean distance
  from `4.056L` to `4.158L`, reduced residence inside `1.5L` from `5.38T` to
  `2.87T`, and made its best pass only at `97.092T`. At that pass speed remains
  `0.669U`, target-ray/course error is `1.692 rad`, course dot is `-0.121`,
  yaw is only `-0.129 rad/T`, and both joints are near a static same-sign
  `-23 deg` bend while posterior acceleration has unused reserve. Do not add
  another target-side bridge, hold threshold, or static-curvature increment
  to this sub-`2L` orbit. If the scaffold is retained, test a bounded dynamic
  actuator response selected by tangent/receding body-frame course and require
  capture, longer near-target residence, or an inward recovery—not merely a
  late scalar minimum. This terminal implication applies only after coherent
  horizon survival and repeated sub-`2L` entry; it is falsified by increased
  posterior clamp/load residence, altered cruise/first-pass geometry, wake
  degradation, or recurrence of the same powered orbit.
  This lesson is falsified if the reserve loses horizon survival or wake
  coherence, raises clamp/load residence, or fails to shrink the orbit when
  the target is behind and course is tangential; it does not authorize more
  curvature for stalled, unstable, nonpropulsive, or already radially closing
  trajectories.
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
