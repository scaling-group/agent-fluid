# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned solver examples satisfy the frozen contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. The two
  executable-identical half-cycle envelope-redistribution samples capture at
  `18.8265--18.8815T` and reproduce the best assigned mean-distance band,
  `2.08855--2.08896L`. The prefilled broadside-reserve sample captures sooner
  at `18.7055T`, but its mean distance is worse at `2.09386L`.
- I inspected the combined sheets for the best-score redistribution capture,
  the prefilled broadside-reserve capture, and the inherited direct-composition
  failure, then cross-checked them against metrics, diagnostics, trajectories,
  executable policies, assigned-parent guidance, and inherited optimizer
  notes. Both captures are genuinely self-propelled: their top-down rows form
  coherent alternating streets that bend toward the target from quiescent
  water, and their oblique rows retain compact caudal Lambda2 structures
  through first crossing. The reserve changes the terminal approach without
  visibly destroying the traveling bend, so wake coherence does not explain
  its weaker distance integral.
- The informative failure directly superposes full envelope redistribution
  and the broadside curvature reserve. Its energetic top-down street and
  compact oblique caudal structures survive, but after about `16T` the body and
  wake bend below and away from the target. It reaches only `1.90495L`, then
  exits left at `31.1905T` and `9.45478L`. This is a route-allocation failure,
  not imposed-flow advection, wake collapse, or numerical instability.
- The inherited axis-to-onset arbitration prevents that superposition and has
  now completed with capture at `18.7385T` and `0.74940L`, proving that
  normalized target geometry can hand control between the two modifiers
  without losing the two-view wake class. Its mean distance is `2.09850L`,
  however, worse than both isolated redistribution captures and inside the
  broadside-reserve repeat band (`2.09386--2.09873L`). Releasing redistribution
  continuously from the target axis to the `0.55` broadside onset therefore
  preserves capture but discards the sampled integral benefit before the
  reserve is eligible to act.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological burst redirect
source_mechanism: observed direction error arbitrates a propulsive rhythm allocation and a temporary bounded redirect instead of commanding both gait modifiers at full authority
transferable_invariant: preserve the evidenced traveling wave while normalized body-frame geometry gives competing two-joint modifiers complementary authority across one continuous handoff
nontransferable_details: published gains, robot geometry, species-specific C-start kinematics, dimensional cadence, prescribed beat phase, exact vortex phase, and task-specific routes
policy_translation: retain full joint-displacement half-cycle envelope redistribution until the sampled body-lateral broadside gate actually opens, then use that same smooth gate and its complement to cross-fade redistribution into the existing forward-qualified curvature reserve; preserve target-owned sign, response release, posterior lag, common mean relief, and acceleration projection
falsification: reject if capture or either coherent wake row is lost, the broadside-to-left-exit topology recurs, mean distance remains in or above the broadside-reserve band rather than recovering the redistribution band, or actuator contact and planar loads materially exceed the isolated-carrier ranges
```

## Single-candidate policy hypothesis

Add exactly one complementary cruise-to-redirect arbitration mechanism to the
prefilled broadside-reserve carrier. Reintroduce the sampled half-cycle
envelope redistribution, but weight it by `1 - broadside_gate`, where the same
smooth normalized body-lateral gate already weights the reserve. Redistribution
therefore remains fully active throughout the ordinary sector, unlike the
completed axis-to-onset release, and can never retain full authority when the
reserve reaches full authority, unlike the failed direct composition.

This is a state-feedback allocation change rather than a carrier-gain retune.
It adds no time, world coordinate, target identity, memorized route,
instantaneous velocity residual, posterior-only allocation, terminal compound,
or pointwise rate barrier. Formal CFD occurs after this worker exits. Accept
the candidate only if it retains capture and both coherent wake rows; credit
the handoff further only if it recovers the isolated redistribution's lower
mean-distance band or produces a distinct useful recovery topology without
worsening the established demand/load class.
