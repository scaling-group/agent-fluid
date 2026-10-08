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
- Do not transfer a learned 2D curvature sign as if it were a geometric
  invariant. The assigned direct-uniform 3D parent mapped a negative body-frame
  request to positive posterior mean curvature, passed the target, and exited
  the lower boundary after reaching only `4.78L`. The sampled test of the
  proposed remedy replaced that asymmetric conversion with a bounded odd map:
  it preserved the coherent alternating wake, kept joint angles below
  `37.2 deg`, and changed the termination class to capture at `23.35T` and
  `0.7497L`. In contrast, the inherited steering-reserve policy with the old
  asymmetric sign exited the upper boundary at `6.276L`, while course-residual
  and large geometry-redirect variants missed on opposite sides (`4.022L`
  closest then upper exit, and `5.775L` closest then lower exit). Therefore
  establish an odd, measured 3D target-request-to-curvature polarity before
  adding allocation, one-sided recovery, or burst redirects; a coherent wake
  does not compensate for the wrong course sign. This evidence is one fixed
  still-water pose, so falsify the reusable claim if a reflected target/pose
  does not produce a reflected course response, or if explicit desaturation
  loses capture despite delivering the same signed mean curvature.
- Distinguish an episode-equivalent output clamp from state-feedback
  desaturation. The sampled signed-curvature cadence policy and its explicit
  `1800 deg/T^2` clamp produced identical `23.3585T` capture, trajectory,
  force history, and `-0.51528` score because the episode already applies that
  independent limit. Withdrawing only speed-increasing acceleration above 96%
  of normalized joint rate retained the coherent two-view wake and capture,
  improved score to `-0.51275`, shortened center path from `13.4189L` to
  `13.3177L`, reduced RMS yaw rate from `1.5749` to `1.5537 rad/T`, and removed
  sampled 99.9%-rate residence from `9.09/1.62%` to zero. Three exact-policy
  sampled reruns reproduce that result, so treat them as determinism evidence,
  not three new mechanisms. The gain remains incomplete: rate residence above
  96% is `15.68/3.58%` and acceleration-ceiling residence is still
  `69.61/50.68%`. Preserve the odd curvature map and full reversal authority;
  however, do not max-pool ordinary two-joint angle/rate state and multiply the
  whole carrier cadence by the resulting load gate. The assigned parent tested
  exactly that upstream mechanism: the gate was active for `87.36%` of the
  rollout and averaged `0.8845` cadence scale. It preserved the coherent
  two-view wake and capture and reduced acceleration-ceiling residence from
  `69.61/50.68%` to `66.08/38.24%`, but delayed arrival from `23.3640T` to
  `24.8380T`, worsened score from `-0.51275` to `-0.62156`, increased mean
  distance from `2.4095L` to `2.5216L`, and increased anterior rate residence
  above `96%` from `15.68%` to `19.00%` as anterior amplitude expanded. This
  is evidence that a chronic shared cadence reduction can trade useful closure
  for lower loads without relieving the bottleneck. If actuator pressure is
  revisited, preserve base cadence and posterior propulsion while testing a
  joint-specific amplitude/energy envelope or other allocation mechanism;
  reject it if total limit residence merely migrates between joints or if
  capture, distance integral, path, or arrival regresses materially.
  The sampled posterior-priority phase-plane envelope now sharpens that lesson:
  preserving cadence, reducing the anterior envelope, and emphasizing the
  lagged posterior wave improved capture from `23.3640T` to `17.8585T`, score
  from `-0.51275` to `-0.09356`, mean distance from `2.4095L` to `1.9800L`,
  center path from `13.3177L` to `12.8148L`, and maximum straight-line
  cross-track from `2.014L` to `0.535L`, while both visual views retained a
  coherent traveling wake. Treat posterior-priority allocation as a
  propulsion and route-efficiency mechanism, not established desaturation:
  posterior acceleration-ceiling residence rose from `50.68%` to `65.17%`,
  RMS yaw/force/moment rose from `1.5537/0.0123/0.0064` to
  `2.0285/0.0156/0.0081`, and capture occurred at only `0.374` course alignment
  with `0.900U` speed and `-3.078 rad/T` yaw. Preserve its full far/middle
  posterior emphasis, but if robustness or load is targeted, condition only
  the extra posterior excursion in the terminal approach or use a genuinely
  joint-specific posterior envelope. Reject the follow-up if it erases the
  transit gain, delays capture materially, or merely transfers saturation to
  the anterior joint without improving terminal alignment and load.
  Later inherited score-only captures at `-0.52318`, `-0.53004`, and
  `-0.53312` lack policy and trajectory evidence, so do not attribute those
  regressions to a controller mechanism or use them to override the measured
  desaturation comparison.
- Separate far/middle route correction from the validated terminal controller,
  and do not treat a scalar score gain as unconditional evidence for a drift
  observer. Against the `17.8585T`, `-0.09356` posterior-priority parent, three
  terminal-only mechanisms—course-cross steering, tail-rate/closing-conditioned
  wave relief, and an inherited approach blend toward neutral posterior
  gain—kept the same coherent two-view wake but regressed to `-0.09460`,
  `-0.09585`, and `-0.09547`; capture alignment improved only from `0.374` to
  `0.385/0.394/0.414`, and the best tail-ceiling reduction inside `2.1L` was
  only `72.48%` to `71.25%`. Avoid another terminal micro-adjustment without a
  new failure signature. A co-windowed line-of-sight residual was score-positive
  (`-0.08710`) and reached `4L` sooner with cross-track reduced from `0.342L`
  to `0.093L`, but it crossed the route, lengthened center path from `12.8148L`
  to `12.9663L`, lowered approach alignment from `0.870` to `0.814`, and reached
  capture at only `0.113` alignment. The sampled error- and distance-qualified
  follow-up validates the remedy: against that unqualified residual it improves
  score from `-0.08710` to `-0.08140`, arrival from `17.8750T` to `17.7265T`,
  mean distance from `1.9733L` to `1.9674L`, path from `12.9663L` to
  `12.8468L`, maximum cross-track from `0.545L` to `0.512L`, approach alignment
  from `0.814` to `0.899`, and capture alignment from `0.113` to `0.601`, while
  preserving coherent wakes in both views. Keep the residual in the full
  mean-curvature plus half-cycle steering path: a sibling that sent it only to
  mean curvature regressed to `18.6175T`, `13.6033L` path, `-0.09128` score,
  and `-0.530` capture alignment. A terminal course-angle handoff also failed
  to improve the unqualified route (`-0.08868`, `0.109` capture alignment).
  Thus route-observer authority should require current normalized body-frame
  target error, release before the validated approach regime, and retain
  phase-synchronous steering; do not revive mean-only allocation or another
  additive terminal correction without a new failure signature. At finite
  speed, the next distinct question is whether measured target-to-velocity
  course agreement can release residual steering that is redundant with an
  already valid intercept. Reject that extension if it loses the early distance
  gain, capture, path/directness, load scale, or terminal alignment. These
  boundaries are established only for the current direct-uniform still-water
  pose and must be retested under reflection or altered initial geometry.
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
