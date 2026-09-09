# Terminal hydrodynamic-moment residual candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm, and
finite `capture` termination. I inspected every combined keyframe sheet from
release to capture, including the top-down mid-plane vorticity and oblique
body/Lambda2 rows. Each fish self-propels on essentially the same direct
down-left route and retains a compact alternating three-dimensional posterior
wake. There is no sampled failure sheet; the weakest-score capture is the
finite comparison and the inherited `1.01--1.22L` left exits remain the
failure boundary. The common carrier and far-field route should stay intact.

The strongest unified response-plus-miss sample, `solver_e0a2513d969f`,
captures at `15.5008T`, scores `-0.02109`, and crosses with only `0.179L` raw
head-relative course miss and velocity `(-1.286,-0.014)L/T`. Its peak
normalized planar force/moment is `0.0365/0.0180`, with no joint dwell beyond
`40 deg`. The prefilled carrier-insensitive terminal request also captures,
but at `15.7735T` and `-0.02195`; its miss widens to `0.682L`, velocity rotates
to `(-1.016,-0.691)L/T`, and joint-angle dwell beyond `40 deg` reaches
`0.418%`. Active yaw-residual arrest is worse in course margin (`0.747L`),
despite zero angle dwell and comparable `0.0351/0.0176` loads.

Two completed inherited tests close the obvious follow-ups. Course-confirmed
release captures at `15.8926T`, scores `-0.02329`, and still crosses strongly
lateral at `(-0.721,-1.072)L/T` with `0.719L` course miss. The sampled `0.75`
minimum-drive amplitude envelope also captures, but at `15.6738T` and
`-0.02289`; terminal speed is `1.300L/T` versus `1.286L/T` for the best sample,
and peak action still reaches the smooth `30 rad/T^2` bound. Thus neither
another terminal request/release qualifier nor mild limit-cycle relief is
supported. Across these policies normalized moment remains bounded near
`0.0174--0.0182`, providing an evidenced physical response scale for a new
feedback channel rather than a reason to change carrier gains.

## Single candidate hypothesis

Start from the strongest sampled unified response-and-predicted-miss policy,
preserving its oscillator, posterior lag and pulse, far-field pursuit/course
blend, predicted-miss geometry, mean bend, and shared response-plus-miss
handoff. Add one bounded wake-disturbance residual to the evidenced shared
half-cycle actuator. Only during a closing terminal intercept, after the
existing yaw-response and small-miss consensus releases route authority, use
the sign of normalized hydrodynamic yaw moment to spend part of the remaining
asymmetry reserve opposing that moment. Full target steering is retained away
from the handoff, and the correction cannot increase total half-cycle
asymmetry beyond the existing route-dependent envelope.

The hypothesis is that physical-moment rejection will arrest the force that
precedes residual terminal rotation without treating beat-sensitive body yaw
as a course reference. Support requires capture with raw terminal course miss
below `0.590L`, preferably near `0.179L`, and arrival/score comparable to the
best unified sample, while the direct route, compact wake, negligible
`>40 deg` dwell, and normalized force/moment scale at or below roughly
`0.037/0.019` survive. Falsify on a miss or left exit, course miss at or above
`0.590L`, slower lateral capture without margin improvement, persistent
command/rate pinning, load growth, wake-route change, nonfinite commands, or
loss of reflection equivariance. Formal CFD is deferred to EvE and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve autonomous rhythmic propulsion and slow geometry steering while a bounded physical-response residual rejects fast adverse yaw dynamics
transferable_invariant: after measured redirect completion, use normalized hydrodynamic response only within unused steering reserve so disturbance rejection cannot erase the propulsive carrier or inflate route authority
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, clock phase, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: retain the two-joint state-feedback carrier and unified response-plus-miss handoff, then use terminal-gated `moment_z_L2` feedback to oppose yaw moment through the shared half-cycle asymmetry while respecting its existing envelope
falsification: reject if capture margin, terminal course, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The prescribed guidance-materiality, parameter-schema, lightweight Julia
policy-contract, and solver editable-boundary checks pass. A deterministic
`18,225`-state grid spanning body-frame target and velocity, both joint angles
and rates, yaw response, and signed hydrodynamic moment produced finite
commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). The moment residual changed at
least one command in `5,616` states and differed from the strongest sampled
parent by as much as `1.89987 rad/T^2`, confirming an active feedback mechanism
rather than a comment or scalar-only edit. These tests are algebraic only;
formal CFD remains deferred to EvE.
