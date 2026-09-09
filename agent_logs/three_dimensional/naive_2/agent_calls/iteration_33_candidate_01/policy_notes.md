# Response-released posterior redirect candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the assigned-parent rollout satisfy the
direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, and
no prewarm. I inspected the combined sheets for the score-best posterior
residual sample `solver_e749afa61520`, the weakest sampled capture
`solver_8600d052eff8`, and the assigned-parent posterior-relief rollout from
release through termination, including both the top-down mid-plane vorticity
row and the oblique body/Lambda2 row. Each fish visibly self-propels along the
same direct down-left route behind a compact, alternating, body-connected 3D
wake. None shows passive advection, wake breakup, boundary interaction, or
instability. No current sampled rollout is a semantic failure, so the weakest
finite capture is the visual comparator; the inherited identical-controller
`1.01--1.22L` left exits remain the failure boundary.

The prefilled posterior predicted-miss residual is the strongest progress
sample but not a robust terminal solution. It captures earliest at `15.1403T`,
scores `-0.01094`, and reaches `0.74290L`, while the other sampled policies
arrive at `15.6893--15.7829T` and score `-0.01874---0.02023`. However, its
terminal speed is `1.479L/T`, raw head-relative constant-course miss remains
`0.651L`, body yaw rate is `-4.637rad/T`, peak normalized planar force/moment
rises to `0.04041/0.01902`, and the posterior joint spends `1.269%` of samples
above `40deg`. The other samples retain zero `>40deg` dwell and roughly the
`0.0355--0.0363/0.0174--0.0180` load class, but cross with still wider
`0.674--0.747L` predicted misses. The tail residual therefore supplies useful
terminal progress and speed, yet remains active into a high-yaw, high-angle
crossing instead of demonstrating a settled redirect.

Two newer inherited mechanisms sharpen this boundary. The assigned parent's
miss-conditioned posterior drive relief captures at `15.8877T/-0.02596` with
`0.734L` predicted miss: it removes `>40deg` dwell but loses the residual's
arrival, score, and course advantage. Predicted-capture-corridor release also
captures, at `15.9109T/-0.02184`, but crosses with `0.716L` miss and slightly
higher `0.03765/0.01844` peak load. Together with the sampled force response,
line-rate, duty-skew, and phase-lag negatives, these outcomes reject another
gain change, broad drive reduction, wholesale terminal release, or new
corrective observation. The untested distinction is to release only the
evidenced tail residual after its intended corrective response appears while
leaving the common geometry/response handoff and carrier intact.

## Single candidate hypothesis

Preserve the prefilled state-feedback traveling carrier, posterior lag,
pursuit/course blend, constant-course predictor, terminal mean bend and pulse,
and shared response-plus-miss steering handoff. Change one mechanism: treat
the cubic tail-only miss residual as a bounded redirect burst and multiply it
by the handoff's existing unmet response gate. A large closing predicted miss
still recruits the tail residual. As carrier-separated corrective yaw appears
and predicted miss becomes small, the residual continuously returns to zero;
the base shared steering and propulsive carrier are not released or braked.
This uses only normalized body-frame geometry, velocity, yaw response, and
joint state, with no clock, route, coordinates, or prescribed phase.

The hypothesis is that the residual's useful early terminal impulse can be
retained without driving the final high-yaw/high-angle tail state. Support
requires capture with arrival and score competitive with the prefill, raw
terminal predicted miss below `0.651L`, materially reduced posterior `>40deg`
dwell and yaw rate, the direct compact-wake route intact, and peak normalized
planar force/moment moving toward the established `0.037/0.019` class.
Falsify on lost capture, miss at or above `0.651L`, loss of the prefill's
progress without course-margin improvement, continued high-angle dwell or
load growth, wake/route degradation, nonfinite action, or loss of reflection
equivariance. Formal CFD remains deferred to EvE and is not evidence available
to this worker.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish rhythmic control
source_mechanism: strong curvature or rhythmic asymmetry is released into the propulsive gait after observed directional response confirms the redirect
transferable_invariant: extra redirect authority should be transient and should vanish continuously when target-relative geometry and measured corrective response agree
nontransferable_details: species-specific C-start timing and curvature, published gains, robot linkage geometry, dimensional beat settings, exact vortex phase, task coordinates, and fixed routes
policy_translation: gate the existing bounded posterior predicted-miss residual by the normalized body-frame geometry-plus-carrier-separated-yaw unmet-response signal while preserving the two-joint state-feedback carrier and shared steering handoff
falsification: reject if capture margin, arrival, score, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `23,328`-state grid
over body-frame target geometry and velocity, heading response, and both joint
angles and rates produced finite commands strictly inside the smooth
`30rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The response release changed `9,444` states relative to the evaluated prefill,
with maximum command difference `1.03717rad/T^2`; it is an active feedback
mechanism rather than a comment or scalar-only edit. All `29` distinct direct
`params.FIELD` references resolve to one of the `30` returned fields. These
checks are algebraic only; formal CFD remains deferred to EvE.
