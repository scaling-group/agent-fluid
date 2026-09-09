# Repeated-capture unified handoff candidate

## Visual and metric diagnosis before editing

All sampled and inherited rollouts used direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the
combined top-down mid-plane vorticity and oblique body/Lambda2 rows for all four
sampled captures, the inherited carrier-phase-pulse capture, and the assigned
parent guidance's inherited `left_domain` failure. The captures are self-propelled on
nearly direct down-left routes behind compact, body-connected alternating
wakes with localized posterior three-dimensional structures. The failure has
the same organized wake through its `1.10362L` pass, then turns nearly vertical
and exits left at `27.654T`; it is a terminal handoff failure rather than
passive advection, wake collapse, excessive load, or instability.

The strongest robustness evidence is a semantic duplicate rather than a new
gain. The unified response-and-predicted-miss controller was evaluated twice
from code that differs only by whitespace. Both runs captured, at `15.5008T`
and `15.6625T`, with scores `-0.0210890` and `-0.0242517` and normalized
distance integrals `1.90236L` and `1.90582L`. Both retain zero joint-angle
dwell at or above `40 deg`, about `17.0--17.9%` near-rate-limit occupancy, and
peak normalized planar force/moment no larger than `0.0366/0.0181`. Their
different capture headings and terminal velocities show beat-phase variation,
so this is evidence for repeat semantic success, not a claim of deterministic
capture pose or enlarged geometric margin.

The current response-only prefill captures later at `15.9830T`, scores
`-0.0244375`, and has a `1.90641L` distance integral. Geometry-qualifying only
the posterior pulse also captures later at `16.0270T`. Conversely, the
inherited carrier-phase-selective posterior pulse preserves the compact wake
and capture but reaches at `15.7396T` with a worse `-0.0250288` score and
`1.90677L` distance integral; its `17.6/17.1%` near-rate occupancy and
`0.0368/0.0179` peak load scale do not improve. Thus posterior phase selection
adds a mechanism without an evidenced trajectory, reserve, or load benefit.

## Single candidate hypothesis

Select the twice-captured unified handoff while preserving all established
gains, the joint-state traveling-bend carrier, raw normalized body-frame
pursuit/course blend, constant-course predicted miss, terminal mean bend,
shared half-cycle steering, and posterior mid-stroke pulse. A corrective
carrier-separated yaw response may release either rhythmic steering channel
only in proportion to how small the bounded predicted-miss request has become.
This is one continuous response-and-geometry consensus mechanism, with no new
threshold, gain, clock, coordinate, route, flow assumption, or static bend.

The evidence-backed expectation is repeat capture with the direct compact-wake
trajectory, rather than the prefill's response-only handoff or the unsupported
phase-selective pulse. Falsify on a miss or left exit, loss of the direct route
or compact wake, joint dwell at `40 deg`, materially more than the observed
roughly `18%` near-rate occupancy, or peak normalized planar force/moment above
about `0.037/0.019`. Because both existing repeats cross close to the `0.75L`
threshold and at different beat phases, another capture supports selection but
does not by itself prove capture margin. The current candidate's CFD evaluation
occurs only after this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return bounded rhythmic steering authority to the propulsive carrier only when measured turning response and remaining target-relative direction error jointly indicate redirect completion
transferable_invariant: corrective response alone is not a completion signal; release a rhythmic redirect only when the residual geometric miss is also small
nontransferable_details: species-specific maneuver timing and curvature, published gains, robot linkage geometry, dimensional frequency, exact vortex phase, target coordinates, capture pose, and task-specific route
policy_translation: combine carrier-separated yaw response with the complement of bounded body-frame predicted miss and use that reflection-equivariant consensus to hand off both existing two-joint rhythmic steering channels
falsification: reject if capture or closest pass and termination worsen together, or if the direct route, coherent wake, joint reserve, normalized loads, boundedness, or reflection symmetry degrades

## Dry validation only

The final candidate is byte-identical to one of the two semantically identical
sampled unified policies that captured. The mandated guidance-materiality check, lightweight Julia
policy contract, direct parameter-schema check, and solver editable-boundary
check pass. A `19,683`-state grid spanning normalized body-frame target and
velocity, both joint states, and yaw response produced only finite commands
inside the smooth `30 rad/T^2` envelope and exact left/right reflection
(maximum error `0.0`). No CFD was run in this worker.
