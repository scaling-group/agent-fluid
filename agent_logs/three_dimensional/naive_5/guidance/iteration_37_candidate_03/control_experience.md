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
  through the calibrated anterior half-cycle channel, changed the visible late
  route while preserving the coherent oblique 3D wake and captured at
  `0.749769L` and `27.605T`. The assigned terminal traveling-bend parent reached
  `0.875770L` and exited left, while sampled intercept-qualified and yaw-rate
  closures reached only `4.278L` and `6.268L`; target-line response, rather
  than another terminal waveform or scalar release threshold, is therefore
  the evidenced mechanism. Retain the carrier, posterior allocation, and
  positive-deficit structure so adequate turns are never cancelled. This
  implication applies to coherent, closing, high-speed pass-bys with persistent
  inertial target-line rotation; reject it when line-of-sight rotation is
  already converging, propulsion is lost, or the wake and loads destabilize.
  Also treat the current success as fragile rather than a gain optimum: its
  capture margin is only `0.000231L`, it touched the angle boundary for three
  joint samples, speed-cap residence was about `11.8%`, and peak planar
  force/yaw moment rose to `0.03397/0.01548` from the parent's
  `0.02142/0.00979`. Require repeat capture or added clearance before claiming
  robustness, and do not increase the residual by scalar tuning unless new
  evidence shows persistent under-response without greater limit or load
  exposure.
- Three separately executed sampled evaluations byte-match the same
  line-of-sight-response policy and combined visual sheet and reproduce its
  `0.749769L` capture at `27.6045T`. This establishes deterministic transfer at
  the fixed initial condition, not geometric or held-out robustness, because
  duplicate policies and images are not trajectory diversity. Their repeated
  trace also isolates a reusable safety deficit: `1183/10038` joint samples
  reached the speed cap, `1878/10038` actions reached the policy acceleration
  clamp, and posterior joint 2 contacted `45 deg` three times, with peak planar
  force/yaw moment of `0.03397/0.01548`. Two independently executed sampled
  evaluations now byte-match the same reflection-equivariant kinetic-headroom
  guard and reproduce its `0.749992L` capture at `27.7695T`. Estimating each
  outward-moving joint's acceleration-limited stopping excursion preserved the
  coherent top-down and oblique wake in both runs, removed all angle contacts,
  reduced speed-cap exposure to `1124/10098`, reduced acceleration-clamp
  exposure to `1700/10098`, and lowered peak planar force/yaw moment to
  `0.02212/0.01041`. Thus predictive joint viability can improve a productive
  carrier without globally weakening its gait; retain the evidenced target-line
  response and make the safety filter inactive for inward motion and states
  with sufficient stopping margin. This implication applies when contact is
  isolated and the unguarded wake remains productive. Reject the angle guard if
  it changes unguarded phases, loses capture, restores contact, or increases cap
  residence or loads. Three separately executed sampled evaluations now
  reproduce the selective speed-viability descendant's trajectory and both
  visual rows: gating only a near-limit command component that would increase
  measured joint speed removes all `1124/10098` exact speed contacts, retains
  zero angle contacts and the coherent capture route, reduces acceleration-
  clamp exposure from `1700/10098` to `1686/10028`, and captures `0.1925T`
  earlier at `0.749366L`, with essentially unchanged peak planar force and
  slightly lower yaw moment (`0.02218/0.01034`). Promote that command-direction
  gate rather than moving the angle threshold or weakening the full carrier. A
  stronger fixed-brake rate barrier is a concrete negative comparison: it left
  34 speed contacts, raised acceleration-clamp exposure to 1725 and peak force/
  moment to `0.02418/0.01124`, and scored worse despite capture, so later
  workers should not scalar-strengthen the velocity brake. Two independently
  executed sampled evaluations now reproduce the coordinated soft-envelope
  descendant byte-for-byte in trajectory and both visual rows. Smoothly
  compressing the peak command above `27 rad/T^2` and scaling both joints by
  the same factor removes all `1686/10028` acceleration-clamp samples while
  retaining zero angle/rate contacts, the coherent three-dimensional wake, and
  capture. Relative to the selective speed-guard parent, it captures `1.2815T`
  earlier (`26.2955T`), lowers mean distance from `2.61279L` to `2.51998L`,
  improves the `8/16/24T` distances from `10.7118/6.7111/2.4363L` to
  `10.4619/6.2293/1.8961L`, and lowers peak planar force/yaw moment from
  `0.02218/0.01034` to `0.01883/0.00979`. Thus a coupled feasibility
  projection can improve a traveling-bend carrier where independent hard
  clipping distorts anterior/posterior coordination: preserve the instantaneous
  command direction and ratio above a soft band, pass sub-band commands
  exactly, and keep angle/rate safety guards downstream at full authority.
  Reject this implication if a held-out rollout loses capture or coherent wake
  structure, restores any contact/clipping, or trades lower loads for slower
  arrival; the duplicate fixed-pose samples establish determinism, not geometric
  robustness. The assigned-parent log contains
  another `0.749430L` capture but no policy, trajectory, visual, or load
  artifact, so its scalar result cannot justify a governor retune. These
  duplicated fixed-condition results establish determinism, not robustness;
  varied initial conditions are still required before calling capture robust.
