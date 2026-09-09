# Phase-selective terminal counter-yaw candidate

## Evidence and visual diagnosis before editing

All sampled and assigned-parent evaluations report direct uniform still water
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected both rows
of the combined keyframe sheets for the sampled `0.74772L` capture, the
`2.70327L` and `3.31217L` late-turn failures, and the assigned parent's latest
`0.81002L` near miss. The top-down rows show self-propelled leftward motion
behind alternating vorticity; the oblique rows show compact body-connected 3D
Lambda2 structures during the useful approach. The failures are trajectory
control failures, not advection, missing propulsion, wake collapse, or
numerical instability. The weaker sampled policies turn only after crossing
high of the target and then curl toward a boundary. The capture instead keeps
a shallow targetward course into the capture sphere.

The predicted-miss controller is the only sampled capture mechanism, but its
identical-policy repeat missed at `0.96311L` and exited lower-left. The assigned
parent retained that interception geometry and made the terminal half-cycle
handoff conditional on carrier-separated yaw response. It improved the closest
pass to `0.81002L`, reduced near-rate-limit occupancy to `8.59%/8.98%` from the
capture's `14.70%/14.70%`, preserved zero joint-angle dwell above `40 deg`, and
kept peak normalized planar force/moment at `0.0348/0.0174`, comparable to the
capture's `0.0347/0.0172`. This is positive evidence for response gating, but
not semantic success: at the closest pass the head is `(9.597,8.952)L`, speed
is `1.117L/T`, and carrier-separated yaw remains wrong-sign while the posterior
acceleration is already near its smooth limit. The fish crosses below the
capture circle and later exits the lower boundary.

## Single candidate hypothesis

Preserve the evidenced traveling-bend carrier, body-frame course/predicted-miss
interception, bounded terminal mean curvature, and the parent's response-gated
half-cycle handoff. Add one distinct response-gated actuator: when the active
terminal request and carrier-separated yaw have the wrong-sign product, apply
a bounded anterior counter-yaw pulse only during the carrier half-cycle whose
anterior acceleration already points in the corrective direction. Leave the
posterior carrier and its restoring half-cycle unchanged. The inherited quiet
terminal response shows that the counter-curvature sign opposes wrong-sign
yaw, while phase gating avoids another persistent mean-bend sign experiment.

Support requires capture, or at minimum a pass below `0.81002L` with target-side
recovery and a better termination class, while retaining the compact wake,
zero `>40 deg` dwell, near-rate-limit reserve, and roughly `0.035/0.018` load
scale. Falsify on loss of the predictive route, unchanged lower-side pass and
termination, oscillatory response switching, anterior limit pinning, load
growth, or loss of wake coherence.

bookshelf_consulted: true
source_domain: biological C-start burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit a bounded curvature pulse for large wrong-sign directional response, then release it into the preserved posterior propulsive rhythm as soon as observed yaw becomes corrective
transferable_invariant: keep rhythmic propulsion intact while normalized target geometry, joint-state phase, and measured response jointly gate a brief corrective actuator channel
nontransferable_details: species-specific C-start posture and timing, published robot or CPG gains, linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: retain body-frame predicted-miss mean curvature and carrier-separated yaw; on wrong-sign terminal yaw, reinforce only the corrective anterior carrier half-cycle while leaving posterior traveling-wave acceleration unchanged
falsification: reject if capture margin or termination fails to improve together, or if wake coherence, joint reserve, and low normalized loads are not preserved

## Dry validation only

The prescribed guidance-materiality, Julia policy-contract, parameter-schema,
and editable-boundary checks pass. A `19,683`-state grid spanning fore/aft and
lateral target geometry, body velocity, both joint angles/rates, and yaw
response produced finite commands strictly inside the smooth `30 rad/T^2`
envelope with exact left/right reflection (maximum error `0.0`). On the
assigned parent's reconstructed closest-pass state, the new channel changes
only anterior acceleration from `-14.092` to `-18.526 rad/T^2`; posterior
acceleration remains `29.986 rad/T^2`. The difference becomes exactly zero
when carrier-separated yaw is corrective and is below `1.3e-13 rad/T^2` in a
far-field state. These are algebraic checks, not CFD evidence. The downstream
evaluation must decide the trajectory, capture, wake, joint, and load
falsifiers above.
