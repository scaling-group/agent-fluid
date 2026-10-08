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
- The four first-generation direct-still-water rollouts establish that redirect
  allocation and sign dominate cadence tuning in this contract. The transferred
  carrier formed a coherent alternating wake and reached `4.780L`, but lacked
  steering authority and exited below at `27.49T`. Preserving that carrier while
  shifting its oscillator centers into a same-sign, geometry-gated C-bend was
  the sole capture (`0.7495L` at `25.39T`, mean distance `2.557L`) and retained
  the alternating wake. In contrast, two response-gated designs that replaced
  most of the carrier with opposite-sign static posture turns gained only
  `0.466L` and `0.155L` before upper-boundary exits at `9.01T` and `7.99T`; one
  spent `78.0%` of samples on the posterior angle limit and produced roughly
  tenfold larger peak lateral load and yaw moment than the capture. Therefore
  preserve the traveling-wave oscillator, use the successful request-to-bend
  sign, and modulate redirect within its posture/lag allocation rather than
  blending wholesale to a static bend. This conclusion is limited to the
  current observation and joint-sign conventions and one fixed still-water
  pose; falsify it if a carrier-preserving redirect loses capture/wake coherence
  or an independently validated sign/allocation improves semantic outcome and
  limit/load histories.
- Once the graded same-sign C-bend established capture, response-triggered
  redirect release and a fourth-order final-command projection each improved
  the same coherent-wake route without changing steering polarity or scalar
  drive gains. Their later composition is now evaluated: it retains capture
  and the alternating top-down/oblique wake, advances arrival from the best
  isolated result's `23.997T` to `23.8755T`, and changes mean scoring distance
  from `2.438L` to `2.4357L`, with peak lateral load/yaw moment near
  `0.0240/0.0141` and commands below `1798 deg/T^2`. The interaction is not
  uniformly additive, however: posterior `>=95%` speed-limit exposure rises
  from about `4.5%` to `9.38%` and peak yaw from `2.922` to `2.949 rad/T`.
  Thus compatible feedback mechanisms must be judged jointly on semantic,
  kinematic, and load histories; after capture is secure, isolate excess
  terminal response without replacing the carrier. Four sampled files differed
  only in comments/version and produced the exact same `4341`-step trajectory,
  so treat byte-distinct but executable-equivalent candidates as one result and
  require a real feedback-path change after such population collapse. This
  boundary is limited to the observed still-water pose and sign convention;
  falsify it if a distinct mechanism improves capture/directness without the
  cited yaw or speed-limit tradeoff.
- Do not treat raw near-target yaw rate as a route-level damping signal without
  accounting for propulsive phase. On the evaluated composed v21 capture,
  heading rate correlates with anterior joint velocity at `-0.944` over the
  rollout and `-0.954` inside `3L`; correspondingly, v22's proximity/closing-
  gated reduction of whole-oscillator amplitude changed mean distance by only
  `-0.000225L`, arrived one step later (`23.8810T` versus `23.8755T`), left peak
  yaw and posterior `>=95%` speed exposure effectively unchanged
  (`2.9486 rad/T` and `9.35%`), and raised peak heave load from `4.349` to
  `5.448`. Near-target bearing also correlates with anterior angle at `-0.693`,
  and a matching phase correction reduces its RMS from `0.279` to `0.206 rad`
  before subtracting the established redirect center. Preserve carrier
  amplitude unless evidence shows a propulsion excess; for terminal yaw
  control, first reject a joint-state-correlated beat component from both yaw
  response and target geometry, then test a small posture/curvature residual
  against target-derived route demand. The observed `0.50` phase relation is a
  one-rollout diagnostic, not a universal gain: distrust it if carrier-rejected
  yaw remains beat-periodic under a changed gait or hydrodynamic condition, and
  reject the residual if it loses capture, wake coherence, or joint/load
  quality.
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
