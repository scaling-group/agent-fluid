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
  miss. Thus a large-error redirect is the first evidenced capture-scale
  steering mechanism, but release must be qualified by translational outcome
  such as normalized projected miss and positive closing speed, not turn-rate
  sign alone. Falsify this implication if intercept-qualified release destroys
  the coherent carrier, over-turns before the target neighborhood, or cannot
  improve the `1.165L` approach; reconsider posterior allocation only after a
  formulation lowers both trajectory and load exposure rather than merely its
  unclipped acceleration request.  The sampled terminal miss-veto descendant
  sharpened that mechanism to `0.829828L` at `27.489T`, with a coherent wake
  and modest peak planar force/yaw moment (`0.0214/0.00981`), but still passed
  the target at about `0.659L/T`; its projected miss was about `0.807L` while
  the fixed redirect had nearly settled. Later completed tests now reject the
  previously open terminal scalar and dissipation branches: predictive entry
  reached `0.926872L`, a posterior recovery pulse reached `0.895724L`,
  posterior approach damping reached `1.111481L` without reducing its roughly
  `0.671L/T` terminal speed, unconditional deeper curvature reached
  `0.832836L`, and the assigned-parent closing-gated depth reached `0.827823L`.
  All still exited left; the two depth variants retained essentially the same
  coherent visual path as the `0.829828L` baseline, so the `0.002005L` best
  difference is not a semantic improvement. Release qualification remains a
  real improvement over the `1.165L` approach, but later workers should avoid
  more redirect thresholds, response-frequency edits, static target depth,
  posterior pulses, or posterior damping on this topology. From about
  `1.1L` inward, course error is already nearly saturated while the settled
  redirect's correct-sign yaw decays and signed target bearing worsens. The
  trajectory makes the diagnostic boundary concrete: at first crossing of
  `1.10L`, normalized course error was about `0.84`, projected miss about
  `0.923L`, closing speed about `0.417L/T`, and heading rate only
  `0.008rad/T`; near `0.90L`, course error rose to about `0.99` while the
  projected miss remained `0.889L`. Thus course-error magnitude is a steering
  demand, not evidence that the redirect is responding, and it should not by
  itself gate more terminal authority. For a coherent low-load pass-by with a
  settled redirect, use the calibrated turn side times body-frame bearing
  trend to distinguish a worsening response from an already converging one;
  require positive closing and an unsafe projected miss, then place any
  bounded dynamic correction on the evidenced anterior phase-selective channel
  while preserving the far carrier and posterior follower. Reject this lesson
  if bearing is already converging, closing has stopped, propulsion is lost,
  or wake/loads show instability; falsify it experimentally if a trend-gated
  anterior residual cannot improve the `0.827823L` pass or repeats the
  high-load upper-exit topology.
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
