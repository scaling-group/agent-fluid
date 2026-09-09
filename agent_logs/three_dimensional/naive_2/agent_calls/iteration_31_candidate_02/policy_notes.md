# Adverse-lateral-force posterior pulse candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected each
combined keyframe sheet from release through capture, including both the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. Each fish
self-propels along the same direct down-left route and sheds a compact,
alternating, body-connected three-dimensional wake. There is no sampled
failure sheet; the assigned parent's lower-scoring capture is the visual
contrast, while the inherited `1.01--1.22L` left exits remain the available
semantic failure boundary. Nothing in the views supports changing the
traveling carrier or far-field route.

The unified response-plus-predicted-miss policy `solver_e0a2513d969f` is still
the strongest terminal-course example. It captures at `15.5008T` with score
`-0.02109`, nearly target-line velocity `(-1.286,-0.014)L/T`, and raw
head-relative constant-course miss `0.179L`. Its peak normalized planar
force/moment is `0.0365/0.0180`, and neither joint dwells beyond `40 deg`.
The sampled target-line-rate transfer, persistence consensus, and posterior
phase-lag variants all retain capture and the compact wake but arrive at
`15.6893--15.7829T` with `0.674--0.747L` course miss. The assigned parent's
evaluated hydrodynamic-moment residual behaves the same way: it captures at
`15.8549T`, scores `-0.02716`, crosses at `(-0.721,-1.081)L/T` with `0.738L`
course miss, and keeps benign `0.0354/0.0175` peak normalized force/moment.
Thus capture and low loads do not validate spending released redirect
authority on another dynamic course reference.

The trajectory histories provide a narrower physical hypothesis. Within
`distance<3L`, normalized lateral force opposes the body-frame target side for
roughly three quarters of samples in every evaluated capture; its adverse
magnitude averages about `0.0155--0.0163` and peaks near `0.032--0.034`.
This is a directly observed load during an active correction, not evidence
that yaw moment or target-line rotation should steer after release. It supports
testing whether a small posterior wave-shape response can help the already
requested redirect overcome adverse lateral loading before the common
response-plus-miss handoff completes.

## Single candidate hypothesis

Start from `solver_e0a2513d969f` and preserve its state-feedback oscillator,
posterior lag, far-field pursuit/course blend, predicted-miss geometry,
bounded mean bend, shared half-cycle redirect, posterior pulse, and common
response-plus-miss release. Add one bounded physical-response component to the
posterior pulse. During a closing terminal redirect, and only while the common
handoff remains unmet, compare normalized body-frame lateral force with the
requested turn. When the measured force opposes that request, strengthen the
posterior corrective pulse during the same joint-state midstroke gate. When
force is supportive, geometry is ready, or the redirect is released, the new
component is zero. It cannot alter anterior carrier acceleration, enlarge
shared half-cycle authority, or act in the far field.

The hypothesis is that responding through the posterior wave before release
can overcome persistent adverse lateral loading without recreating the failed
moment/line-rate re-steering class. Support requires capture with raw terminal
course miss below `0.590L`, preferably near `0.179L`, and arrival/score
comparable to the `15.50T/-0.02109` unified sample while preserving the direct
route, compact wake, zero `>40 deg` dwell, and peak normalized planar
force/moment at or below about `0.037/0.019`. Falsify on a miss or left exit,
course miss at or above `0.590L`, slower lateral capture without margin
improvement, changed far-field motion, wake decoherence, greater joint/load
class, nonfinite commands, or loss of reflection equivariance. Formal CFD is
deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-adaptive swimming
source_mechanism: preserve autonomous rhythmic propulsion while target-consistent physical response gates a bounded corrective wave-shape component
transferable_invariant: a measured lateral load may modulate the corrective posterior wave only while target geometry still requests that correction; fast load response is not a route command after redirect completion
nontransferable_details: published gains, dimensional frequencies, source history windows, robot linkage geometry, species-specific kinematics, exact vortex phase, task coordinates, capture routes, and source-task waypoints
policy_translation: retain normalized body-frame geometry and the two-joint carrier, then use adverse `force_body_L[2]` to gate a bounded posterior-only midstroke pulse before the existing response-plus-miss release
falsification: reject if capture margin, terminal course, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance/materiality and parameter-schema check, lightweight
Julia policy contract, and solver editable-boundary check pass. A deterministic
`52,488`-state grid over normalized body-frame target geometry and velocity,
lateral force, heading response, and both joint angles and rates produced
finite commands strictly inside the smooth `30 rad/T^2` envelope. Exact
left/right reflection error was `0.0`. The adverse-force channel changed
`10,008` states relative to the strongest sampled unified policy, with maximum
command difference `3.19213 rad/T^2`, so it is an active bounded feedback
mechanism rather than a comment or scalar-only edit. These checks are algebraic
only; the formal CFD result occurs after this worker exits.
