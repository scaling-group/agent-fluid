# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations use direct uniform still-water initialization,
`U_infinity=(0,0,0)`, no cylinders, and the validated moving window. Their
policy parameter objects and executable expressions are identical; the source
files differ only in comments. All four capture at `0.7482--0.7497L` in
`19.228--19.784T`, so the small score spread (`-0.2433` to `-0.2299`) is a
repeatability band for one controller rather than evidence for a gain choice.

I inspected the combined top-down vorticity and oblique Lambda2 sheets for the
best-scoring capture and the assigned-parent capture, and compared them with
the inherited differential turn-rate-servo failure. The captures carry a
coherent alternating top-down street and compact three-dimensional structures
from the caudal region while curving into the target. The rate servo has an
equally clear propulsive wake but keeps an almost axial high-side route, reaches
only `4.9765L`, and exits after `33.209T`. This supports preserving the current
package: body-frame lateral target fraction owns turn sign, opposite anterior
and posterior biases provide differential curvature, and correctly signed yaw
may release but never invert the request.

The repeated captures also reproduce a narrower unresolved weakness. Across
the four traces, raw acceleration exceeds the `1800 deg/T^2` envelope on about
`61.7--62.2%` of anterior samples and `71.7--72.3%` of posterior samples;
joint-rate contact is about `10.6--10.8%` and `14.1--14.4%`. Peak raw commands
are about `63/101 rad/T^2`, versus the physical `31.42 rad/T^2` envelope, while
joint angles remain below the `45 deg` limit. About `19--22%` of samples per
joint combine outward acceleration with a rate above `80%` of its limit. The
visual wake and capture validate route control, but not this repeated attempt
to drive farther into a saturated joint rate.

An inherited negative result matters here: posterior-only steering combined
with pointwise `tanh` action compression removed clipping but exited at
`9.576T`, so it did not isolate whether compression or missing differential
steering caused failure. The present candidate keeps every evidenced steering
and carrier expression, and changes only demand handling at high joint rate.

## Policy hypothesis

Wrap each raw oscillator acceleration in a state-feedback rate guard. Below
`80%` of the joint-rate envelope, or whenever acceleration opposes the current
rate, the command is unchanged. Above that threshold, attenuate only the
outward component continuously to zero at the rate limit, then clamp the
returned command to the acceleration envelope. This preserves phase reversal,
mean curvature, and braking authority while avoiding continued outward drive
at saturation. It is an actuator-aware feedback mechanism, not scalar-only
carrier tuning.

The candidate should retain capture and both coherent wake views while reducing
joint-rate contact and eliminating over-envelope returned commands. Falsify it
if capture is lost, the route or wake topology changes materially, rate contact
does not fall, force/moment peaks worsen, or reduced outward authority delays
arrival enough to erase the useful distance integral.

bookshelf_consulted: true
source_domain: robotic-fish state-feedback CPG control and actuator-limited rhythmic locomotion
source_mechanism: preserve a joint-state rhythmic carrier while measured joint response gates only demand that reinforces saturation
transferable_invariant: keep route and phase information in normalized body-frame geometry and joint state, and reduce outward actuation continuously as a measured joint rate approaches its physical envelope
nontransferable_details: published CPG gains, motor models, species kinematics, dimensional beat settings, exact vortex phases, and task-specific routes
policy_translation: retain the captured lateral-fraction differential-curvature controller; normalize each observed joint rate by its policy-owned limit and attenuate only same-sign acceleration above a bounded guard threshold
falsification: lost capture, collapsed alternating or three-dimensional wake, unchanged rate-limit contact, worse loads, or a materially slower distance trajectory
