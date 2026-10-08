# Wake-policy candidate notes

## Evidence diagnosis before policy edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, no cylinders, and an inertial moving window.
The top-down and oblique rows show self-propulsion rather than advection.  The
three failures retain a coherent alternating wake but accumulate positive-y
translation, pass their closest points, bend sharply upward, and leave the
upper virtual boundary.  Their scalar carrier-shrink variant is effectively
indistinguishable from its fixed-carrier parent: minimum distance changes only
from `5.144L` to `5.086L`, termination remains `left_domain`, and applied
posterior limit residence remains `35.9%` versus `36.2%`.

The response-gated posterior redirect is a semantic change, not a scalar-only
improvement.  Its top-down path advances down-left to the target while the
oblique row retains a compact alternating three-dimensional wake, and it
captures at `0.746L` and `16.291T`.  The cost is higher actuation and load: the
posterior action occupies the applied acceleration limit in `60.4%` of samples
with mean/max force magnitude `0.0156/0.0372`, versus `35.9%` and
`0.0113/0.0328` for the fixed-redirect failure.  At `15T` and `16T` the capture
trajectory is already closing at about `1.2L/T` and `1.3L/T`; it needs only
about `0.28L` more head travel at the final one-second landmark, yet both joint
commands still repeatedly reach the hard acceleration envelope.

## Policy hypothesis

Preserve the successful cruise carrier, response-error redirect, and
attenuation-only opposing-lobe relief outside the target neighborhood.  Add
one continuous approach mechanism: when normalized body-frame target distance
is small *and* target-aligned body velocity confirms reliable closing, damp
the anterior oscillator and reduce only the posterior wave component.  Do not
reduce the mean steering bend.  The closing gate prevents premature coasting
during a near miss or adverse wake event, while the distance gate confines the
new mechanism to the terminal part of the already successful trajectory.
Falsify the candidate if it loses capture, materially delays first crossing,
or fails to reduce near-field joint-speed/acceleration residence and loads.

bookshelf_consulted: true
source_domain: biological terminal capture and sensor-modulated robotic-fish CPG control
source_mechanism: continuous near-target drive relief with response-gated release from the propulsive rhythm
transferable_invariant: after broad target-directed motion works, use observed proximity and reliable closing response to reduce excess drive without removing steering authority
nontransferable_details: species maneuvers, published CPG gains, dimensional distances, prescribed phases, and task-specific routes
policy_translation: smooth gates from normalized body-frame target distance and target-aligned body velocity add bounded anterior damping and posterior-wave attenuation while preserving mean curvature
falsification: reject if capture is lost or delayed materially, the coherent wake collapses before crossing, or near-field saturation and loads do not decrease
