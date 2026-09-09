# Phase-decomposed redirect-reserve candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
no prewarm, finite dynamics, and capture termination. I inspected the combined
keyframe sheets for the score-leading tail-only residual
`solver_e749afa61520` and the assigned parent `solver_acc3a9086425`, including
the top-down vorticity and oblique body/Lambda2 rows from release through
capture. Both are visibly self-propelled along the same direct down-left route,
with a compact alternating mid-plane wake and a sparse body-connected 3D vortex
train. Neither shows passive advection, wake breakup, boundary interaction, or
an initialization artifact. The parent and leader are visually nearly
indistinguishable, so the current problem is terminal allocation quality rather
than propulsion or route topology. There is no semantic failure among the four
current sheets; the parent is the informative quality failure against its own
reserve hypothesis.

The trajectory and trace diagnostics falsify the parent's one-step
`previous_action` phase proxy. It still captures at `15.2107T` with score
`-0.01708`, but its head-relative constant-course miss is `0.631L`, posterior
`>40 deg` dwell rises to `1.878%`, and peak normalized planar force/moment is
`0.03930/0.01922`. That misses the inherited acceptance boundary of at most
`0.461L` miss and less than `0.681%` posterior dwell. The sampled absolute
dual-reserve and residual-direction allocators remain better compromises:
`solver_db935956483b` captures at `15.2957T` with `0.556L` miss,
`0/0.898%` anterior/posterior dwell, and `0.03872/0.01876` peak loads;
`solver_c4ca102cc4ad` captures at `15.3385T` with `0.461L` miss,
`0/0.681%` dwell, and `0.03959/0.01889` peak loads. The score-leading
tail-only residual arrives at `15.1403T/-0.01094` but has `0.651L` miss,
`1.269%` posterior dwell, and `0.04041/0.01902` loads.

The sampled optimizer log adds a useful boundary. Receiver-safe spillover
`solver_3f9023504354` eliminates all `>40 deg` dwell and retains capture at
`15.2823T`, but its miss remains `0.516L`, score is `-0.01727`, and loads are
`0.03988/0.01906`. Shedding unavailable authority therefore protects joint
quality, but neither receiver gating nor the delayed carrier-direction proxy
establishes a centered, low-dwell terminal course. A previous bounded action
contains prior steering and is delayed by one control update; more importantly,
gating the entire residual by carrier direction discards the safe half-cycle
where the redirect opposes and weakens the carrier.

## Single candidate hypothesis

Preserve the evidenced state-feedback oscillator, posterior lag and pulse,
normalized body-frame pursuit/course blend, constant-course predictor, shared
response-plus-miss handoff, cubic redirect magnitude, and smooth acceleration
envelope. Change one mechanism: decompose each joint's redirect by its
contemporaneous analytic carrier phase. When redirect and carrier oppose, keep
the residual because it suppresses rather than amplifies that carrier
half-cycle. When they align, admit the amplifying residual only through signed
angle/rate reserve. Excluded tail authority may reach the head under the same
rule; authority that neither joint can accept is shed. This uses current joint
state rather than a delayed action proxy and remains continuous through carrier
reversal, reflection equivariant, clock-free, and route-free.

Support requires capture with a direct compact wake, no anterior `>40 deg`
dwell, posterior dwell no worse than the directional allocator's `0.681%`,
terminal course miss at or below `0.461L`, peak normalized planar force/moment
within about `0.040/0.019`, and arrival in the sampled `15.14--15.34T` class.
Falsify on lost capture, wider miss, higher dwell/load class, delayed arrival
without a joint-quality improvement, altered far-field translation, nonfinite
commands, or loss of exact reflection equivariance. The new CFD outcome is
unavailable to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping turning and sensor-modulated CPG control
source_mechanism: preserve a traveling propulsive oscillator while steering through bounded half-cycle asymmetry and sensed actuator-state release
transferable_invariant: distinguish carrier-suppressing steering from carrier-amplifying steering, preserving the former while reserve-gating the latter
nontransferable_details: published gains, dimensional beat frequency, hardware duty ratios, linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: use normalized body-frame predicted miss for redirect sign and the current two-joint analytic carrier plus angle/rate state to retain braking half-cycles and reserve-gate only amplifying half-cycles
falsification: reject if capture margin, arrival, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality, lightweight Julia policy-contract, and
solver editable-boundary checks pass without CFD. A deterministic `37,500`
state grid spanning normalized target/course geometry and both joint angles and
rates produced finite commands inside the owned `30 rad/T^2` envelope, with
exact left/right reflection (maximum error `0.0`). The phase-decomposed policy
changed `20,694` grid states relative to the assigned parent and `14,061`
relative to residual-direction allocation, confirming an active feedback
mechanism rather than a comment or scalar-only change. These algebraic results
do not establish capture, wake, load, or joint-history improvement; those
remain falsifiable in the downstream formal evaluation.
