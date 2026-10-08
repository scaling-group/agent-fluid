# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled rollouts satisfy the experiment contract: direct uniform
initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm, and capture.
Their combined keyframe sheets show essentially the same useful topology. From
release through termination the fish advances under its own body wave, turns
onto the target line, and leaves a regular alternating top-down vortex train;
the oblique Lambda2 row shows the corresponding compact three-dimensional
tail structures without wake breakup or passive advection. The parent and the
slowest sibling are visually near-identical at the sampled frames, so the
policy choice must be resolved by the trace rather than vortex prominence.

The assigned parent `solver_2546ece173ab` (anterior half-cycle
counter-curvature) has the best sampled score and scoring mean distance
(`-0.53509095`, `2.433543L`) and captures at `23.8425T`. Inside `3L`, however,
its mean/peak absolute yaw remains `1.680/3.185 rad/T`, body-lateral speed is
`0.252U`, mean absolute yaw moment is `0.006382`, and lateral force is
`0.011756`. The posterior-relief sibling `solver_3b8f345c391b` is the most
informative relative failure: it preserves capture and the coherent wake and
reduces the same quantities to `1.606/3.063 rad/T`, `0.241U`, `0.006137`, and
`0.011351`, but delays capture to `23.8755T` and worsens mean distance to
`2.433993L`. The load-gated counter-tangent arrives at `23.8315T`, yet has
higher target-transverse speed (`0.245U`), peak yaw (`3.264 rad/T`), and peak
moment (`0.014385`) than the parent. The direction-consensus brake is slower
and has worse mean distance. All four reach the joint-speed caps at comparable
fractions and remain below the projected `31.416 rad/T^2` command limit, so
there is no evidence for cadence or scalar command-limit tuning.

## Policy hypothesis

Retain the parent's target-aware C-bend carrier, continuous target-course
brake, response release, smooth command projection, and anterior half-cycle
counter-curvature. Add one bounded posterior stroke-redistribution mechanism:
using the already normalized, carrier-rejected excess-yaw request and observed
posterior tangent side, reduce the oscillatory tail target on the
yaw-supporting half-cycle and transfer the same fractional authority to the
opposing half-cycle. Unlike unconditioned relief, this preserves cycle-scale
posterior drive; unlike the sampled counter-tangents, it does not add static
tail curvature; unlike the unsuccessful inherited load gate, it does not
arbitrate on instantaneous moment. There is no clock, stored phase, route, or
world-frame cue.

Expected result: retain capture, parent-scale arrival and distance integral,
and the coherent alternating wake while moving terminal yaw/lateral-load
metrics toward the relief sibling. Reject the mechanism if arrival or mean
distance degrades to the relief sibling's level without its yaw cleanup, if
peak moment exceeds the sampled parent, if joint-speed/projected-command
exposure increases materially, or if the wake/trajectory topology changes.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological half-cycle steering
source_mechanism: sensor-modulated asymmetric flapping that changes the useful stroke half without replacing the propulsive rhythm
transferable_invariant: bounded state-selected redistribution between stroke halves can alter turning impulse while preserving cycle-scale propulsion
nontransferable_details: published gains, duty ratios, clocked oscillator phase, species kinematics, exact vortex phase, and task routes
policy_translation: use normalized carrier-rejected yaw demand and observed two-joint tail tangent to attenuate the yaw-supporting posterior wave target and strengthen the opposing target by the same bounded fraction near capture
falsification: reject if capture, distance integral, wake coherence, load history, or actuator-limit exposure fails the parent/relief comparison above
