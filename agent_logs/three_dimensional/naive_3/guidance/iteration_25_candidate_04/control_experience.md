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
- Treat full-direction recovery as a distinct semantic success, but do not
  equate a target-side crossing with completed recovery. Against three sampled
  powered lower exits near `31--32T` (`2.326--2.539L` minimum and about
  `8.42--8.43L` mean distance), the assigned parent's geometry-released
  same-curvature C-turn preserved its coherent 3D wake, formed repeated return
  legs, reached the `100T` horizon, and improved mean/final distance to
  `4.714/3.902L`; this overrides the older blanket negative on same-sign
  target-behind bending for the new recovery regime. It did not capture or
  improve the `2.346L` first-pass minimum, and later circuits remained broad
  (`3--5.7L`) while speed stayed about `0.62--0.66U`. At representative first
  and return passes the target had barely crossed ahead (normalized forward
  projection `0.189` and `0.137`) but remained almost fully lateral
  (`0.982` and `0.991`) with target-ray/course error about `1.12 rad`; a
  forward-projection-only release therefore aliases tangential passage with
  alignment. Completed response tests sharpen that diagnosis without solving
  it. Holding the same C-turn across the lateral/course boundary gives the
  best sampled mean distance (`4.458L`) and increases post-pass residence
  inside `3L` from under `1%` to `22%`, but worsens the minimum slightly to
  `2.377L` and only makes a tighter noncapturing horizon circuit while speed
  remains about `0.65U`. Nonclosing carrier contraction reaches only
  `2.484L` minimum / `4.545L` mean, and radial-closure release reaches only
  `2.532/4.780L` while raising post-pass speed to about `0.73U`; neither
  changes the horizon/loop class. Thus lateral target fraction plus
  target-ray/course error is an evidenced recovery-completion selector, but
  not evidence for more same-curvature persistence, drive contraction, radial
  release, another response threshold, or a scalar C-turn gain. Preserve the
  target-behind recovery onset and, if that selector is reused, attach it to a
  genuinely different inward-course actuator topology after target-side
  crossing; this does not reopen the failed pre-recovery static S-bends,
  half-cycle notches, or phase-gate retunes. This implication applies only to
  coherent powered return-leg trajectories and is falsified if the new action
  changes inbound progress, raises clamp/load residence, stalls the wake, or
  leaves the same `2.3--5L` noncapturing circuit without inward convergence or
  a semantic improvement.
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
