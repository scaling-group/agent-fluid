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
- Do not optimize terminal control allocation for clamp fraction alone. The
  conditional speed-reserve policy, which softens only outward carrier effort
  when joint speed, previous action, and carrier direction agree, has three
  exact-byte sampled captures at `0.7466--0.7494L` and `18.320--18.601T`, but
  the assigned parent's newly complete exact-byte replay passes at `1.5478L`
  and exits below. All four retain coherent top-down and oblique wakes; the
  miss's closest-pass speed (`0.820L/T`), peak force/moment (`0.0306/0.0158`),
  and clamp fractions (`70.2%/71.8%`) overlap the captures' propulsion and load
  envelope. Sparse carrier reserve is therefore a repeat-supported propulsion
  and allocation baseline, not robust targeting success or an actuator-
  saturation cure. A total-command governor reduced speed residence to
  `6.9%/7.2%` yet missed below at `1.3877L` and retained `69.8%/70.9%` action
  clamping with a coherent wake. Preserve the sparse reserve while testing
  outer-loop target interception; avoid governors that replace outward
  combined commands with restoring acceleration merely to lower limit
  residence. Falsify this boundary only if a governor repeatedly captures
  while lowering both speed residence and clipping without increasing loads
  or coasting.
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
  after closest pass. Its lone capture was also slower-scoring than all three
  exact speed-reserve captures and did not reduce clipping. This `1/3` record
  contrasts with `3/3` captures at `0.7466--0.7494L` for the achieved-course,
  intercept-guarded speed-reserve baseline, so the failure is terminal path
  geometry rather than insufficient propulsion. Revert to that repeat-backed
  error and preserve its traveling bend; do not stack yaw/slip, capture-
  corridor, or actuator feedback onto projected miss. This conclusion applies
  to replacing the route command inside the last `2L`; revisit it only if
  multiple exact repeats become reliable and add a clear arrival, load, or
  saturation benefit without changing far-field closure or wake coherence.
- Do not promote terminal yaw damping or phase-synchronous posterior curvature
  from isolated threshold captures. The geometry-gated yaw brake's exact
  repeat retained self-propulsion and both organized wake views but passed
  below at `1.5097L` and exited while still traveling `0.829L/T`; this rejects
  widening its gate or tuning its damping scalar. The distinct intercept-gated
  posterior wave-shape pulse captured twice at `0.7480--0.7492L`, with clipping,
  speed-limit residence, forces, moments, score, and mean distance only
  overlapping the repeat-backed speed-reserve baseline. Its required third
  exact replay then kept an active alternating wake but passed below at
  `1.2589L` and exited the lower boundary at `32.945T`, final distance
  `10.7282L`. That `2/3` record falsifies compatibility as a sufficient reason
  to retain or scalar-tune the phase-dependent tail residual: restore the
  repeat-backed achieved-course/intercept controller instead. This boundary
  applies to terminal yaw or posterior residuals added inside the existing
  intercept gate; revisit only a distinct observation-conditioned steering
  mechanism that repeatedly improves capture, arrival, load, or actuator use
  without altering far-field closure or the traveling wake.
- Localize targeting changes before the first visibly separated approach
  corridor, not only at closest pass. In the newly complete exact speed-reserve
  miss, the head is already at `y=10.605L` on the first `4L` crossing and
  `10.056L` at `3L`, versus `10.952--11.004L` and `10.551--10.623L` in three
  exact captures; it then misses at `1.5478L` despite overlapping speed, load,
  clipping, and coherent-wake evidence. A course-convergence release guard and
  a joint-speed phase-compensated course observer also miss at `1.4503L` and
  `1.5445L`, while the mean-curvature servo misses at `1.8818L`. This rejects
  more restrictive response release, scalar phase compensation, and added
  terminal curvature as repairs for the lower branch. Preserve the carrier
  and allocation, but test a distinct normalized outer-loop task observation
  early enough to act across the `6--3L` approach. Avoid short-window bearing
  rates or joint-phase convergence triggers, which can turn beat motion into a
  false task signal. Falsify this implication if a later mechanism changes the
  far path or wake, or if repeated complete diagnostics show that a sub-`3L`
  change alone robustly restores capture without increasing loads or clipping.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
