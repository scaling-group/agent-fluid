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
- Early carrier establishment is a supported improvement locus, but the
  physical need signal and the allocation of extra tail work matter more than
  an additional absolute-energy threshold. Relative to three deterministic
  `17.7265T`, `-0.081395`, `1.967391L` no-reserve captures, an anterior-energy
  gated posterior wave amplification improves first-`3T` mean distance/speed
  from `12.230072L/0.2395U` to `12.214443L/0.2523U` and score/mean distance to
  `-0.073952/1.960279L`, with a coherent wake in both visual rows. That reserve
  is not route-neutral: capture slips to `17.9740T`, path and maximum head
  cross-track rise from `12.8468L/0.5120L` to `13.0672L/0.6630L`, and
  approach/final alignment fall from `0.899/0.601` to `0.740/0.132`. Requiring
  deficient target closure retains part of the early gain
  (`12.220627L/0.2453U`) and is the only sampled qualification that also
  improves arrival: it captures at `17.6935T`, reaches `1.960960L` mean
  distance on a `12.8750L` path, and finishes at `0.637` alignment with only
  `-0.046 rad/T` yaw. In contrast, the assigned parent's conjunction with low
  absolute posterior angle-rate energy regresses to `18.0015T`,
  `-0.077585/1.963845L`, a `13.1271L` path, and `0.181` final alignment. The
  two-view wakes and RMS yaw/force/moment classes remain near-identical, so
  absolute posterior energy does not survive as a response certificate; it
  can also mix steering curvature with oscillatory response. Avoid retrying
  that simple two-joint energy conjunction. A later closure-qualified
  velocity-aligned work reserve leaves the lagged target and mean curvature
  unchanged and improves score/mean distance further to
  `-0.072146/1.958037L`, with first-`3T` distance/speed
  `12.214522L/0.2519U` and unchanged two-view wake and load class. This is a
  qualified propulsion success, but not a route-neutral one: relative to the
  target-amplitude closure gate it delays capture from `17.6935T` to
  `17.8695T`, lengthens path from `12.8750L` to `13.0071L`, increases maximum
  head cross-track from `0.4571L` to `0.6102L`, and changes final
  alignment/yaw from `0.637/-0.046 rad/T` to
  `-0.003/-3.068 rad/T`. Thus an unchanged target alone does not certify clean
  propulsion/steering separation: unconditional signed-velocity work can
  reinforce posterior motion while it is moving away from the lagged wave
  target. Preserve closure qualification as the startup/recovery need signal,
  but require any next work allocation to be phase-consistent with observed
  oscillatory tracking error rather than adding work across every response
  phase. Falsify this boundary if a phase-consistent reserve loses the early
  and mean-distance gains, or if unconditional work proves route-neutral in a
  reflected or disturbed condition without raising actuator/load class or
  disrupting either wake view; also reject closure qualification if its
  phase-sensitive signal fails to release during useful progress.
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
