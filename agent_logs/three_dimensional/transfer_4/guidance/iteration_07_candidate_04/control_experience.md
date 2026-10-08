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
  invariant. In the direct-uniform L64 3D parent, the traveling-wave carrier
  produced a coherent alternating wake and reduced distance from `12.33L` to
  `4.78L`, but a negative body-frame target request was mapped to positive
  posterior mean curvature. After the target passed behind, measured mean tail
  tangent stayed positive (`8.2 deg` over `20--25T`) while yaw increased by
  `42.7 deg`; the fish moved another `3.68L` toward the lower boundary and
  terminated `left_domain` at `27.49T`. Infer actuator polarity from the
  measured 3D course response, and prefer a bounded odd target-to-curvature map
  before adding direction-specific recovery branches. Falsify that implication
  if reversing the map fails to contract signed target bearing or instead
  degrades the coherent wake and forward progress; that new rollout must decide
  whether authority, saturation, or another mechanism is the remaining fault.
- Treat actuator ownership as feedback design, not just command clipping. On
  the captured course-aligned controller, adding a policy clamp identical to
  the downstream `1800 deg/T^2` envelope was a demonstrated no-op: trajectory,
  forces, termination, and score stayed identical at `-0.51527750`. In
  contrast, smoothly withdrawing only speed-increasing acceleration above
  `0.96` of the observed joint-rate envelope preserved the coherent wake and
  capture, eliminated sampled `99.9%` rate-limit residence from the prior
  `9.09%/1.62%`, shortened center path from `13.4189L` to `13.3177L`, reduced
  RMS yaw rate from `1.5749` to `1.5537 rad/T`, and improved mean
  score-distance from `2.412601L` to `2.409486L` (score `-0.51274776`), at the
  cost of one `0.0055T` arrival step and a shallower radius crossing. Three
  upstream attempts to reduce the remaining rate/acceleration residence then
  established a negative boundary: rate-headroom cadence suppression,
  positive-power gating, and shared velocity damping all retained capture and
  visually coherent wakes, but worsened score to `-0.52318`, `-0.53312`, and
  `-0.53004` and delayed arrival to `23.7435T`, `23.6555T`, and `23.7215T`.
  A joint-load carrier gate likewise regressed to `-0.62156`, while subtracting
  a fitted gait-phase yaw component regressed to `-0.62377`, `24.4090T`, and
  `2.522887L` mean score-distance. Thus residual saturation or high
  joint-rate/yaw correlation alone does not justify weakening the productive
  carrier or deleting its implicit phase feedback; avoid more energy
  attenuation or gait-yaw subtraction unless a new condition ties those
  signals to instability, loads, or semantic failure. When the carrier still
  captures, preserve it and the odd curvature/reversal logic; instead, a
  distinct actuator-allocation test is warranted if normalized traces show
  complementary authority (the strongest trace has opposite joint-rate signs
  for `65.91%` of samples and exactly one joint above `80%` rate for `52.66%`).
  Such allocation is not a positive result until CFD improves target progress:
  falsify it if capture/wake coherence, reflected polarity, distance integral,
  path, arrival, loads, limits, or switching worsen materially.
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
