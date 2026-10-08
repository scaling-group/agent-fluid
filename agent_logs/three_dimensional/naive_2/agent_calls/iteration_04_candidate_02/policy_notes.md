# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their top-down rows show
self-propelled motion and an alternating mid-plane wake; their oblique rows
show coherent tail-connected three-dimensional Lambda2 structures. Wake
collapse and passive advection therefore do not explain the shared failure.
Every trajectory instead hooks toward the upper virtual boundary.

The assigned-parent posterior mean-curvature controller reaches
`11.512/11.518L` minimum/final distance and exits at `9.823T`. The inherited
response-gated redirect reaches `11.330L` but then recedes to `11.546L` before
its `9.872T` upper exit, so stronger posterior curvature plus wave relief is
not a positive result. A speed-gated course residual remains monotonic to
`11.303L` and delays exit only to `9.906T`. The strongest sampled controller
instead adds relative crossflow to the same posterior mean-tangent actuator:
it advances the center from `x=21.000L` to `18.144L`, reaches its final
`10.513L` minimum, and survives to `10.785T`. Its larger coherent wake and
continued distance reduction support retaining the uncentered anterior
carrier, posterior lag, relative-crossflow residual, and soft acceleration
envelope.

The crossflow result is still a better version of the same upper hook. At
termination its center is at `y=15.201L`, body-frame target bearing is about
`-0.85 rad`, relative crossflow is about `-0.11U`, and heading rate remains
about `-1.78 rad/T`. The raw heading-rate cue is mostly carrier motion rather
than persistent route rotation: across that rollout its correlation with
anterior joint velocity is about `-0.91`; representative `(phi1_dot,
heading_rate)` pairs are `(3.63,-2.07)` at `8T` and `(-4.03,2.39)` at `9T`.
Thus the existing raw-yaw term alternates with beat phase even while negative
bearing and upward displacement accumulate.

## Policy hypothesis

Use the strongest sampled posterior-mean/crossflow policy as the baseline and
make one architectural change. Estimate the repeatable carrier-correlated yaw
from normalized anterior joint velocity, subtract it from measured body yaw,
and feed only the bounded residual to the yaw-damping term. This retains the
evidenced propulsion and slip correction but prevents nominal beat yaw from
releasing and reapplying route curvature every half-cycle. The mapping remains
odd under lateral reflection because bearing, crossflow, yaw, and joint
velocity all change sign.

Expected testable change: preserve the alternating three-dimensional wake and
the crossflow controller's leftward progress while keeping corrective
posterior curvature coherent across carrier phase, remaining inside the field
past `10.785T`, and reducing the late negative bearing before the upper
boundary. Falsify the mechanism if minimum distance does not beat `10.513L`,
the same upper exit is not delayed or topologically changed, the carrier loses
forward speed, or residual damping increases joint-limit residence or load
excursions.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and wake-disturbance rejection
source_mechanism: separate repeatable carrier-phase yaw from persistent route-response yaw before applying damping
transferable_invariant: retain the thrust-producing traveling bend and close the slow steering loop on a response residual rather than on rhythmic body recoil
nontransferable_details: published gains, species kinematics, dimensional frequencies, fitted vortex phases, exact yaw amplitudes, and task-specific routes
policy_translation: use normalized anterior joint velocity to estimate the odd carrier-correlated component of normalized body yaw, then combine the bounded yaw residual with body-frame bearing and relative crossflow in the posterior mean-tangent request
falsification: reject if the crossflow controller's progress or coherent wake is lost, upper exit persists without delay or useful route change, or actuator and hydrodynamic loads grow materially
