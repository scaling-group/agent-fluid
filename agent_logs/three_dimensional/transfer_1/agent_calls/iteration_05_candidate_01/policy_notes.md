# Acceleration-projected completion-gated capture

## Evidence and visual diagnosis before editing

- All four sampled solver examples are byte-identical policies and rollouts.
  They satisfy the frozen evidence contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
  dynamics, and `capture` at `26.411 T` and `0.7496068 L` with score
  `-0.71050181`.  There is therefore no distinct failure among the current
  samples; the inherited speed-guard capture is the informative poorer
  contrast, and the inherited `2.4625 L` response-gated miss and `4.7800 L`
  seed failure establish why redirect semantics should not be reopened here.
- The top-down sheet shows self-propelled progress along a continuous curved
  route, with an alternating red/blue wake established by `5 T`, preserved
  through the long closing segment, and redirected toward the capture disk
  between `21 T` and `26 T`.  The lateral oscillation remains organized around
  net target progress rather than producing an unproductive standing wiggle.
  The oblique Lambda2 sheet agrees: compact alternating three-dimensional
  structures remain attached to the posterior wake through the redirect, with
  no visible wake collapse or instability immediately before capture.
- The metrics confirm the visual interpretation rather than merely a dramatic
  vortex: distance falls from `12.3277 L` to `0.7496 L`, the run remains finite,
  and the fish captures in still water rather than being advected by ambient
  flow.  The sampled controller's issued acceleration reaches
  `74.1975/85.6413 rad/T^2`; at least one joint exceeds the evaluator's
  `31.4159 rad/T^2` envelope in many trajectory rows even though the evaluator
  applies that same componentwise clamp before state integration.
- The assigned parent's isolated acceleration-projection rollout is the
  decisive evidence.  Relative to the unprojected sampled capture, its two
  command columns are bounded at `31.4159 rad/T^2`, every trajectory column
  other than those issued-command columns is byte-identical, and the combined
  keyframe sheet, capture time, final distance, and score are identical.  By
  contrast, the inherited joint-speed outward-acceleration guard changed the
  applied dynamics, delayed capture by `0.4015 T`, worsened mean distance and
  score, and provided no material force/moment benefit.

## Policy hypothesis

Promote the assigned parent's isolated componentwise acceleration projection
onto the public candidate.  Preserve the evaluated completion-gated redirect,
posterior-lag carrier, body-frame target feedback, cadence schedule, and
half-cycle steering without retuning.  Own the physical limit in
`target_policy_params` and sanitize each raw joint command before clamping.
This should reproduce the sampled target trajectory and coherent wake while
making the policy contract itself feasible, without the unsupported
joint-speed guard.

Falsification: reject the transfer if formal evaluation changes any applied
joint state, non-command trajectory value, wake structure, capture time, or
score beyond deterministic tolerance.  Do not infer held-out robustness from
this idempotence result, and do not add speed-based attenuation unless an
isolated held-out rollout shows instability from speed-limit residence and a
benefit that repays the demonstrated closure delay.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG and residual joint control
source_mechanism: preserve a feedback-generated propulsive rhythm while projecting the issued two-joint command onto the physical actuator envelope
transferable_invariant: an actuator-boundary feasibility projection can bound commands without changing the lower-amplitude state-feedback gait when the plant already applies the same projection
nontransferable_details: published gains, robot torque and motor models, clocked CPG phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame completion-gated steering and the observed-joint posterior-lag carrier, then finite-sanitize and componentwise clamp both accelerations to a parameter-owned limit without a joint-speed guard
falsification: reject if applied joint histories, non-command trajectory columns, wake, loads, capture time, or score differ materially; separately test rather than assume robustness under a different actuator envelope

## Scope

The current worker claims no new CFD result.  The projection itself is backed
by the completed assigned-parent rollout; this candidate's formal evaluation
still occurs only after worker exit.
