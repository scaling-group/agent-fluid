# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver evaluations satisfy the frozen contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm,
  a finite moving window, and `termination=capture`. Three executable-identical
  clean half-cycle envelope-redistribution policies capture at
  `18.6505--18.8815T` with mean distance `2.08855--2.09222L`; the sampled
  rearward-route variant captures at `18.9640T` and `2.09072L`, but inherited
  evidence establishes that its extra branch is dormant on that route.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best-score sampled redistribution capture and the assigned-parent
  executable-identical redistribution failure. Both start in visibly quiescent
  water and are genuinely self-propelled. Both retain an energetic alternating
  top-down street and compact caudal Lambda2 packets; neither shows wake
  collapse, advection masquerading as progress, or numerical instability.
- The visual distinction is route topology after about `16T`. The capture
  continues through the target at `18.8265T` and `0.74757L`. The assigned-parent
  repeat passes below the capture circle, reaches only `1.28476L` at `19.1400T`,
  and then maintains its energetic wake while turning farther down-left until a
  `left_domain` exit at `32.7195T` and `9.94538L`. Its rate contact is lower
  (`9.40%/10.69%` versus `11.07%/14.93%` in the best capture), but that is not
  useful relief because the semantic route class was lost. Peak planar
  force/moment remain comparable (`0.03203/0.01627` versus
  `0.03171/0.01632`), further isolating the problem to feedback allocation.
- This is now a repeated robustness boundary rather than an isolated miss.
  The inherited guidance already records an executable-equivalent
  redistribution near miss at `0.81206L` followed by a left exit; the assigned
  parent supplies a second failure at `1.28476L`, while the current samples
  supply three captures of the same executable. Coherent wakes and a slightly
  lower captured distance integral therefore do not justify preserving this
  phase-dependent envelope term.
- Five inherited geometry-scheduled captures occupy the tighter reliable route
  class (`18.6505--18.7550T`, mean distance `2.09340--2.09542L`). The clean
  candidate is a structural rollback to that controller: retain target-signed
  differential mean curvature, non-inverting correcting-yaw release,
  displacement-only half-cycle steering, posterior lag, and final acceleration
  projection, while removing half-cycle redistribution from the common
  amplitude relief. This is not scalar-only gain tuning.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric-flapping turning
source_mechanism: preserve one coupled posterior-lagged rhythmic carrier while sensor feedback supplies a bounded target-signed offset or beat-side asymmetry
transferable_invariant: keep propulsion in one low-dimensional traveling-wave carrier and use one compact target-owned phase asymmetry; remove a second phase-dependent envelope channel when it changes route class without changing wake coherence
nontransferable_details: published oscillator gains, dimensional cadence, robot geometry, species-specific envelopes, prescribed phase, exact vortex timing, and task-specific routes
policy_translation: retain normalized body-lateral differential curvature, correcting-response release, displacement-only half-cycle steering, posterior lag, and acceleration projection; restore common amplitude relief to a phase-independent function of absolute body-lateral target fraction
falsification: reject the rollback if it loses capture or either coherent wake row, reproduces the down-left exit topology, materially leaves the established 2.09340--2.09542L geometry-scheduled mean-distance band without another semantic benefit, or raises demand/load beyond the established capture class
```

## Single-candidate policy hypothesis

Materialize exactly one geometry-scheduled common-envelope candidate. Remove
`half_cycle_relief_redistribution` from `target_policy_params()` and replace
the displacement-phase redistribution of amplitude relief with the inherited
phase-independent `turn_amplitude_relief_fraction * abs(lateral_fraction)`
schedule. Preserve every other executable expression and active parameter.

This isolates the mechanism implicated by two executable-equivalent failures
without adding a distance stage, velocity/flow residual, rearward or broadside
reserve, posterior-specific allocation, rate barrier, hidden clock, or scalar
gain change. Formal CFD occurs only after this worker exits; no outcome for
this candidate is claimed here.
