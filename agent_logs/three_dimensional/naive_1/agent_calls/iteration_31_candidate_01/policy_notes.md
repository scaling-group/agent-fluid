# Coupled acceleration-projection candidate

## Evidence diagnosis before editing

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, and `capture` termination. Three samples are
executable-identical replications of the prefilled half-cycle redistribution
policy. They capture at `18.6505--18.8815T` with mean distance
`2.08855--2.09222L`; the broadside-reserve comparison captures at `18.7055T`
but has worse mean distance, `2.09386L`. The inherited optimizer logs also
contain captures at scores `-0.20598`, `-0.20830`, `-0.21054`, and `-0.25886`,
plus left-domain failures reaching only `2.43664L` and `11.53664L`. This agrees
with the parent lesson that another broadside, handoff, distance, or alignment
channel is not justified.

In both the best finite sheet (`solver_649d7e789a5a`) and the lowest-scoring
sampled capture (`solver_de4c121e5685`), the top-down row develops a coherent
alternating street behind a self-propelled fish and bends smoothly toward the
target; the oblique row retains compact alternating caudal Lambda2 structures
through capture. There is no visible advection source or wake collapse, and
the two sheets are nearly replication-equivalent. The diagnostics corroborate
the visuals: distance falls from `12.3277L` to `0.7463--0.7493L`, lateral local
flow remains below `0.00953 L/T`, lateral force coefficient below `0.02916`,
and yaw-moment coefficient below `0.01704`. Thus the useful object is the
traveling bend and its route allocation, not another disturbance or recovery
signal.

The unresolved defect is actuator allocation. Across the four sampled traces,
anterior acceleration is clipped on `60.84--60.996%` of rows, posterior on
`72.97--73.27%`, and exactly one of the two commands is clipped on
`54.26--54.50%`. Both joint rates still contact `260 deg/T`. Independent
component clipping therefore changes the requested two-joint acceleration
ratio on more than half the trace even while the visible wake remains useful.
A reconstructed full common projection would rescale about `91.8%` of the
prefill rows and is too large a first ablation.

## Policy hypothesis

Preserve the evidenced redistribution carrier, target geometry, response
release, mean-curvature shares, oscillator, and posterior lag. Replace only
the final independent acceleration projection with a convex blend between
that projection and a common two-joint projection. The common component scales
both raw accelerations by the same bounded factor, preserving their
instantaneous ratio; a small owned blend fraction limits departure from the
captured plant action. This is an actuator-allocation mechanism, not a route
gain change.

Expect fewer total componentwise acceleration contacts and less flattening of
the requested joint ratio while retaining capture, both coherent wake rows,
and the established `2.0886--2.0922L` mean-distance band. The peak component
can still contact the envelope. Falsify the candidate if it loses capture,
leaves that band without a clear demand/load improvement, raises joint-rate
contact or force/moment peaks, or visibly weakens the target-directed street
or compact caudal structures. A lower public-command contact rate alone is not
success.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and low-dimensional coupled-oscillator control
source_mechanism: directed anterior-to-posterior bend with posterior lag, kept coherent under bounded actuation
transferable_invariant: preserve relative two-joint wave allocation when enforcing the actuator envelope
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact wake phase, and prescribed routes
policy_translation: use only the existing normalized body-frame target feedback and joint state; blend independent clipping with one common scale on the two raw joint accelerations
falsification: reject if capture, the two-view coherent wake, or the established mean-distance band is lost, or if rate/load contact fails to improve
