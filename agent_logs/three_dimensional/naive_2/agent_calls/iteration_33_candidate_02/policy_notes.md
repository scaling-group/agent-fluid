# Joint-reserve-aware redirect allocation candidate

## Visual and metric diagnosis before editing

All four sampled rollouts and the newly completed inherited parent satisfy the
frozen-flow contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
keyframe sheets from release through capture for all four samples and the
inherited parent, including both the top-down mid-plane vorticity row and the
oblique body/Lambda2 row. The score-best posterior-residual sample
`solver_e749afa61520` and weakest sampled capture `solver_8600d052eff8` both
self-propel on the same direct down-left route with a compact, alternating,
body-connected three-dimensional wake. The parent corridor-release sheet has
the same topology. There is no sampled visual failure; the inherited
identical-controller `1.01--1.22L` left exits remain the semantic failure
boundary, and the weakest finite capture is the required visual comparator.
The images and metrics therefore support preserving the carrier and route.

The inherited capture-corridor release did not solve terminal spread. It
captured at `15.9109T`, scored `-0.02184`, and ended with head-relative
constant-course miss `0.716L` and target-line rate `1.619/T`; this is the same
wide tangential class as force-deficit (`0.744L`), persistent line-rate
(`0.747L`), and direct line-rate (`0.674L`) variants. Its normalized peak
planar force/moment was `0.03765/0.01844`, and posterior `>40 deg` dwell
returned at `0.104%`. This falsifies further corridor-width, release-horizon,
or release-threshold tuning on the current carrier.

The posterior predicted-miss residual `solver_e749afa61520` is the only
sampled semantic improvement in arrival and scalar objective: it captures
earliest at `15.1403T`, has the best score and mean distance
(`-0.01094/1.89264L`), and keeps the direct coherent-wake route. Its boundary
is actuator quality rather than propulsion: terminal miss remains `0.651L`,
peak normalized force/moment rises to `0.04041/0.01902`, and the posterior
joint spends `1.269%` of samples beyond `40 deg`, whereas the other four
evaluated captures have zero or at most `0.104%` posterior dwell. Suppressing
the residual or adding another terminal request is not supported; allocating
the evidenced residual according to instantaneous joint reserve is a distinct
state-feedback hypothesis.

## Single candidate hypothesis

Start from the sampled posterior-residual controller and preserve its
state-feedback traveling carrier, posterior lag and pulse, body-frame
pursuit/course blend, constant-course predictor, mean bend, and common
response-plus-miss handoff. Retain the same bounded cubic predicted-miss
residual, but replace its tail-only injection with a smooth two-joint
allocator. When posterior angle and rate have reserve, apply the residual at
the tail exactly as sampled. As either posterior state approaches its soft
reserve boundary, continuously move that residual into the anterior rhythmic
half-cycle channel, scaled by the already evidenced anterior steering share.
The residual sign, terminal geometry gate, total acceleration envelope, and
unmodified carrier remain intact. Absolute joint state controls allocation,
so the mechanism is reflection equivariant and uses no clock, route, target
identity, world coordinate, force-fit model, or exact wake phase.

The hypothesis is that the posterior residual's useful early translation can
survive while state-dependent control allocation removes its avoidable tail
dwell and load increase. Support requires capture with arrival/score near the
sampled `15.1403T/-0.01094` result, no posterior `>40 deg` dwell, normalized
peak planar force/moment below the residual sample's `0.04041/0.01902`, and
terminal predicted miss no worse than `0.651L`. The direct route, compact
alternating 3D wake, bounded finite commands, and reflection equivariance must
survive. Falsify on a miss or boundary exit, slower arrival without joint/load
improvement, terminal miss above `0.651L`, anterior saturation replacing tail
saturation, wake decoherence, nonfinite commands, or changed far-field
behavior. Formal CFD remains deferred to EvE and is not evidence available to
this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and wave-shape modulation
source_mechanism: preserve an autonomous propulsive oscillator while bounded directional modulation is assigned through observable joint-state capacity
transferable_invariant: keep the carrier intact and continuously redistribute a target-relative rhythmic residual away from an actuator that is losing kinematic reserve
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phases, hard-coded task coordinates, routes, and waypoints
policy_translation: gate the sampled cubic body-frame predicted-miss residual by posterior angle/rate reserve, applying its complement to the anterior half-cycle channel while retaining the two-joint state-feedback carrier and smooth acceleration envelope
falsification: reject if capture, arrival, terminal course, direct routing, coherent wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Validation boundary

The mandated guidance-materiality/parameter-schema, lightweight Julia policy
contract, and solver editable-boundary checks pass. A deterministic
`13,230`-state grid over normalized body-frame target geometry and velocity,
heading response, and both joint angles and rates produced finite commands
strictly inside the smooth `30 rad/T^2` envelope. Exact left/right reflection
error was `0.0`. Relative to the sampled posterior-only residual, the allocator
changed `12,996` grid states at numerical tolerance and reached a maximum
command difference of `8.03211 rad/T^2`, confirming an active feedback
mechanism rather than a comment or scalar edit. These are algebraic checks
only; formal CFD is run by EvE after this worker exits and is not evidence
available here.
