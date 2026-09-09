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

- This is a fresh 40-iteration lineage with no solver or optimizer population
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
- Do not equate a centered body-axis target bearing with a centered achieved
  course in a free swimmer. In the sampled 2D-champion transfer, the alternating
  3D wake and early propulsion remained coherent, but near `4T` the target
  bearing was only about `-0.04 rad` while the body-frame velocity course was
  about `-0.95 rad`; the controller then reversed its initially useful turn,
  reached only `6.13L`, and exited the lower boundary. When this signed
  bearing/course discrepancy is present, preserve the demonstrated gait and
  test a speed-gated target-versus-velocity course residual before adding
  propulsion or cadence. Falsify that implication if it weakens early distance
  closure, disrupts wake coherence, saturates the joints, or retains the same
  long-turn `left_domain` topology.
- Do not treat a close pass as evidence for deeper scalar cadence relief when
  the achieved-course command already has the correct saturated sign. The
  inherited course servo reached `1.044L`; continuously lowering oscillator
  frequency from `4L` toward a `0.72` floor slowed the sampled terminal pass to
  about `0.738L/T` but worsened closest approach to `1.542L`, retained the same
  below-target lower exit, reached the `260 deg/T` joint-speed limit, and left
  raw acceleration outside the envelope on about `95.5%` of trace rows. In
  this regime preserve the coherent far-field carrier and change how bounded
  steering authority is realized within the beat, or test terminal yaw/slip
  estimation, rather than increasing route gain or reducing cadence again.
  This implication applies only after broad route acquisition and a coherent
  finite wake; falsify it if a later cadence-relief evaluation improves the
  capture class while materially reducing saturation without stalling.
- Treat terminal carrier collapse as distinct from insufficient route gain.
  Relative to the inherited cadence-relief miss at `1.542L`, opposing-half
  carrier attenuation improved closest approach to `1.267L`, but the combined
  wake sheet and trace show that it then stopped laying down a substantial new
  alternating wake: joint motion and commands became small after the pass even
  though inertial speed remained about `0.78--0.85L/T`, and the fish coasted
  below the target into the same lower exit. Once broad course acquisition is
  established, avoid further terminal carrier suppression in this topology;
  test a bounded mean-curvature or wave-shape steering realization that keeps
  the traveling bend active. Falsify this implication if preserved terminal
  oscillation worsens the `1.267L` pass, raises saturation, or redirects the
  route before the evidenced terminal regime.
- Treat a threshold capture from response-conditioned steering as a mechanism
  demonstration, not robust success, until an exact-policy repeat survives.
  The same LOS-guarded policy bytes, config, geometry, and IBM hashes produced
  both the sampled `0.7493L` capture at `18.6065T` and the assigned parent's
  `1.7715L` lower exit. Both visual rows in both runs retain a coherent
  alternating wake, closest-pass speed remains `0.8471/0.8185L/T`, both joints
  touch the speed limit, and returned acceleration clamps on about
  `69.2%/71.4%` versus `70.6%/72.8%` of rows. The earlier evidence still
  supports gating yaw-response release with inertial LOS geometry, but the
  repeat falsifies retaining that controller unchanged or calling one
  boundary crossing robust. For this coherent, broadly acquired topology,
  test whether normalized target/velocity projection permits release only on
  an approaching closest pass inside the capture corridor; avoid more route
  gain, carrier suppression, or unchanged replay. Falsify this implication if
  exact repeats establish reliable capture, or if intercept gating changes
  far-field closure, weakens the traveling wake, increases saturation/loads,
  or cannot improve the `1.7715L` repeat-failure pass.
- Do not optimize terminal control allocation for clamp fraction alone, and do
  not call the conditional speed-reserve policy robust after its three sampled
  captures at `0.7466--0.7494L`. The assigned parent's exact-byte replay
  retained the same active top-down and oblique wake, comparable peak speed
  (`0.9108L/T`), force (`0.0310`), and yaw moment (`0.0163`), yet passed below
  at `1.6463L` and exited; action still clamped on `70.3%/72.0%` of rows. At
  the first `4L` crossing its projected miss was already `1.780L`, and replay
  of the policy equations shows about `40%` response-based steering release at
  `2.75L` while projected miss was `1.708L`, because the distance-blended
  corridor veto had not activated. Preserve the traveling bend and sparse
  outward-carrier reserve, but stop unchanged replay and test a terminal-band
  release rule that requires raw target/velocity geometry to predict an
  approaching capture-corridor intercept. This applies to coherent lower-pass
  trajectories with preserved speed and loads; reject the implication if a
  full-band geometry veto changes far-field closure, weakens the wake, flips
  the miss side, or increases actuator/load metrics. The earlier total-command
  governor remains a negative comparison: it lowered speed-limit residence but
  missed at `1.3877L` without materially curing action clipping.
