# Candidate wake-policy diagnosis

## Evidence boundary and visual diagnosis

The shared prewarm sheets are byte-identical. They show the fish held at the
upper-right release pose while four developed cylinder streets merge across the
target region, so this wake is common initial-condition evidence rather than a
candidate effect.

No sampled rollout is a termination failure: all four policies reach the tight
`0.75L` target. The most informative adverse comparison is therefore the
lower-scoring `1750 deg/time^2` posterior-bound prefill against the three exact
`1700 deg/time^2` samples. The three `1700` policies, released sheets, and all
metrics except wall time are identical. Both released sheets show active,
self-propelled diagonal motion down and left, a vigorous periodic body/trailing
wake rather than passive advection, continued target-facing curvature, entry
into the developed multi-cylinder wake, and capture without visible collision,
domain exit, or loss of control. The `1700` sheet preserves the same route but
finishes it sooner.

The diagnostics confirm a navigation/effort improvement with a load tradeoff.
Relative to `1750`, exact `1700` improves score from `0.133441` to `0.159531`,
arrival from `35.750` to `34.331`, mean distance from `1.7406L` to `1.7137L`,
command energy from `48243` to `45153`, and power from `3614` to `3390`.
However, relative-crossflow RMS rises from `0.2257` to `0.2312`, force/moment
RMS rise from `47.39/694.77` to `54.48/766.14`, and posterior excursion rises
from `0.500` to `0.509` rad. The posterior acceleration maximum equals the
policy bound in both cases (`30.543` versus `29.671` rad/time^2); the anterior
acceleration and both joint rates also touch the episode envelopes. Thus the
tighter bound is not evidence of unloading or eliminated saturation.

## Policy hypothesis

Materialize the replicated `1700 deg/time^2` posterior acceleration bound and
hold the gait, lag, damping, body-frame bearing law, steering allocation, and
observations fixed. The falsifiable expectation is preservation of the visible
active diagonal capture with the sampled `1700` navigation and effort envelope.
This selects an evidence-backed score improvement over the `1750` prefill; it
does not claim lower hydrodynamic load. Do not continue below `1700` on this
evidence because the sampled improvement already increases crossflow, force,
moment, and posterior excursion. The claim is limited to the certified wake
phase and start pose and is falsified by a missed/different route or material
departure from the replicated arrival, distance, effort, crossflow, or load
metrics.
