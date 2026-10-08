# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=[0,0,0]`, no prewarm, and
  finite `capture` termination.
- No inherited `logs/optimize/` artifact was present in this rendered
  workspace; the inherited iteration history available for transfer is the
  curated assigned-parent experience bank plus the four sampled solver traces.
- The assigned-parent policy is independently replicated by
  `solver_d97cee67d951`, `solver_5187bb13ebc0`, and
  `solver_ed6d64fbfa4b`: the policy sources and combined wake sheets are
  byte-identical, and each captures at `16.0545T`, final distance
  `0.744345L`, distance integral `1.938857L`, and score `-0.055617`.
- In both visual rows, that parent is self-propelled rather than advected. The
  top-down row develops a strong, coherent alternating wake from release to
  capture while the body follows a smooth target-directed turn; the oblique
  Lambda2 row shows compact alternating three-dimensional structures near the
  posterior body without diffuse breakdown or instability before capture.
- `solver_d9f2302868e3` preserves the same qualitative two-view wake and the
  same semantic outcome, but its carrier-residual yaw-opposition feedback
  changes the useful trajectory. It advances the `8/6/4/2/1.25L` milestones
  from `9.202/11.154/13.013/14.905/15.604T` to
  `9.075/11.044/12.920/14.801/15.532T`, lowers the distance integral from
  `1.938857L` to `1.931257L`, and improves score from `-0.055617` to
  `-0.048654`, with effectively unchanged capture time (`16.0545T`).
- The changed route is not purchased with broad actuator escalation. Mean
  absolute commands fall from `23.504/24.888` to `23.495/24.616 rad/T^2`,
  exact acceleration-limit residence falls from `49.37/22.47%` to
  `49.19/21.86%`, and peak yaw moment falls from `0.01945` to `0.01903`.
  Peak lateral force rises modestly from `0.03193` to `0.03320`, and posterior
  angle grows from `31.7 deg` to `36.4 deg` while remaining below the owned
  `42 deg` target limit. The candidate therefore retains explicit load and
  angle falsification boundaries.

## Policy hypothesis

Adopt the sampled yaw-opposition residual as the one candidate mechanism,
leaving the replicated carrier, phase-residual redirect, intercept-conditioned
anterior damping release, posterior wave allocation, and exact speed-boundary
projection unchanged. Predict the beat-synchronous part of yaw rate from
normalized anterior joint position and velocity, subtract it from normalized
measured heading rate, and add bounded posterior mean curvature only when this
residual opposes an already reliable raw target redirect. Aiding yaw receives
zero additional authority. The sampled closed-loop comparison predicts earlier
distance milestones and a lower distance integral without losing coherent
propulsion or capture.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual commands over rhythmic locomotion
source_mechanism: preserve a low-dimensional propulsive oscillator while sensory feedback supplies a bounded residual steering action
transferable_invariant: separate repeatable carrier-synchronous yaw from non-carrier yaw response, and intervene only when the residual opposes a target-directed turn
nontransferable_details: published oscillator gains, dimensional rates, species or robot kinematics, exact beat or vortex phase, full-body waveforms, and task-specific routes
policy_translation: form carrier yaw from `q1/amp` and `qd1/(omega*amp)`, subtract it from `heading_rate/omega`, gate by normalized forward-speed reliability and raw body-frame redirect demand, and add at most a small owned posterior mean curvature on the opposing residual only
falsification: reject if capture is lost or delayed, any distance milestone or integral regresses, the alternating two-view wake degrades, aiding yaw is modified, posterior angle approaches its target clamp, or force/moment and command-limit residence rise enough to outweigh route improvement

The bookshelf supplies only the residual-control invariant. The numerical
carrier-yaw fit and curvature bound come from the sampled L64 solver candidate,
not from published gains or species-specific kinematics; this is a mechanism
transfer, not scalar-only tuning.
