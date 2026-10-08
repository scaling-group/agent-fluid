# Carrier-demodulated redirect-handoff candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no prewarm or cylinders, finite dynamics,
  and capture after 2,919 steps and 239 moving-window shifts. They all arrive
  at `16.0544T`; their differences are response-local rather than a change in
  termination class or bulk route.
- I inspected the combined sheets for the strongest finite sample
  (`solver_b8f061aba429`, score `-0.046900`) and the most informative relative
  failure (`solver_a03406b458eb`, score `-0.046998`) from release through
  capture, including both the top-down vorticity and oblique body/Lambda2
  rows. Both show self-propelled translation along the same smooth
  target-directed arc, a coherent alternating reverse-street wake, and compact
  three-dimensional caudal structures. Neither shows passive advection,
  reciprocal standing motion, collision, exit, wake breakup, or out-of-plane
  instability. The carrier, posterior traveling bend, base redirect, and
  one-sided wave shaping should remain unchanged.
- The strongest sample's carrier-demodulated middle line-of-sight branch is a
  concrete negative route result. Its inherited audit found only four changed
  posterior commands from `1.518L` to `1.259L`; closed-loop evaluation still
  reproduced every sampled distance milestone, `16.0544T` capture, and the
  visible route. Its observed pre-capture distance integral
  (`1.3037347574L`) is effectively identical to the simpler net line-of-sight
  controller (`1.3037347571L`). Its score gain comes from the terminal hold
  term, not earlier approach progress. The sampled posterior-lobe alternatives
  are likewise terminal-only and do not justify another phase or scalar
  threshold edit.
- A one-beat moving average of the strongest trace lies about `0.30L` on one
  side of the initial target chord near the `8L` milestone, crosses the chord
  near `3L`, and reaches roughly `0.40L` on the other side at capture. This is
  compatible with bounded steering handoff as measured response becomes
  adequate, but does not justify cancelling base target curvature: inherited
  evidence already shows that a safe projected course alone is insufficient
  permission to release mean redirect or posterior wave shaping.
- A non-CFD counterfactual audit rejected the first, more restrictive form of
  the candidate hypothesis before it became the final edit. Removing proximity
  but requiring both a safe predicted intercept and target-signed yaw changed
  only 13 sampled posterior commands, first at `1.518L`, by at most
  `0.092 rad/T^2`. That support is too late and too small to test a new route;
  the next hypothesis therefore used measured response sign directly as a
  duty allocator for the supplemental correction. A second audit then
  rejected that formulation too: the supplemental branch's pre-existing
  residual-opposition predicate made measured-aiding yaw nearly mutually
  exclusive, yielding only negligible changes outside `1.5L` and material
  action on the terminal beat. The final candidate instead hands off the
  high-authority redirect increment itself when carrier-demodulated yaw aids.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: preserve the propulsive oscillator while sensor-confirmed residual turn response hands a burst-like high-authority redirect continuously back to a lower-authority target bend
transferable_invariant: open high steering authority for unresolved target-course mismatch, then release only the authority increment as carrier-demodulated yaw acquires the requested sign; keep the lower-authority target controller active and restore the increment if residual response is lost
nontransferable_details: published CPG gains, clock phase, robot or species kinematics, dimensional frequencies, exact vortex phase, morphology-specific envelopes, and source-task routes
policy_translation: retain the evaluated two-joint carrier, redirect selector and direction, supplemental yaw-opposition correction, terminal net line-of-sight damper, and posterior wave law; remove the ineffective middle line-of-sight counter-curvature branch, and use a smooth target-signed carrier-yaw-residual gate to interpolate only the redirect curvature increment from the established high-authority bend toward cruise
falsification: reject if pre-terminal milestones or distance integral regress, capture is delayed or lost, high authority fails to return when residual yaw ceases to aid the requested turn, posterior limiting or loads rise materially, or the coherent top-down and oblique wake changes

## One candidate hypothesis

Start from the strongest sampled net line-of-sight controller and retain its
terminal damper, but do not retain the evaluated middle counter-curvature
branch that failed to change pre-capture progress. Keep the established raw
target-course error as redirect selector and direction. When the normalized
carrier-subtracted yaw residual has the requested sign, interpolate only the
high-authority redirect increment toward the existing cruise curvature; when
the residual ceases to aid, restore the full redirect continuously. The
anterior carrier, cruise bend, supplemental opposition correction, posterior
wave relief, approach law, terminal line-of-sight damper, allocator, and
exact-boundary projection remain untouched. The handoff has no proximity or
route-coordinate gate, so it can change feasible posterior action across the
established translation without reversing steering or coasting.

Expected evidence is the same capture class and coherent two-view wake with a
measurably earlier milestone or lower observed distance integral. This worker
does not claim the unevaluated CFD result.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `4a4073ee8f16d78cccbb31ba695553f9ff73f45ee39c4cfacf21545b0af6da40`.
  The deterministic schema guard finds all 48 direct `params.FIELD`
  references among the 48 fields returned by `target_policy_params()`.
- Counterfactual evaluation on the strongest sampled trajectory changes 116
  posterior commands above `1e-7 rad/T^2` while leaving every anterior command
  unchanged. Support begins during the established translation, includes
  changes in the `12-10L` and `4-2L` intervals, and becomes material before
  the `1.25L` milestone; the largest sampled-state change is bounded at
  `11.246 rad/T^2` versus the `31.416 rad/T^2` envelope. This establishes
  feasible nonterminal action support, not a closed-loop CFD result.
- A deterministic sweep of 9,072 paired normalized body-frame states returns
  finite commands within the acceleration envelope with zero numerical
  lateral-reflection error. The non-finite task-observation fallback is also
  finite.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed checks were therefore
  run directly and separately: the material guidance/notes check, lightweight
  Julia contract plus schema guard, and solver editable-boundary check all
  pass. The material checker required deleting one duplicate assigned-parent
  marker from the rendered workspace `README.md`; this metadata repair changes
  neither policy nor guidance behavior. No CFD was run.
