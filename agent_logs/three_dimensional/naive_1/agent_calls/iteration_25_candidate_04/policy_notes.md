# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned examples and the inherited failure use direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The two executable-identical prefilled redistribution policies
  capture at `18.8265--18.8815T`, with mean distance
  `2.08855--2.08896L`; the dormant rearward multiplier also captures, at
  `18.9640T` and `2.09072L`. The sampled geometry-scheduled broadside reserve
  captures sooner at `18.7055T`, though its `2.09386L` mean distance does not
  retain the redistribution benefit.
- In the strongest sampled capture sheet, the top-down row develops an
  energetic alternating street from quiescent water and bends it toward the
  target through first crossing. The oblique row retains compact alternating
  caudal Lambda2 structures. Its progress is therefore self-propelled and
  target-directed, not imposed-flow advection. Reconstructed anterior/posterior
  acceleration contact remains high at `60.85%/73.27%`, and rate contact is
  `11.07%/14.93%`, so its lower distance integral is allocation evidence, not
  demand relief.
- The inherited additive reserve-plus-redistribution sheet supplies the
  required failure contrast. It keeps an energetic top-down wake and compact
  oblique caudal structures, but after about `16T` the trajectory passes
  broadside and bends away; it reaches only `1.90495L`, then exits left at
  `31.1905T` and `9.45478L`. This is wrong route control despite coherent
  propulsion, not wake collapse or numerical instability. Its reconstructed
  acceleration contact (`64.24%/70.96%`) is still in the carrier's broad
  demand class.
- Trace reconstruction identifies a concrete interaction boundary. In the
  successful geometry-scheduled reserve, the largest additive reserve is
  `0.0385` and the combined normalized curvature request peaks at `1.0123`
  near `0.9645L`. In the failed composition, the reserve reaches `0.20` and
  the combined request reaches about `1.196` near `1.995L`; at closest
  approach it is still about `1.170`. Thus two individually capture-compatible
  allocations cannot be assumed composable when their additive route channel
  can exceed the nominal mean-curvature shares.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish mean-curvature steering
source_mechanism: a persistent body-frame direction error gates a temporary curvature redirect while the traveling rhythm remains active and observed correcting response releases authority
transferable_invariant: redirect authority should be observation-gated, bounded within the carrier's usable curvature budget, and released without reversing target-owned turn sign
nontransferable_details: published gains, species-specific C-start shapes, dimensional timing, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: retain the geometry-scheduled two-joint carrier; compute a smooth forward-qualified broadside reserve from normalized target fractions, apply the existing non-inverting response release, and project route plus reserve to the nominal normalized curvature budget before the established anterior/posterior shares
falsification: reject if capture or either coherent wake row is lost, the broadside-to-left-exit topology recurs, the projected reserve has no measurable route effect, or actuator contact and planar loads exceed the established carrier band without semantic benefit
```

## Single-candidate policy hypothesis

Produce exactly one curvature-budgeted broadside-redirect candidate. Start
from the sampled geometry-scheduled carrier rather than the fragile
half-cycle envelope redistribution. Preserve target-owned sign,
displacement-only half-cycle steering, the one-sided correcting-yaw release,
common rhythmic-amplitude relief, posterior lag, damping, and the exact final
acceleration projection. Add the sampled smooth forward-qualified broadside
reserve outside the saturated route argument, then clamp the combined route
request to a parameter-owned unit curvature budget before applying the
established `4/10 deg` anterior/posterior shares.

This is a controller-architecture boundary, not scalar-only gain tuning: the
reserve may add authority when the response-released base route leaves room,
but may not enlarge both mean-curvature shares beyond their nominal request.
The formal CFD result is unavailable to this worker. Accept the candidate only
if it retains capture and both wake views; then require either a different
useful approach topology or repeat evidence before calling it more robust.
