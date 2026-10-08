# Candidate diagnosis and hypothesis

The assigned parent (`solver_c526bc14a636`, duplicated by
`solver_e07c5232a21a`) captures at `0.748591L` and `26.2405T` with score
`-0.616154`.  Its combined keyframes show self-propulsion rather than passive
advection: a regular reverse-street wake is already coherent in the top-down
row by `5T`, remains attached to the two-joint traveling bend through `21T`,
and curls smoothly into the target at `26T`.  The oblique row confirms a
three-dimensional train of alternating compact structures without wake
breakdown.  There is no collision, boundary exit, or numerical instability,
and the direct-uniform diagnostics confirm still water and no prewarm.

The useful carrier is therefore not the missing capability.  The inherited
guidance identifies an upstream course/aim mismatch: at `5T` and `10T` the
body is aimed much closer to the target than its translational course.  The
sampled translation-side observer alone (`solver_8e7135ef9173`) leaves the
visual route and objective essentially unchanged (`-0.616147`, `26.2460T`).
In contrast, the upstream posterior course-slip mapping
(`solver_fb7bddf12f80`) moves the head path by `0.0693L` before the parent
first enters `4.5L`, improves score to `-0.607211`, reduces score mean distance
from `2.518917L` to `2.509866L`, and captures `0.0770T` earlier.  Both visual
rows remain coherent and actuator contacts remain zero.  That directional
benefit comes with a modest peak planar-force increase from `0.018834` to
`0.019441`, so simply strengthening its mean posterior offset is not supported.

The candidate retains the sampled translation-consistent observer and all
limit-free carrier/safety mechanisms, but replaces the added mean tail offset
with a phase-selective redistribution of the existing posterior target.  When
normalized course error exceeds body bearing during closing far/middle travel,
the half-cycle that reinforces the course slip is weakened and the opposite
half-cycle is strengthened by the same bounded fraction; an RMS normalization
avoids intentionally increasing idealized beat energy.  Joint-state phase is
used instead of time, and all low-speed, aligned, redirect-dominated, and late
capture states pass through continuously.  On the assigned parent's frozen
trace, its `0.08` fractional envelope keeps the maximum posterior-target
displacement near `0.063 rad`, matching the sampled mean-offset scale instead
of adding untested authority.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological mean-curvature steering
source_mechanism: target-feedback half-cycle amplitude asymmetry applied to a traveling posterior bend
transferable_invariant: steer by redistributing an established propulsive rhythm between observed joint-state half-cycles, keyed by persistent target-course error
nontransferable_details: published oscillator gains, dimensional frequencies, duty ratios, species envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame course error minus body-bearing alignment to gate a bounded reflection-equivariant posterior target scaling; infer half-cycle from anterior joint velocity and preserve the existing two-joint carrier and feasibility guards
falsification: reject if the pre-4.5L head path does not move by roughly the sampled 0.07L scale, capture or wake coherence is lost, any actuator contact returns, peak planar force exceeds the sampled 0.019441 envelope, or arrival and distance integral do not improve over the assigned parent
