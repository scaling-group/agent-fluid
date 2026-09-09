# Posterior yaw-brake candidate

## Evidence and visual diagnosis before editing

All four sampled evaluations and the inherited step-9/10 evaluations use the
required direct-uniform still-water initialization (`U_infinity=(0,0,0)`), no
cylinders, and no prewarm. In every combined sheet, the top-down row shows a
body-connected alternating vorticity street and the oblique row shows compact
three-dimensional Lambda2 structures shed from the caudal region. Translation
is self-propelled rather than advected, and the useful wake remains coherent
until the terminal controls bend or suppress it.

The closest sampled policy (`2.595L`) passes above the target with both joints
pinned at `-45 deg`; the continuous hold (`2.703L`), mean-bend release
(`2.664L`), and phase-separated prefill (`4.650L`) preserve propulsion but
repeat the left-exit topology. The assigned-parent guidance identifies a much
stronger course-residual carrier: it reached `1.173L` without joint-angle dwell
or large loads. Its inherited target-bearing mean-curvature handoff improved
that to `1.033L`, still at about `1.07L/T`, before a lower-left escape.

Two completed step-10 results sharpen the terminal boundary. The assigned
parent's common-mode mean-curvature PD acceleration plus positive-closing-speed
carrier relief regressed to `2.167L`, added `1.611/4.943T` of head/tail dwell
above `40 deg`, raised peak normalized planar force/moment to `0.526/0.226`,
and exited left. A parallel damped two-joint interception hold retained the
low-load trajectory and improved the miss slightly to `1.008L`, with zero
`40 deg` dwell and peaks `0.036/0.018`, but it did not slow translation enough.
At its closest point the head is `(9.756,8.834)L`, speed is `1.01L/T`, both
joint rates are nearly zero (`-0.096/0.149 rad/T`), and heading rate has the
wrong sign (`+0.231 rad/T`) for the target lying up-left; it then exits left at
`9.228L`. The two-joint hold therefore trades away beat-scale steering before
it removes enough inertial miss velocity.

## Single candidate hypothesis

Use the evidenced course-residual traveling bend and target-bearing terminal
mean as the base. Replace the full two-joint interception hold with one new
actuator-allocation mechanism: a posterior-only yaw brake. Recruit it smoothly
only when normalized target proximity, positive radial closing speed,
target/course misalignment, and wrong-sign measured yaw agree. During that
state, blend the posterior acceleration toward a damped target-signed posture
while leaving the anterior course-responsive rhythm intact. Correct-sign yaw,
aligned closure, receding motion, and the far field retain the unmodified
traveling carrier.

This tests whether selectively shedding tail-generated thrust during the
counterproductive yaw half-cycle can preserve directional authority long
enough to cross the `0.75L` capture circle. Support requires capture, or at
minimum a pass below `1.008L` with a target-side recovery or better termination
while retaining the inherited zero angle dwell and low loads. Falsify it if the
approach worsens, the fish again coasts with wrong-sign yaw, the left exit
repeats without a closer pass, joint/load occupancy grows, or the coherent
far-field wake collapses.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-thrust allocation combined with sensor-modulated robotic-fish CPG turning
source_mechanism: preserve the anterior steering rhythm while selectively damping posterior thrust during a measured counterproductive terminal yaw response
transferable_invariant: posterior motion is the stronger thrust lever, so near-target braking should be allocated separately from the rhythmic joint motion that maintains steering authority
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, linkage geometry, clocked CPG phase, exact vortex phase, and prescribed routes
policy_translation: use normalized body-frame target and velocity, distance, closing speed, heading rate, and two-joint state to gate a smooth posterior-only damped hold on the course-residual carrier
falsification: reject if capture or a sub-1.008L pass is not obtained with improved recovery/termination, or if wrong-sign yaw, joint dwell, loads, or wake quality worsen

## Dry validation after editing

The mandatory guidance-materiality, lightweight Julia contract, parameter
schema, and solver-boundary checks pass. A simulation-free grid of `59,049`
finite body-frame states remained strictly inside the smooth `30 rad/T^2`
command envelope and had exact left/right reflection (maximum error `0.0`). In
a near, closing, off-course probe, changing only yaw from correct-sign to
wrong-sign left the anterior command exactly unchanged and changed the
posterior command by `8.446 rad/T^2`, confirming the intended differentiated
allocation. These are algebraic checks, not CFD evidence; the post-worker
rollout must decide the physical falsifiers above.
