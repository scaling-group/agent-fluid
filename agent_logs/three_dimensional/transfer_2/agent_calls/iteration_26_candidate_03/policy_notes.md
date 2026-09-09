# Wake-policy candidate diagnosis

## Assigned evidence

All four sampled evaluations are valid direct-uniform still-water runs
(`U_infinity=(0,0,0)`) and capture; there is no prewarm artifact. The two
byte-identical response-aware parents capture at `19.162--19.338T`, with
distance integral `2.06924--2.07622L`, head path `12.304--12.309L`, and peak
planar force/yaw moment `0.02535--0.02537/0.01335--0.01356`. They are the
informative weak baseline rather than a semantic failure.

Both sampled carrier-only rate guards retain capture and advance every
distance milestone. The joint-specific carrier guard captures at `18.111T`,
with integral/path `2.00209L/12.281L`, while reducing greater-than-99%-rate
residence to `8.17%/0.43%` anterior/posterior. The shared phase-preserving
carrier governor also captures at `18.111T` and improves integral/path further
to `1.99710L/12.198L`, but its corresponding rate residence is
`10.45%/3.55%`; peak load also rises modestly to `0.02729/0.01435` from the
parent load class. Thus carrier governance is a useful new trajectory
mechanism, but the best path variant still weakens one joint's reversal when
the other joint's positive work dominates its signed group-power gate.

## Visual diagnosis

The combined top-down mid-plane and oblique Lambda2 sheets show self-propelled,
coherent traveling wakes in both the strongest shared-governor example and the
weak response-aware parent. Alternating vortices and three-dimensional loops
remain organized from release through approach; none of the improvement is
passive advection. The shared governor has already reached the capture circle
at `18.111T`, whereas the parent is still following a visibly broader late hook
at `16T` and captures at `19.338T`. The guarded sheets do not show a wake
collapse, collision, or instability, but their stronger late acceleration is
consistent with the measured load increase and leaves actuator allocation as
the useful boundary.

## Candidate policy hypothesis

Start from the best shared phase-preserving governor and retain the complete
response-aware targeting, distance/closing relief, half-cycle steering, and
posterior handoff scaffold. Replace signed net carrier-power gating with a
common gate derived from the sum of the two nonnegative outward carrier powers.
Apply that one gate only to the outward-work fraction of each carrier command;
leave target-conditioned steering and carrier components that oppose current
joint motion untouched. This is a coupled work-selective throttle, not a scalar
gait or steering retune. It should retain the short coherent route of shared
traveling-wave modulation while restoring reversal authority and moving
anterior rate residence/outward impulse toward the joint-specific guard.

Falsify this translation if evaluation loses capture or the coherent two-view
wake; misses any of the shared governor's `10/8/6/4/2/1L` milestones
(`6.677/9.191/11.539/13.871/16.467/17.776T`) materially; widens the
`12.198L` head route or worsens the `1.99710L` integral beyond repeat
variation; fails to reduce anterior greater-than-99%-rate residence/positive
impulse from `10.45%/10854`; or further increases the `0.02729/0.01435` load
class, command residence, or joint-angle use.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and elongated-body reactive propulsion
source_mechanism: modulate a low-dimensional traveling-wave carrier while preserving posterior wave propagation and separate sensor-feedback steering
transferable_invariant: govern rhythmic energy as a coupled carrier and preserve phase/reversal structure instead of clipping complete joint commands independently
nontransferable_details: published oscillator gains, dimensional beat frequency, species kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized joint-rate proximity and carrier-action times joint-velocity to apply one bounded gate only to outward carrier work; preserve body-frame target residuals and the two-joint state-feedback contract
falsification: reject if capture, milestones, short path, distance integral, coherent wake, joint margin, outward-rate headroom, or inherited load class regresses
