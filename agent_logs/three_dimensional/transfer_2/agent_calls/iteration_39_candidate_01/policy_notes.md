# Candidate diagnosis and hypothesis

The combined keyframes for `solver_6dada5e7a98a` (highest sampled score,
`0.08781`) and `solver_7d26cc24fc23` (lowest sampled score, `0.07575`) both
show self-propelled target capture from direct uniform still water. In the
top-down rows, each fish turns toward the target while shedding a compact,
alternating wake; neither trajectory is consistent with passive advection
because `U_infinity=(0,0,0)`. The oblique rows show coherent three-dimensional
Lambda2 structures through the approach and no visible breakup or disturbance
event before capture. The lower-scoring sample is therefore an informative
allocation tradeoff rather than a semantic failure.

The diagnostics sharpen that tradeoff. The shared full-demand preview sample
captured at `15.604T`, with `1.79354L` distance integral, `13.137L` head path,
and peak planar-force/yaw-moment coefficients `0.04226/0.02076`. Previewing
only same-sign carrier demand captured at `15.730T`, with a worse `1.80572L`
integral, but shortened the path to `12.848L`, lowered the peaks to
`0.03558/0.01724`, and reduced posterior greater-than-90%-rate residence from
`6.66%` to `5.77%`. The two executable-equivalent joint-local full-demand
samples captured at `15.560T` and `15.708T`, so differences within about
`0.15T` are not reliable timing evidence on this release. All four metrics and
observations confirm direct uniform initialization. The assigned-parent log
also records a capture (`solver_f9b08c4ffbbd`, score `0.07873`), supporting
preservation of the inherited target/approach/redirect scaffold rather than a
new route or scalar steering retune.

The candidate keeps that scaffold and the joint-local full-demand rate guard.
It adds one allocation mechanism: when the measured body-frame velocity course
is already aligned with the target and the posterior joint's own projected
rate remains below contact, release only the shared redirect guard's
suppression of positive posterior carrier work. Local posterior positive-work
protection, negative-work reversal, anterior protection, and target steering
remain unchanged. This should retain the shorter/lower-load joint-local class
while avoiding unnecessary tail-thrust withdrawal caused solely by an
anterior rate bottleneck.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion combined with response-gated robotic-fish/C-start turning
source_mechanism: posterior reactive work supplies thrust while a large redirect is released as measured directional response becomes adequate
transferable_invariant: allocate posterior propulsive work only when direction is resolved and the posterior actuator itself has margin
nontransferable_details: published gains, species envelopes, dimensional frequencies, exact vortex phases, and prescribed maneuver stages or routes
policy_translation: use normalized body-frame velocity-course error, course authority, and the posterior projected-rate gate to release only positive tail-carrier work
falsification: reject unless capture and coherent two-view wake persist and timing or distance integral improves beyond the approximately 0.15T repeat spread without worse path, force/moment peaks, posterior rate residence, or joint margin
