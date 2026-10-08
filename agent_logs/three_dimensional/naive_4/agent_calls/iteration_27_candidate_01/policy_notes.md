# Carrier-demodulated closing-intercept candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm or cylinders, finite dynamics, capture after 2,919 steps at about
  `16.0544T`, and 239 moving-window shifts. Translation is therefore
  self-propelled rather than background advection.
- I inspected the combined keyframe sheets for the strongest finite sample
  (`solver_b8f061aba429`) and the distinct, lower-scoring assigned-parent
  policy (`solver_8474fe870fa5`) from release through capture. In both top-down
  vorticity rows, a small release disturbance grows into an alternating,
  laterally organized wake while the fish follows a smooth target-directed
  arc. In both oblique body/Lambda2 rows, compact three-dimensional caudal
  structures persist along that arc through capture. Neither sheet shows
  passive advection, wake collapse, collision, virtual-boundary approach, or
  out-of-plane instability. Their visible paths and wakes are effectively
  indistinguishable at sheet resolution, so the metric difference is terminal
  response shaping rather than new route or wake topology.
- Two independent samples of the assigned-parent net line-of-sight terminal
  damper (`solver_8474fe870fa5` and `solver_acb79e618a5d`) are byte-identical
  and capture at final/minimum distance `0.745853782L`, distance integral
  `1.929846378L`, and score `-0.046908385`. Two independent samples of the
  carrier-demodulated variant (`solver_b8f061aba429` and
  `solver_197b19357040`) are also byte-identical and capture on the same step
  at `0.745845616L`, integral `1.929839552L`, and score `-0.046899933`.
  The latter slightly lowers mean absolute posterior command from `24.585802`
  to `24.584520 rad/T^2` and posterior acceleration-limit residence from
  `21.857%` to `21.788%`; peak lateral force rises from `0.032233` to
  `0.032388`, while peak axial force and yaw moment are unchanged. This is a
  replicated but trace-scale improvement, not held-out robustness evidence.
- The sampled policy subtracts the existing anterior-joint-phase carrier
  prediction from normalized bearing rate before the tight terminal band, but
  admits the residual only through the established closing, course-reliable,
  safe-intercept predicate. It then fades continuously into the raw net-rate
  damper under one shared three-degree curvature envelope. This is the only
  sampled structural change that improves the assigned parent; broad
  bearing-rate half-cycle relief had already regressed to `0.745940L`,
  `1.929919L`, and `-0.046998` in the inherited evidence.
- The inherited optimizer log supplies the decisive negative boundary. A
  stronger route-wide two-degree residual mean brake opened from about
  `4.34T` across roughly 950 commands. Although its wake remained coherent,
  it missed capture at `0.785816L`, curled away, and exited the virtual domain
  at `29.293T` with final distance `9.122L` and score `-10.1782`. Removing a
  carrier estimate does not by itself make instantaneous residual bearing
  rate a safe route signal.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal capture control
source_mechanism: preserve a rhythmic propulsive carrier while bounded sensor feedback modulates a separate target-response residual
transferable_invariant: separate repeatable joint-phase motion from persistent target-line response, and admit residual steering only through a validated state-conditioned handoff that cannot broadly suppress the carrier
nontransferable_details: published gains, clock-defined phase, dimensional frequency, species-specific kinematics and envelopes, exact vortex phase, morphology, and task-specific routes
policy_translation: retain the evaluated two-joint traveling-bend carrier, redirect, wave shaping, and terminal net-rate damper; subtract the normalized anterior-phase response from measured body-frame bearing rate only inside the positive-closing safe-intercept corridor, share the existing bounded posterior mean-curvature envelope, and fade continuously into raw terminal damping
falsification: reject if the branch changes earlier milestones, delays or loses capture, disrupts the coherent two-view wake, materially increases limiting or loads, or repeats the inherited near-miss-and-exit topology; do not expand it route-wide without new milestone and capture evidence

## One candidate hypothesis

Materialize exactly the evaluated `solver_b8f061aba429` feedback structure as
the single candidate. Preserve the anterior state-feedback oscillator,
posterior lag, response-gated redirect, one-sided wave relief, approach
settling, redirect handoff, and exact speed-boundary projection. Before the
tight terminal interval, demodulate normalized bearing rate with the existing
anterior joint-phase response model. Permit the residual to subtract posterior
mean curvature only when target closing, course reliability, and the safe
predicted-intercept corridor all agree; as proximity enters the established
terminal band, fade into the raw line-of-sight-rate damper with weights that do
not stack beyond the existing curvature envelope.

The prior sampled rollout predicts the same coherent wake, capture step, and
route milestones with a small crossing/integral improvement. Loss of capture
or earlier-route change outweighs that trace-scale benefit. No new CFD result
is claimed by this worker; formal evaluation occurs after exit.

## Non-CFD verification after the edit

- The candidate is byte-identical to the twice-sampled better policy and has
  SHA-256
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`.
  This is inherited evaluation evidence, not a same-worker CFD claim.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were run directly and separately: the material guidance/notes
  check, lightweight Julia policy contract, and solver editable-boundary check
  all pass. No CFD was run.
- Static schema validation resolves all 48 direct `params.FIELD` references
  against the 48 fields returned by `target_policy_params()`. A deterministic
  sweep of 21,870 paired normalized body-frame states remains finite, respects
  the acceleration envelope and exact speed-boundary projection, and is
  exactly lateral-reflection-equivariant; the non-finite task-observation
  fallback is also finite.
