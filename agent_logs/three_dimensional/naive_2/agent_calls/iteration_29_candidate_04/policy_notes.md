# Terminal posterior phase-lag modulation candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the combined sheets from release to capture for the
best finite sample and the weakest-score finite comparison, including both the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. Both fish
self-propel on the same direct down-left route behind a compact alternating
wake, with localized posterior three-dimensional structures and no visible
advection, wake breakup, boundary interaction, or instability. No sampled
failure sheet is available; the assigned parent guidance's `1.01--1.22L`
left-domain misses remain the inherited semantic-failure boundary.

The unified response-plus-predicted-miss policy in `solver_e0a2513d969f`
remains the strongest sample. It captures at `15.5008T`, scores `-0.02109`,
has distance integral `1.90236L`, and crosses with velocity
`(-1.286,-0.014)L/T` and only `0.179L` raw head-relative constant-course
miss. Its peak normalized planar force/moment is `0.0365/0.0180`, neither
joint dwells beyond `40 deg`, and the compact wake remains attached to the
productive route.

The assigned prefill's released-authority yaw arrest also captures, but at
`15.8061T/-0.02175` with velocity `(-0.774,-1.012)L/T` and `0.747L` raw
course miss. The newly sampled anterior duty-skew candidate preserves the same
route and wake yet arrives later again at `15.9148T/-0.02231`, crosses at
`(-0.711,-1.038)L/T` with `0.717L` miss, and introduces `0.138%` posterior
joint dwell beyond `40 deg`. The sampled centered-drive envelope likewise
retains a `0.679L` miss. In the inherited logs, terminal hydrodynamic-moment
rejection captures at `15.9383T/-0.02303` but still has `0.736L` miss and
slightly raises peak normalized planar force to `0.0375`. Thus yaw arrest,
release qualification, weak drive relief, anterior half-cycle timing, and
instantaneous moment rejection all preserve propulsion but reproduce the
lateral terminal class; another gate or scalar change is not supported.

## Single candidate hypothesis

Start from the strongest sampled unified controller, preserving every owned
carrier, route, prediction, mean-bend, posterior-pulse, and shared
response-plus-miss handoff parameter. Add one bounded posterior wave-shape
mechanism. During an active terminal intercept, multiply the existing
posterior lag coefficient by a small reflection-even modulation formed from
signed target-relative course error and centered anterior joint phase. This
increases posterior lag on one requested bend half-cycle and decreases it on
the other, while the anterior state-feedback oscillator, posterior restoring
dynamics, and response-plus-geometry release remain unchanged. The existing
course-share handoff fades the modulation toward the base traveling wave; no
clock, world coordinate, fixed route, static curvature, or carrier braking is
introduced.

The hypothesis is that posterior phase-lag steering can correct the repeated
`0.68--0.75L` lateral crossings without repeating the ineffective anterior
stiffness duty-skew or phase-selective pulse gate. Support requires capture
with raw terminal course miss below `0.590L`, preferably near the `0.179L`
best sample, arrival and score comparable to the unified parent, a direct
compact-wake route, negligible `>40 deg` dwell, and normalized peak planar
force/moment no higher than roughly `0.037/0.019`. Falsify on a miss or left
exit, a slower lateral capture without margin gain, wake-route change,
persistent joint/rate pinning, increased load class, nonfinite commands, or
loss of reflection equivariance. The new CFD evaluation occurs only after
this worker exits and is not evidence here.

bookshelf_consulted: true
source_domain: robotic-fish CPG phase-lag modulation and classical traveling-wave propulsion
source_mechanism: steer by changing posterior phase lag across opposing bend half-cycles while retaining an autonomous anterior oscillator and posterior traveling-wave emphasis
transferable_invariant: bounded target feedback may reshape posterior wave timing without imposing persistent curvature or suppressing the propulsive carrier
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, clock phase, exact vortex phase, task coordinates, and fixed routes
policy_translation: use normalized body-frame target-versus-velocity course error and centered anterior joint phase to modulate the posterior lag coefficient within the two-joint state-feedback carrier, faded by the existing response-plus-miss handoff
falsification: reject if capture margin, terminal course, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation only

The prescribed guidance-materiality, Julia policy-contract/schema, and solver
editable-boundary checks pass. A deterministic `26,244`-state grid spanning
body-frame target geometry and velocity, carrier-separated heading response,
and both joint angles and rates produced finite commands strictly inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`). Setting only the new lag-modulation fraction to zero changed a command
by as much as `9.23730 rad/T^2`, confirming that the posterior wave-shape
mechanism is active. These checks are algebraic only; formal CFD remains
deferred to EvE.
