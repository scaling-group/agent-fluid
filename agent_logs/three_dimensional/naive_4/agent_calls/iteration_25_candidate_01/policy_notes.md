# Net line-of-sight terminal-response candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, capture at `16.054375T` after 2,919 steps, and
  239 moving-window shifts. Their motion is self-propelled, not background
  advection.
- I inspected the combined sheets for the highest-scoring net line-of-sight
  controller (`solver_8474fe870fa5`) and the most informative controlled
  regression (`solver_a03406b458eb`) from release through termination. In both
  the top-down vorticity and oblique body/Lambda2 rows, both policies follow
  the same smooth target-directed arc, shed a coherent alternating lateral
  wake with compact three-dimensional caudal structures, and reach the target
  without collision, virtual exit, wake collapse, or instability. No sampled
  rollout has a failed termination class; the useful contrast is terminal
  response quality below the image sheet's resolution.
- The assigned-parent separate yaw-plus-translational-slip brakes capture at
  `0.745868803L`, distance integral `1.929858993L`, and score `-0.046924004`.
  Translational-slip half-cycle relief changes only the final three recorded
  actions and is positive but trace-scale at `0.745867431L`, `1.929857842L`,
  and `-0.046922579`. In contrast, broad bearing-rate posterior-lobe relief
  changes 17 terminal actions and regresses to `0.745940387L`, `1.929919104L`,
  and `-0.046998432`. These two results do not support stacking another phase
  gate on the carrier.
- The sampled net line-of-sight controller replaces the component-specific
  yaw and slip brakes with one measured total-response damper. Relative to the
  assigned parent it leaves all `8/6/4/2/1.25L` milestones, capture time,
  hard-limit residence, and force/moment peaks unchanged, changes only the
  final 17 recorded actions starting at `0.842L`, and moves the path by at most
  `2.1e-5L`. It nevertheless gives the strongest crossing in the current
  allocation: `0.745853782L`, distance integral `1.929846378L`, and score
  `-0.046908385`, while mean posterior demand falls slightly from `24.586242`
  to `24.585802 rad/T^2`.
- The inherited notes identify the same terminal decomposition: body yaw and
  translational slip both contribute to reopening of the body-frame target
  ray. The current sample now shows that correcting their measured net effect
  is stronger and simpler than braking them separately. This remains a narrow
  terminal-shape result, not evidence of route diversity or held-out
  robustness.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish sensor modulation and terminal capture control
source_mechanism: preserve rhythmic propulsion while bounded target-relative feedback damps endpoint yaw and slip without coasting early
transferable_invariant: separate the productive traveling-wave carrier and route curvature from a continuously gated terminal response, and correct the measured net target-relative angular drift rather than stacking component-specific brakes
nontransferable_details: published gains, clock-driven CPG phase, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology envelopes, and source-task routes
policy_translation: preserve the evaluated carrier, redirect handoff, wave shaping, and anterior release; inside the normalized body-frame closing capture corridor, replace separate yaw and slip mean bends with one bounded posterior bend signed by measured bearing rate only while bearing magnitude is reopening
falsification: reject if cruise milestones or the coherent two-view wake change, capture is delayed or lost, the response acts while alignment is closing or the predicted intercept is unsafe, or crossing, distance integral, limiting, and load evidence regress from the sampled separate yaw-plus-slip parent

## One candidate hypothesis

Adopt the sampled net line-of-sight-rate feedback as exactly one candidate.
The policy keeps the established state-feedback oscillator, posterior lag,
response-gated redirect, one-sided wave relief, anterior safe-corridor release,
redirect-increment handoff, and exact speed-boundary projection. Only the
terminal brake changes: a normalized measured `bearing_rate` represents the
combined target-relative consequence of body yaw and translational slip, and a
smooth proximity/closing/intercept/reopening predicate subtracts at most three
degrees of posterior mean curvature. This is a feedback-structure selection,
not scalar-only gain tuning. The current worker does not claim a new CFD
result; its evaluation should reproduce the sampled capture and preserve all
pre-terminal behavior, and it should be rejected if that reproduction fails
or if later held-out geometry shows that total line-of-sight rate aliases
productive carrier motion.

## Non-CFD verification after the edit

- The candidate is byte-identical to the evaluated
  `solver_8474fe870fa5` policy and has SHA-256
  `6a92f26667929a775a778d6ef8eda8e8030383fea68436ee4196342b642daf38`.
  This is prior sampled evidence, not a same-worker CFD claim.
- The material guidance/notes checker, lightweight Julia policy contract, and
  solver editable-boundary check pass when run directly and separately.
- A deterministic audit resolves all 48 direct `params.FIELD` references
  against the 48 fields returned by `target_policy_params()`. Across 11,340
  paired body-frame states, outputs remain finite, stay within
  `31.416 rad/T^2`, and have zero numerical lateral-reflection error. The
  non-finite-observation fallback is finite, and acceleration at either exact
  joint-speed boundary is never outward.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its prescribed checks
  were therefore executed directly as reported above. No CFD was run.
