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
  regulate rhythmic demand upstream from normalized joint state rather than
  add another output clamp or scalar-only cadence edit. Falsify this implication
  if capture/wake coherence is lost, limit residence does not fall, or distance
  integral, path, arrival, yaw, or loads worsen materially.
  Later inherited score-only captures at `-0.52318`, `-0.53004`, and
  `-0.53312` lack policy and trajectory evidence, so do not attribute those
  regressions to a controller mechanism or use them to override the measured
  desaturation comparison.
- Treat the sampled posterior-priority phase-plane controller as a propulsion
  and course-topology success, not as actuator relief. Relative to the
  rate-governed capture it improves score from `-0.51275` to `-0.09356`, arrival
  from `23.3640T` to `17.8585T`, mean distance from `2.4095L` to `1.9800L`,
  center path from `13.3177L` to `12.8148L`, maximum head cross-track from
  `2.0139L` to `0.5347L`, and mean speed from `0.5701` to `0.7178 U`, while both
  visual rows retain a coherent posteriorly lagged wake through capture. The
  earlier inherited max-pooled shared-cadence gate instead delayed capture to
  `24.8380T` and scored `-0.62156`; preserve posterior emphasis and common
  cadence rather than throttling both joints when one is loaded. The successful
  controller does not establish desaturation: RMS yaw and force/moment rise to
  `2.029 rad/T` and `0.01557/0.00807`, and inside `2.1L` its tail rate-above-96%
  and acceleration-ceiling residence reach `14.68%/72.48%`. Regulate that
  excess, if at all, upstream and locally without erasing the fast far-field
  wave. Also do not add route-residual feedback merely because it helped the
  slower baseline: the same co-windowed line-of-sight residual on this direct
  parent has only `+0.00051 rad/T` mean and nearly balanced signs. This lesson
  is established only for the fixed direct-uniform still-water pose; falsify it
  if reflected or held-out poses lose capture/course equivariance, or if local
  posterior relief cannot reduce terminal limit residence without materially
  worsening wake coherence, arrival, or distance integral.
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