- Do not infer that carrier-aligned clipping makes half-cycle steering
  reallocation safe. Starting from the three-repeat speed-reserve baseline, a
  continuous terminal allocator reduced additive steering on carrier-aligned
  acceleration and increased it on the opposing half-cycle inside the existing
  intercept region; it retained self-propulsion and an organized alternating
  top-down and oblique wake, yet worsened closest approach to `1.686L` at
  roughly `0.84L/T` and exited below with final distance `10.309L`, versus the
  baseline's three `0.7466--0.7494L` captures. In this coherent, broadly
  acquired topology, preserve the evaluated carrier/steering allocation and
  test a terminal response observation such as geometry-gated yaw or slip
  damping before another carrier-phase weighting. Falsify this negative lesson
  only if an independently repeated phase allocator preserves capture and the
  wake while improving arrival, loads, or actuator-envelope metrics rather
  than merely redistributing clipping.
- Reject normalized signed projected miss as a replacement terminal steering
  error in this topology, rather than tuning its scale or blend distance. The
  exact projected-miss policy produced one threshold capture at `0.7477L` but
  then two direct-uniform, stable lower exits at `1.7680L` and `1.6366L`; the
  failures retained active alternating wakes and continued self-propelling
  after closest pass. Its lone capture was also slower-scoring than the three
  sampled speed-reserve captures and did not reduce clipping. The subsequent
  exact speed-reserve miss means neither controller is robust, but projected
  miss remains the poorer route error (`1/3` versus multiple captures) and the
  shared failure is terminal path geometry rather than insufficient
  propulsion. Preserve the raw achieved-course error and traveling bend as a
  scaffold; do not stack yaw/slip, capture-
  corridor, or actuator feedback onto projected miss. This conclusion applies
  to replacing the route command inside the last `2L`; revisit it only if
  multiple exact repeats become reliable and add a clear arrival, load, or
  saturation benefit without changing far-field closure or wake coherence.
- Do not promote terminal yaw damping from a single threshold capture, even
  when normalized interception geometry gates it. An exact repeat of the
  geometry-gated phase-compensated yaw brake retained self-propulsion and both
  organized wake views but passed below at `1.5097L` and exited, while still
  traveling `0.829L/T` at closest approach; this falsifies widening its gate
  or tuning its damping scalar. A distinct posterior wave-shape pulse, gated
  by the existing intercept region and synchronized by normalized anterior
  joint speed, has two exact captures at `0.7480--0.7492L` with active wakes.
  Its clipping, speed-limit residence, force, moment, score, and mean distance
  remain inside or overlap the repeat-backed speed-reserve baseline envelope,
  so the evidence supports compatibility and an exact-repeat test, not
  superiority or gain tuning. This implication applies only to a small tail
  target bias that is identically zero outside the intercept gate and leaves
  the achieved-course carrier controller unchanged; reject it after any exact
  miss, far-field divergence, wake weakening, or actuator/load excursion, and
  do not stack it with the failed yaw brake.
- Do not treat offline suppression of beat-synchronous course variation as a
  capture surrogate. The assigned parent's terminal course observer subtracted
  a bounded `0.42U` anterior-joint-speed projection after trace replay reduced
  route-error total variation from `10.30--13.60` to `5.45--6.82`; its CFD
  rollout nevertheless missed at `1.5445L`, exited below with final distance
  `10.4040L`, and scored `-11.2867`. In contrast, the current sample contains
  three sampled speed-reserve captures at `0.7466--0.7494L` with active
  alternating top-down and oblique wakes. Restore the raw achieved-course
  observation after this observer failure, but treat the later exact-baseline
  lower exit as evidence that unchanged controller replay is not the repair;
  do not tune the compensation coefficient or stack it with prior terminal
  residuals. This result
  falsifies this one joint-speed projection and offline smoothness criterion,
  not every phase-invariant observer; revisit observation filtering only when
  complete repeated CFD artifacts show improved capture geometry as well as
  preserved closure, wake coherence, loads, and actuator use.
- Do not promote or scalar-tune a fixed unsafe-terminal anterior steering
  transfer from one threshold capture. The sampled transfer preserved the
  alternating top-down street and bilateral oblique wake and captured at
  `0.7492L`, but arrived at `18.7495T`, later than the two current exact
  speed-reserve samples at `18.2875--18.6010T`; head/tail action clipping
  remained `68.76%/70.75%`, speed-limit residence remained
  `10.74%/11.62%`, and peak force and yaw moment stayed inside rather than
  improved the baseline envelope. The assigned-parent logs also add recent
  lower-exit closest passes at `1.3725L` and `1.9385L`, while inherited
  half-cycle and total-command reallocations already failed with coherent,
  active wakes. For this broadly acquired topology, preserve total steering
  share and the posterior carrier; if spatial allocation is tested again,
  condition it on normalized posterior-over-anterior actuator burden and
  available anterior margin so it is zero outside the unsafe intercept and
  burden conjunction. Reject that implication if exact repeats do not improve
  semantic reliability or useful actuation, if the lower-pass topology
  remains, or if wake coherence, speed, clipping, force, or moment leaves the
  repeat-backed speed-reserve envelope.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
