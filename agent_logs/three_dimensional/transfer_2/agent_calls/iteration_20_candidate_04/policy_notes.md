# Response-aware posterior-allocation handoff candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable moving-
  window transport, and `capture` termination. The assigned-parent handoff is
  the strongest sampled result at `19.3545T`, distance integral `2.07892L`,
  and score `-0.18968`; the other samples arrive in `19.3600--19.5910T` with
  integrals of `2.08911--2.09637L`. This is a gait-allocation refinement, not
  a missing-success problem.
- Both rows of the combined sheets for the assigned-parent handoff
  (`solver_2dfe05597921`) and the informative weaker exact response-gate repeat
  (`solver_26d7454466f5`) were inspected from release through capture. Their
  top-down rows show self-propulsion from quiescent water and a coherent
  alternating wake; their oblique rows show compact three-dimensional
  Lambda2 structures following the fish without passive advection, collision,
  wake breakup, or instability. Both retain the established late-hook capture
  topology, so the useful difference is trajectory and effort rather than wake
  class.
- The distance-only far-amplitude/near-lag handoff resolves the assigned
  hypothesis only in part. Relative to the plain posterior-lag sample, it
  reaches `10/8/6L` at `6.897/9.675/12.293T` rather than
  `7.040/9.829/12.463T`, arrives `0.055T` earlier, lowers distance integral by
  `0.01318L`, and reduces mean anterior command from `19.03` to
  `18.26 rad/T^2`. It preserves the sampled force/moment class at
  `0.02523/0.01333` and zero angle-limit residence.
- The same handoff does not recover the plain lag controller's low-slip
  approach. Head path rises from `12.095L` to `12.416L`; in the `2--4L` band,
  mean absolute body-frame course error/lateral speed rise from
  `0.202 rad/0.146U` to `0.347 rad/0.230U`; below `2L`, mean absolute lateral
  speed and yaw rise from `0.085U/0.349 rad/T` to
  `0.116U/0.431 rad/T`. Both policies touch the `260 deg/T` joint-rate limit,
  while the handoff retains about `35.5/34.0%` action residence above 90% of
  the smooth command bound. The extra early momentum therefore needs an
  observed-response release, not more posterior authority or another terminal
  bend.
- The inherited speed-gated middle-field course-redirect log is a concrete
  architectural warning, not a tuning datum: that candidate left the domain
  at `8.750T`, reached only `11.895L`, and scored `-14.4867`. Do not extend
  redirect curvature outside the validated approach region or compose it with
  the handoff. The current edit acts only by removing phase allocation during
  the already established `6--4L` handoff.

## One-candidate hypothesis

Preserve the complete capture scaffold and both endpoints of the successful
far-amplitude/near-lag allocation. Add one bounded mechanism inside the existing
handoff: when the body-frame turn request and normalized measured yaw have the
same sign, continuously advance the blend toward posterior lag. When yaw is
opposed or absent, retain the original distance schedule. The gate is
multiplied by the existing approach weight, cannot affect the `>6L` far-field
allocation, adds no mean curvature or command gain, and is reflection
equivariant because it uses the product of two signed body-frame quantities.

Expected signature: retain the handoff's earlier `10/8/6L` progress, lower
anterior effort, capture, coherent two-view wake, and sampled load class, while
reducing the `2--4L` course error/lateral speed, terminal yaw/slip, and head
path toward the plain-lag envelope. Falsify the mechanism if the early
milestone advantage disappears, arrival/integral leave the capture scaffold's
repeat envelope, or path, command residence, joint margin, loads, capture, or
wake coherence regress. If it does not change the middle/near trajectory, do
not tune another response scalar; return to the evaluated distance-only
handoff or test portability on a held-out pose.

bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release a bounded redirect into the established traveling rhythm once measured yaw aligns with the observed turn demand
transferable_invariant: use normalized agreement between body-frame route demand and measured yaw response to release turn-biased wave allocation continuously, without a clock or route state
nontransferable_details: species-specific C-start kinematics, published gains, dimensional burst timing, robot-specific joint envelopes, clock phase, exact vortex phase, and task-specific coordinates or routes
policy_translation: during the existing normalized-distance handoff only, use positive turn-request/yaw agreement to advance posterior allocation from amplitude asymmetry toward the already sampled lag asymmetry under the unchanged two-joint acceleration contract
falsification: reject if early progress is lost or middle/near course error, lateral speed, yaw, path, command residence, joint margin, loads, capture, or either wake view fails to improve without regression
