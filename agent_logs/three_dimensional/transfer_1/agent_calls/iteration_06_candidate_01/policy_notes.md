# Evidence-confirmed acceleration-projected capture

## Evidence and visual diagnosis before editing

- All four sampled examples satisfy the frozen rollout contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and capture at `26.411 T` and
  `0.7496068 L` with score `-0.71050181`. Three carry the assigned parent's
  unprojected completion-gated policy; one carries the isolated acceleration
  projection. Their combined keyframe sheets are byte-identical, so they are
  repeated evidence of one successful trajectory rather than four distinct
  controller outcomes.
- In the top-down vorticity row, displacement begins only after tail motion,
  an alternating red/blue wake develops behind the posterior body, and the
  fish follows a continuous target-directed arc into the capture disk. The
  lateral oscillation produces net progress rather than a standing wiggle. In
  the oblique Lambda2 row, compact three-dimensional structures remain behind
  the tail through the terminal redirect; there is no visible wake collapse
  or instability before capture. With zero ambient flow, the motion is
  self-propelled rather than advection.
- Metrics and trajectory data agree with the visual diagnosis. Distance falls
  from `12.3277 L` to `0.7496 L`; mean/max speed is `0.5013/0.6669 L/T`; and
  the finite rollout remains stable. The unprojected policy issues raw joint
  acceleration peaks of `74.1975/85.6413 rad/T^2`, with at least one component
  beyond `31.4159 rad/T^2` in `3963/4802` rows. The evaluator already applies
  that componentwise physical clamp before integration.
- The projected sample caps both issued-command peaks at
  `31.4159 rad/T^2`. Its combined sheet is byte-identical to the unprojected
  sample, and hashes of every trajectory column except the two issued-command
  columns are identical. Capture time, mean distance `2.6134 L`, score, speed,
  loads, joint histories, and termination are unchanged. This completed A/B
  result establishes policy-boundary projection as idempotent for the present
  evaluator.
- The inherited optimizer logs provide the poorer contrast missing from the
  four duplicate successful views. Adding a near-speed-limit outward-
  acceleration guard changed the applied dynamics, delayed capture by
  `0.4015 T`, worsened mean distance from `2.6134 L` to `2.6382 L` and score
  from `-0.71050` to `-0.73429`, without a compensating load benefit. Earlier
  inherited response-gated and transferred-seed trajectories missed at
  `2.4625 L` and `4.7800 L`. Those negative results argue against reopening
  the successful completion gate, carrier, or speed feedback in this
  candidate.

## Policy hypothesis

Promote the sampled isolated componentwise acceleration projection onto the
assigned parent. Preserve the evaluated completion-gated redirect,
posterior-lag carrier, normalized body-frame guidance, cadence schedule, and
half-cycle steering exactly. Own the acceleration limit in
`target_policy_params`, finite-sanitize each final joint command, and omit the
unsupported joint-speed guard. This is one actuator-boundary mechanism, not a
gain retune or a new route.

Expected result: reproduce the captured parent's applied trajectory, coherent
two-view wake, `26.411 T` arrival, and score to deterministic tolerance while
never issuing a nonfinite or out-of-envelope acceleration. Falsify the
candidate if any applied joint state, non-command trajectory value, wake,
load, capture time, or score changes materially, or if a returned command
exceeds the parameter-owned bound. This equivalence does not establish
robustness under a different actuator model or held-out initial pose.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG and residual joint control
source_mechanism: preserve the feedback-generated propulsive rhythm while projecting the issued two-joint command onto the physical actuator interface
transferable_invariant: an actuator-boundary feasibility projection can bound commands without changing an already-feasible applied state-feedback gait when the plant uses the same projection
nontransferable_details: published gains, robot torque and motor models, clocked CPG phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame completion-gated steering and the observed-joint posterior-lag carrier, then finite-sanitize and componentwise clamp both final accelerations to a parameter-owned limit without a joint-speed guard
falsification: reject if applied joint histories, non-command trajectory columns, wake, loads, capture time, or score differ materially; retest rather than assume equivalence under a different actuator envelope

## Scope

The candidate's new CFD evaluation occurs after this worker exits. The
projection mechanism itself is supported by the completed sampled rollout;
no same-worker CFD result is claimed.
