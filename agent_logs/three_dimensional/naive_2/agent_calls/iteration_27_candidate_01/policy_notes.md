# Course-confirmed redirect-release candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected every combined sheet from release through capture,
including both the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The four fish self-propel along the same nearly direct
down-left route; each leaves a compact alternating wake connected to the
posterior body, with localized three-dimensional tail structures and no wake
collapse or visible passive advection. The weakest sampled capture is therefore
an informative terminal-control comparison rather than a propulsion failure.

The unified response-and-predicted-miss controller is the strongest sample:
`solver_e0a2513d969f` captures at `15.5008T`, scores `-0.02109`, and crosses
with head-relative raw course miss `0.179L` and velocity
`(-1.286,-0.014)L/T`. Its normalized peak planar force/moment is
`0.0365/0.0180`, and neither joint dwells beyond `40 deg`. The prefilled
carrier-insensitive request blend also captures, but later at `15.7735T`; it
crosses with about `0.682L` raw course miss, velocity
`(-1.016,-0.691)L/T`, and `0.418%` joint-angle dwell beyond `40 deg`.
Geometry-qualified pulse release is slower again (`16.0270T`, score
`-0.02335`) and crosses with about `0.643L` raw course miss, despite similarly
compact wake and low `0.0348/0.0175` peak normalized force/moment.

The assigned parent's active redirect-to-cruise yaw arrest is now sampled in
`solver_1900be936beb`. It preserves capture, zero `>40 deg` dwell, the direct
route, compact wake, and low `0.0351/0.0176` normalized peak force/moment, so
the actuator transfer is physically compatible. It does not improve the
claimed boundary: arrival slows to `15.8061T`, score worsens to `-0.02175`,
velocity rotates to `(-0.774,-1.012)L/T`, and raw head-relative terminal course
miss widens to about `0.746L`. Thus transferring released authority directly
to instantaneous carrier-separated yaw countersteer is a concrete negative
result. Residual body yaw is not a sufficient redirect-completion reference;
the target-relative course must remain in the consensus.

## Single candidate hypothesis

Use the strongest sampled unified response-and-predicted-miss controller as
the parent architecture, preserving every owned gain, its joint-state
traveling-bend carrier, pursuit/course blend, constant-course predictor,
bounded mean bend, posterior mid-stroke pulse, and shared response-plus-miss
handoff. Change one feedback mechanism only. Multiply the existing release
consensus by a smooth course-alignment gate formed from the sine magnitude of
the bounded angle between body-frame target and translational velocity. A
corrective yaw and small perpendicular miss may then release redirect
authority only when actual target-relative travel is also aligned; otherwise
the evidenced rhythmic target steering remains active. This adds no gain,
clock, world coordinate, route, static curvature, or carrier braking.

The hypothesis is that course-confirmed release preserves the direct compact-
wake capture while preventing the `0.643--0.746L` lateral terminal crossings
seen when yaw response or miss alone can complete the handoff. Support requires
capture with raw terminal course miss below `0.590L`, preferably near the
`0.179L` best sample, with arrival/score comparable to the unified parent,
zero or negligible `>40 deg` dwell, and normalized peak planar force/moment no
higher than about `0.037/0.019`. Falsify on a miss or left exit, terminal miss
at or above `0.590L`, slower or more lateral crossing without a margin gain,
persistent steering/rate pinning, wake-route change, nonfinite commands, or
loss of reflection equivariance. The new CFD outcome is deferred to EvE and
is not evidence in these notes.

bookshelf_consulted: true
source_domain: biological burst-redirect transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: strong rhythmic steering returns to cruise only after sensed directional response confirms maneuver completion
transferable_invariant: redirect release should require agreement between corrective body response and target-relative course, because removing or reversing steering on body yaw alone can preserve residual lateral travel
nontransferable_details: published gains, robot linkage geometry, species-specific maneuver timing and curvature, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: multiply the existing response-plus-predicted-miss release by a reflection-equivariant alignment gate computed from normalized body-frame target and velocity, while retaining the two-joint traveling carrier and rhythmic steering actuator
falsification: reject if capture, terminal course margin, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation only

The prescribed guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `77,760`-state grid
over normalized body-frame target geometry and velocity, heading response, and
both joint angles and rates produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The course-confirmed release changed a command by as much as
`9.20671 rad/T^2` relative to the strongest sampled unified parent, confirming
that it is an active feedback mechanism rather than a comment or scalar-gain
edit. These checks are algebraic only; formal CFD remains deferred to EvE.
