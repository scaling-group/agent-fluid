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
  independent limit. Adding a selective joint-rate governor instead—only
  withdrawing acceleration that would increase signed joint speed above 96%
  of the envelope—retained capture, improved score to `-0.51275`, shortened
  center path from `13.4189L` to `13.3177L`, and reduced RMS yaw rate from
  `1.5749` to `1.5537 rad/T`; maximum angles also fell from `27.61/37.19 deg`
  to `27.48/36.75 deg`. The gain is useful but incomplete: anterior residence
  above 96% of the rate limit remained `15.68%`, and acceleration-ceiling
  residence only changed from `70.03/52.15%` to `69.61/50.68%`. Subsequent
  evidence rejects reducing shared carrier energy as the remedy: rate-headroom
  cadence suppression, positive-power gating, and common velocity damping all
  preserved capture and a visually coherent traveling wake but worsened score
  to `-0.52318`, `-0.53312`, and `-0.53004`. A broader angle/rate load gate did
  lower acceleration-ceiling residence to `66.08/38.24%` and RMS yaw to
  `1.5077 rad/T`, yet delayed capture to `24.8380T`, raised mean score-distance
  to `2.52163L`, and worsened score to `-0.62156`. Lower actuator residence is
  not a reusable improvement when it removes useful forward progress; preserve
  the carrier and full reversal authority, and avoid further energy-withdrawal
  variants unless a matched rollout improves arrival and distance/path as well
  as saturation and wake coherence.
- Treat gait-correlation as an observer-design clue, not a causal coefficient.
  Although sampled body yaw and normalized anterior joint rate had correlation
  `-0.976` during established transit, subtracting a fixed signed joint-rate
  projection from yaw feedback worsened the captured controller from
  `-0.51275` to `-0.62377`: arrival moved from `23.3640T` to `24.4090T`, center
  path from `13.3177L` to `14.8232L`, RMS yaw from `1.5537` to
  `1.6874 rad/T`, and posterior 96%-rate residence from `3.58%` to `13.86%`.
  The two-view wake stayed organized, so the regression is route-feedback
  distortion rather than propulsion collapse. Do not fit and subtract a
  single gait-state proxy from instantaneous yaw; test bounded phase-confidence
  or genuinely slower route observations while keeping body-frame target
  geometry continuous. Reject those alternatives too if capture, reflected
  polarity, mean distance, path, arrival, yaw, loads, or rate residence worsens.
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
