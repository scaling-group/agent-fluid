# Predicted-capture corridor release candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the combined keyframe sheets from release through
capture for the score-best posterior-residual sample
`solver_e749afa61520` and the weakest sampled capture
`solver_8600d052eff8`, including both the top-down mid-plane vorticity row and
the oblique body/Lambda2 row. Both fish self-propel on the same direct down-left
route. Their alternating wakes remain compact, body-connected, and visibly
three-dimensional; neither sheet shows passive advection, wake breakup,
boundary interaction, or instability. The visible distinction is terminal
timing and course rather than far-field propulsion, so the carrier and route
should be preserved.

The newly evaluated assigned parent `solver_0abf107c2bc4` falsifies its
carrier-separated force-deficit hypothesis. It captures at `15.7384T`, scores
`-0.01874`, and keeps the narrow inherited load class
(`0.03563/0.01764` peak normalized planar force/moment), but crosses with
velocity `(-0.978,-0.872)L/T`, raw head-relative constant-course miss
`0.744L`, and target-line rate `1.741/T`. This is effectively the same wide
terminal class as persistent line-rate consensus (`0.747L`) and is much worse
than the inherited unified handoff's `0.179L` centered capture. Thus the
force residual is physically bounded but does not provide useful redirect
completion; another force gain or residual threshold is not supported.

The sampled posterior predicted-miss residual
`solver_e749afa61520` supplies a different, mixed result. It has the best
score (`-0.01094`), earliest arrival (`15.1403T`), and lowest mean distance
(`1.89264L`) of the four samples, but still crosses tangentially with
`0.651L` predicted miss and `1.745/T` target-line rate. Its extra tail
authority also raises peak normalized force/moment to `0.04041/0.01902` and
posterior `>40 deg` dwell to `1.269%`, versus zero dwell and at most about
`0.0363/0.0180` for the other samples. The result supports preserving the
direct state-feedback carrier, not adding another terminal residual: score or
earlier capture alone does not establish terminal margin or actuator quality.

## Single candidate hypothesis

Start from the assigned parent's unified response-plus-predicted-miss
controller, remove the falsified lateral-force re-engagement, and preserve the
state-feedback traveling carrier, posterior lag, pursuit/course blend,
constant-course predictor, response-plus-miss handoff, and smooth acceleration
envelope. Add one state-gated release mechanism instead of another corrective
input. When the normalized body-frame target and measured translational
velocity predict a safely narrow constant-course crossing within a short
time-to-closest horizon, smoothly release terminal mean bend, tail pulse, and
shared half-cycle steering back to the unmodified rhythmic carrier. Outside
that predicted capture corridor, the inherited unified controller remains
unchanged. The release uses no clock, route, target identity, world coordinate,
or externally prescribed phase.

The hypothesis is that continuing target correction after the measured course
already enters a narrow capture corridor causes the repeated tangential
terminal spread. A geometry- and response-gated return to the carrier should
preserve far-field translation and wake coherence while avoiding both the
parent's force chasing and the posterior residual's added load/dwell. Support
requires capture with raw terminal predicted miss below the inherited
`0.590L` repeat boundary, preferably near the `0.179L` centered sample, and
arrival/score competitive with the `15.14--15.74T` sampled class. The direct
route, compact alternating 3D wake, zero `>40 deg` dwell, and normalized peak
planar force/moment near or below `0.037/0.019` must survive. Falsify on a
miss or boundary exit, premature release before a closing intercept, terminal
miss at or above `0.590L`, slower capture without margin improvement, wake
decoherence, increased joint/load class, nonfinite commands, or loss of
reflection equivariance. Formal CFD remains deferred to EvE and is not
evidence available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded residual path following
source_mechanism: preserve an autonomous rhythmic propulsive carrier and gate directional modulation with observed goal-relative response
transferable_invariant: when normalized state predicts that the current course already enters a safe goal corridor, release corrective modulation continuously back to the carrier instead of adding a competing terminal command
nontransferable_details: published gains, dimensional frequencies, source corridor sizes, robot linkage geometry, species-specific kinematics, exact vortex phase, task coordinates, capture routes, and source-task waypoints
policy_translation: use body-frame target and velocity to gate off terminal mean bend, posterior pulse, and shared half-cycle steering only during a short-horizon narrow predicted crossing, while retaining the two-joint state-feedback carrier
falsification: reject if capture margin, arrival, direct routing, coherent wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Validation boundary

The mandated guidance-materiality/parameter-schema, lightweight Julia policy
contract, and solver editable-boundary checks pass. A deterministic
`3,888`-state grid over normalized body-frame target geometry and velocity,
heading response, and both joint angles and rates produced finite commands
strictly inside the smooth `30 rad/T^2` envelope. Exact left/right reflection
error was `0.0`. Disabling only the new capture-corridor release changed
`1,824` grid states, with maximum command difference
`30.83157 rad/T^2`, so the release is an active feedback mechanism rather
than a comment or scalar carrier edit. All `32` direct `params.FIELD`
references resolve to returned parameter fields. These are deliberately broad
algebraic checks; formal CFD will be run only by EvE after this worker exits
and is not rollout evidence available here.
