# Evidence-selected terminal phase-allocation candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window. Three byte-identical v40 predicted-miss-corridor
  rollouts capture at `24.662014T`, minimum/final distance `0.748606L`, mean
  distance `2.348173L`, and score `-0.448570730`. The distinct v41
  phase-selective allocation also captures, at `24.640015T`, `0.748356L`,
  `2.347937L`, and `-0.448328283`.
- Both rows of the v41 and assigned-parent v40 combined keyframe sheets were
  inspected from release through capture. Their top-down rows start wake-free
  and show self-propelled diagonal progress, a coherent alternating mid-plane
  vortex street, and the same compact transverse terminal hook. Their oblique
  rows retain compact three-dimensional Lambda2 structures through capture.
  The fish is not advected, unstable, or escaping out of plane, and the v41
  improvement is not a new wake or route class.
- No failed-rollout keyframe is present in the current sample. The informative
  failure boundary therefore comes only from inherited audited logs: posterior
  reference-velocity feedforward preserved a coherent wake but changed the far
  route by `8T`, missed at `0.993183L`, and exited left at `37.1470T` and
  `6.9973L`. This rules against broad phase correction or synthesized follower
  acceleration, not against v41's terminal-local veto of an existing residual.
- Relative to v40, v41 allocates the already-bounded collision-course residual
  only on the observed lagged-wave half-cycle aligned with the requested turn.
  The completed rollout advances capture by four integration rows
  (`0.021999T`), lowers mean distance by `0.000236L`, improves final projected
  perpendicular miss from `0.637713L` to `0.631928L`, and improves terminal
  course angle from `58.415` to `57.610 deg`. It preserves zero sampled
  posterior hard-stop occupancy, nearly identical anterior/posterior exact-rate
  exposure (`9.196/4.643%` versus `9.233/4.639%`), and the same peak absolute
  body-force/yaw-moment class (`0.0254/0.0319/0.0156` versus
  `0.0254/0.0319/0.0157`).
- The gain is repeatable only after this candidate is evaluated again and is
  still nonsemantic: capture, visible route, coherent wake, load class, and
  rate class do not change. It supports phase-local allocation over another
  terminal magnitude scalar, but not a claim of generalization or a reason to
  stack another nominal terminal residual.

## Candidate hypothesis

Select the completed v41 controller as this workspace's one candidate. Preserve
v40's anterior state-feedback phase anchor, lagged posterior traveling wave,
sector and course-preview paths, predicted-miss corridor, steering-priority
envelope, posterior stroke braking, posterior coast, and every route-scale
gain. Keep v41's single actuator-allocation change: separate the terminal
collision-course residual from mean curvature and spend only a bounded portion
on the observed lagged-wave half-cycle aligned with its sign. Phase remains a
pure function of joint position and velocity; no clock, stored oscillator,
world-frame route, or new scalar gait tune is introduced.

Expected post-exit evidence is a deterministic v41-family capture near
`24.640T`, the same coherent three-dimensional route, zero posterior hard-stop
occupancy, and unchanged low-load and rate-limit classes, with the small v40
arrival, mean-distance, and projected-miss improvements retained. Reject the
selection if replication loses capture or those improvements, changes the far
trajectory, enlarges peak command/load class, or causes phase selection to
become a noisy same-route perturbation. Reflected or perturbed evaluation must
separately reject it if the mirror-equivariant phase gate withdraws necessary
course steering. The new CFD result is not available to this worker and is not
claimed here.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry allocates sensory steering within a stable anterior-to-posterior traveling bend instead of replacing the rhythm with static curvature
transferable_invariant: preserve the observed phase anchor and posterior lag, and spend an existing bounded target-derived residual only on the joint-state half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: select v41's mirror-equivariant gate on the normalized body-frame predicted-miss residual, using the lagged-wave state inferred from anterior joint position and rate while leaving the carrier and safety layers unchanged
falsification: reject if replication loses capture, far-route noninterference, coherent wake, zero posterior hard-stop occupancy, or the low-load class, or if phase selection raises peak command while failing to retain the measured terminal improvements

## Pre-evaluation validation

- The single candidate is byte-identical to the completed v41 sample (LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This selects completed sampled evidence and does not claim a same-worker CFD
  result.
- The Julia public-contract probe returns exactly two finite accelerations
  (`-14.3858335`, `0.0005062`). The deterministic schema audit resolves all
  `87` direct `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD checks were then
  run directly and separately: reusable-guidance semantics, the Julia public
  contract, and the solver editable-boundary audit all pass. The duplicated
  assigned-parent marker in the rendered workspace README was reduced to the
  single marker required for an unambiguous semantic comparison. No formal CFD
  was run.
