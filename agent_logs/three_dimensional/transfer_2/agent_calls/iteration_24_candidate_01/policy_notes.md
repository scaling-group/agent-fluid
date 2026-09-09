# Geometric-response posterior-handoff candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable finite
  moving-window transport, and `capture` termination. They arrive in
  `19.1620--19.3545T` with distance integrals `2.06924--2.07983L`. This is a
  route-shaping test inside a successful self-propelled class, not a missing
  propulsion, steering-sign, or termination repair.
- Both rows of every sampled combined keyframe sheet were inspected from
  release through capture, with the strongest finite response-aware execution
  (`solver_bf9554cfba28`) compared against its informative weaker exact repeat
  (`solver_e59354c14c2c`) and the inherited proprioceptive-governor failure
  (`solver_99fa6535411b`). The top-down rows show clean starts in quiescent
  water, target-directed translation, coherent alternating posterior
  vorticity, and the common late target-side hook. The oblique rows show
  compact three-dimensional Lambda2 structures following the caudal region;
  none shows passive advection, wake breakup, collision, or instability. The
  useful differences are therefore path, progress, and actuator allocation,
  not wake class.
- The three byte-identical response-aware samples broaden its execution
  envelope: they capture at `19.162/19.338/19.338T`, with integrals
  `2.06924/2.07622/2.07983L` and paths `12.309/12.304/12.370L`. All remain
  shorter than the sampled distance-only handoff's `12.416L` path and retain
  the approximately `0.0254/0.0136` peak planar force/moment class, but the
  third repeat shows that a `12.370L` route is not by itself evidence that a
  new controller caused regression.
- The inherited proprioceptive rate governor is a concrete negative result.
  It preserved capture and the coherent two-view wake, and nearly removed
  posterior greater-than-99%-rate residence, but delayed every milestone:
  capture moved to `19.657T`, distance integral to `2.09937L`, and path to
  `12.427L`; anterior greater-than-99%-rate residence increased to `9.01%`
  and peak planar force rose to `0.02588`. Do not tune or weaken that governor:
  suppressing the shared carrier at instantaneous rate alignment traded away
  useful propulsion rather than producing commensurate actuator headroom.
- The current response handoff intends to release far-field posterior
  amplitude allocation once yaw follows persistent route demand, but its gate
  multiplies yaw by `turn_command`, which mixes geometric target angle with a
  fast yaw-rate brake. Reconstructing the controller quantities from all three
  response-aware trajectories shows that this mixed command has the opposite
  sign from the geometric route request during `16.6--23.2%` of samples in the
  active `4--6L` handoff band. Its aligned-response gate is active only
  `23.4--32.6%` of that band, versus `46.6--49.2%` when the same measured yaw
  is compared with the persistent body-frame route request. This is a semantic
  signal conflation, not evidence for another gain or terminal bend.

## One-candidate hypothesis

Preserve the complete evaluated response-aware capture scaffold, including
the uninterrupted traveling carrier, distance/closing drive relief, velocity-
course redirect, mean steering, joint-state half-cycle asymmetry, far
posterior-amplitude and near posterior-lag endpoints, and smooth limiter.
Change only the response observation used to advance the existing `6--4L`
posterior-allocation handoff: compare normalized measured yaw with the
normalized unbraked body-frame geometric route request. Keep the yaw-rate
brake in mean steering, where it provides damping, but do not let that fast
feedback reverse the persistent direction used to decide whether a gait
redirect has responded. The signed product remains reflection invariant and
adds no clock, route memory, mean bend, drive, or command authority.

Expected signature: preserve the sampled early milestones, capture, coherent
top-down and oblique wakes, zero angle-limit residence, and force/moment class,
while releasing far-field amplitude allocation more consistently through
`4--6L` and retaining or improving the response-aware path/integral envelope.
Falsify the mechanism if it loses early progress or capture, widens the route
beyond the distance-only handoff, worsens arrival/integral beyond the three-run
response-aware envelope, increases command/rate residence or loads, erodes
joint margin, or changes either coherent wake view. If falsified, restore the
exact evaluated response-aware scaffold; do not tune the failed rate governor
or add another terminal curvature scalar.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological response-gated burst redirects
source_mechanism: separate persistent target-direction demand from fast yaw feedback when releasing a transient gait allocation back into the established traveling rhythm
transferable_invariant: use agreement between normalized body-frame geometric route demand and measured yaw response to release a bounded gait modulation, while retaining fast yaw feedback only as steering damping
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, robot joint envelopes, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: inside the existing normalized-distance posterior handoff, replace mixed steering-command/yaw agreement with unbraked target-angle/yaw agreement under the unchanged two-joint acceleration contract
falsification: reject unless capture, early progress, path and integral, actuator residence, joint margin, load class, and coherent top-down and oblique wakes satisfy the evidence bounds above
