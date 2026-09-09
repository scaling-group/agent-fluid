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
- In the direct-uniform seed rollout, the alternating top-down wake and oblique
  Lambda2 structures show genuine self-propulsion, and joint angles stay near
  `26 deg`, yet heading ranges from about `+0.60` to `-1.17 rad`: distance only
  improves from `12.3277L` to `12.0638L` transiently before a `left_domain`
  exit at `8.613T` and `12.3510L`. The same trace touches the velocity limit on
  `4.0%` of rows and exceeds the raw acceleration envelope on `52.6%`, so a
  coherent wake proves self-propulsion but not efficient control authority.
  For this failure topology, preserve the joint-state traveling-bend structure
  and first add bounded body-frame
  target-vector-to-mean-curvature feedback rather than retuning propulsion.
  This implication applies when a coherent wake and finite translation are
  visible without target alignment; falsify it if the added curvature turns
  with the wrong sign, destroys wake coherence, worsens saturation, or leaves
  the same exit topology and distance record; do not answer a failed turn by
  blindly increasing already actuator-heavy propulsion.
- Completed redirect evidence supports a geometry-authoritative steering
  package, not a raw yaw-rate servo. The opposite-sign anterior/posterior servo
  preserved a coherent 3D wake but beat-scale rate feedback repeatedly changed
  route request, passed about `5L` high, and exited after reaching `4.9765L`.
  Replacing it with lateral target fraction as the persistent sign source and
  allowing correcting yaw to release, but never invert, differential curvature
  produced capture in four sampled repeats at `0.7482--0.7497L` and
  `19.228--19.784T`; their executable policies and parameters are identical,
  so their score spread is repeatability evidence rather than support for
  distinct gains. Preserve this steering package when testing the next
  mechanism, and count comment-only variants as replications. Its capture does
  not establish efficient actuation: the repeats request acceleration beyond
  `1800 deg/T^2` on about `61.7--62.2%`/`71.7--72.3%` of anterior/posterior
  samples and contact the `260 deg/T` rate limit on about
  `10.6--10.8%`/`14.1--14.4%`. Test demand relief as a separate state-feedback
  ablation, but distinguish interface normalization from changes to the
  carrier. Final policy-side projection at the episode's `1800 deg/T^2`
  envelope is now supported by two completed rollouts: both preserve the
  target-directed top-down street and compact caudal Lambda2 structures,
  capture at `0.7464--0.7494L` in `19.118--19.135T`, and keep mean distance at
  `2.1220--2.1276L`, while public command peaks fall from roughly `62/101` to
  `31.416 rad/T^2`. Treat that exact final projection as a validated contract
  boundary, not as rate relief: rate contact remains. In contrast, outward
  acceleration tapers beginning at `0.80` and `0.85` of the joint-rate limit
  keep coherent wakes and remove rate contact but both lose capture, exit left
  after `21.203--22.132T`, and approach only `5.3386L` and `5.0277L`. Avoid
  further pointwise rate barriers around this carrier unless a new mechanism
  explicitly preserves phase and mean curvature; falsify any proposed relief
  on route topology and capture before accepting lower saturation statistics.
- Instantaneous terminal velocity residuals are not established improvements
  around the captured differential-curvature carrier. A raw body-lateral lead
  preserved capture in two sampled compositions, but its arrival shifted by
  opposite signs versus matched projected and unprojected baselines and its
  mean distance was worse in both comparisons. A target-relative transverse-
  velocity residual was more damaging: despite a coherent top-down street and
  compact 3D caudal wake, it missed the `0.75L` radius at `0.9490L`, then exited
  at `32.065T` with final distance `8.7907L`. For this carrier, avoid letting
  instantaneous velocity directly add or subtract route curvature; first test
  response qualification in which target geometry retains sign authority and
  measured bearing progress can only govern release of existing curvature. An
  eight-row reconstruction supports that boundary: yaw and bearing progress
  disagree on only `6/1624` yaw-correcting rows in the projected capture but
  on `1092/2826` in the course-residual failure.
  This boundary applies to stable self-propelled target approaches; overturn
  it only with replicated capture and route/load improvement beyond the
  `19.129--19.228T`, `2.1185--2.1277L` successful repeat band.
- Do not assume that adding joint velocity makes displacement-based half-cycle
  steering more predictive. On the projected geometry-owned carrier, replacing
  the anterior displacement phase coordinate with a normalized
  `phi1 + 0.35*phi1_dot/omega` lead preserved an alternating top-down street,
  compact caudal Lambda2 structures, and bounded public action, but destroyed
  the captured route: target-forward alignment averaged only `0.305`, closest
  approach was `3.5687L`, and the fish exited left at `28.650T` and `9.1929L`.
  In contrast, all four current displacement-only samples capture at
  `18.881--19.052T` with mean distance `2.0987--2.1154L`. Around this carrier,
  keep beat redistribution tied to observed displacement and let persistent
  target geometry own route authority; reject velocity-led phase anticipation
  on capture and route topology before considering wake coherence or scalar
  load improvements. Reopen this boundary only if a separately normalized
  phase estimator replicates capture without leaving that route-quality band.
- Mild body-frame misalignment scheduling is positive route evidence but not
  yet replicated demand relief. Reducing only the rhythmic amplitude by up to
  `15% * abs(target_body_y/distance)` while preserving absolute differential
  curvature, displacement-phase steering, and the projected action envelope
  retained the shallow target-directed street and compact caudal Lambda2 wake,
  and captured at `18.6505T` with mean distance `2.0934L`. That is better than
  the sampled displacement-only result (`18.8815T`, `2.1023L`) and the other
  current captures (`19.0080--19.0520T`, `2.0987--2.0999L`), so preserve this
  schedule while isolating the next feedback mechanism. Do not interpret it as
  load reduction: its `61.0%/73.2%` acceleration contact and `11.1%/15.1%`
  rate contact overlap the successful carrier family. Treat the route benefit
  as provisional until replicated; falsify it first on capture, trajectory
  topology, and distance quality, and only then on saturation or wake metrics.
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
