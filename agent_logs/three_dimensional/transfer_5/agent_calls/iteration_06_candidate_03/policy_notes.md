# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=(0,0,0)`) and all terminate in capture. There is no semantic
  failure in the current sample, so the comparison uses the strongest finite
  result (`solver_e08e4373a646`) and the weakest relative result
  (`solver_f2d961b95010`), with the assigned parent
  (`solver_74436c6ae2ba`) treated separately.
- In both the top-down and oblique rows, the best and weakest sheets show
  self-propelled target progress, a coherent alternating vortex street, paired
  three-dimensional wake structures, and the same broad gradual-turn capture
  topology. Neither sheet supports replacing the traveling-wave carrier or
  applying a static posture turn.
- The assigned phase-compensated terminal-yaw parent captures fastest
  (`23.7600T`) but is not the strongest overall sample. Against the best
  target-relative-course candidate (`23.8810T`), its scoring mean distance is
  slightly worse (`2.434407L` versus `2.434313L`), its terminal mean/peak
  absolute yaw rate is higher (`1.865/3.472` versus `1.556/2.975 rad/T`), its
  peak lateral load is higher (`0.02556` versus `0.02400`), and its joint-1
  `>=95%` speed-limit exposure is higher (`20.35%` versus `19.71%`). The parent
  therefore buys arrival speed with a noisier late response rather than a
  clean route improvement.
- Target-transverse velocity is itself dominated by the carrier: within `3L`,
  its correlation with anterior joint velocity is `0.841` for the best sample
  and `0.867` for the parent. Subtracting the one-rollout phase proxy
  `0.07*qdot1` lowers transverse-speed RMS from `0.2606` to `0.1531 U` in the
  best sample and from `0.3049` to `0.1661 L/T` in the parent. A raw
  target-course residual therefore needs the same beat rejection already used
  for yaw; its residual mean must still be allowed to request correction.

## Policy hypothesis

Retain the assigned parent's captured response-released C-bend carrier,
traveling-wave lag, phase-rejected excess-yaw magnitude, and smooth physical
projection. Replace the terminal bend's sign/magnitude request with a bounded,
target-relative course residual formed from normalized `target_body_L` and
`velocity_body_U` after subtracting an anterior
phase-velocity proxy. This makes terminal curvature require both route-level
cross-track error and excess yaw instead of reacting to yaw phase alone.

Falsification: reject the candidate if it loses capture or coherent alternating
wake structure; if arrival and scoring distance both regress; or if terminal
yaw, lateral load, acceleration exposure, or joint-speed exposure fail to move
toward the cleaner target-relative-course sample. The phase coefficient is an
empirical diagnostic from this gait, not a universal hydrodynamic constant.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and terminal target capture
source_mechanism: sensor feedback modulates a low-dimensional propulsive rhythm while near-target course error supplies a bounded residual
transferable_invariant: preserve the traveling-wave carrier and separate slow target-course correction from beat-correlated yaw and transverse motion
nontransferable_details: published gains, dimensional cadence, species envelopes, exact vortex phase, and source-task routes
policy_translation: use the normalized body-frame target/velocity cross product, subtract an anterior joint phase-velocity proxy, and let the bounded residual gate the existing two-joint excess-yaw counter-bend
falsification: reject if capture or wake coherence is lost, or if course directness, terminal yaw, load, and saturation histories do not improve together

## Worker-side verification boundary

- The prescribed guidance/provenance check, Julia policy-contract load, direct
  parameter-schema audit, and repository boundary check pass. No CFD was run.
- Synthetic near-target probes remain finite and strictly inside the smooth
  acceleration envelope; the new course residual reverses sign under mirrored
  body-frame target, velocity, and joint-phase inputs.
- Static replay of the assigned parent's recorded states is exactly identical
  to that parent outside the `3L` terminal gate. Inside it, the new brake is
  materially active on `71.6%` of reconstructed samples but reduces mean
  absolute bend request from `0.2913` to `0.1137` (peak `0.5047`). This checks
  algebra, gating, and scale only; it is not a fluid-dynamic counterfactual and
  does not claim the unevaluated candidate improves the rollout.
