# Wake-policy candidate notes

## Evidence diagnosis

All four sampled solver episodes and the assigned-parent episode satisfy the
direct-uniform still-water contract (`U_infinity=(0,0,0)`, no prewarm) and end
in capture without instability. In both views, the fish starts in wake-free
water, propels itself toward the target, and leaves a persistent alternating
mid-plane vortex street with coherent oblique Lambda2 structures. The wake is
therefore self-generated rather than advective. The lateral motion remains a
productive traveling bend through the middle field; the visible performance
difference is route shape and terminal correction, not wake collapse.

The strongest sampled controller is the range-specific restoration of carrier
coupling. It captures at `15.939T`, has distance integral `1.82008L`, head path
`13.107L`, peak planar-force/yaw-moment coefficients `0.03477/0.01715`, and
reaches `4/2/1L` at `11.688/14.185/15.549T`. The all-distance carrier-release
repeats remain coherent but capture at `16.071--16.088T`; the prefilled
redirect-residual controller visibly retains the late hook and lengthens the
path to `13.363L`, with capture at `16.247T` and late mean absolute yaw rate
`0.269 rad/T` versus `0.106 rad/T` for the strongest sample.

The assigned parent tested response-gated half-cycle asymmetry on the strongest
scaffold. It still captured with a coherent two-view wake and slightly reduced
late yaw (`0.096 rad/T`), peak force/moment (`0.03456/0.01707`), and mean joint
commands (`16.65/15.38 rad/T^2`). It nevertheless regressed distance integral
to `1.82375L`, delayed the `10/8/6L` milestones, and did not reduce the common
actuator cost: anterior residence above 90/99% of the rate limit was
`17.71/12.15%`, essentially the strongest sample's `17.70/12.18%`. Thus
target-demand/yaw-response gating of the steering asymmetry is not the lever
for the persistent rate residence.

## Policy hypothesis

Restore the strongest sampled range-specific carrier-coupling policy and add
one different mechanism: a phase-aware one-step-ahead rate guard on only the
energy-injecting carrier component of each joint. Current joint rate and the
sign/magnitude of computed carrier acceleration predict whether that component
would cross the existing normalized rate barrier over a small fraction of a
beat. The anticipatory supplement then withdraws only outward carrier work;
the sampled common guard, steering residual, and response-conditioned reversal
authority remain unchanged. This should begin protection before the controller
has already entered the 98% barrier, reduce anterior 90/99%-rate residence and
load, and preserve the coherent wave and the best controller's late milestones.

Falsify this candidate if capture or either coherent wake view is lost; if
`4/2/1L` milestones, capture timing, or distance integral leave the sampled
useful class; or if anterior 90/99%-rate residence, mean command, joint margin,
force/moment, and path do not materially improve. A timing gain without an
actuator/load benefit does not validate this mechanism.

bookshelf_consulted: true
source_domain: closed-loop CPG control of robotic-fish rhythmic locomotion
source_mechanism: sensor feedback modulates the energy-injecting part of a coupled rhythm while preserving its phase-coherent carrier
transferable_invariant: use normalized proprioceptive response to withdraw imminent outward rhythmic work without suppressing reversal or target-conditioned steering
nontransferable_details: published gains, oscillator frequencies, robot morphology, duty ratios, exact phases, species kinematics, and world-frame routes
policy_translation: predict normalized joint-rate growth from joint velocity and same-sign carrier acceleration over a bounded beat fraction, then smoothly scale only the corresponding outward carrier component
falsification: reject if rate residence and load do not improve while capture timing, distance integral, joint margin, route shape, and both wake views remain in the strongest sampled class
