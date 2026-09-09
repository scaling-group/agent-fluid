# Closing-course terminal-observation candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected both the top-down vorticity row and the oblique
body/Lambda2 row of the highest-score sampled capture and an inherited
informative near-miss. The `solver_64ab25982638` capture is self-propelled on
the established nearly direct down-left route. Its alternating vorticity street
stays compact and body-connected, and localized three-dimensional tail
structures remain organized through capture at `16.027T`. The inherited
`solver_d32f9008f843` rollout follows the same compact-wake approach, passes
just below the capture sphere at `0.82926L`, then turns nearly vertical and
exits left at `27.990T`. The miss is not passive advection, wake collapse,
collision, or instability.

The four sampled policies all capture at `15.921--16.027T` and
`0.74729--0.74998L`, with low peak normalized planar force/moment and no
`>40 deg` joint dwell in the inherited diagnostics. They differ only in
terminal redirect-release logic: always-active, response-released,
predicted-miss-qualified, or body-corridor-qualified. In particular, the
assigned parent's body-corridor-qualified release now captures at `0.74729L`
after its sampled parent missed at `1.10362L`, while inherited replays show
that always-pulse and response-release forms can each both capture and miss.
This supports preserving the common traveling carrier and constant-course
route, but does not support another pulse or static-bend gain change.

Offline reconstruction from the logged head, heading, and velocity makes the
remaining common boundary concrete. During the final `2.5T`, the present
terminal pursuit/predicted-miss blend changes sign six times in three sampled
captures, whereas the rotation-invariant course error changes sign four times.
The current predictive contribution is weighted by the magnitude of its own
request, so a small, well-centered predicted miss removes the phase-separated
signal and lets instantaneous body-frame pursuit bearing dominate. That is the
wrong handoff direction for a beat-contaminated terminal observation. The
near-miss retains low loads and a coherent wake, so the evidence does not call
for drive relief or more propulsion.

## Single candidate hypothesis

Preserve the evaluated oscillator, posterior lag, far-field pursuit/course
blend, constant-course prediction, terminal mean bend, response logic,
geometry-qualified posterior pulse, and every gain. Change one observation
handoff only. Inside the existing near-target gate, when speed and positive
closing alignment make course observable, smoothly select the bounded
rotation-invariant course-error request with a weight that does not depend on
error magnitude. Fall back continuously to the inherited terminal blend when
the course is slow, nonclosing, or outside the near-target region. This keeps a
centered course request at zero instead of reintroducing beat-scale bearing,
and it leaves far-field translation and both propulsive half-cycles intact.

Support requires repeat capture or a closer pass with a better termination
class than the inherited `0.829--1.104L` miss band, while retaining the direct
route, compact alternating wake, low normalized loads, little or no
`>40 deg` dwell, bounded commands, and reflection equivariance. Falsify on a
left exit without a closer pass, altered route or wake class, loss of joint
reserve, larger loads, or failure to reduce terminal request switching.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return steering authority toward the propulsive rhythm only after an observable directional response indicates that the redirect is complete
transferable_invariant: separate the slow target/course error from beat-scale body motion and make redirect handoff depend on response observability rather than on the instantaneous error magnitude
nontransferable_details: species-specific maneuver timing and curvature, published controller gains, robot linkage geometry, dimensional frequency, exact vortex phase, capture coordinates, and task-specific routes
policy_translation: under the existing distance gate, use normalized body-frame target and velocity to form a rotation-invariant course error, and smoothly select it only while the fish is moving and closing; retain the two-joint carrier and existing target-relative actuation
falsification: reject if closest approach and termination do not improve together, or if the direct route, coherent wake, joint reserve, boundedness, reflection symmetry, low load scale, or terminal request stability degrades

The candidate's CFD evaluation occurs only after this worker exits. All
rollout outcomes above are sampled or inherited prior evidence; the offline
request replay is diagnostic rather than CFD validation.

## Dry validation only

The mandated guidance-materiality, lightweight Julia contract, parameter-
schema, and solver-boundary checks pass. A deterministic `10,935`-state grid
over target side, body velocity, heading response, and both joint states
produced finite commands strictly inside the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). Against the prefill, a
constructed centered closing approach changes the action materially while a
far-field counterpart is byte-identical. Replaying observations reconstructed
from prior trajectories reduces terminal request crossings from six to four
on the highest-score capture and from five to three on the informative
`0.82926L` miss; at that miss's closest state the bounded corrective request
changes from `0.890` to `0.978`. These tests establish schema, boundedness,
symmetry, locality, and semantic activation only; they do not predict the new
CFD outcome.