- Completed capture-corridor actuator-allocation tests now bound the value of
  terminal residual tuning on the coordinated, limit-free carrier. Two
  byte-identical anterior course-response runs captured at `0.749090L` and
  `26.3010T`; three separately executed samples now byte-match the gated
  posterior phase-lag policy at `0.748829L` and `26.2955T`, versus the
  unmodified carrier's `0.749242L` at the same arrival time. The posterior edit
  changed 364 command rows but displaced the anterior-residual centerline by
  at most `0.002788L`; both visual rows retained the same coherent approach and
  late hook, and the compared policies all retained zero actuator contacts and
  the same peak planar force/yaw moment (`0.01883/0.00979`). This replication
  establishes a finite fixed-pose tie-break, not a semantic capture-clearance
  result. In the common trace, projected miss is still about `1.19L` at `22T`
  and `0.97L` at `24T`, while the target-line response and bearing/course
  channel request opposite steering half-cycles through much of that middle
  approach. Therefore preserve posterior modulation only as a bounded baseline
  and do not scalar-strengthen, blindly combine, or further threshold-tune the
  terminal residuals. The completed assigned-parent test now closes the
  remaining arbitration branch: combining the signed route and target-line
  requests before the nonlinear half-cycle selector changed `420/4772` frozen
  commands and captured slightly earlier (`26.2130T`), but reached only
  `0.749076L` with a worse score than the translation-consistent parent
  (`0.748338L` at `26.2460T`). Both visual rows retained the same coherent wake
  and shallow hook, with zero actuator contacts and no new load regime. Thus
  neither pre-selector combination nor choosing either request after the
  selector has produced a semantic benefit; do not continue threshold or
  arbitration variants without a new response observation. One such
  observation is empirically separable from the closed branch: after `18T`,
  the normalized target-normal hydrodynamic force in the strongest sampled
  trace correlates `0.976` with measured course rotation while opposing the
  required course turn in about `54%` of rows. This made force a separable fast
  response/phase-gate hypothesis while body-frame target geometry retained
  route-side authority; it never supported letting instantaneous force choose
  the route or copying a vortex phase. The completed force-gated result below
  hits its shallow-cluster falsification boundary, so do not reuse this
  correlation alone as evidence for another load-gate threshold. Reopen a
  load residual or terminal phase-lag branch only if repeated or held-out
  evidence adds real capture margin or a visibly different useful trajectory.
- Three sampled descendants reproduce the useful part of upstream posterior
  course-slip vectoring despite different nested mechanisms. Against the
  translation-consistent carrier's `10.4643/6.2320/1.8942L` distances at
  `8/16/24T`, the vectoring family reaches
  `10.4536--10.4546/6.1888--6.1924/1.8095--1.8216L` and captures
  `0.0825--0.1540T` earlier, while retaining coherent top-down and oblique wakes
  and zero angle/rate/acceleration contacts. A subsequently materialized
  course/miss-triggered, response-released two-joint redirect supplies a second
  finite improvement: it captures at `0.749266L` and `25.9710T`, lowers mean
  distance to `2.498175L`, and raises score to `-0.596086` from the unredirected
  vectoring sample's `0.748361L`, `26.1635T`, `2.509866L`, and `-0.607211`.
  Both visual rows retain the organized self-propelled wake and terminal hook,
  all actuator contacts remain zero, and peak planar force/yaw moment remains
  modest at `0.01885/0.01010`. This validates bounded geometric burst
  engagement as a progress mechanism, not its proposed course-acquisition
  interpretation: the redirect's projected miss is worse at `8/12T`
  (`7.85/6.22L` versus `7.17/6.03L`) and, after release, body-normal velocity
  remains `0.269/0.239 U` at `20/22T` versus `0.028/0.021 U`, leaving roughly
  twice the comparison's normalized course error and projected miss. Therefore
  audit translational response separately from score and body yaw. Four
  completed middle-recovery samples now retract the earlier proposal to keep
  tuning that sideslip signature. Posterior reaction, adverse yaw-moment
  gating, velocity-normal-force gating, and their load-aware combination all
  capture with zero actuator contacts, but span only `25.8115--25.9105T` in
  arrival and `2.496011--2.497000L` in mean distance. Their `18--24T` mean
  normalized course error/projected miss remain clustered at
  `0.54411--0.55184/1.77355--1.79710L`, their peak planar force/yaw moment
  remains `0.01891--0.01910/0.01009--0.01014`, and both visual rows retain the
  same organized wake and shallow hook. Thus phase-rejecting a beat-synchronous
  slip signal is a valid diagnostic, but allocating it through another
  posterior half-cycle or instantaneous force/moment gate is not an evidenced
  course-recovery mechanism. Avoid further middle-gate thresholds, residual
  combinations, or scalar authority changes on this fixed-pose trace. All
  four samples are identical through `18T`, where the shared normalized course
  error is already about `0.753/0.744/0.543` and projected miss
  `7.85/6.22/3.31L` at `8/12/16T`; a later test should instead change one
  bounded upstream within-beat actuation primitive and require a visibly
  different early route. Reject that direction if early course response stays
  fixed or if wake coherence, capture, actuator viability, or the sampled load
  regime degrades.
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
