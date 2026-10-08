# Multi-wake Candidate Notes

## Evidence diagnosis

The only sampled solver is therefore both the best finite example and the most
informative failure available in this fresh lineage. Its released keyframes
show that the fish starts above and downstream of the developed interacting
wakes, translates slightly upstream, turns almost vertical, and then crosses
the lower boundary without entering the target/wake corridor. This is active,
wasteful self-propulsion rather than passive advection: release lasts only
`50.1269`, head displacement is `(-3.545, -13.300)L`, and minimum target
distance remains `8.615L`. The scalar diagnostics agree with the pictures:
progress is only `0.0243`, while both joints reach the `260 deg/time` rate cap
and `1800 deg/time^2` acceleration cap. The estimated tailbeat/shedding ratio
of `32.83` further identifies an over-fast actuator-limited rhythm. The common
prewarm sheet confirms that the multi-wake field is developed before release,
but the failed trajectory never reaches its organized central region.

The naive seed does provide one useful behavior to preserve: a joint-state
oscillator and lagged posterior target produce material upstream motion. Its
missing capability is persistent target-directed turning; it reads no target
observation. Aggregate relative crossflow, force, and moment are large, but the
single failed rollout provides neither their time-resolved sign nor evidence
that rejecting them would improve the route, so wake-residual feedback is not
identified yet.

## Policy hypothesis

Shift the state-feedback oscillator about a bounded mean-curvature target made
from `state.bearing`, and give the posterior joint a smaller compatible mean
bias while retaining its lagged oscillatory target. This translates a
persistent body-frame target error into steering without a world-frame route
or clock. Lengthen the state oscillator period and reduce its nominal bend so
the traveling wave operates inside the actuator envelope instead of relying on
clipping. The candidate is falsified if it preserves the downward domain-exit
topology, turns with the wrong sign, loses meaningful upstream propulsion, or
continues to spend substantial time at the joint rate/acceleration limits.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and fish turning by biased curvature
source_mechanism: bounded mean-curvature bias superposed on a posterior-lagged propulsive rhythm
transferable_invariant: persistent body-frame target error can shift mean bend while the oscillatory posterior lag continues to supply thrust
nontransferable_details: published gains, dimensional beat frequencies, species kinematics, exact vortex phases, and source-task routes
policy_translation: map bounded `state.bearing` to a mean first-joint bend and a smaller second-joint mean bend; form the propulsive wave from joint angle and velocity about that moving mean
falsification: reject the transfer if target-turn sign is wrong, the same lower-boundary exit remains, upstream progress collapses, or actuator saturation remains persistent

## Pre-evaluation verification

The no-CFD contract check returned finite two-joint actions. A controller-only
60-time-unit integration at fixed bearings `-0.5`, `0`, and `+0.5` rad stayed
inside the episode envelope without command clipping: peak joint bends were
`35.40/26.63 deg` at the nonzero bearings, peak rates were
`195.74/158.87 deg/time`, and peak accelerations were
`1382.49/1082.74 deg/time^2`. This only verifies internal boundedness; it does
not predict thrust, turn sign, wake interaction, or task success, which remain
for the post-worker CFD evaluation.
