# Wake-policy candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders
or prewarm, finite dynamics, and moving-window transport. I inspected both the
top-down vorticity and oblique body/Lambda2 rows for the successful finite
example and the most informative differential-servo failure, then
cross-checked them against `wake_metrics.csv`, `trajectory.csv`, and
`wake_diagnostics.json`.

The assigned parent's geometry-held differential redirect preserves a coherent
alternating wake and nearly reaches the target: minimum head distance is
`1.092679L` at `19.058T`. It then passes below the target, spends `42.1%` of
trajectory rows moving farther away, and exits the lower boundary at
`32.071T` with final distance `9.554851L`. Its full signed line-of-sight request
therefore supplies strong route authority but does not release enough during
the terminal crossing. This is a concrete negative result against retaining
that geometry-only redirect unchanged.

The sampled response-gated differential redirect is the only semantic success.
It forms the same self-propelled alternating vorticity street and finite 3D
Lambda2 structures while curving toward the target, then captures at
`19.228T` and `0.748197L`. Only `2.6%` of its distance increments are outward.
In contrast, the differential turn-rate-error servo keeps a compact coherent
wake but swims almost horizontally above the target: it reaches only
`4.976522L`, then exits high at `33.209T`. Its beat-scale measured yaw can
reverse the steering request even while the target remains on one side.

The successful policy is not yet evidence of economical actuation: joint-rate
contact remains about `10.8%/14.3%`, and raw acceleration exceeds the hard
envelope on `61.9%/72.0%` of rows. Preserve semantic capture first; later
workers should test policy-owned command relief as a separate ablation rather
than combining it with another route change.

## Policy hypothesis

Adopt the successful response-gated differential-curvature mechanism as one
candidate. Normalize body-frame lateral target displacement by current
distance so persistent target side owns the redirect sign. A bounded recent
yaw response may release only part of a correctly signed request; it cannot
invert the request within a propulsive half-cycle. Apply the result as a small
anterior and larger opposite-sign posterior mean offset around the seed's
joint-state oscillator and lagged tail target.

This is a controller-structure selection from completed CFD evidence, not
scalar-only gain tuning. Treat the lateral mapping and one-sided response gate
as one evidenced package: the sampled policies changed both, so their
individual causal contributions are not identified. Falsify the package if it
fails to reproduce capture, repeats the geometry-only lower exit or the
rate-servo high pass, loses the coherent wake, or materially worsens actuator
contact and loads.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and biological burst redirect
source_mechanism: target-signed bounded curvature with response-triggered release into the propulsive rhythm
transferable_invariant: persistent body-frame lateral error owns redirect sign while measured correcting response may reduce but never invert the request
nontransferable_details: published gains, dimensional turn rates, clocked CPG phase, species-specific bend envelopes, exact vortex phases, and prescribed routes
policy_translation: normalize target lateral displacement by distance, map it to opposite-sign anterior/posterior mean bends, and use bounded recent yaw only as a one-sided release gate around the joint-state oscillator
falsification: reject if capture is not reproduced, turn sign is wrong, the high or low boundary topology returns, wake coherence collapses, or actuator and load histories worsen
