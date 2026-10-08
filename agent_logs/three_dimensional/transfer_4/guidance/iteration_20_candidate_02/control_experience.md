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
  cost of one `0.0055T` arrival step and a shallower radius crossing. That
  direction-selective output guard remains useful, but three completed
  upstream desaturation tests bound what should follow it. Rate-headroom
  cadence suppression, positive-power phase-load gating, and shared
  velocity-opposing carrier damping all retained capture and visually
  coherent top-down/oblique wakes, yet worsened score from `-0.51275` to
  `-0.52318`, `-0.53312`, and `-0.53004`; their arrivals also slipped from
  `23.3640T` to `23.7435T`, `23.6555T`, and `23.7215T`. The two phase-energy
  variants reduced anterior residence above 96% rate from `15.68%` to
  `14.55%` and `13.66%`, and reduced acceleration-ceiling residence slightly,
  but increased mean score-distance from `2.409486L` to `2.430448L` and
  `2.427669L`. Therefore, when this coherent still-water gait captures and the
  objective has no direct energy term, actuator-limit residence alone is not
  evidence that carrier energy should be withdrawn: avoid further cadence,
  positive-power, or shared-damping attenuation unless a new rollout links
  saturation to a semantic failure, load problem, or scored loss. Instead test
  a distinct observed route/feedback defect while preserving the carrier and
  reversal authority. Falsify this negative boundary if another condition
  shows saturation causing instability or loss, or if upstream energy shaping
  improves distance/path/arrival without sacrificing wake coherence.
- Preserve the posterior-priority phase-plane redistribution when extending
  this still-water controller, and evaluate additions by where they act. The
  inherited direction-selective governor captured at `23.3640T` with mean
  score-distance `2.409486L`; regulating anterior amplitude without lowering
  cadence while amplifying the lagged posterior wave advanced capture to
  `17.8585T`, lowered mean distance to `1.980025L`, center path to `12.8148L`,
  and maximum head cross-track to `0.5347L`, while retaining a coherent
  top-down and oblique wake. Four sampled continuations then isolate the next
  boundary. Co-windowed `turn_rate_recent - bearing_window_rate` feedback
  outside the terminal corridor is the only positive addition: it lowers mean
  distance to `1.973290L` and score from `-0.09356` to `-0.08710`. Stand-alone
  target-to-course correction and tail-load-conditioned posterior relief both
  capture slightly earlier and improve final course alignment from `0.374` to
  `0.385` and `0.394`, but worsen mean distance to `1.980854L` and `1.981849L`
  and score to `-0.09460` and `-0.09585`; their wakes remain visually
  unchanged. The useful line-of-sight residual also has a boundary: center
  path rises to `12.9663L`, near/final course alignment falls from
  `0.870/0.374` to `0.814/0.113`, and near speed rises from `0.876U` to
  `0.897U`. Therefore keep that residual bounded, forward-looking, and
  released near capture; do not weaken the carrier or claim a terminal-only
  intervention from improved alignment alone. Four later direct-uniform
  continuations sharpen both the gate and actuator boundary. Qualifying the
  route residual by current body-frame target error and fading it to zero at
  the `2.10L` approach boundary is best: it captures at `17.7265T`, improves
  score/mean distance to `-0.08140/1.967391L`, and reduces center path and
  maximum head cross-track to `12.8468L/0.5120L`. Sending the same slow
  residual only to posterior mean curvature preserves the visible wake but
  regresses to `18.6175T`, `-0.09128`, `13.6033L` path, and `0.7700L`
  cross-track, so the route correction needs the existing mean-curvature plus
  beat-synchronous steering path. An unqualified residual handed continuously
  to direct target-course steering also regresses to `17.8805T`,
  `-0.08868/1.974576L`, and a final yaw rate of `-3.1956 rad/T`; removing only
  that terminal course term scores slightly better at `-0.08710`. Preserve
  the error-qualified far-route gate and the ordinary approach controller;
  avoid another terminal course injection unless a rollout first exhibits an
  actual near miss or loss of closure. Falsify this lesson if a reflected or
  disturbed condition shows that the gate suppresses necessary correction,
  loses capture/wake coherence, or if a terminal mechanism improves mean
  distance and arrival without increasing path, loads, or actuator residence.
