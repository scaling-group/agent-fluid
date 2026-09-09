# Candidate diagnosis and hypothesis

## Evidence diagnosis

All four sampled rollouts are valid direct-uniform still-water runs
(`U_infinity=(0,0,0)`, no prewarm and no cylinders), and all capture. The
combined sheets show self-propulsion rather than advection: from release through
about `16T`, the fish advances while shedding a coherent alternating mid-plane
vorticity street, and the oblique row shows compact three-dimensional Lambda2
structures behind the caudal region. The body wave remains organized rather
than collapsing into lateral thrashing. Between the `16T` and terminal frames,
all sampled trajectories form a pronounced target-directed hook and coast
across the capture circle; no collision, exit, or instability precedes
termination.

The strongest sampled response-aware handoff captured at `19.338T`, with
distance integral `2.07622L`, head path `12.304L`, mean lateral speed/course
error of `0.196U/0.289 rad` from `2--4L`, and `0.099U/0.404 rad/T` mean lateral
speed/yaw below `2L`. The distance-only handoff captured at `19.354T`, with
`2.07892L`, `12.416L`, `0.230U/0.347 rad`, and `0.116U/0.431 rad/T`,
respectively. Their peak planar force/yaw-moment coefficients remain in the
same class (`0.02535/0.01335` versus `0.02523/0.01333`). However, a byte-identical
distance-only repeat ranged to `19.613T`, `2.09432L`, and `12.554L`, so the small
timing and integral advantage is not yet separable from rollout variability.
The response-aware policy's middle/near trajectory changes are directionally
useful, but require an exact repeat before composition.

## Policy hypothesis

Replace the assigned response-gated posterior mean bend with the sampled
response-aware posterior wave handoff, exactly. Preserve the corrected 3D bend
sign, fore/aft-aware target vector, distance/closing drive relief, terminal
velocity-course redirect, and joint-phase half-cycle steering. While far, use
bounded joint-phase-conditioned posterior carrier allocation; on approach,
blend back to the captured posterior-lag allocation. During the existing
distance transition only, advance that blend when the normalized yaw response
has the same sign as the body-frame turn request. This is a one-mechanism test:
it releases extra turn-biased wave allocation once turning is established and
does not add terminal mean curvature, slip feedback, a clock, or a route.

The candidate should retain coherent capture and the early `10/8/6L`
milestones while repeating the sampled reductions in middle/near lateral motion
and path length without raising command residence, joint/rate use, or the
`~0.0254/~0.0134` force/moment class. Treat timing or integral changes inside
the byte-identical distance-handoff envelope as inconclusive. Falsify the
mechanism if an exact run loses capture, loses the early milestone advantage,
restores the longer high-slip hook, damages wake coherence, or worsens actuator
and load diagnostics.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and biological burst-redirect turning
source_mechanism: release asymmetric turn-producing wave modulation continuously once the requested yaw response appears
transferable_invariant: preserve the baseline posterior traveling bend, but use observed turn-demand/yaw agreement to release extra turn-biased allocation after the response is established
nontransferable_details: published gains, clock phase, species-specific kinematics, exact vortex phase, prescribed routes, and source-task timing
policy_translation: multiply body-frame turn request by normalized recent yaw rate and use its positive part to advance a bounded approach blend from joint-phase carrier allocation to posterior-lag allocation
falsification: reject if exact replication loses capture or early progress, fails to reduce middle/near slip and path outside repeat variation, or worsens command, joint, load, or coherent-wake diagnostics
