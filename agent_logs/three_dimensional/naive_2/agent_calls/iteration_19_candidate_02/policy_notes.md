# Candidate diagnosis and hypothesis

The four sampled evaluations are direct-uniform still-water runs. All capture,
so semantic success and wake preservation take priority over speculative route
changes. The prefilled mean-preserving carrier captures at `16.6320T` with
score `-0.118307`; the raw-`q1` yaw reconstruction also captures but is slower
at `16.6375T` with score `-0.119674`. In both combined keyframe sheets, the
fish visibly self-propels along the same curved target approach rather than
being advected: the top-down row develops an alternating red/blue wake that
remains attached to the tail, while the oblique row shows compact, alternating
three-dimensional structures behind the caudal region through capture. There
is no prewarm wake or imposed background flow.

The informative difference is actuator feasibility. On the prefilled trace,
both joints reach the released `260 deg/T` speed clamp. Acceleration continues
outward while within the final one percent of that clamp in about `9.66%` of
all joint-1 samples and `14.42%` of joint-2 samples. Those requests cannot
increase feasible speed, yet broad wave attenuation has already been
falsified by inherited evidence. The sampled tangent-projection controller
removes only this outward component in a smooth `0.99--1.00` normalized speed
guard, preserves every inward reversal command, and retains capture. Relative
to the exact prefill, it arrives at `16.6100T`, improves score to `-0.115560`,
reduces mean requested acceleration from `22.77/25.43` to `21.74/22.69
rad/T^2`, reduces joint excursions from `0.548/0.556` to `0.541/0.549 rad`,
and lowers peak planar force/moment from about `0.03678/0.01827` to
`0.03583/0.01776`, without visibly breaking the connected alternating wake.

Policy hypothesis: adopt exactly that parameter-owned, state-feedback tangent
projection on top of the mean-preserving captured carrier. This is a distinct
constraint-handling mechanism, not a carrier gain change. The candidate should
retain the route and capture while avoiding dynamically redundant outward
commands at the hard speed boundary. Falsify it if the completed rollout loses
capture, changes the approach arc or reversal timing materially, disconnects
the wake, increases joint contact or loads, or fails to reduce redundant
outward boundary effort.

bookshelf_consulted: true
source_domain: classical reactive and undulatory fish propulsion
source_mechanism: phase-lagged traveling bend with posterior thrust emphasis
transferable_invariant: preserve the directed anterior-to-posterior carrier and its inward beat reversals while adding bounded feedback around it
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, exact vortex phases, and prescribed routes
policy_translation: leave the normalized body-frame route and phase-demodulated two-joint carrier unchanged; project only acceleration aligned with joint velocity inside the normalized hard-speed guard
falsification: reject if capture, approach topology, connected three-dimensional wake, reversal timing, joint clearance, force, or moment worsens, or if the runtime actuator does not actually clip outward speed-boundary effort
