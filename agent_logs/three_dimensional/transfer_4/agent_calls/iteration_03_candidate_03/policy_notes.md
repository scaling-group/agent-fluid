# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
and both the top-down mid-plane vorticity and oblique Lambda2 views present.
The combined and view-specific sheets show self-propulsion rather than
advection. Both the transferred seed and the successful policies retain a
coherent alternating caudal wake, so the important difference is planar course
control rather than wake collapse or loss of thrust.

The transferred seed is the informative failure. Its top-down and oblique
rows show the fish and wake turning together after the useful approach; it
reaches `4.77995L` and then continues away to the lower boundary, terminating
`left_domain` at `27.4945T` and `9.70888L`. The signed-curvature policies
instead bend the same propulsive wake into the target circle and capture near
`23.35T`. This confirms the inherited conclusion that the bounded odd mapping
from target turn request to same-sign posterior mean tangent is the mechanism
that must be preserved.

Among the captures, the prefilled signed-curvature policy reaches `0.74968L`
at `23.3530T` with mean distance `2.41468L`. Adding only a policy-side copy of
the evaluator's acceleration clamp produces the exact same trajectory and
score, demonstrating that output clipping is not a physical desaturation
mechanism. The assigned parent's course-aligned capture-cadence floor is the
best sampled score (`-0.5152775`) and slightly lowers mean/final distance to
`2.41260L/0.74697L`, but it captures `0.0055T` later rather than earlier and
raises the tail raw-clipping fraction slightly (about `0.518` to `0.521`). Its
route and wake remain useful, but the predicted shorter arrival is falsified;
another cadence scalar change is not justified by this evidence.

The remaining visible inefficiency is upstream of the capture corridor. On a
reconstruction of the best capture, the rotation-invariant cross product of
body-frame target and velocity stays negative while distance falls from about
`11.6L` to `3.0L`; mean target/velocity alignment improves only gradually from
`0.775` over `5--10T` to `0.927` over `18--20T`. The established geometric
turn request has the correct positive sign over this interval. A replayed
course-consistency signal that is speed gated, enabled only when course error
and target bearing request the same turn, and distance gated to zero at
`2.10L` adds only about `0.83--1.26 deg` of mean posterior tangent over
`5--20T`, falls to `0.18 deg` over `20--22T`, and is exactly zero over the
final sampled `22--23.36T` segment. This is deliberately much smaller than the
inherited direct course-redirect experiment, which reached `4.0215L` but
crossed to an upper-boundary exit; the other inherited large
redirect/allocation variants also lost capture and raised loads.

## Candidate hypothesis

Start from the highest-scoring captured policy, preserving its joint-state
traveling wave, signed posterior curvature, target/yaw feedback, half-cycle
steering, and course-aligned cadence floor. Add exactly one route mechanism: a
small bounded posterior mean-curvature residual proportional to the observed
target/velocity course error. A smooth agreement gate prevents it from
opposing the established target-bearing turn, a speed gate suppresses the
undefined low-speed direction, and a distance gate releases it completely in
the demonstrated `2.10L` capture corridor. The expected effect is earlier
course alignment and a shorter or lower-integral approach without modifying
the terminal capture mechanism.

Falsify this candidate if it loses capture, fails to improve arrival or
distance integral meaningfully, crosses to the opposite side as the inherited
large redirect did, increases joint-limit occupancy or force/moment loads
materially, or disturbs the coherent alternating wake. Offline replay only
establishes signal scale and gating; it is not new CFD evidence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological mean-curvature turning
source_mechanism: sensor-derived course error modulates a bounded average bend while a traveling propulsive rhythm remains active
transferable_invariant: reinforce target-consistent curvature only while observed velocity remains off the target course, then release the bias continuously as alignment or target proximity removes the error
nontransferable_details: published gains, clocked CPG phase, robot geometry, species-specific bends, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: form a normalized body-frame target/velocity cross product, speed-gate it, require sign agreement with body-frame bearing, and add a small odd posterior-tangent residual only outside the established capture corridor
falsification: reject if capture is lost, course error does not contract sooner, the trajectory overshoots to the opposite boundary, or saturation, loads, or wake coherence deteriorate
