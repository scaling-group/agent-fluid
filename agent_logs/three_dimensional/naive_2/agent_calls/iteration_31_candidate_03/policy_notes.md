# Carrier-separated force-deficit candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected each combined keyframe sheet from release through
capture, including the top-down mid-plane vorticity row and oblique
body/Lambda2 row. All four fish self-propel along essentially the same direct
down-left route and retain a compact alternating three-dimensional wake
connected to the posterior body. There is no sampled failure sheet, so the
weakest finite capture is the visual comparator and the inherited identical-
controller `1.01--1.22L` left exits remain the semantic failure boundary. The
views do not support changing the carrier, far-field route, or wake structure.

The unified response-plus-predicted-miss controller
`solver_e0a2513d969f` is still the strongest terminal-course sample. It
captures at `15.5008T`, scores `-0.02109`, and crosses with velocity
`(-1.286,-0.014)L/T` and raw head-relative predicted miss `0.179L`, with
peak normalized planar force/moment `0.03653/0.01801`. The three sampled
target-line-rate mechanisms retain capture and the same compact wake but do
not improve that margin. Direct target-line-rate steering
`solver_f792c48d0852` gives the best scalar score `-0.01965` yet crosses at
`15.6893T` with `0.674L` predicted miss. Persistent instantaneous/windowed
line-rate consensus `solver_8600d052eff8` crosses at `15.7829T` with
`0.747L` miss, while posterior phase-lag modulation
`solver_dc562b1ee0c2` crosses at `15.7509T` with `0.727L` miss and the
weakest score `-0.02201`. Their peak normalized force/moment remains in the
narrow `0.03553--0.03705/0.01740--0.01833` class. Thus routing, wake, and
load quality survive, but line-rate request, persistence filtering, and
actuator remapping all preserve the wider tangential crossing; another
line-rate scalar, consensus gate, or phase-lag translation is not supported.

The sampled force histories expose a different response variable. In the
`distance<3L` interval, a least-squares joint-rate carrier model for normalized
body-lateral force is stable across all four policies:
`force_y ~= (0.00140--0.00163)phi_dot_1 -
(0.00364--0.00382)phi_dot_2`. The residual RMS is
`0.00660--0.00701`; inside `1L` it is `0.00433--0.00518`. More importantly,
the carrier-separated residual has the requested turn sign for `79.5%` of the
centered capture's `distance<1L` samples, versus only `52.5--62.5%` in the
three wider-course captures. This does not prove that force feedback will
improve capture, but it supplies an evidenced hydrodynamic response and scale
instead of treating a carrier-phase termination snapshot as causal.

## Single candidate hypothesis

Start from the unified sampled controller and preserve its state-feedback
traveling carrier, posterior lag and pulse, pursuit/course blend, predicted-
miss geometry, bounded mean bend, and response-plus-miss handoff. Add one
bounded force-deficit mechanism to the shared rhythmic redirect only. Subtract
the evidenced two-joint-rate carrier estimate from normalized body-lateral
force. When the residual force opposes the current terminal turn request,
smoothly re-engage a portion of the rhythmic authority that the common handoff
had released; when force is absent or already corrective, leave the unified
handoff unchanged. The mechanism never enlarges the inherited asymmetry
envelope, changes carrier drive, adds static curvature, commands from force
alone, or acts outside a closing terminal intercept.

The hypothesis is that a hydrodynamic response deficit, rather than another
kinematic line-rate command, can correct wider-course realizations while
remaining mostly inactive on the evidenced centered response. Support requires
capture with raw terminal predicted miss below the sampled `0.674--0.747L`
line-rate class, preferably below the inherited `0.590L` replicate boundary,
and arrival/score comparable to `15.50--15.78T` and
`-0.02201---0.01965`. The direct route, compact wake, negligible `>40 deg`
dwell, near-rate occupancy near the inherited `18%` class, and normalized peak
planar force/moment at or below about `0.038/0.019` must survive. Falsify on a
miss or left exit, a slower lateral capture without margin improvement,
far-field action, wake decoherence, force-chasing oscillation, a higher joint
or load class, nonfinite commands, or loss of reflection equivariance. Formal
CFD is deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: wake-adaptive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate carrier-scale hydrodynamic loading from persistent corrective response before modulating a bounded rhythmic steering channel
transferable_invariant: retain an autonomous propulsive carrier and use only the carrier-separated deficit of a sensed physical response to re-engage target-directed steering
nontransferable_details: published gains, dimensional frequencies, source force scales, robot linkage geometry, species-specific kinematics, exact vortex phase, task coordinates, capture routes, and source-task waypoints
policy_translation: subtract an evidence-fitted two-joint-rate carrier model from normalized body-lateral force, then use wrong-sign residual force only to re-engage already-released shared half-cycle target steering in a closing terminal intercept
falsification: reject if capture margin, terminal course, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality/parameter-schema, lightweight Julia policy
contract, and solver editable-boundary checks pass. A deterministic `486,000`
state grid over normalized target geometry and velocity, lateral force, heading
response, and both joint angles and rates produced finite commands strictly
inside the smooth `30 rad/T^2` envelope. Exact left/right reflection error was
`0.0`. The force-deficit channel changed `78,252` states relative to the
sampled unified controller, with maximum command difference
`3.40477 rad/T^2`, so it is an active observation/feedback mechanism rather
than a comment or scalar-only edit. These are algebraic checks only; formal CFD
remains deferred to EvE.
