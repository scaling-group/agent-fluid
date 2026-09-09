# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the frozen lane contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
prewarm, finite moving-window transport, and capture. Their executable policy
expressions and parameter values are identical; the only source differences
are comments. Across the repeats, capture occurs at `0.7482--0.7497L` in
`19.228--19.784T`, with mean scored distance `2.1185--2.1321L`. The combined
keyframe sheets show a target-directed curved trajectory, an alternating
top-down vorticity street, and compact three-dimensional caudal Lambda2
structures through capture. This supports preserving the normalized lateral
request, one-sided yaw-response release, opposite-sign mean curvature, and
the joint-state traveling carrier as one package.

The inherited step-5 results falsify pre-limit joint-rate tapering around that
package. Guards beginning at `0.80` and `0.85` of the rate envelope eliminate
rate-limit contact and keep energetic alternating top-down and oblique wake
structures, but both lose the captured route: they terminate `left_domain` at
`21.203T` and `22.132T`, reach only `5.3386L` and `5.0277L`, and finish at
`5.8866L` and `5.9506L`. Their heading ranges of about `[-0.65,0.78] rad`
and visibly downward late paths show that changing carrier phase through a
velocity barrier is not route-neutral. Later policies should not infer that
wake coherence or zero rate contact is sufficient evidence of useful demand
relief.

The repeated captures nevertheless expose a narrower contract mismatch. Raw
policy acceleration exceeds the physical `1800 deg/T^2` envelope on
`61.7--62.2%` of anterior and `71.7--72.3%` of posterior samples, with peaks
near `63` and `101 rad/T^2`. The episode immediately clamps each returned
acceleration to that same envelope before integrating joint velocity and angle.
Thus projecting only the final command onto the policy-owned acceleration
envelope is mathematically action-equivalent to the captured parent at the
plant, unlike the failed state-dependent taper.

## Policy hypothesis

Preserve every evidenced steering and carrier equation and add only a final
hard projection of each joint acceleration to a policy-owned
`1800 deg/T^2` limit. This is an actuator-contract projection rather than a
gain change: it removes physically unrealizable returned demand while leaving
the downstream applied acceleration, carrier phase, target-owned redirect,
and braking exactly as in the four sampled captures.

Expected result: returned over-envelope commands fall to zero while capture,
arrival, distance integral, joint-rate contact, and both wake views remain
within the sampled repeat band. Falsify the equivalence if the evaluator
applies a different limit, if any returned command exceeds the policy-owned
bound, or if the route, coherent wake, or capture changes materially. Do not
claim reduced rate contact from this candidate; the inherited barrier results
show that rate relief requires a separately evidenced phase-preserving
mechanism.

bookshelf_consulted: true
source_domain: robotic-fish state-feedback CPG control and actuator-limited rhythmic locomotion
source_mechanism: preserve the low-dimensional propulsive rhythm while constraining commands to the physical actuator envelope
transferable_invariant: retain target-owned mean curvature and joint-state phase, and project only the final command that the plant cannot apply
nontransferable_details: published gains, motor dynamics, species-specific kinematics, dimensional beat settings, exact vortex phases, and task routes
policy_translation: keep the captured normalized body-frame redirect and two-joint carrier unchanged, then clamp each final acceleration at a policy-owned limit identical to the episode envelope
falsification: any returned over-envelope command, loss of capture or coherent wake, or a route and applied-action history outside the successful repeat band
