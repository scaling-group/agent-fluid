# Phase-separated wake-policy candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the direct-uniform quiescent initialization
contract.  Their top-down rows show self-propelled fish shedding coherent
alternating wakes, and the oblique Lambda2 rows show tail-connected
three-dimensional vortex trains rather than passive advection or a prewarm
artifact.  Every trajectory nevertheless hooks upward and exits the upper
virtual boundary, so the retained mechanism should be the uncentered anterior
oscillator and posterior traveling bend, not the observed course.

The assigned parent's relative-crossflow residual is the strongest finite
sample.  It preserves the wake, survives to `10.785T`, moves the center from
`x=21.000L` to `18.144L`, and improves minimum/final distance to `10.513L`.
It also reduces terminal upward velocity to `0.271U`, versus `0.682U` for the
bearing/yaw posterior-mean controller.  The course-angle posterior-mean
variant reaches only `11.303L`, and the response-gated redirect reaches
`11.330L` before losing progress to `11.546L`; neither replaces the useful
crossflow cue.  The parent's correction is still incomplete because it leaves
at `y=15.201L` with a large negative body-frame bearing and the same upper-exit
class.

The sampled traces identify a signal-separation problem, not merely a gain
shortage.  Regressing each rollout's short-window yaw on `(q1, qdot1/omega)`
explains `92.0--97.2%` of its variation and reduces yaw standard deviation
from `1.077--1.392` to `0.236--0.304 rad/T`.  The same two carrier-phase
coordinates explain `67.1--78.7%` of relative-crossflow variation and reduce
its standard deviation from `0.159--0.201U` to `0.091--0.095U`, while leaving
the persistent negative slip mean.  Thus the parent's raw yaw and crossflow
feedback repeatedly interpret predictable beat-synchronous motion as a route
response and modulate the posterior mean request within each cycle.

## Policy hypothesis

Preserve the parent's anterior Van der Pol oscillator, posterior phase lag,
posterior-only mean curvature, curvature bound, and smooth acceleration
envelope.  Estimate only the carrier-synchronous component of measured yaw
and relative crossflow from the normalized anterior phase coordinates
`q1/amplitude` and `qdot1/(omega*amplitude)`, then subtract those estimates.
Combine body-frame bearing with the remaining slow slip and yaw residuals to
set the bounded posterior mean tangent.  This phase-conditioned residual is
odd under reflection, uses no clock or persistent state, and should preserve
the useful alternating wave while making steering feedback respond to course
drift instead of the carrier's expected oscillation.

Falsify the mechanism if the alternating wake or the parent's leftward
progress is lost, if minimum distance does not improve on `10.513L`, if
phase-separated slip does not shrink before the prior `10.785T` exit, if the
same upper exit recurs without a useful delay or trajectory change, or if
joint-limit residence and force/moment peaks become dominant.  The fitted
phase projection is specific to this fixed morphology and carrier; it must be
recalibrated or rejected if their frequency, amplitude, or response changes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: sensor feedback modulates a rhythmic carrier while slow persistent route error is separated from fast alternating response
transferable_invariant: remove the predictable carrier-synchronous component of a response signal before using its residual to regulate mean turning
nontransferable_details: published gains, clock phases, species or robot kinematics, exact vortex phases, prescribed routes, and the present trace-fit coefficients outside this fixed carrier
policy_translation: project body-frame relative crossflow and recent yaw onto normalized anterior joint phase, subtract those projections, and combine the residuals with bearing only in the bounded posterior mean-tangent request
falsification: reject if phase separation loses the alternating wake, fails to beat `10.513L` or alter the upper-exit topology usefully, leaves persistent slip, or increases actuator and hydrodynamic load dominance