- Treat terminal propulsion qualification as an observation-bandwidth problem
  once the route already captures with coherent propulsion. Four sampled
  artifacts byte-replicate the error-qualified controller at `17.7265T`,
  `-0.08140`, and `1.967391L` mean distance. An inherited continuation replaced
  its narrow course threshold with a smooth positive target-to-velocity
  alignment gate, but the top-down and oblique wakes remained visually
  near-identical while score/mean/final distance regressed to
  `-0.08417/1.969622L/0.749986L` at the same capture step. Continuity alone did
  not help because the observation stayed gait-phase sensitive: inside
  `2.10L`, instantaneous alignment spans `0.601..1.000` and lies below `0.82`
  for `24.9%` of samples, whereas a one-control-period distance derivative
  remains positively closing at `0.636..0.871 L/T`. On a stable, strongly
  closing approach, avoid further cadence gates driven directly by
  instantaneous course/velocity alignment. The assigned parent's completed
  attempt to use `window_closing_speed_L` retained the `17.7265T` capture but
  worsened score/mean distance from `-0.081395/1.967391L` to
  `-0.081819/1.967732L`; inspection of the formal moving-window observation
  tuple shows that field is not exposed, so its `hasproperty` branch silently
  fell back to single-step `closing_speed_L`. Do not claim time-scale
  separation from a guarded field name: verify the evaluated adapter schema
  and fallback semantics first, and do not retry radial-progress cadence
  gating until a genuinely slower observation is available. Preserve the
  established carrier and steering instead. This boundary does not forbid fast
  disturbance rejection when a wake event causes a measured semantic failure;
  falsify it if a disturbed or reflected rollout shows that phase-sensitive
  gating improves capture, distance integral, and route/load metrics, or if a
  slow closure gate fails to release during tangential or receding motion.
- Early carrier establishment is a supported improvement locus, but posterior
  reserve evidence now separates useful work direction from route quality.
  Relative to three deterministic `17.7265T`, `-0.081395`, `1.967391L`
  baseline captures, anterior-energy-qualified posterior wave amplification
  improves first-`3T` mean distance/speed to `12.214443L/0.2523U` and overall
  score/mean distance to `-0.073952/1.960279L`, while retaining a coherent
  two-view traveling wake. Closure-qualified velocity-aligned posterior work
  preserves that early benefit (`12.214522L/0.2519U`) and improves score/mean
  distance to `-0.072146/1.958037L`, with peak planar force/yaw moment
  `0.039/0.019`, but leaves a `13.0071L/0.6102L` path/cross-track and weak
  `0.787/-0.003` near/final course alignment. Two inherited negative results
  show that release observations are not interchangeable: a deficit of
  posterior normalized angle-rate response retains capture but regresses to
  `-0.082282/1.968655L`, while replacing head-range closure with
  target-projected body translation causes `left_domain` at score `-11.5034`
  after only `0.9166L` closest approach. Do not retry achieved-response
  thresholds or body translation as generic progress certificates.
  The local direction-consistency guard is score-positive, and two
  byte-identical sampled policies reproduce the same score and trajectory: it
  rejects velocity-aligned work that increases error to the current combined
  posterior target, retains first-`3T` distance/speed at
  `12.214593L/0.2519U`, and improves score/mean distance to the lineage best
  `-0.064599/1.950823L` without changing the peak load class or the coherent
  top-down/oblique wake. Count those duplicate artifacts as reproducibility of
  one mechanism, not as two independent controller discoveries. The mechanism
  is not a demonstrated route repair: arrival slips from `17.8695T` to
  `18.0125T`, path/cross-track widen to `13.2330L/0.7417L`, and near alignment
  falls to `0.664`. A sampled
  consensus-qualified amplitude reserve reaches sooner at `17.7870T` and
  retains the same visual wake class, but gives back both early propulsion
  (`12.220562L/0.2459U` first-`3T` distance/speed) and scored mean distance
  (`-0.073937/1.959602L`); requiring target-projected body translation to
  agree with head-range closure is therefore not a substitute for the local
  work-direction guard. Full inherited evidence now makes the global
  wave-reference test a concrete negative result: excluding mean curvature
  from the work guard throughout transit retains capture and the coherent
  two-view wake, advances arrival from `18.0125T` to `17.8585T`, and contracts
  path/cross-track from `13.2330L/0.7417L` to `12.9783L/0.5621L`, but reduces
  first-`3T` speed from `0.2519U` to `0.2469U` and worsens score/mean distance
  from `-0.064599/1.950823L` to `-0.080637/1.966422L`. Do not retry global
  phase/offset separation as a generic route repair. Carrier-energy
  interpolation does not supply a safe boundary either: it retains first-`3T`
  response and improves path modestly, yet regresses to
  `-0.073525/1.959839L` and is farther from the target in every sampled
  post-start time window.
  A sampled distance-only terminal partition supplies the opposite boundary.
  Although it changes the work-phase reference inside `2.10L`, it exactly
  reproduces the combined-reference leader's trajectory, `18.0125T` arrival,
  `-0.064599/1.950823L` score/mean distance, final crossing, and moving-window
  shifts. Treat that as a semantic no-op, not a second reproduction of the
  mechanism: on this strongly closing approach the reserve-work path has no
  useful terminal authority. In the evaluated leader, consistency is the
  product of posterior rate and error to
  `mean_tail_tangent + tail_wave_target`, so route steering can still decide
  propulsion admission. The reusable next boundary to test is current
  normalized body-frame target error: retain mean-assisted work during a
  material redirect, then separate the extra-work phase reference as bearing
  and target-vector angle center, before the distance-only handoff. Avoid
  another scalar attenuation, cadence gate, response-magnitude threshold,
  body-translation consensus gate, global separation, carrier-energy
  partition, or terminal-only partition. Falsify error-conditioned separation
  if it loses early/mean-distance benefit, fails to reduce path/cross-track,
  raises the actuator/load class, loses capture, or degrades either wake view.
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
