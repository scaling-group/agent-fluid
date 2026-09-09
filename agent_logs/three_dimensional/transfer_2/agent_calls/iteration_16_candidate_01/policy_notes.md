# Response-gated posterior-curvature candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
- I inspected both the top-down vorticity row and oblique body/Lambda2 row for
  the strongest sample (`solver_7ac67a265211`, `19.409T`, mean distance
  `2.09210L`, score `-0.20288`), the slowest byte-identical replication
  (`solver_17ed583a64e1`, `19.635T`, `2.10246L`, `-0.21272`), and the distinct
  prefilled counterturn-gated parent (`solver_37425e4b74e2`, `19.486T`,
  `2.09523L`, `-0.20571`). All three show self-propulsion from quiescence, an
  orderly alternating top-down wake, compact three-dimensional tail
  structures, and the same late hook into capture. None shows passive
  advection, collision, wake collapse, or instability.
- The three clean posterior phase-lag samples are byte-identical yet span
  `19.409--19.635T`, `2.09210--2.10246L`, and scores
  `-0.20288-- -0.21272`. The assigned parent's additional wrong-sign-yaw
  phase-authority gate lies inside every one of those intervals and retains
  the same visual topology. It therefore has no repeat-resolved benefit and
  should not be tuned or stacked into the next mechanism.
- The parent's inherited trace diagnosis nevertheless localizes a real
  control residual: below `1L`, target-derived route demand has reversed while
  yaw remains opposed to it, with mean absolute terminal yaw about
  `0.339 rad/T`. The indirect posterior phase gate did not create a new
  response class, while earlier unsigned lag compression and raw slip
  curvature also regressed. This supports changing actuator primitive rather
  than another scalar lag, corridor, slip, or release adjustment.

## One-candidate hypothesis

Restore the evaluated clean phase-shaped scaffold by removing the unsupported
counterturn multiplier on posterior lag. Add one different actuator mechanism:
during the existing continuous approach window, form a reflection-invariant
wrong-sign-response gate from bounded body-frame turn request times normalized
measured yaw. Apply a small bounded posterior mean-curvature contribution in
the requested direction only while that disagreement persists, then release
it smoothly. Leave anterior steering, propulsive amplitude, base posterior
lag, LOS/course redirect, and command bounds unchanged.

Expected signature: retain capture and the coherent two-view wake while
shortening or visibly straightening the terminal hook, lowering sub-`1L`
course/lateral residual, and improving arrival or mean distance beyond the
`0.226T` exact-policy repeat span without increasing command-bound residence,
joint/rate-limit residence, or the established approximately `0.025/0.013`
force/moment envelope. Falsify the mechanism if capture is lost, the same
hook and residual remain, arrival/integral stays within repeat variation
without an effort/load benefit, or wake, command, joint, force, or moment
diagnostics regress. If falsified, restore the clean phase-lag scaffold and do
not tune the curvature limit without a held-out pose showing the same
wrong-sign response.

bookshelf_consulted: true
source_domain: biological C-start response control and robotic-fish target-directed mean-curvature turning
source_mechanism: a bounded corrective bend is held only while observed yaw opposes current route demand and releases when the response aligns
transferable_invariant: separate the persistent body-frame route request from measured response disagreement and use the latter to gate direct posterior turning authority
nontransferable_details: species kinematics, dimensional burst duration, published gains, exact gait or vortex phase, full-body waveforms, and task-specific coordinates or routes
policy_translation: multiply a bounded posterior curvature residual by the existing approach weight and a normalized wrong-sign product of target-derived turn request and recent yaw, under the two-joint soft action bound
falsification: reject if repeat-resolved arrival, distance integral, terminal course or lateral residual, coherent wake, joint margin, command residence, force, or moment does not improve against the clean replicated scaffold
