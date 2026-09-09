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
- Do not optimize terminal control allocation for clamp fraction alone. From
  the same projected-intercept lineage, carrier-first nested saturation reduced
  whole-trace acceleration clamping to about `60.8%/60.9%` but missed below
  the target at `1.4292L`; conditional speed reserve instead softened only
  outward carrier effort when joint speed, previous action, and carrier
  direction agreed, retained the alternating top-down and oblique wake, and
  captured in three exact-policy evaluations at `0.7466--0.7494L` and
  `18.2050--18.6010T`. Those repeats clear the earlier robustness boundary even
  though both joints still touch `260 deg/T` and returned acceleration remains
  clamped on about `68.5--68.7%/70.6--71.0%` of rows. Preserve this selective
  reserve as the baseline authority allocation; do not broaden it into total
  command suppression or tune it merely to lower clamp fraction. Falsify the
  implication if later exact repeats lose capture, wake coherence, crossing
  speed, or the established force/yaw-moment envelope.
- Do not tune continuous signed projected-miss steering after its one threshold
  capture. Blending from course error toward normalized target/velocity miss
  inside `2L` captured once at `0.7477L`, then the same bytes missed at
  `1.6366L` and `1.7680L` and exited below. Both failures retained coherent
  alternating wakes and about `0.82L/T` closest-pass speed, were already on
  wider paths as they crossed `2L`, and reached closest approach with negative
  target/velocity alignment while the route request was saturated in the
  corrective direction. Revert to the three-repeat speed-reserve route rather
  than adjusting the failed blend scale or distance. A distinct recovery test
  may use receding alignment and short-window range increase to gate bounded
  target-signed curvature after a pass, but it must be inactive on evidenced
  first-pass captures and must preserve the carrier. Falsify this implication
  if a projected-miss replay becomes repeatably successful, or if post-pass
  feedback cannot prevent the same lower exit without higher loads or a tight
  orbit.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
