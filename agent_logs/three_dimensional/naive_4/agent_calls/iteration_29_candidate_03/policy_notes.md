# Evaluated forward-response posterior-emphasis candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture. Translation is self-propelled rather
  than background advection. Three samples are byte-identical copies of the
  prefilled carrier-demodulated line-of-sight policy; the fourth is a distinct
  forward-speed-gated posterior-emphasis policy.
- I inspected the combined keyframe sheets for the distinct strongest finite
  rollout (`solver_07403e1ebc74`) and the prefilled comparison
  (`solver_29c0d17a684e`) from release through capture. In both top-down rows,
  the release disturbance develops into a coherent alternating lateral wake
  as the fish follows the same smooth target-directed arc. Both oblique
  body/Lambda2 rows show compact three-dimensional caudal structures without
  collision, wake collapse, virtual-boundary approach, or out-of-plane
  instability. The terminal path difference is too small to resolve reliably
  from the sheets alone. No failed termination is present in the current
  sample, so the three-copy weaker capture is the informative negative
  comparison rather than a fabricated failure case.
- The distinct policy improves capture from `16.054371T`/2,919 steps/239
  shifts to `15.977511T`/2,905 steps/238 shifts, final and minimum distance
  from `0.745845616L` to `0.744402707L`, scored distance integral from
  `1.929839552L` to `1.928580797L`, and score from `-0.046899933` to
  `-0.045506315`. It also reduces maximum posterior excursion from about
  `36.43 deg` to `33.12 deg`; capture and wake coherence therefore survive the
  added feedback mechanism.
- The assigned-parent hypothesis that the branch works by advancing startup
  propulsion does not survive the closed-loop trace. The `8L` and `6L`
  crossings are delayed from `9.074996T` and `11.044002T` to `9.091496T` and
  `11.055001T`; the `4L` and `2L` crossings are unchanged at `12.919506T` and
  `14.800513T`. The benefit appears later: the `1.25L` and `0.9L` crossings
  advance from `15.531978T` and `15.911484T` to `15.493514T` and `15.823509T`.
  Mean absolute posterior command rises from `24.5845` to
  `25.4727 rad/T^2`, exact posterior acceleration-limit residence rises from
  `21.79%` to `22.58%`, and peak lateral force rises from about `0.03239` to
  `0.03334`. Thus the score gain is a later route/crossing consequence of an
  early feasible-action perturbation, not evidence that more posterior gain
  monotonically improves launch thrust or effort.
- The inherited step-28 counterfactual found that the mechanism changed 562
  parent-trace posterior commands through `3.657503T` and that none of those
  reconstructed commands hit the acceleration limit. The completed CFD result
  shows why that pointwise check was necessary but insufficient: the changed
  hydrodynamic trajectory later accumulated more posterior command and limit
  residence. This rules out using offline no-clamp support as a guarantee of
  closed-loop actuator relief.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an anterior rhythmic carrier while allocating temporary posterior traveling-wave authority from measured propulsive response
transferable_invariant: posterior wave authority may respond smoothly to a normalized forward-speed deficit while preserving the established anterior carrier, steering bend, and approach handoff
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact Strouhal values, clock-defined burst durations, exact vortex phases, and task-specific routes
policy_translation: preserve the evaluated two-joint oscillator and all navigation and terminal roles; outside approach, multiply only the posterior traveling-wave target by a bounded smooth function that is largest at weak body-frame forward speed and returns exactly to unity after measured recovery
falsification: reject the startup-thrust interpretation because early 8L and 6L milestones did not advance; reject the policy transfer if capture, coherent two-view wake, later approach milestones, distance integral, joint envelope, or force envelope regresses, and do not tune a stronger scalar gain without a new response mechanism

## One candidate hypothesis

Materialize the distinct sampled-best policy as exactly one candidate. Relative
to the prefill, it adds only the evaluated forward-response branch: while
normalized body-frame forward speed is at or below `0.10U`, posterior
traveling-wave scale can rise smoothly by at most 25%; the increment fades to
zero by `0.35U` and is suppressed continuously by approach proximity. The
anterior oscillator, target/course steering, response-conditioned redirect,
one-sided wave relief, carrier-demodulated line-of-sight response, approach
roles, posterior allocation, and exact velocity-boundary projection remain
unchanged.

This selection is evidence-backed controller structure rather than a new gain
sweep. Its falsifiable expectation is reproduction of the sampled semantic
improvement—coherent wake, capture near `15.98T`, and better terminal distance
history—without claiming earlier propulsion milestones or lower effort. A
future held-out or follow-up result should distrust the thrust-recovery label
unless it advances route-scale distance progress as well as the final crossing.
No same-worker CFD result is claimed; formal evaluation occurs after exit.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`,
  byte-identical to the evaluated `solver_07403e1ebc74` policy. This is sampled
  prior evidence, not a new same-worker CFD claim.
- The lightweight Julia contract returns exactly two finite accelerations, and
  static schema validation resolves all 51 direct `params.FIELD` references
  against the 51 fields returned by `target_policy_params()`.
- Guidance materiality and solver editable-boundary checks pass. The first
  guidance run exposed a duplicated assigned-parent marker in the rendered
  workspace `README.md`; removing only the second duplicate marker repaired
  that metadata defect while preserving one authoritative parent marker.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were therefore run directly and separately and all pass. No CFD was
  run.
