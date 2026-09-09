# Terminal relative-flow pulse handoff candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected every combined keyframe sheet from release through
capture, including the top-down mid-plane vorticity row and oblique
body/Lambda2 row, and also inspected the assigned parent's evaluated
hydrodynamic-moment candidate. Every fish self-propels on essentially the same
direct down-left route behind a compact, body-connected alternating wake with
localized three-dimensional posterior structures. There is no sampled failure
sheet; the weakest finite capture is the visual comparison, while the inherited
`1.01--1.22L` left exits remain the semantic failure boundary. The carrier,
far-field route, and common response-plus-miss handoff should remain intact.

The new target-line-rate sample `solver_f792c48d0852` has the best scalar score
(`-0.0196486`) and lowest normalized distance integral (`1.90130L`), but it
does not establish the proposed terminal-margin improvement. It captures at
`15.6893T`, later than the unified sample's `15.5008T`, and crosses at
`(-1.112,-0.671)L/T` with `0.674L` raw head-relative predicted miss rather
than the unified sample's nearly horizontal `(-1.286,-0.014)L/T` crossing and
`0.179L` miss. Thus transferring released shared half-cycle authority to
target-line rate improves one scalar without escaping the inherited lateral
`0.59--0.75L` crossing class.

The prefilled terminal duty-skew policy likewise captures but arrives at
`15.9148T`, scores `-0.0223101`, crosses at `(-0.711,-1.038)L/T` with
`0.717L` predicted miss, and restores `0.138%` posterior joint dwell beyond
`40 deg`. The assigned parent's hydrodynamic-moment residual is now a completed
negative result: it captures at `15.9383T/-0.0230331`, has `0.736L` terminal
miss and `0.173%` posterior angle dwell, and raises peak normalized planar
force to `0.03746` without improving the roughly `0.0181` moment class.
Together with active yaw arrest (`0.747L` miss), these results reject further
terminal request, moment, yaw, duty-skew, or scalar-gain refinement on the
shared half-cycle actuator.

The trajectory evidence does expose a distinct physical response at capture.
Projected target-normal relative flow is about `-0.288U` in the centered
unified sample, versus `-1.145U` for target-line-rate steering, `-1.186U` for
duty skew, `-1.195U` for moment rejection, and `-1.252U` for yaw arrest. This
is not causal proof and is partly the kinematic counterpart of lateral travel,
but it supplies an observed normalized scale for a different actuator test:
retain target-relative route steering and use relative flow only after the
existing geometry/response consensus says the redirect is being released.

## Single candidate hypothesis

Start from `solver_e0a2513d969f`, the strongest semantically replicated unified
response-and-predicted-miss controller. Preserve its state-feedback traveling
carrier, posterior lag, pursuit/course blend, constant-course predictor,
terminal mean bend, shared response-plus-miss release, all far-field behavior,
and existing pulse envelope. Change one mechanism in the posterior wave-shape
actuator: as the consensus releases the target-turn pulse, transfer that same
bounded pulse share to opposition of target-normal relative flow. The request
uses the cross product of normalized body-frame target and relative-flow
vectors, so it is target-relative and reflection-equivariant; release and
unmet-release shares sum through one pulse envelope, so the mechanism cannot
add posterior pulse authority or erase the continuously propulsive carrier.

The hypothesis is that posterior relative-flow rejection will oppose residual
lateral translation after redirect completion without using beat-sensitive
body yaw, instantaneous hydrodynamic moment, or another shared-asymmetry
handoff. Support requires capture with raw terminal course miss below the
replicated `0.590L` boundary, preferably near `0.179L`, and arrival/score
comparable to the unified sample, while preserving the direct compact-wake
route, negligible `>40 deg` dwell, near-rate occupancy near the sampled class,
and peak normalized planar force/moment at or below roughly `0.037/0.019`.
Falsify on a miss or left exit, a `>=0.590L` lateral crossing, slower arrival
without margin improvement, altered far-field translation, wake decoherence,
joint/load growth, nonfinite output, or loss of reflection equivariance. CFD
is deferred to EvE and is not claimed as current-worker evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve autonomous rhythmic propulsion and slow route steering while a bounded physical-flow residual modulates an existing posterior wave-shape channel
transferable_invariant: after measured redirect completion, oppose only target-normal relative flow within already available rhythmic authority so disturbance rejection cannot erase propulsion or enlarge steering authority
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, clock phase, dimensional frequency, exact vortex phase, task coordinates, capture pose, and fixed routes
policy_translation: retain the two-joint state-feedback carrier and unified response-plus-miss handoff, then transfer the released share of the existing posterior pulse from target-turn request to normalized body-frame target-normal relative-flow rejection
falsification: reject if capture margin, terminal course, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The configured independent check runner reports PASS for guidance materiality
and parameter schema, the lightweight Julia policy contract, and the solver
editable-file boundary. A separate deterministic `209,952`-state grid over
normalized body-frame target, velocity, relative flow, heading response, and
both joint states produced finite commands inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The relative-flow handoff changed `81,648` terminal grid states relative to the
unified parent, by at most `6.82569 rad/T^2`, while opposite relative-flow
states on a far, receding route changed by exactly `0.0`. These are algebraic
and repository checks only; formal CFD remains deferred to EvE.
