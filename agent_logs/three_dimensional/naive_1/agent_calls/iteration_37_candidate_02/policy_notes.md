# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts are finite captures from the required direct-
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no instability. The assigned parent and one
  executable-identical sample capture at `22.154001T`, cross at `0.748384L`,
  have scored mean distance `2.105583L`, and score `-0.210952`. Their launch
  reaches `11.300/8.629L` at `4/8T`; mean action is `59.932`, exact anterior/
  posterior rate-cap occupancy is about `11.49/6.41%`, and peak normalized
  force/moment is `0.030897/0.015839`.
- Extending the fixed recovery-allocation preview by the same proximity lead
  used elsewhere is an operational no-op in this rollout: despite a material
  code and parameter-schema change, the third sample reproduces the parent's
  trajectory and every reported score, action, saturation, force, and moment
  statistic exactly. Its oblique row is blank, so it supplies no independent
  3D-wake confirmation. The result is evidence that the recovery allocator is
  already insensitive or saturated where that extra preview opens, not
  evidence for more predictive lead.
- Combining the successful posterior prediction with target-signed moment
  unloading of the anterior redirect also fails to improve the parent. It
  reaches capture on the same control step and crosses slightly deeper at
  `0.748374L`, but raises mean distance to `2.105967L`, lowers score to
  `-0.211334`, and trails at `16/20T` (`3.981/1.861L` versus
  `3.975/1.859L`). Mean action falls to `59.695` and anterior cap occupancy to
  `11.02%`, with unchanged peak loads, so this is a route/allocation
  regression rather than instability or excessive effort. Its top-down wake
  retains the parent's alternating topology, but its oblique sheet is blank;
  inherited notes calling this sampled composition a complete two-view case
  must not be reused.
- The assigned-parent trace has a stable self-propelled route, but after the
  target moves to its lateral side the full target error remains about
  `0.70--0.77 rad` at `12--20T` and rises to `1.118 rad` at capture. During
  the same useful interval the normalized yaw moment is repeatedly adverse to
  the requested turn (about `-0.0048`, `-0.0070`, and `-0.0048` at
  `12/16/20T`). That provides a measured sign and scale for testing response
  qualification without importing a gain.

## Visual diagnosis

The assigned parent is self-propelled rather than advected: from quiescent
release it forms a compact alternating red/blue caudal street by `4T`, carries
that street through a smooth target-directed S-route at `9/13/18T`, and keeps
the rhythmic sheet attached through capture. Its oblique row shows discrete
three-dimensional Lambda2 structures following the caudal region through the
same approach. The moment-unloaded comparison has an almost indistinguishable
top-down wake and route class, so its loss is not a missing carrier or gross
wake failure; the small distance deficit appears after the response gate can
alter anterior steering. The comparison's blank oblique row is an evaluation
artifact, not evidence of either 3D preservation or collapse.

## One candidate hypothesis

Preserve the assigned parent's through-water course feedback, bounded speed
recovery, full body-frame target geometry, anterior curvature and redirect,
predictive posterior half-cycle steering, recovery allocation, reactive
rudder, terminal relief, and every existing authority ceiling. Add one
hydrodynamic-response qualifier only to the posterior half-cycle-asymmetry
envelope. When normalized yaw moment opposes the instantaneous target-side
request, smoothly union that response with the existing predicted geometry
gate; when moment is favorable, make no change. Continue to select target side
from body-frame geometry and stroke side from anterior joint velocity.

This is a causal allocation test, not an additive moment residual or scalar-
only gain change: it can recruit an otherwise unused share of the existing
`0.30` posterior asymmetry but cannot exceed that ceiling, modify the carrier,
or unload either joint. The expectation is that adverse moment at `12--20T`
brings target-side posterior loading forward enough to lower the distance
integral while leaving the unchanged launch and complete parent wake intact.

Falsify the mechanism if capture is lost or later than `22.154001T`, scored
mean distance exceeds `2.105583L`, score falls below `-0.210952` without a
distinct semantic improvement, or the `4/8T` launch changes. Also reject it if
mean action or exact rate-cap occupancy materially exceeds `59.932` and
`11.49/6.41%`, peak normalized force/moment exceeds `0.030897/0.015839`, or a
valid two-view sheet fails to retain the established alternating 3D wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and wake-disturbance rejection
source_mechanism: retain a rhythmic carrier while separating slow target geometry from fast hydrodynamic-response modulation
transferable_invariant: use measured adverse load to schedule an existing oscillatory steering allocation rather than adding torque or suppressing the carrier
nontransferable_details: published gains, dimensional moment scales, clocked CPG phase, robot linkage and species kinematics, prescribed vortex phase, and task-specific routes
policy_translation: smoothly recruit only unused posterior target-side half-cycle asymmetry from normalized adverse target-signed yaw moment, with stroke phase inferred from joint state and the established ceiling unchanged
falsification: reject if it fails to beat the 22.154001T and 2.105583L parent boundaries or worsens launch, valid two-view wake, action, saturation, force, or moment envelopes
