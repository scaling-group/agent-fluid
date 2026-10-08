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
- The inherited logs and sampled multimodal evidence show that phase-selective
  steering is not interchangeable across joints or selector signs. Positive
  anterior selectors stayed in the high corridor or exited the upper margin,
  while a response-inverted selector and then direct sign-corrected allocation
  preserved coherent wakes to about `38.5T` and improved minimum distance from
  `5.156L` to `4.676L` and `4.516L`. Retain that calibrated side: selector sign
  follows body-frame bearing and opposes the normalized velocity/target cross
  product once translation is observable. However, the direct selector was
  already near full authority while the center stayed near `y=14.05L`, so
  another scalar selector or propulsion increase is unsupported. The next two
  mechanism tests sharpen what to do instead. Headroom-gated posterior
  half-cycle redistribution worsened the minimum to `5.386L`, exited the upper
  margin at `(8.770,15.201)L` after `26.043T`, touched the angle boundary, and
  produced peak planar force and yaw moment near `0.211` and `0.0968`—about ten
  times the other long-wake samples. Do not treat instantaneous acceleration
  headroom as evidence that added posterior asymmetry is hydrodynamically safe.
  In contrast, an observation-gated same-sign two-joint redirect preserved the
  3D wake, avoided the angle boundary, reduced speed/acceleration limit
  residence to about `33/36%`, and reached `1.165L`. It then passed the target:
  yaw-based release fell nearly to zero redirect authority from `18--23T` even
  though the velocity/target cross product still predicted a `2.5--3.9L`
  miss. The resulting global intercept-and-closing-speed qualification is now
  a concrete negative result: the assigned parent retained a coherent wake but
  held a near-static same-sign bend at range, stayed in the high corridor,
  reached only `4.278L`, and exited the upper margin at `(8.132,15.202)L` after
  `27.066T`. A sibling that instead released on measured two-joint bend
  attainment kept the downward 3D wake, avoided angle contact, held peak planar
  force and yaw moment near `0.0214/0.0098`, and improved the minimum to
  `0.8307L`; it missed capture by only `0.0807L` while still moving about
  `0.66L/T` on an almost perpendicular course, then overshot and exited left.
  Two later evaluations sharpen the boundary. A capture-neighborhood
  projected-miss veto on release preserved the downward wake and load scale but
  reached `0.829828L`, less than `0.001L` better and not a semantic improvement.
  Supplementing bearing entry with projected miss inside `2.5L` then worsened
  the minimum to `0.926872L`, raised mean distance from `7.89069L` to
  `7.92726L`, and passed higher and faster (`head_y=10.180L`, `0.676L/T`) than
  the release-veto parent (`9.961L`, `0.659L/T`), with the same coherent wake,
  load/angle scales, and `left_domain` termination. Two bounded terminal
  actuator effects now close the remaining alternatives. Miss-gated deeper
  same-sign curvature preserved the broad wake but reached `0.832836L`, slightly
  worse than `0.829828L`: at closest approach body heading rotated about
  `0.075 rad` farther, while velocity direction changed only about `0.044 rad`
  and body/velocity slip grew from about `0.638` to `0.757 rad`. Projected-miss
  posterior damping then worsened the minimum to `1.111481L`, left terminal
  speed high at `0.671L/T`, and reduced heading response. Projected miss is
  therefore a local terminal qualifier, but entry, release, redirect frequency,
  static curvature depth, and posterior drive damping have all failed to supply
  capture authority on this carrier. Preserve bearing entry and yaw/joint-state
  release at range; avoid another scalar edit to those channels. Diagnose future
  terminal mechanisms by course rotation, not body yaw alone: a useful test must
  create a bounded target-side lateral impulse from measured slip or phase while
  beating `0.829828L` without a high-corridor latch, angle contact, incoherent
  wake, higher load, or greater limit residence. Reconsider static curvature or
  drive relief only if it measurably rotates velocity toward the target or
  reduces approach speed before the target station, respectively; reconsider
  global intercept qualification only if it preserves the broad downward route
  without a far-field latch.
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
