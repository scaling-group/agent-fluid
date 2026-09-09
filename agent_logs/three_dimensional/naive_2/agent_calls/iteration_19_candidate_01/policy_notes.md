# Predictive capture-funnel candidate

## Visual and metric diagnosis before editing

All sampled and inherited episodes used direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the
combined top-down vorticity and oblique Lambda2 views for the best sampled
capture, the full-circle pursuit failure, and the assigned-parent repeat
failure. The captures are self-propelled on a gently curving targetward track
behind a compact, body-connected alternating wake. The full-circle controller
also propels, but curls into a broad off-target route with large wake
structures and exits left after reaching only `4.650L`. The assigned-parent
response/pulse controller initially follows the compact-wake route, passes
below the capture circle near `16T`, then turns nearly vertical and exits left.
The missing capability is repeatable terminal interception, not thrust, wake
formation, or numerical stability.

The apparent replication of the response-gated posterior pulse does not
survive the inherited evidence. The exact policy SHA
`c8459795cfc38bc3ebbebc4120c1427abe9622491e2bc3fae39385b55f1805ca`
has three captures in the sampled/inherited records but also three
`left_domain` failures with closest approaches `1.0156--1.2164L`. The
assigned-parent repeat retains zero joint dwell beyond `40 deg` and low peak
normalized planar force/moment near `0.0336/0.0169`, so its failure cannot be
explained by a lost wake, excessive static posture, or load growth. The base
predicted-miss policy is likewise near-threshold rather than robust: it has one
sampled capture at `0.7477L` and one inherited repeat miss at `0.9631L`.

The body-frame target/velocity traces expose a usable separation before
closest approach. Constant-course predicted miss is about `0.57--0.65L` at
the sampled capture crossings, while the three same-hash pulse failures are
about `0.88--1.03L` at closest approach. At `14T`, the assigned-parent failure
already forecasts about `0.82L` cross-track miss, compared with `0.38L` for a
sampled capture, although both still have a coherent carrier. Existing course
feedback is nearly saturated during parts of the approach, so another scalar
gain or posterior-pulse gain is not a distinct correction mechanism.

## Single candidate hypothesis

Keep the prefilled base policy's joint-state traveling bend, posterior lag,
rotation-invariant target/course feedback, bounded time-to-closest prediction,
small shared mean bend, and two active rhythmic half-cycles. Add one predictive
capture-funnel actuator: while the target is closing within the existing
prediction horizon, compute how far the signed constant-course miss lies
outside an owned `0.70L` safe corridor. That excess recruits a bounded,
target-signed anterior-only half-cycle residual proportional to the magnitude
of the anterior carrier acceleration. It releases continuously when the
forecast enters the corridor or closing alignment disappears. The posterior
joint remains on its lagged propulsive target instead of receiving another
pulse.

This is a new state-gated authority-allocation mechanism, not static-curvature
or scalar-only pulse tuning. Support requires capture across the known
near-miss topology, ideally with more margin than the `0.748--0.750L` threshold
crossings, while preserving the compact wake, zero `>40 deg` dwell, useful
far-field translation, and roughly `0.04/0.02` normalized force/moment scale.
Falsify on another `left_domain` miss outside the corridor, an altered
far-field route, loss of the alternating wake, materially greater joint-rate
occupancy or loads, or a new high-side/looping topology. The new CFD result is
downstream evidence and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style posterior propulsion and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve posterior traveling-wave thrust while an observed interception deficit briefly recruits anterior steering authority
transferable_invariant: separate the joint that primarily redirects the body from the lagged posterior propulsion channel, and release extra steering when measured target-course geometry enters a safe corridor
nontransferable_details: published gains, robot linkage geometry, species-specific curvature, dimensional frequencies, exact vortex phases, prey routes, and the source tasks' timing
policy_translation: use normalized body-frame target and velocity to form signed constant-course miss, gate an anterior-only rhythmic residual by excess miss and closing alignment, and leave the posterior lagged carrier unchanged
falsification: reject if repeat capture and miss margin do not improve together without preserving route, wake coherence, joint reserve, low normalized loads, and reflection symmetry

## Dry validation only

The prescribed guidance-materiality, lightweight Julia policy-contract, and
solver editable-boundary checks pass. All `25/25` direct `params.FIELD`
references are owned by `target_policy_params()`. A `14,580`-state grid over
fore/aft and lateral target geometry, body-frame velocity, both joint angles,
and both joint rates produced finite commands strictly inside the smooth
`30 rad/T^2` envelope (maximum `29.99999998`) with exact left/right reflection
(maximum error `0.0`).

Against recorded states from `13.5--16.2T`, the new channel leaves the
posterior command exactly unchanged and activates on `54.7--56.6%` of the two
capture traces versus `66.8--72.9%` of the three repeated terminal-failure
traces. A constructed inside-corridor state is byte-identical to the base
action; an outside-corridor state changes only the anterior action, and a
`12L` state differs by only `1.36e-9 rad/T^2`. These checks establish schema,
boundedness, symmetry, isolation, and gate semantics only. No CFD was run in
this workspace, so capture and physical effects remain downstream falsifiers.
