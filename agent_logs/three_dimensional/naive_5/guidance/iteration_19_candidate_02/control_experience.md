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
  real improvement over the `1.165L` approach, but later completed results now
  also close the terminal dynamic-actuator branch: an anterior same-side
  response residual reached `0.831067--0.831781L`, an anterior counter-sweep
  `0.828153L`, a coordinated C-to-S recoil `0.830575L`, a curved forward wave
  `0.875770L`, a reverse-wave brake `0.874118L`, and a terminal traveling-bend
  recovery `0.870635L`. All retained the coherent high-speed pass-by and
  `left_domain` termination. Thus the approximately `0.828--0.831L` cluster is
  not evidence for more terminal pulse amplitude, phase, recoil, or damping
  tuning. An upstream instantaneous projected-intercept hold supplied a
  genuinely different test but regressed to `1.096087L`; its frozen-state
  audit changed `1272` commands, including `522` outside `1.75L`, and the
  evaluated visual path remained a coherent pass-by. Do not retune that hold's
  corridor thresholds or use a single beat-scale velocity projection as a
  binary reason to suppress steering. A sampled response-based geometric
  residual now supplies the first semantic success in this lineage: summing
  body-frame bearing-window rate with recent body turn to reconstruct inertial
  line-of-sight rotation, then adding only the positive yaw-response deficit
  through the calibrated anterior half-cycle channel, changed the late route
  while preserving the coherent top-down and oblique 3D wake. Three
  byte-identical sampled executions captured at `0.749769L` and `27.605T`,
  whereas the assigned terminal traveling-bend parent reached `0.875770L` and
  exited left and other sampled intercept-qualified/yaw-rate closures reached
  only `4.278L/6.268L`. Retain that normalized target-line response, its
  anterior-only allocation, the carrier, and posterior allocation rather than
  reopening terminal waveform or scalar residual tuning. The success initially
  remained envelope-fragile (`0.7826/0.7854 rad` peak joint angles,
  `23.7/13.7%` acceleration-limit residence, and `0.03397/0.01548` peak planar
  force/yaw moment). A sampled symmetric angle-plus-stopping-excursion guard
  then repeated capture and slightly improved score while reducing those
  measures to `0.7655/0.7632 rad`, `21.7/11.9%`, and `0.02212/0.01041`.
  Therefore guard an evidenced successful rhythm with an inward-only,
  state-predicted stopping residual before increasing steering or propulsion;
  actuator headroom gained without repeat capture is not an improvement. This
  implication applies to coherent, closing, high-speed approaches with
  persistent inertial target-line rotation. Reject it if line-of-sight
  rotation is already converging, propulsion is lost, repeat capture fails, or
  wake, load, or joint-limit exposure worsens. The two sampled guarded captures
  further separate angle viability from rate viability: the symmetric
  angle-plus-stopping guard removed all three `45 deg` posterior contacts,
  reduced acceleration-clamp residence from `1878/10038` to `1700/10098`
  joint samples, and lowered peak planar force/yaw moment from about
  `0.03397/0.01548` to `0.02212/0.01041`, but exact speed-cap residence fell
  only from `1183/10038` to `1124/10098` and both joints still reached
  `260 deg/T`. Thus do not keep moving the angle threshold inward to solve the
  remaining rate plateau. Treat rate headroom as a separate constraint test:
  modify only same-direction acceleration near the measured speed envelope and
  preserve already-inward commands. This boundary applies only after the
  guarded policy has repeated capture with unchanged wake topology; reject a
  rate barrier if it loses capture, creates a soft-boundary limit cycle, or
  trades exact cap residence for worse propulsion, mean distance, or loads.
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
