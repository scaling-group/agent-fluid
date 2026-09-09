# Selective capture-corridor actuator release

## Visual and metric diagnosis before editing

The four sampled evaluations and the assigned-parent evaluation all satisfy
the frozen-flow contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
keyframe sheets from release through capture for the score-best sampled run,
the weakest sampled run, and the assigned parent, including both the top-down
mid-plane vorticity row and oblique body/Lambda2 row. All are self-propelled
along the same direct down-left route behind a compact, body-connected,
alternating three-dimensional wake. None shows passive advection, wake
breakup, boundary interaction, or instability. The remaining distinction is
terminal course and actuator quality, so the state-feedback traveling carrier
and far-field route should remain unchanged.

The assigned parent's predicted-capture-corridor release is now evaluated.
Returning mean bend, posterior pulse, and shared rhythmic steering together
to the carrier preserved capture and the coherent wake, but crossed at
`15.9109T/-0.02184` with `0.7155L` raw constant-course miss and velocity
`(-0.702,-1.049)L/T`. Peak normalized planar force/moment rose to
`0.03765/0.01844`, and posterior `>40 deg` dwell appeared at `0.104%`.
This is slower and wider than direct target-line-rate steering
(`15.6893T/-0.01965/0.6740L`) and remains in the same broad tangential class
as force-deficit and persistent-line-rate feedback (`0.7441--0.7470L`). Thus
a narrow predicted crossing is not evidence that every target correction can
be removed; full carrier return discards useful course authority.

The fastest sampled posterior predicted-miss residual is also not a template
for more authority. It arrives at `15.1403T` and scores `-0.01094`, but still
has `0.6511L` terminal miss while raising peak normalized force/moment to
`0.04041/0.01902` and posterior `>40 deg` dwell to `1.269%`. Across the
sampled and inherited results, additive line-rate, force, and tail residuals
or full correction release preserve capture without establishing a smaller
terminal margin. The evidence instead isolates actuator allocation during the
redirect-to-cruise transition.

## Single candidate hypothesis

Start from the assigned parent's response-plus-predicted-miss controller and
preserve its normalized body-frame pursuit/course blend, constant-course
predictor, carrier-separated yaw response, shared consensus handoff,
state-feedback traveling bend, posterior lag, and smooth acceleration
envelope. Retain the parent's closing short-horizon capture-corridor detector,
but change its role: inside that corridor, continuously release only the slow
terminal mean bend and posterior pulse. Do not release the shared rhythmic
course-steering channel beyond its existing response-plus-miss handoff.

This partitions cruise return by actuator role. The potentially persistent
offset and tail pulse vanish once measured geometry predicts a safe crossing,
while bounded half-cycle steering continues to correct target-relative course
around the propulsive carrier. It adds no force residual, line-rate command,
extra tail authority, clock, route, target identity, or world coordinate.

The hypothesis is that the assigned parent's broad release widened the course
because it removed rhythmic target authority together with terminal offsets.
Selective release should preserve the direct compact-wake capture while
improving on the parent's `0.7155L` miss, `15.9109T` arrival, and load/dwell
class. Support requires capture with raw terminal predicted miss below the
inherited `0.590L` repeat boundary, preferably near the `0.179L` centered
sample, arrival competitive with `15.14--15.74T`, zero `>40 deg` dwell, and
peak normalized planar force/moment near or below `0.037/0.019`. Falsify on a
miss or boundary exit, terminal miss at or above `0.590L`, a slower capture
without margin improvement, loss of the direct route or compact wake, higher
joint/load occupancy, nonfinite commands, or loss of reflection equivariance.
The candidate's CFD evaluation occurs only after this worker exits and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return continuously from maneuver modulation toward an autonomous rhythmic carrier while preserving directional feedback until sensed goal-relative response confirms completion
transferable_invariant: different steering channels need not be released together; persistent offsets may return to cruise inside a safe intercept while rhythmic target-relative correction remains available
nontransferable_details: published gains, robot linkage geometry, species-specific maneuver timing and curvature, dimensional frequency, exact vortex phase, source corridor dimensions, and task-specific routes
policy_translation: use normalized body-frame target and velocity to release terminal mean bend and posterior pulse in a short-horizon predicted capture corridor, while retaining the two-joint traveling carrier and the existing response-gated shared half-cycle course steering
falsification: reject if capture margin, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract, and
solver editable-boundary checks pass. All `32` direct `params.FIELD`
references resolve to the `32` fields returned by `target_policy_params()`.
A deterministic `151,875`-state grid over normalized body-frame target
geometry and velocity, both joint angles and rates, and yaw response produced
finite commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). The selective release differs
from the assigned parent's broad corridor release by as much as
`7.86285 rad/T^2` on that grid, confirming an active feedback-allocation
change rather than a comment or scalar-only edit. These checks are algebraic;
formal CFD remains deferred to EvE after this worker exits.
