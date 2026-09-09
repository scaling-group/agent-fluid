# Wake-policy candidate notes

## Inherited evidence diagnosis

The only sampled solver is the common naive drive-only seed
`solver_0718f4efab03`; no successful comparison example or inherited optimizer
log is present in this first-generation workspace. Its evidence is a valid
direct-uniform still-water rollout (`U_infinity=(0,0,0)`, zero cylinders), so
it is treated as the informative failure rather than inventing a missing
positive comparator.

Both visual rows show self-propulsion rather than advection. The top-down row
develops an alternating mid-plane wake and the oblique Lambda2 row develops a
three-dimensional vortex chain, so the state-feedback oscillator and posterior
lag create a useful traveling-bend carrier. The carrier does not control mean
curvature, however: after modest early target progress the fish turns upward,
the wake follows the curved route, and the fish exits the upper virtual
boundary at `8.613T`. Metrics agree: distance improves only from `12.328L` to
`12.064L`, ends at `12.351L`, and termination is `left_domain` at center
`(20.048,15.200)L`. The trajectory also shows raw acceleration beyond the
fixed `1800 deg/T^2` envelope on 52.6% of samples and exact velocity-limit
contact on 3.4%, so adding an unstructured acceleration correction would have
unreliable authority.

## Policy hypothesis

Retain the evidenced joint-state oscillator and lagged posterior target, but
center both oscillatory joint coordinates on a bounded mean bend driven only
by normalized body-frame target bearing. Positive joint bias is already
calibrated by the 3D turn sanity evidence to produce negative yaw, matching the
observation convention in which positive bearing requests negative yaw. By
forming the oscillator and tail lag relative to their moving biases, steering
changes mean curvature without replacing the propulsive traveling bend.

This is one controller mechanism: target-vector-to-mean-curvature feedback.
The candidate does not add time, a route, world coordinates, target identity,
flow-phase forcing, or scalar-only gait tuning.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish/robotic mean-curvature steering
source_mechanism: add bounded average bend to a propulsive rhythm using observed direction error
transferable_invariant: persistent target-side error should create signed mean curvature while the oscillatory posterior lag continues to carry thrust
nontransferable_details: published gains, species-specific amplitudes and frequencies, exact vortex phases, and source-task routes
policy_translation: map clamped body-frame bearing through a smooth saturation to two owned joint-bias limits, then run the anterior oscillator and posterior lag on bias-centered joint state
falsification: reject or revise the mechanism if the next rollout still exits the upper boundary without materially improving minimum distance, if the turn sign is wrong, or if the visual traveling wake collapses while saturation or load spikes increase
