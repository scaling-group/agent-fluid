# Carrier-supportive posterior-pulse candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen rollout contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected both the top-down mid-plane vorticity row and the
oblique body/Lambda2 row of the highest-score capture, the threshold-tight
prefill capture, and the assigned parent's informative `left_domain` failure.
The captures are self-propelled on nearly direct down-left routes. Their
top-down rows retain compact, body-connected alternating vorticity streets and
their oblique rows retain localized paired posterior Lambda2 structures through
capture; there is no passive advection, broad-wake loop, collision, wake
collapse, or numerical instability. The parent's angle-domain carrier-yaw
subtraction also retains organized propulsion, but misses at `1.10362L`,
continues past the target station, and exits left at `27.654T`. It is a terminal
steering failure, not a propulsion or load failure.

The sampled handoff comparison identifies one useful controller distinction.
The raw response/pulse composite, corridor-gated half-cycle release, and
geometry-qualified pulse release capture at `15.921--16.027T` with terminal
raw constant-course miss `0.643--0.746L`. The assigned parent's
actuator-specific corridor/predicted-miss release also captures at `15.854T`
with `0.737L` terminal miss. In contrast, applying the same response-plus-
predicted-miss consensus gate to both rhythmic steering channels captures at
`15.501T` with only `0.179L` raw terminal miss. It preserves zero joint dwell
at or beyond `40 deg`, `38.4/39.3 deg` peak joint angles, `17.8/17.0%`
near-rate-limit occupancy, and peak normalized planar force/moment of
`0.0365/0.0180`. The combined sheets likewise preserve the direct compact-wake
class. This is stronger evidence for a shared geometric completion signal than
for mixing a lateral corridor on one actuator with predicted miss on the other,
although one capture does not establish repeatability.

## Single candidate hypothesis

Use the best sampled unified response-and-predicted-miss handoff as the parent
architecture, preserving its full state-feedback traveling-bend carrier,
far-field pursuit/course blend, constant-course predictor, terminal mean bend,
shared half-cycle asymmetry, and all evidenced gains. Change one actuator
mechanism: make the bounded posterior mid-stroke pulse carrier-phase selective.
Compute the posterior acceleration of the unpulsed carrier, normalize it by the
action envelope, and smoothly admit the terminal pulse only on the half-cycle
whose carrier acceleration agrees with the requested turn. The base posterior
carrier and shared steering remain active on both half-cycles; this removes only
the portion of the pulse that would oppose the established traveling bend.

The hypothesis is that phase agreement will keep the terminal redirect from
braking the posterior wave on the wrong half-cycle, retaining the unified
candidate's centered intercept while reducing beat-phase sensitivity at the
`0.75L` crossing. Support requires capture with the direct compact-wake route,
terminal predicted miss near or below the sampled `0.179L`, no slower arrival
without compensating margin, no `>=40 deg` dwell, and normalized planar
force/moment near or below `0.037/0.019`. Falsify on a miss or left exit, a
return to the `0.64--0.75L` terminal-miss band, route or wake-class change,
greater joint/load occupancy, nonfinite commands, or loss of reflection
equivariance.

bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric-flapping control and biological redirect-to-cruise transitions
source_mechanism: add bounded steering asymmetry around a preserved propulsive rhythm and release maneuver authority as target-relative response converges
transferable_invariant: a posterior redirect should reinforce the requested-side carrier half-cycle rather than oppose both halves of the traveling bend
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific kinematics and maneuver timing, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: normalize the unpulsed posterior carrier acceleration by the two-joint action envelope and use its sign agreement with the body-frame terminal request to gate only the posterior pulse; retain the unified predicted-miss handoff and state-feedback carrier
falsification: reject if capture margin or termination worsens, or if arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades

## Dry validation only

The lightweight policy contract and editable-boundary checks pass. A
deterministic `58,320`-state grid spanning normalized body-frame target
geometry and velocity, both joint angles and rates, and yaw response produced
finite commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). The new carrier-phase gate changed
posterior acceleration by as much as `6.26798 rad/T^2` relative to the sampled
unified parent on that grid, confirming that the mechanism is active. These are
algebraic checks only; no CFD was run.

The candidate's CFD evaluation occurs only after this worker exits. Every
rollout result above is sampled or inherited prior evidence.
