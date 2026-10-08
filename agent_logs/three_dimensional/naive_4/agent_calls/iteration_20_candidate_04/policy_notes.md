# Hydrodynamic-moment lead for residual yaw correction

## Evidence read before the policy edit

- All four sampled episodes satisfy the frozen experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `capture` at `16.0545T` after `2919` steps and `239`
  moving-window shifts.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the best sampled result (`solver_d198bc53b207`) and the informative
  weaker comparator (`solver_0b4f3f55c611`), as well as the two repeated
  terminal-release sheets. All show self-propelled target approach: an
  initially quiescent release develops a spatially trailing alternating wake
  by about `4T`, with compact three-dimensional posterior structures through
  capture. There is no passive advection, wake collapse, boundary event, or
  numerical breakup. The carrier, posterior traveling bend, base redirect,
  and terminal capture path should therefore be preserved.
- The repeated response-and-corridor release improves the yaw-residual parent
  from score `-0.048654`, distance integral `1.931257L`, and final distance
  `0.747530L` to `-0.048055`, `1.930773L`, and `0.746955L`, without changing
  any `8/6/4/2/1.25/1.0/0.8L` milestone or capture time. The assigned-parent
  alignment-escape addition then changes only `17` closed-loop posterior
  actions and improves those values by merely `0.0000017`, `0.00000135L`, and
  `0.00000161L`; its keyframe sheet remains indistinguishable. This is not a
  meaningful new trajectory and argues against another terminal micro-release
  gate. The inherited broader target-bearing-support cap is the complementary
  negative result: it began acting near `1.675L` and regressed to score
  `-0.048763`, so target geometry alone is not sufficient to release the
  route-improving supplemental branch early.
- A trace-level response check identifies a different observable role. The
  normalized measured yaw moment has mean absolute magnitude `0.00808` and
  peak `0.01903`; it correlates `0.9906` with measured yaw acceleration three
  solver steps later. Thus its sign is evidence of imminent angular response,
  while the existing carrier-relative yaw-rate residual reacts only after
  that response appears. On the assigned-parent states, a smooth target-
  opposing moment gate normalized at `0.010` would change `310` feasible
  posterior commands, mainly before `8L`; only `57` changes exceed
  `1 rad/T^2`, and the largest is `4.081 rad/T^2` versus the
  `31.416 rad/T^2` acceleration limit. This is an earlier response mechanism,
  not a scalar adjustment to the proven steering gain.

## One candidate mechanism

Start from the replicated terminal yaw-response release, and remove the
assigned-parent alignment-escape branch that produced no meaningful physical
change. Preserve the oscillator, route-error residual, base redirect, wave
allocation, approach law, anterior corridor release, terminal response
release, and exact speed-boundary projection. Add one bounded
*hydrodynamic-moment lead* to the existing supplemental yaw correction:
smoothstep only the normalized yaw moment whose sign opposes the reliable raw
target redirect, and take the maximum of this lead gate and the existing
carrier-relative yaw-rate-opposition gate. This opens the already tested
`4 deg` posterior curvature bound a few steps earlier when fluid torque
predicts a loss of target-directed yaw; it never sums a second curvature
allowance, and target-aiding moment receives no extra authority.

Expected result: retain the coherent carrier and capture while beginning
selected posterior corrections before the yaw-rate residual lags behind the
hydrodynamic response, producing a meaningfully different early route rather
than another same-step terminal perturbation. Falsify the mechanism if it
delays any distance milestone, loses capture or two-view wake coherence,
raises posterior excursion, limiting, or force/moment peaks enough to outweigh
route progress, or if target-opposing moment does not provide useful lead over
the rate residual in closed loop.

bookshelf_consulted: true
source_domain: wake-interaction feedback and sensor-modulated robotic-fish CPG residual control
source_mechanism: separate the rhythmic carrier from a bounded sensory correction, and use measured hydrodynamic load as an early response signal rather than cancelling all carrier motion
transferable_invariant: a target-signed route request may admit a bounded residual action when normalized body-frame fluid torque predicts angular acceleration opposite that request; aiding torque must not receive extra correction
nontransferable_details: published gains, dimensional moment thresholds, robot or species kinematics, full-body waveforms, exact vortex phases, capture radius, and task-specific routes
policy_translation: preserve the state-feedback traveling bend and target/course redirect; smoothstep `-redirect_turn * moment_z_L2` at a scale calibrated from the sampled trace, combine it by `max` with the existing yaw-rate-opposition selector, and retain the same owned posterior-curvature ceiling
falsification: reject if the added selector changes action for target-aiding moment, exceeds the existing supplemental curvature bound, breaks lateral reflection symmetry, delays milestones or capture, degrades the coherent wake, or increases limiting and loads without route benefit

The shelf supplies only the residual-response and load-feedback invariant. The
moment sign, normalization, lead correlation, and bounded policy translation
come from the sampled L64 rollout evidence, not from published numerical
settings.

## Non-CFD verification after the edit

- The final candidate SHA-256 is
  `fd9d50460a75d5909e33b163892a726a7ac42ceead80d699c21a01ef4cd2987f`.
  All `43` direct `params.FIELD` references are owned by the `43` fields from
  `target_policy_params()`.
- A deterministic `52,488`-state sweep over joint state, both exact joint-
  speed boundaries, target side, body-frame course, distance, yaw rate, and
  yaw moment returned finite bounded commands, zero outward acceleration at
  either speed boundary, and lateral-reflection error at or below `1e-12`.
  Target-aiding moment matched the evaluated terminal-release reference
  exactly, while target-opposing moment changed posterior action on `1,238`
  sweep states; anterior action was unchanged everywhere.
- Counterfactual replay on the assigned-parent states confirms mechanism
  scope, not a new closed-loop outcome: `310` posterior commands differ from
  the replicated terminal-release reference, `191` by more than
  `0.1 rad/T^2` and `57` by more than `1 rad/T^2`. The first difference above
  `0.1 rad/T^2` occurs at `11.736L`, the largest is `4.080 rad/T^2`, and the
  last occurs at `1.127L`; the established terminal release therefore remains
  the final-approach mechanism.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were run directly and separately: guidance provenance and semantic
  change, the lightweight Julia policy contract, and the solver editable-
  boundary check all pass.

No formal CFD was run. The predicted route and wake effects remain hypotheses
for post-worker evaluation.
