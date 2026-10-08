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
  residence only changed from `70.03/52.15%` to `69.61/50.68%`. Preserve the
  proven odd curvature map and full reversal authority, and test upstream
  state-conditioned carrier modulation rather than another hard clamp,
  scalar-only cadence edit, or route redirect. Reject that implication if it
  loses capture, worsens distance integral/path, increases limit residence, or
  disrupts the coherent top-down and oblique traveling wake in a matched or
  reflected rollout.
- Phase-stratify actuator residence before tightening a successful governor.
  The inherited and sampled score logs all retain capture across
  `-0.52318` to `-0.51275`, while three independent samples of the best
  rate-governed policy reproduce the same trajectory and score. In that policy
  exact `99.9%` rate-wall residence is already zero, yet acceleration remains
  at its ceiling for `69.61/50.68%` of the rollout. For the anterior joint,
  acceleration is clipped in `93.5%` of samples below half the rate envelope
  and `90.8%` between `0.5--0.8`, but never above the governor's `0.96` onset.
  This locates the remaining defect in the restoring/energy-injection part of
  the carrier, not at the rate wall. After capture and odd steering polarity
  are established, test a smooth normalized phase-space modulation of
  positive-power carrier acceleration while retaining full braking, reversal,
  posterior lag, and steering authority; avoid interpreting a lower rate
  threshold or another downstream clamp as that test. Falsify this implication
  if matched or reflected evaluation fails to reduce acceleration residence
  and loads while preserving capture, path/integrated distance, and the
  coherent wake in both visual views.
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
