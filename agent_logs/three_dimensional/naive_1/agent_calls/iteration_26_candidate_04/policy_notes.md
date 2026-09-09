# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected every combined sheet's top-down vorticity and oblique
  body/Lambda2 rows and cross-checked them against scores, diagnostics,
  trajectories, executable policies, assigned-parent guidance, and inherited
  optimizer notes. The assigned set contains no semantic-failure sheet, so I
  use inherited failure notes as textual negative evidence rather than
  pretending that one of the capture images is a failure.
- The two executable-identical prefill policies are genuinely self-propelled:
  they form coherent alternating top-down streets from quiescent water and
  compact caudal structures in the oblique row, bend toward the target, and
  capture at `18.8265--18.8815T`. Their mean-distance band is
  `2.08855--2.08896L`, but their approximately `61%/73%` acceleration contact
  and `11%/15%` rate contact do not establish demand relief. The dormant
  rearward multiplier also captures, but inherited reconstruction shows that
  its added branch never activates.
- The sampled broadside-reserve policy preserves the same two-view wake class
  and captures sooner at `18.7055T`, with mean distance `2.09386L`. Its
  normalized direction gate activates before capture, proving that separate
  target-signed curvature can coexist with the geometry-scheduled carrier,
  though not that it improves the distance integral or demand.
- Directly superposing the common-envelope redistribution and broadside
  reserve is the most informative inherited failure: the energetic wake
  survives, but the fish becomes broadside at `6.0626L`, reaches only
  `1.90495L`, and exits left at `31.1905T`. The lower rate-contact statistic is
  not relief because capture is lost. In contrast, the assigned-parent
  geometry-authoritative handoff completed with capture at `0.749397L`
  (score `-0.210898`), while a sibling curvature-budgeted broadside policy
  independently captured at `0.749975L` (score `-0.211698`). Those compact
  inherited scores establish semantic non-interference separately, but do not
  establish their combined wake, route, demand, or integral behavior.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological burst redirect
source_mechanism: observed direction error hands control priority from cruise-rhythm allocation to a bounded redirect while measured response releases steering
transferable_invariant: competing uses of the same two joints should be arbitrated by normalized body-frame geometry, and redirect curvature should remain inside a fixed carrier budget while the traveling wave stays active
nontransferable_details: published gains, species-specific C-start shapes, robot geometry, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: smoothly release displacement-phase envelope redistribution to zero by the normalized body-lateral broadside onset, activate the forward-qualified target-signed curvature reserve only beyond that onset, and project route plus reserve to the nominal unit curvature budget before applying the established anterior/posterior shares
falsification: reject if capture or either coherent wake row is lost, the broadside-to-left-exit topology recurs, the prefill distance-integral benefit disappears without a robustness or route benefit, or actuator contact and planar loads exceed the isolated-carrier bands
```

## Single-candidate policy hypothesis

Starting from the prefilled half-cycle redistribution carrier, add one
geometry-authoritative allocation mechanism. A smooth cruise gate derived
from absolute normalized body-lateral target direction keeps redistribution
fully available on axis and releases it to zero at the existing broadside
onset. A separate smooth, forward-qualified reserve starts at that boundary,
so the two gait modifiers are never active together. Project the combined
base-route and reserve request to a parameter-owned unit curvature budget
before applying the established `4/10 deg` anterior/posterior shares.

This is a state-feedback architecture test, not scalar-only carrier tuning.
It preserves target-owned sign, displacement-only phase, correcting-yaw
release, posterior lag, common mean amplitude relief, damping, and exact final
acceleration projection. It adds no time, route, coordinate, target identity,
instantaneous velocity residual, posterior-only allocation, or rate barrier.
Formal CFD occurs only after this worker exits. Accept the candidate only if
capture and both wake views survive; credit it further only if it retains the
redistribution distance-integral class or produces a distinct robustness or
route benefit.
