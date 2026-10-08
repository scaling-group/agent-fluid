# Candidate wake-policy notes

## Inherited evidence diagnosis

The assigned parent guidance is the fresh-lineage baseline and there are no
inherited `logs/optimize` notes in this workspace.  The only sampled solver is
therefore both the best finite example and the informative failure; no positive
or successful comparator is available.

The sampled naive drive-only seed terminates `left_domain` after `8.547 T`, at
center `(20.075, 15.200)L`.  It improves from `12.328L` only to a minimum of
`12.078L` at about `6.36 T`, then ends at `12.380L`.  The top-down vorticity row
shows a self-propelled fish with an alternating wake, followed by a large
clockwise hook toward the upper boundary.  The oblique Lambda2 row
confirms that the wake is a coherent three-dimensional structure attached to
the tail rather than passive advection; initialization is direct uniform still
water and the local flow starts at zero.  By termination the heading has
departed far from the initial target-aligned direction and vertical speed is
about `0.57 U`; the initial normalized body-frame bearing is only about
`+0.155 rad`, so the sustained hook is over-turn rather than a required route.
Joint motion remains oscillatory, but raw acceleration commands
exceed the `1800 deg/T^2` envelope on 502 of 1554 head samples and 521 tail
samples.  Thus the useful evidence is the traveling-bend propulsion scaffold,
not the scalar drive aggressiveness.  The missing semantic capability is
closed-loop target steering.

## Policy hypothesis

Preserve the seed's autonomous anterior oscillator and lagged posterior target,
but center both on a bounded mean-curvature request computed from the observed
body-frame target bearing.  Applying the request as a joint-angle equilibrium,
rather than a large additive acceleration, should create persistent turn
asymmetry without erasing the alternating carrier.  The request is odd under
reflection and uses no world coordinate, time, route, or target identity.  No
wake-force residual or terminal schedule is added because this rollout provides
neither a cylinder disturbance nor a near-capture regime with which to calibrate
those mechanisms.

Expected first-order result: the initial small positive body-frame bearing
creates positive mean joint curvature, producing a clockwise correction toward
the target instead of the seed's upper-boundary hook.  As bearing approaches
zero the mean bend vanishes continuously and the original carrier remains.

bookshelf_consulted: true
source_domain: biological and robotic-fish direction tracking
source_mechanism: bounded mean-curvature or tail-beat bias superposed on a propulsive rhythm
transferable_invariant: persistent target error should create bounded signed gait asymmetry while the traveling bend continues to supply thrust
nontransferable_details: published gains, species-specific joint envelopes, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing through an odd saturation to head and tail equilibrium offsets in the two-joint state-feedback oscillator
falsification: reject the undamped mapping if its sign reverses after crossing the target line yet the same upper-boundary hook persists; reduce or replace excessive authority if the alternating wake collapses, joint-limit residence grows, or distance progress remains negligible
