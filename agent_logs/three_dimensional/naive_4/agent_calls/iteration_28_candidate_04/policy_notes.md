# Response-conditioned phase-lag candidate

## Evidence diagnosis before the policy edit

- All four current sampled solvers are byte-identical to the assigned policy
  (`650a2d0d...e6e2`), and their combined sheets are byte-identical
  (`c36dbb96...e72c`). Each satisfies the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, capture after 2,919 steps at `16.054371T`, and 239
  moving-window shifts. They reproduce final/minimum distance `0.745845616L`,
  distance integral `1.929839552L`, score `-0.046899933`, and posterior exact
  acceleration-limit residence about `21.79%`. Four identical outcomes are
  replication evidence, not four distinct controller mechanisms.
- I inspected the current combined sheet (`solver_197b19357040`) and the
  nearest distinct inherited controlled regression
  (`step_24_worker_1_solver_e808cf9d855f`) from release through termination.
  In both top-down rows, a small release disturbance develops into a coherent
  alternating lateral wake along a smooth target-directed arc. Both oblique
  body/Lambda2 rows retain compact three-dimensional caudal structures through
  capture. Neither rollout is passively advected, approaches a virtual
  boundary, loses its wake, collides, or becomes unstable; the terminal
  differences are below sheet resolution.
- The inherited quantitative contrast is nevertheless decisive. The current
  carrier-demodulated middle-approach mean brake improves the preceding net
  line-of-sight damper only from `0.745853782/1.929846378L` to
  `0.745845616/1.929839552L` at the same arrival step, and all four current
  samples then repeat the latter trace. Translational-slip half-cycle relief
  was weaker at score `-0.046922579`, while broad bearing-rate lobe relief
  regressed to `-0.046998432`. Another terminal amplitude gate or scalar
  threshold edit is therefore unsupported.
- The inherited route-wide counterexample bounds any attempt to broaden the
  same mean brake: a two-degree instantaneous residual-curvature branch acted
  across roughly 950 commands, missed capture at `0.785816L`, curled away in
  both views, and exited at `29.293T` with final distance `9.122L` and score
  `-10.1782`, even though its wake remained coherent. Carrier subtraction is
  not enough to make instantaneous line-of-sight residual a safe route-wide
  mean-steering signal.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and two-joint phase-lag steering
source_mechanism: preserve a productive traveling-wave carrier while sensor feedback temporarily advances only the posterior phase that aids the requested correction
transferable_invariant: when a bounded mean correction is trace-scale and broad mean curvature is unsafe, reallocate the same response into a state-conditioned posterior phase change without amplifying the opposing wave lobe
nontransferable_details: published oscillator gains, clock-defined phase, dimensional frequencies, species-specific envelopes, exact vortex phase, morphology, and task-specific routes
policy_translation: retain the evaluated anterior oscillator, posterior carrier, route redirect, approach law, and raw terminal line-of-sight damper; during the normalized closing approach but above the terminal band, subtract the fitted anterior carrier response from body-frame bearing rate and advance posterior lag only on joint-state phases where the target change opposes measured reopening, under the existing three-degree target envelope
falsification: reject if pre-approach milestones change, capture is delayed or lost, the coherent two-view wake or force envelope regresses, posterior limiting grows materially, the phase branch merely reproduces the assigned trace, or the inherited curl-away topology returns; do not broaden it outside the proximity-and-closing gate without distinct positive evidence

## One candidate hypothesis

Create exactly one structural alternative to the replicated assigned policy.
Preserve the proven state-feedback oscillator, posterior traveling bend,
response-gated redirect, one-sided wave relief, approach settling, redirect
handoff, raw terminal line-of-sight damper, and exact speed-boundary
projection. Replace only the carrier-demodulated *middle-approach mean
curvature* with a bounded posterior phase-lag advance. The branch is active
only when normalized proximity, positive target closing, course reliability,
residual line-of-sight reopening, and a joint-state phase that moves the tail
target against that reopening all agree. It fades to zero as the validated
raw net-rate terminal damper takes over below `0.90L`.

This is a new actuation allocation rather than gain tuning: no new mean route
bias is added, the phase change is derived from observed anterior joint state,
and its target displacement is capped by the existing three-degree terminal
envelope. The intended test is whether phase allocation can create a useful
feasible posterior action and improve approach geometry without the unsafe
route-wide mean bend. The current worker makes no claim about the unevaluated
CFD outcome.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `dd83843c3bb4162ac898b5fed3ebc14aa071a1de3feda811fc923d15fd56b88a`.
  All 49 direct `params.FIELD` references resolve against exactly the 49
  fields returned by `target_policy_params()`.
- Counterfactual evaluation on the assigned rollout's recorded body-frame
  states changes 17 posterior commands between `1.6529L` and `1.2589L`; it
  leaves anterior commands and every earlier state unchanged. Maximum
  posterior difference is `0.66891 rad/T^2`, mean absolute difference over
  changed samples is `0.11398 rad/T^2`, and 13 of 17 changes reduce
  instantaneous command magnitude. Two changed samples reach the existing
  acceleration bound, so the later CFD evaluation must check the stated
  limiting falsifier. This replay demonstrates feasible approach action, not
  a closed-loop outcome.
- A deterministic grid of 59,049 paired normalized body-frame states has
  finite commands, stays within `31.416 rad/T^2`, and has reflection error
  below `2e-12`. Exact positive and negative joint-speed boundaries never
  receive outward acceleration, and the non-finite-observation fallback is
  finite.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were then run directly and separately: the lightweight Julia
  contract plus 49/49 parameter schema, material guidance, and solver editable
  boundary checks all pass. The material checker initially exposed a duplicate
  assigned-parent marker in the rendered workspace `README.md`; removing only
  that duplicate metadata repaired the check. No CFD was run.
