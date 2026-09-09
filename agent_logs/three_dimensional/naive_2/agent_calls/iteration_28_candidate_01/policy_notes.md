# Terminal duty-skew candidate

## Visual and metric diagnosis before editing

All four sampled rollouts and the inherited course-confirmed rollout satisfy
the frozen-flow contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected each combined
sheet from release through termination, including the top-down mid-plane
vorticity row and oblique body/Lambda2 row. All five fish self-propel on the
same direct down-left route behind a compact alternating wake, with localized
three-dimensional posterior structures and no visible advection, wake breakup,
boundary interaction, or instability. No sampled failure sheet is available;
the weakest finite capture is the visual comparison, while the assigned parent
guidance's `1.01--1.22L` left exits provide the inherited failure boundary.

The unified response-plus-predicted-miss policy remains the strongest sample:
`solver_e0a2513d969f` captures at `15.5008T`, scores `-0.02109`, has distance
integral `1.90236L`, and crosses almost horizontally at
`(-1.286,-0.014)L/T` with about `0.179L` raw head-relative course miss. The
assigned parent's active yaw-arrest transfer also captures and retains the
compact wake and low load class, but arrives at `15.8061T`, scores `-0.02175`,
and crosses laterally at `(-0.774,-1.012)L/T` with about `0.746L` course
miss. Thus instantaneous carrier-separated yaw is not a sufficient reference
for transferred redirect authority.

The other sampled and inherited terminal refinements do not improve this
boundary. Carrier-insensitive terminal direction (`solver_9b34df41b425`) and
a centered-approach amplitude envelope (`solver_6a4dfc32a317`) capture at
`15.7735T/-0.02195` and `15.6738T/-0.02289`, respectively, but both retain a
strong lateral crossing. The inherited course-confirmed release also captures
at `15.8926T/-0.02329`, yet ends at `(-0.721,-1.072)L/T` with roughly
`0.719L` raw course miss. Across these variants the direct route and coherent
wake survive, while release qualification, yaw countersteer, observation
blending, and drive relief do not reproduce the best centered crossing. This
supports preserving the carrier and common response-plus-miss handoff while
testing a different rhythmic steering actuator.

## Single candidate hypothesis

Start from the strongest sampled unified controller, preserving its owned
parameters, far-field pursuit/course blend, constant-course predictor,
carrier-separated response gate, shared geometry/response handoff, terminal
mean bend and posterior pulse, and continuously propulsive two-joint traveling
wave. Add one bounded terminal duty-skew mechanism to the anterior oscillator.
While terminal interception is active, signed target-relative course error and
observed centered joint phase smoothly reduce anterior restoring stiffness on
the requested bend half-cycle and increase it on the opposing half-cycle. The
posterior joint continues to follow the same lagged wave, so the mechanism
changes bend residence time rather than adding static curvature, braking the
carrier, changing pulse release, or copying a clock phase.

The hypothesis is that phase-duration steering supplies course correction
through the lateral terminal crossings without sacrificing the direct route or
compact wake. Support requires capture with arrival and score comparable to
the unified parent and a raw terminal course miss below the repeated
`0.59--0.75L` lateral class, preferably near `0.179L`, while retaining
negligible `>40 deg` dwell and normalized planar force/moment near the sampled
`0.037/0.019` envelope. Falsify on a miss or left exit, a slower lateral
capture without margin improvement, altered far-field translation, wake
decoherence, persistent joint/rate pinning, increased load class, nonfinite
commands, or loss of reflection equivariance. Formal CFD is deferred to EvE;
the new candidate outcome is not evidence in these notes.

bookshelf_consulted: true
source_domain: robotic-fish duty-ratio control and sensor-modulated CPG direction tracking
source_mechanism: steering by changing the relative duration of opposing rhythmic bend half-cycles while retaining an autonomous propulsive carrier
transferable_invariant: bounded task feedback can lengthen the useful curvature half-cycle and shorten the opposing half-cycle without imposing persistent curvature or suppressing the traveling wave
nontransferable_details: published gains and duty ratios, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: use normalized body-frame target-versus-velocity course error and centered anterior joint phase to skew terminal restoring stiffness within the two-joint state-feedback oscillator while leaving posterior lag and the evidenced response-plus-miss handoff intact
falsification: reject if capture margin, direct routing, coherent wake, arrival, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation only

The prescribed guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `11,664`-state grid
over normalized body-frame target geometry and velocity, heading response, and
both joint angles and rates produced finite commands within the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The duty-skew mechanism changed a command by as much as
`1.76060 rad/T^2` relative to the strongest sampled unified parent, while a
far receding state changed by exactly `0.0`, confirming that the mechanism is
active and terminally scheduled rather than a comment or scalar-only edit.
These checks are algebraic only; formal CFD remains deferred to EvE.
