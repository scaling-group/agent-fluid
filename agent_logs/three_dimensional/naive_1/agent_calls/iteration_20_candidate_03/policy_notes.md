# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the frozen direct-uniform still-water
contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm), remain finite, and
capture. I inspected the combined top-down vorticity and oblique body/Lambda2
rows for the strongest baseline repeat and the half-cycle envelope sample,
then cross-checked them against scores, metrics, diagnostics, trajectories,
and executable policy diffs. I also inspected the assigned parent's completed
rearward-geometry rollout and an inherited direct-uniform `left_domain`
failure before proposing this candidate.

The three executable-equivalent geometry-scheduled samples all show genuine
self-propulsion: a body-attached alternating top-down street remains directed
toward the target and compact paired caudal Lambda2 structures persist through
first crossing. They capture at `18.6505--18.7550T` with mean distance
`2.09340--2.09542L`. The half-cycle envelope redistribution has the best
sampled mean distance (`2.08855L`) and also retains both coherent wake views,
but its single capture at `18.8265T` does not override the assigned guidance's
executable-equivalent miss at `0.81206L`, followed by a `left_domain` exit at
`34.2320T` and `10.67789L` final distance.

The available inherited failure sheet reinforces the control diagnosis. Its
top-down street and oblique caudal structures stay energetic while the fish
turns down and away after approach; it exits left at `31.2950T`, with minimum
distance `2.24855L`, final distance `9.88895L`, and mean distance `9.01735L`.
Thus coherent propulsion is not evidence of route recovery. The inherited
notes locate the executable-equivalent redistribution miss more sharply: once
the target becomes rearward, normalized lateral target fraction decays from
`0.361` to `0.128`, so a lateral-magnitude-only route request weakens while a
continued turn is needed.

The assigned parent's first rearward-aware multiplier is important negative
evidence rather than a demonstrated recovery. It captured at `18.6505T` and
`0.74811L`, with mean distance `2.09634L`, and its two wake rows remain in the
established coherent capture class. Reconstruction from its trajectory shows,
however, that normalized forward target fraction stayed in
`[0.85627, 1.00000]` on every row. Its behind-target factor was therefore
exactly one for the whole rollout. This establishes non-interference on an
ordinary capture, but does not test whether multiplying a shrinking lateral
fraction can recover from a miss.

Preserve the sampled displacement-only half-cycle steering, target-owned turn
sign, one-sided correcting-yaw release, common gait relief, posterior lag, and
final acceleration projection. Do not retry the fragile half-cycle envelope
redistribution or add velocity phase, terminal residuals, pointwise rate
barriers, or another propulsion gain.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological burst redirect
source_mechanism: sensed target direction gates a bounded strong-curvature redirect while the organized traveling rhythm remains intact
transferable_invariant: preserve the propulsive oscillator and use the full normalized body-frame target direction to maintain turn authority only when recovery geometry demands it
nontransferable_details: published gains, robot geometry, clock phase, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: retain lateral target sign as turn owner; when the normalized target direction is rearward, add a smooth signed lateral curvature reserve before the existing route saturation, while making the added term identically zero for target-ahead motion
falsification: reject if a target-ahead capture changes route, arrival, demand, or either wake class; if near-astern direction chatters; or if an activated recovery still decays into the inherited left-domain topology

## Single-candidate policy hypothesis

Add one bounded behind-target route-reserve mechanism to the current sampled
capture carrier. Compute normalized forward target fraction from
`target_body_L[1] / distance_L`. For a target ahead, the reserve is exactly
zero and every inherited control expression is unchanged. For a target
behind, add to the lateral route argument a bounded reserve whose sign is a
smooth `tanh` of normalized lateral target fraction. This prevents the route
magnitude from being proportional only to the decaying lateral fraction, yet
lets the reserve continuously vanish at the directly-astern ambiguity. The
existing route `tanh`, correcting-response release, bias limits, and final
acceleration projection still bound the resulting action.

This is a feedback-structure test, not scalar-only tuning. It uses no clock,
stage, world coordinate, route, target identity, velocity phase, force, or
flow residual. The formal CFD evaluation occurs after this worker exits.
Accept the mechanism only if ordinary captures remain in the established
trajectory/wake/demand band, or an activated post-miss trace sustains the turn
and approaches again instead of exiting left. A capture with no rearward rows
is safety evidence only and must not be reported as recovery evidence.

## Implementation and non-CFD validation

The candidate adds two parameter-owned normalized quantities for one feedback
mechanism: the maximum signed route reserve and the lateral scale over which
its direction fades near directly astern. The reserve enters only before the
inherited route saturation; propulsion, common gait relief, curvature shares,
displacement phase, response release, posterior lag, and acceleration
projection are unchanged.

The configured guidance-provenance check, explicit Julia policy-contract
check, and solver boundary check pass. A direct dry ablation against the
prefill confirms exact action equality for target-ahead observations and for
a directly-astern target, nonzero activation for a rearward off-axis target,
left/right reflection symmetry, and actions inside the owned acceleration
limit. No CFD was run; recovery effectiveness remains the next evaluator's
hypothesis.
