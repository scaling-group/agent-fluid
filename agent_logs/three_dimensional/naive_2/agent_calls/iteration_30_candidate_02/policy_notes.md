# Persistent target-line consensus candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected each
combined keyframe sheet from release through capture, including both the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. All four
fish self-propel along essentially the same direct down-left route while
retaining a compact alternating three-dimensional wake connected to the
posterior body. The views do not support changing the carrier, far-field
route, or wake interaction. There is no sampled failure sheet; the weakest
finite capture is the visual comparator, and the inherited `1.01--1.22L`
left exits remain the semantic failure boundary.

The unified response-plus-predicted-miss controller
`solver_e0a2513d969f` remains the best terminal-course sample. It captures at
`15.5008T`, scores `-0.02109`, has distance integral `1.90236L`, and crosses
with velocity `(-1.286,-0.014)L/T` and raw predicted course miss `0.179L`.
The duty-skew and active-yaw-arrest samples preserve the route and capture but
cross later with `0.717L` and `0.747L` predicted misses. The assigned parent's
target-line-rate transfer `solver_f792c48d0852` obtains the best scalar score
`-0.01965` and lowest distance integral `1.90130L`, but it does not improve
terminal margin: it crosses at `15.6893T` with velocity
`(-1.112,-0.671)L/T`, `0.674L` predicted miss, and absolute instantaneous
target-line rate `1.562/T`. Thus the parent's new dynamic signal is active and
useful enough to retain as a hypothesis, but transferring every instantaneous
sample into rhythmic steering is a concrete negative terminal result.

The earlier claim that instantaneous target-line rate cleanly separates the
centered capture is not robust to carrier phase. At the final centered sample,
absolute rate from target/velocity is `0.411/T`, whereas the inertial rate from
the eight-observation bearing-plus-turn window is `1.761/T`. Across the whole
`distance<3L` interval, the two rate estimates agree in sign only `41.4%` of
the centered rollout, compared with `49.4--62.9%` for the three wider-course
captures. The low centered terminal snapshot is therefore phase-contingent,
not evidence that a scalar line-rate threshold is causal. The reusable
comparison must use the near-field history, not one termination row.

## Single candidate hypothesis

Start from the evidenced unified controller and preserve its owned carrier,
posterior lag and pulse, far-field pursuit/course blend, predicted-miss
geometry, bounded mean bend, and response-plus-miss release. Retain the
assigned parent's idea of transferring only already-released rhythmic
authority to target-relative steering, but require a smooth persistence
consensus between two independent normalized body-frame estimates: the
instantaneous inertial target-line rate from target and velocity, and the
windowed inertial rate from bearing-window rate plus recent body turn rate.
Opposite-sign estimates smoothly remove the transferred correction; agreeing
estimates produce a bounded request without enlarging the inherited
half-cycle-asymmetry envelope. This is an observation/feedback mechanism, not
a carrier-gain or line-rate-threshold change.

The hypothesis is that carrier-phase disagreement caused the parent's
instantaneous target-line feedback to re-steer a geometry-ready intercept.
Persistence consensus should remain mostly inactive on the centered near-field
history while acting on sustained tangential rotation, retaining the direct
compact-wake capture and the parent's distance-integral benefit without its
large terminal miss. Support requires capture with raw course miss below the
parent's `0.674L` and preferably below the inherited semantic replicate's
`0.590L`, arrival and score comparable to the `15.50--15.69T` and
`-0.02109---0.01965` samples, negligible `>40 deg` dwell, near-rate occupancy
near the inherited `18%` class, and normalized peak planar force/moment at or
below about `0.037/0.019`. Falsify on a miss or left exit, course miss at or
above `0.674L`, slower lateral capture without margin improvement, a changed
far-field route, wake decoherence, a higher joint/load class, nonfinite
commands, or loss of reflection equivariance. Formal CFD remains deferred to
EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: wake-adaptive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate slow or persistent route error from fast alternating carrier-scale yaw and crossflow before modulating a bounded rhythmic steering channel
transferable_invariant: an autonomous propulsive carrier should respond to a target-relative dynamic error only when independent state observations show that the error persists beyond contradictory beat-scale motion
nontransferable_details: published gains, dimensional frequencies, source history windows, robot linkage geometry, species-specific kinematics, exact vortex phase, task coordinates, capture routes, and source-task waypoints
policy_translation: combine instantaneous target/velocity line rate with windowed bearing-plus-turn line rate in the normalized body frame, then transfer only the already-released shared half-cycle authority through their smooth signed consensus while preserving the two-joint carrier
falsification: reject if capture margin, terminal course, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality/parameter-schema, lightweight Julia policy
contract, and solver editable-boundary checks pass. A deterministic `46,656`
state grid over normalized body-frame target geometry and velocity, windowed
target-line motion, heading response, and both joint angles and rates produced
finite commands strictly within the smooth `30 rad/T^2` envelope. Exact
left/right reflection error was `0.0`. The persistence channel changed
`11,232` states relative to the sampled unified controller, with maximum
command difference `3.17837 rad/T^2`, so it is an active observation/feedback
mechanism rather than a comment or scalar-only edit. These are algebraic checks
only; formal CFD remains deferred to EvE.
