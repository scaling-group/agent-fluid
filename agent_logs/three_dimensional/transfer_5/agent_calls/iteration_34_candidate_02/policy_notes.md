# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`) and capture. Three reproduce the same baseline outcome:
`23.3750T`, score `-0.5051577`, mean distance `2.402131L`, and final distance
`0.748882L`. The prefilled middle-distance cadence-release policy preserves the
same trajectory topology and coherent wake, but captures later at `23.4575T`
with score `-0.5055400` and mean distance `2.402686L`.

In both the baseline and the cadence-release keyframe sheets, the top-down row
shows self-propelled target approach and a coherent alternating vortex street,
not passive advection. The body turns toward the capture circle without wake
collapse. The oblique Lambda2 row confirms a persistent three-dimensional
alternating wake from release through the terminal arc. The distance-faded
cadence reserve does not visibly produce a different useful wake or route.
Trajectory cross-checks agree: versus the baseline it lowers inside-`3L` mean
and peak absolute yaw (`1.713/3.292` to `1.676/3.226 rad/T`) and peak moment
(`0.01451` to `0.01353`), but worsens arrival, mean distance, and peak target-
cross-track speed (`0.6195U` to `0.6270U`). It also does not relieve the exact
joint-rate clamp; anterior/posterior full-rollout occupancy changes from
`11.20%/4.85%` to `11.32%/4.90%`.

## Policy hypothesis

Restore the replicated progress-qualified split-observer carrier and test one
new actuator-feasibility layer. After the inherited smooth acceleration
projection, use normalized joint rate to taper only acceleration that would
increase the current absolute rate near the known `260 deg/T` envelope.
Acceleration that reverses or brakes a joint remains untouched, as do the
carrier, steering allocation, posterior lag, and cadence logic. This should
reduce exact clamp residence without imposing another route, phase, or
distance gate. Reject the mechanism if clamp residence is not reduced, or if
capture, distance progress, alternating wake coherence, terminal yaw/load, or
smooth command behavior regresses from the sampled baseline.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation
source_mechanism: sensor feedback modulates a rhythmic oscillator while preserving its low-dimensional carrier
transferable_invariant: use measured actuator state to continuously reduce infeasible outward drive while leaving the rhythm and corrective return direction intact
nontransferable_details: published CPG gains, servo dynamics, species kinematics, dimensional cadence, and prescribed routes
policy_translation: normalize each observed joint rate by its policy-owned rate limit and smoothly taper only same-sign outward acceleration near that limit, after the existing command projection
falsification: exact rate-clamp occupancy must fall without losing capture, progress, coherent wake, terminal yaw/load balance, or inward reversal authority
