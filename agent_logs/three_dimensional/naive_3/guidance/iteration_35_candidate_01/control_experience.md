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
  anterior restoring scale. Posterior phase-lag modulation is the first tested
  slow-selector topology to improve both minimum and scored mean distance,
  from the brake's `2.385/8.436L` to `2.326/8.424L`, while preserving the
  coherent wake and similar `0.749/0.355` anterior/posterior clamp residence;
  nevertheless it still powers through the lower boundary with `9.213L` final
  distance. Two inherited attempts to make that phase action engage from
  lateral/closure miss formation then regressed to `2.390L` and `2.684L` and
  retained `left_domain`. Preserve the localized phase result as a scaffold,
  but close simple phase-gate, radius, and amplitude retuning until a new
  response mechanism is evidenced. The assigned parent's completed
  harmful-sign yaw-moment residual closes that proposed fast-response branch:
  despite the earlier `0.927` moment/heading-acceleration correlation, it
  regressed to `2.539/8.433L` minimum/mean distance and retained the same
  powered `31.416T` lower exit with `9.189L` final distance. Do not treat
  same-step moment correlation or a local sign audit as causal steering
  evidence. In contrast, a full-direction, target-behind same-curvature C-turn
  with geometry-based release is the first semantic improvement: it preserves
  the coherent first pass (`2.346L` minimum), reaches the `100T` horizon,
  improves mean/final distance to `4.714/3.902L`, and reduces posterior clamp
  residence to about `0.104` while forming repeated return loops. Preserve this
  nonsteady recovery topology rather than reverting to the lower-exit phase
  scaffold. Its oversized powered orbit does not contract through scalar drive
  relief: the inherited response-conditioned carrier contraction still reaches
  only `2.484L`, does not lower post-pass speed, and retains the broad loop.
  Response-held curvature (`2.377L`) and a yaw-selected posterior counterbend
  (`2.249L`) also remain outside `2L`. Normalized target-ray/course response is
  the first selector to change that topology: a bounded curvature reserve
  tightens the orbit to `1.314L`, improves mean/final distance to
  `4.056/3.077L`, and reduces anterior clamp residence to about `0.249`; then a
  terminal course-alignment hold improves minimum/final distance further to
  `1.241/2.082L` and enters `1.25L` for about `0.47T`, with posterior clamp
  residence still near `0.102`. A lateral-geometry-only terminal bridge is
  weaker (`1.371/3.303L`) and never enters `1.25L`, so preserve the continuous
  course-dot hold rather than retuning lateral thresholds, radius, drive, or
  maximum curvature. At the `1.241L` miss, speed remains `0.669U`, course error
  is `1.692 rad`, normalized course is slightly receding, useful yaw is only
  about `0.13 rad/T`, anterior velocity remains `-0.260 rad/T`, and both joint
  commands are small. Three newly completed descendants close the proposed
  equilibrium/constant-residual branch: rear-centerline selector replacement,
  joint-state equilibrium unbend, and a course-signed low-activity restart
  reach only `2.366/3.875/3.502L`, `2.215/3.859/3.416L`, and
  `2.369/3.869/3.455L` minimum/mean/final distance, respectively. Each remains
  finite with a coherent wake to the horizon but loses the tight return; at
  representative minima the latter two have nearly zero anterior velocity
  (`|phi_dot_1| <= 0.003 rad/T`) in a common negative C-bend. Thus a localized
  frozen-state delta, measured low activity, or target-side gating does not
  establish coupled locality, and a fixed-sign restart can reinforce the
  parked equilibrium it was intended to escape. Preserve the continuous
  course hold, but avoid more static bend shifts, selector replacement,
  posterior residuals, or constant signed restart. The assigned parent's
  completed requested-sign half-cycle pulse closes the simplest rhythmic
  escape too: it reaches only `1.702/3.921/3.574L` minimum/mean/final distance,
  never enters `1.5L`, and reduces mean absolute anterior/posterior joint
  velocity inside `2L` to about `0.028/0.028 rad/T`. Because that pulse is
  quadratic near zero velocity and acts on only one half-cycle, it cannot
  destabilize the same parked bend; do not retune its amplitude, velocity
  scale, or radius. In contrast, low-activity velocity feedback on both
  half-cycles is the first rhythmic semantic improvement: it reaches `1.175L`,
  remains inside `1.25L` for about `2.35T` versus `0.47T`, preserves near-target
  mean absolute joint velocity around `0.775/0.360 rad/T`, and lowers clamp and
  RMS-load residence relative to the `1.241L` course hold, although its
  `4.041/3.243L` mean/final distance shows an oversized return remains. Preserve
  phase-balanced energy about the moving equilibrium as the new scaffold.
  A later half-cycle asymmetry is applicable only as a bounded modulation on
  top of that two-sided carrier, and is falsified by loss of active motion, a
  changed first return, a broader wake/orbit, worse load margins, or failure to
  improve closest approach, near-target residence, and final distance. That
  falsification is now observed: adding useful-half-cycle duty asymmetry to the
  `1.175L` phase-balanced carrier regresses to `2.362/3.886/3.511L`
  minimum/mean/final distance, never enters `2L`, and reaches its minimum with
  only about `0.00385/0.00133 rad/T` anterior/posterior joint velocity. Its
  coherent but broad top-down and oblique return is effectively the same
  low-activity attractor as the `2.366L` rear-selector failure, despite the
  candidate's small, positive-work frozen-trace delta. Close duty-bias and
  half-cycle-scale retuning: later workers should preserve symmetric two-sided
  anterior energy exactly while testing a genuinely different actuator role,
  and should distrust frozen action locality as evidence that the coupled
  terminal attractor will remain local.
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
