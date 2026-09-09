# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled solver examples satisfy the frozen rollout contract: direct
uniform initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
moving-window motion, and `capture`. I inspected both rows of the combined
keyframe sheet for the assigned parent `solver_072da2f3a45e` and compared them
with the inherited `solver_8b09b74b749e` failure. The parent visibly
self-propels along a broad target-directed curve: its top-down row retains an
alternating street from release through capture, and its oblique row retains
compact caudal Lambda2 structures. It captures at `19.0520T`, has mean scored
distance `2.09874L`, and contacts the acceleration envelope on
`60.94%/73.12%` of anterior/posterior rows and the rate envelope on
`10.91%/14.75%`.

The inherited clean half-cycle ablation also retains coherent propulsion in
both wake views, but without the correcting-yaw response release it turns past
the target, reaches only `2.9270L`, and exits left at `28.9190T` with final
distance `9.1943L`. A second inherited ablation kept response release but
phase-led the joint-state half-cycle coordinate; it reaches only `3.5687L`
before the same exit class. Those failures sharpen the sampled captures: the
displacement-only half-cycle plus response gate is composition-critical, even
though terminal velocity and range schedules remain unproven. Do not remove
the response gate or alter its phase observation in this candidate.

## Single-candidate policy hypothesis

Preserve the assigned parent's target-owned route request, correcting-yaw
response observation, displacement-only half-cycle steering, approach
envelope, posterior lag, oscillator, and exact final acceleration projection.
Change only how the existing correcting response releases differential mean
curvature: retain the current anterior release, but release a larger bounded
fraction of posterior mean bias. The posterior gate remains positive, so it
cannot reverse target-owned sign. This response-conditioned allocation should
keep prompt anterior course authority while returning the caudal joint toward
a more symmetric propulsive beat once the turn is visibly established. It is
intended to reduce the parent's larger posterior acceleration/rate contact
without the phase distortion of the failed rate barriers.

Reject the mechanism if capture is lost; arrival or mean distance leaves the
sampled `18.881--19.052T` / `2.0987--2.1024L` half-cycle-and-response band
without a compensating load improvement; posterior acceleration/rate contact
does not fall below `73.12%/14.75%`; planar force or yaw moment worsens; or the
top-down street or oblique caudal structures lose coherence. The new CFD
result is unavailable to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish mean-curvature turning
source_mechanism: release steering curvature into a stronger posterior propulsive beat after a correcting turn response appears
transferable_invariant: persistent body-frame target geometry owns turn sign, while observed correcting yaw may redistribute bounded curvature away from the caudal mean offset without reversing the route request or replacing the traveling wave
nontransferable_details: C-start timing, published gains, species kinematics, robot duty ratios, dimensional frequency and amplitude, exact vortex phase, and task-specific routes
policy_translation: use the parent's normalized target lateral fraction and bounded correcting-yaw response; keep anterior release unchanged and apply a stronger positive release gate only to posterior mean curvature before the existing joint-state half-cycle scale
falsification: reject on lost capture, route degradation beyond the sampled capture band, unchanged or worse posterior demand and loads, target-sign inversion, or disruption of either wake view
