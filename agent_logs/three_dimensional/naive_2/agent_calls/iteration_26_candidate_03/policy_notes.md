# Corridor-consensus redirect-release candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen rollout contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the top-down mid-plane vorticity and oblique
body/Lambda2 rows of all four combined keyframe sheets, and contrasted them
with the assigned parent's informative `left_domain` rollout. The sampled
captures are self-propelled along the same nearly direct down-left route. They
retain compact, body-connected alternating vorticity streets and localized
paired posterior Lambda2 structures through capture at `15.501--16.027T`;
there is no passive advection, broad-wake loop, collision, wake collapse, or
numerical instability. Peak normalized planar force/moment is only
`0.0342--0.0366 / 0.0173--0.0180`, peak joint angles stay below `39.4 deg`,
and near-rate-limit occupancy is about `17--18%` per joint.

The inherited angle-domain carrier-yaw subtraction is a clean terminal-control
failure: it retains the organized wake and mild loads, passes at `1.10362L`,
then continues to a left-domain exit at `27.654T`. More narrowly, the sampled
set and inherited logs show that posterior-pulse phase selection is not a
reliable robustness mechanism on this carrier. Two byte-identical executions
of the unified response-plus-predicted-miss release both capture, but their raw
constant-course miss at crossing varies from `0.179L` to `0.590L`. The
response-only, pulse-specific release, and always-pulse samples capture with
`0.643--0.652L` raw miss. The assigned parent's carrier-supportive pulse also
captures, but worsens the raw miss to `0.723L`, arrives at `15.740T`, and
slightly worsens score and load scale relative to the best unified execution.
All remain in the compact-wake route class, so this is a steering-completion
distinction rather than a propulsion distinction.

The earlier inherited corridor gate provides the complementary evidence: it
changed an organized-wake `1.10362L` left-exit miss into capture by withholding
shared half-cycle release until body-frame lateral target error was small.
Corrective yaw plus a small instantaneous predicted miss can still describe a
course parallel to, but offset from, the capture corridor. Therefore neither a
carrier-phase pulse gate nor predicted miss alone is a complete terminal
handoff signal.

## Single candidate hypothesis

Preserve the best sampled unified policy's full state-feedback traveling-bend
carrier, far-field pursuit/course blend, constant-course predictor, terminal
mean bend, posterior mid-stroke pulse, response gate, and every evidenced
gain. Change one completion mechanism: allow corrective yaw to release both
rhythmic steering channels only when the bounded predicted miss is centered
and the normalized body-frame lateral target coordinate lies inside the
previously evidenced smooth capture corridor. Outside either geometric
condition, the existing target/course request continues to set steering sign
and both carrier half-cycles remain active.

This combines two compatible residuals rather than tuning a scalar actuator.
It should leave the established far-field route and compact wake unchanged,
behave almost identically on already centered crossings, and prevent premature
release on centered-but-offset approaches. Support requires capture with a
raw terminal miss no worse than the repeated unified `0.179--0.590L` band,
direct routing, peak joint angles below about `40 deg`, near-rate occupancy no
worse than about `18%`, and peak normalized planar force/moment near or below
`0.037/0.019`. Falsify on a miss or left exit, slower arrival without increased
margin, return to the `0.64--0.90L` miss band, route/wake-class change, greater
joint or load occupancy, nonfinite commands, or loss of reflection equivariance.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: preserve rhythmic propulsion while releasing bounded steering authority only after response and residual directional geometry jointly converge
transferable_invariant: corrective response and course centering are insufficient when the course remains laterally outside the target corridor; maneuver release should require both course and position residuals to be small
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific maneuver timing and curvature, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: multiply the existing corrective-yaw and bounded predicted-miss readiness by a smooth gate on normalized body-frame lateral target offset, and use that consensus to release both shared half-cycle asymmetry and the posterior pulse around the unchanged two-joint carrier
falsification: reject if capture margin or termination worsens, or if arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades

## Dry validation only

The configured guidance, lightweight policy-contract, parameter-schema, and
editable-boundary checks pass. A deterministic `17,496`-state grid spanning
normalized body-frame target geometry and velocity, both joint angles and
rates, and yaw response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The corridor-consensus candidate differed from the sampled unified parent by
as much as `9.72060 rad/T^2` on this deliberately broad grid, confirming that
the new completion mechanism is semantically active. These are algebraic
checks only; no CFD was run.

The candidate's CFD evaluation occurs only after this worker exits. Every
rollout outcome above is sampled or inherited prior evidence.
