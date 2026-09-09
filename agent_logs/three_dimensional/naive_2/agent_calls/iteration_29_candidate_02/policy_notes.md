# Terminal hydrodynamic-moment rejection candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected every combined sheet from release through capture,
including the top-down mid-plane vorticity row and the oblique body/Lambda2
row. Each fish self-propels on the same nearly direct down-left route and leaves
a compact alternating wake attached to the posterior body, with localized
three-dimensional tail structures. There is no visible passive advection,
wake collapse, boundary interaction, or instability. Because every sampled
rollout captures, the weakest finite trajectory is the useful visual contrast
and the inherited `1.01--1.22L` left exits remain the failure boundary.

The unified response-plus-predicted-miss sample `solver_e0a2513d969f` remains
the strongest: it captures at `15.5008T`, scores `-0.02109`, and crosses with
nearly horizontal `(-1.286,-0.014)L/T` velocity and about `0.179L` raw
head-relative constant-course miss. Its normalized peak planar force/moment is
`0.0365/0.0180`, with no joint-angle dwell beyond `40 deg`. The sampled
terminal amplitude envelope preserves capture but arrives at `15.6738T`,
scores `-0.02289`, and retains a `0.679L` raw miss with lateral
`(-1.128,-0.647)L/T` velocity. Active residual-yaw arrest is worse at
`15.8061T/-0.02175`, `0.747L`, and `(-0.774,-1.012)L/T`.

The prefilled duty-skew mechanism is also a concrete negative result. It keeps
the direct compact-wake route and captures, but arrives latest at `15.9148T`,
scores `-0.02231`, crosses with `(-0.711,-1.038)L/T` velocity and `0.717L`
raw course miss, and adds `0.138%` posterior-joint dwell beyond `40 deg`.
Thus skewing anterior bend residence time does not correct the repeated lateral
terminal class. Across all four samples, normalized peak yaw moment remains in
a narrow `0.0176--0.0182` band while peak action reaches the smooth
`30 rad/T^2` envelope and near-rate occupancy remains about `14--15%` per
joint. The carrier and route should be preserved; neither more carrier drive,
amplitude relief, instantaneous-yaw countersteer, nor phase-duration steering
is supported as the next robustness mechanism.

The assigned parent's physical-moment residual is an inherited, dry-validated
hypothesis rather than evaluated evidence. It remains distinct after the new
duty-skew result because it changes the feedback signal and actuator handoff,
not a carrier scalar. It also uses the only newly proposed response scale that
the sampled histories directly bound.

## Single candidate hypothesis

Start from the strongest sampled unified response-and-predicted-miss policy,
preserving every owned carrier gain, the far-field pursuit/course blend,
constant-course predictor, terminal mean bend and posterior pulse, and the
shared response-plus-miss release. Add one bounded physical-response residual
to the evidenced shared half-cycle actuator. Only during a closing terminal
intercept, after corrective carrier-separated yaw and small predicted miss
jointly release route authority, use normalized hydrodynamic yaw moment to
spend at most half of the otherwise-unused asymmetry reserve opposing that
moment. Full target steering remains outside the handoff, and the residual
cannot enlarge the existing route-dependent asymmetry envelope.

The hypothesis is that moment rejection arrests the physical load driving
terminal rotation without treating beat-sensitive yaw, joint phase, or static
curvature as a course reference. Support requires capture with raw terminal
course miss below the repeated `0.59--0.75L` lateral class, preferably near the
`0.179L` best sample, and arrival/score comparable to the unified parent while
the direct route, compact wake, negligible `>40 deg` dwell, and normalized
force/moment scale at or below roughly `0.037/0.019` survive. Falsify on a miss
or left exit, course miss at or above `0.590L`, slower lateral capture without
margin improvement, persistent command/rate pinning, load growth, wake-route
change, nonfinite commands, or loss of reflection equivariance. Formal CFD is
deferred to EvE and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve autonomous rhythmic propulsion and slow geometry steering while a bounded physical-response residual rejects adverse yaw dynamics
transferable_invariant: use normalized hydrodynamic response only within released steering reserve so disturbance rejection cannot erase the propulsive carrier or inflate route authority
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, clock phase, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: retain the normalized body-frame unified controller and use terminal-gated `moment_z_L2` feedback to oppose yaw moment through reserved shared half-cycle asymmetry under the two-joint state-feedback contract
falsification: reject if capture margin, terminal course, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Validation boundary

The prescribed lightweight policy contract passes. A separate deterministic
`17,496`-state grid over normalized body-frame target geometry and velocity,
heading response, hydrodynamic yaw moment, and both joint angles and rates
produced finite commands strictly inside the smooth `30 rad/T^2` envelope with
exact left/right reflection (maximum error `0.0`). The moment residual was
active in `4,752` states and changed a command by as much as
`1.14991 rad/T^2` relative to the strongest evaluated unified parent, so this
is an active feedback mechanism rather than a comment or scalar-only edit.
These checks are algebraic only. The formal CFD outcome occurs after this
worker exits and must be treated as evidence only by a later worker.
