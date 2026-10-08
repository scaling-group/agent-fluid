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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- In the direct-uniform still-water seed rollout, the `0.55T`, `28 deg`
  joint-only oscillator did self-propel and form a coherent curved wake, but
  joint speed reached the `260 deg/T` cap, raw acceleration requests exceeded
  the `1800 deg/T^2` envelope, yaw rate spanned about `-2.79` to `+2.24 rad/T`,
  and distance improved only `0.25L` before an upper-boundary exit at `8.55T`.
  Therefore visible wake strength alone does not validate a carrier: when this
  saturation-and-curl topology appears, first restore sub-limit traveling-bend
  motion and add bounded target-error-to-curvature feedback with measured turn
  response, rather than increasing drive gains. Falsify this implication if a
  target-aware sub-limit carrier loses propulsion despite remaining clear of
  the caps, or if an unsaturated carrier produces the same broad curl exit;
  also reject the diagnosis if both visual views show that the recorded yaw is
  a moving-window artifact rather than body rotation.
- Across three target-aware descendants of that seed, bounded static
  mean-curvature steering did not change the upper-boundary-exit topology.
  Two posterior-only variants removed all sampled speed and acceleration
  clipping, yet the `0.90T/18 deg` carrier reached only
  `12.226L` (final `13.084L`, exit `8.916T`) and the assigned
  `1.10T/10 deg` parent reached only `12.296L` (final
  `13.405L`, exit `9.080T`), versus the unbiased seed's
  `12.078L` minimum and `12.380L` final distance.  A shared
  anterior/posterior bias was worse (`12.235L` minimum,
  `13.829L` final) and restored joint-speed clipping.  Both visual rows
  confirm that every variant still self-propelled into the same tight upward
  curl, so actuation headroom alone is not steering authority and another
  scalar mean-bend retune is unsupported.  When bearing has already reversed
  by closest approach but a mean bend cannot reverse the turn, test a
  phase-selective mechanism such as target-error-driven half-cycle asymmetry,
  and calibrate its side against measured joint-phase/yaw response.  This
  negative result applies to static equilibrium offsets on these
  state-feedback carriers; reconsider mean curvature only if a later rollout
  demonstrates sustained correct-sign bearing recovery rather than merely a
  longer finite trajectory.
- The inherited logs and successive sampled rollouts show that phase-selective
  steering is not interchangeable across joints, response signs, or route
  loops. Posterior-only asymmetry repeated the near-`9T` curl, while anterior
  half-cycle forcing on the `0.90T/18 deg` traveling bend first produced a
  coherent wake to about `39T`. The latest direct-uniform still-water controls
  sharpen the reusable sign and loop lesson. Feeding persistent course error
  through raw instantaneous yaw closure made the scalar-best parent exit the
  upper margin at `(12.027,15.200)L` after only `20.790T` (`6.268L` minimum),
  with angle contact, about `57%` speed/acceleration-cap residence, and peak
  lateral load and yaw moment roughly three times those of the long carriers.
  Adding course error through a phase-rejected residual loop preserved the
  long wake but reached only `5.016L` and crossed the target x station near
  `y=14.567L`, worse than the bearing-only residual controller's `4.676L` and
  `y=14.183L`. Direct allocation with the response-calibrated sign—anterior
  selector follows body-frame bearing and opposes normalized velocity/target
  cross error—retained coherent top-down and oblique wakes, avoided angle
  contact, lowered that station to `y=14.085L`, and improved the minimum to
  `4.516L`. Preserve this sign, anterior placement, symmetric phase pump, and
  posterior lag as the current carrier baseline, but treat the improvement as
  insufficient steering rather than success: the target remains about `4.6L`
  below the path and speed/acceleration caps still occupy roughly `56/59%` of
  the trace. Do not retry the opposite response sign, raw-yaw/course closure,
  posterior-only asymmetry, or scalar propulsion/steering amplification on
  this saturated carrier. The next useful test must change the large-error
  steering mechanism or energy allocation while retaining the measured sign;
  falsify this boundary if a different sign or genuinely beat-averaged route
  loop lowers the target-station crossing with a coherent wake and less limit
  residence.
- A geometry- and response-gated same-side two-joint redirect is the first
  sampled large-error mechanism to convert that high-corridor carrier into a
  near-capture trajectory.  In direct-uniform still water it preserved the
  coherent top-down and oblique wakes, crossed the target x station near
  `y=11.256L`, and reached `1.165L` at `27.055T`, versus `y=14.044L` and
  `4.516L` for the sign-corrected carrier.  It also avoided angle contact and
  reduced any-joint speed/acceleration-cap residence from about `40/59%` to
  `22/36%`, so a bounded burst redirect can create useful steering authority
  without scalar amplification.  Its response-only release is nevertheless
  incomplete: at closest approach the joints had settled near
  `(-0.258,-0.173) rad` with velocities only
  `(-0.070,-0.180) rad/T` and near-zero commands while the fish still moved at
  about `0.68L/T`; yaw then reversed and the fish coasted past the target to a
  left exit.  For a memoryless two-joint burst that already has the correct
  turn sign, release on normalized attainment of both commanded bends as well
  as measured yaw response, returning continuously to the traveling carrier;
  do not answer this static-bend latch with more redirect angle or drive.
  This implication applies only after the visual wake and route confirm a
  productive correct-sign redirect.  Falsify it if bend-state release fails to
  beat `1.165L` or lower the `11.256L` crossing, preserves the low-joint-speed
  coast, or restores the carrier's saturation/load levels.
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
