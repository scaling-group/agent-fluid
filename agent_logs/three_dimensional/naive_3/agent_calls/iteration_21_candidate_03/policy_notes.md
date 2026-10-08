# Candidate diagnosis and hypothesis

The four sampled rollouts are direct-uniform still-water evaluations
(`U_infinity=[0,0,0]`, no prewarm), and all capture at about `18.27T`. In the
best-scalar fixed-width-brake sample (`solver_3991cf23285f`), the top-down row
shows a self-propelled target-directed arc with an alternating reverse wake;
the oblique Lambda2 row shows compact three-dimensional structures persisting
through the final turn. The lowest-score continuous-barrier sample
(`solver_6db9f4cf6a7a`) has the same visible route and wake topology. This is
not passive advection: sampled peak body speed is `1.329U`, versus only
`0.03154U` peak local flow.

The discriminating evidence is mechanical rather than visual. The assigned
parent's fixed `8 deg` guard reaches exactly `-45 deg` at joint 2 and produces
whole-trace peak force norm `0.17183` and yaw moment `0.07699`. Both
distance-gated continuous stopping-risk samples stay near `-42.997 deg` and
reduce those peaks to `0.03716` and `0.01907` while preserving capture. The
sampled global projection with a `0.60` risk onset also captures, stays near
`-42.998 deg`, and slightly improves score and mean distance relative to the
otherwise identical gated `0.50` variants (`-0.24813`/`2.13496L` versus
`-0.24827`/`2.13507L`). Its early speed, local-flow, joint, and load extrema
match the gated samples, consistent with the inherited observation that broad
route risk stays below `0.60` and the projection is dormant there.

Policy hypothesis: preserve the complete zero-centered oscillator,
velocity-course steering, posterior carrier, and acceleration-reserve
allocation. Replace only the fixed spatial brake with the sampled global,
continuous posterior viability projection. Normalize kinetic stopping
distance by buffered remaining joint-angle margin, activate smoothly above a
dimensionless risk threshold, and project only acceleration in the current
motion direction. This removes target distance from mechanical protection and
should preserve capture/wake topology while avoiding hard-stop load spikes.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control
source_mechanism: sensor feedback modulates a low-dimensional rhythmic controller without replacing its propulsive carrier
transferable_invariant: preserve the evidenced traveling rhythm and apply only a bounded state-feedback correction when normalized joint motion becomes mechanically unsafe
nontransferable_details: published CPG gains, clock phase, species-specific kinematics, duty ratios, morphology, and prescribed routes
policy_translation: retain the joint-state oscillator and posterior lag, then continuously project only outward posterior acceleration using joint velocity squared over acceleration capacity and remaining angle margin
falsification: reject if capture or alternating shedding is lost, either joint boundary is touched, broad-route commands change materially, peak force exceeds 0.0372, peak yaw moment exceeds 0.0191, or applied limit occupancy fails to improve over the fixed-width brake
