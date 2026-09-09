# Actuator-specific terminal-consensus candidate

## Visual and metric diagnosis before editing

All four sampled solver evaluations satisfy the frozen evidence contract:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm. I inspected both the top-down mid-plane vorticity
row and oblique body/Lambda2 row of every combined keyframe sheet. The four
policies are self-propelled along nearly identical direct down-left routes.
They retain compact body-connected alternating wakes and localized posterior
three-dimensional structures through capture at `15.921--16.027T`; there is
no visible broad-wake loop, passive advection, wake collapse, or instability.
The different capture poses are primarily different terminal beat phases.

The assigned parent's informative predecessor is a clean terminal-control
failure rather than a propulsion failure. Its angle-domain carrier-yaw
subtraction retains the same organized wake and mild motion through a
`1.10362L` pass, then crosses the target station outside the capture sphere
and continues to a left-domain exit at `27.654T` with `9.329L` final distance.
The parent's next corridor-gated half-cycle handoff changes that semantic
outcome to capture at `0.74729L/15.921T`, while preserving the direct route and
compact wake. This is evidence that corrective yaw alone is an insufficient
redirect-completion signal and that small residual body-frame target error is
needed before shared rhythmic steering is released.

The new corridor-gated capture also exposes an actuator boundary. It crosses
with raw constant-course miss about `0.746L`, reaches `38.54/40.39 deg` joint
angles, and occupies the last `10 deg/T` of the two rate envelopes for
`17.7/16.7%` of samples. The response-only and geometry-qualified pulse
captures cross with `0.613--0.652L` raw miss, stay below `37.9 deg`, and have
similar near-rate occupancy and low peak normalized planar force/moment
(`0.0332--0.0348/0.0166--0.0175`). Thus the corridor handoff is a semantic
improvement, but keeping its posterior pulse always active is not supported as
the best completion rule for that separate actuator.

## Single candidate hypothesis

Preserve the complete sampled traveling-bend carrier, raw far-field
pursuit/course blend, constant-course time-to-closest and signed predicted
miss, terminal mean bend, and all established gains. Apply one coherent
terminal-consensus mechanism with actuator-specific residuals: use the
assigned parent's smooth lateral-target corridor to let corrective yaw release
shared half-cycle steering, and use the existing bounded predicted-miss
magnitude to let corrective yaw release the posterior mid-stroke pulse. The
body-frame request retains turn sign, both carrier half-cycles remain active,
and no clock, global route, scalar drive relief, or new static bend is added.

The hypothesis is that response-plus-geometry consensus will preserve the
parent's recovered capture while avoiding an always-active posterior redirect
once the predicted course is centered. Support requires capture or a closer
pass than the inherited `1.10362L` failure with the same direct compact-wake
route, peak joint angles near or below `40 deg`, no worse near-rate occupancy,
and normalized planar force/moment near or below `0.037/0.019`. Falsify on
loss of capture, another left exit without a closer pass, a larger terminal
course miss, posterior pinning, route-class or wake change, higher joint/load
occupancy, nonfinite commands, or loss of reflection equivariance.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return steering authority to a preserved propulsive rhythm only when measured turning response and the relevant residual directional error jointly indicate redirect completion
transferable_invariant: corrective response alone is not a completion signal; each bounded rhythmic steering actuator should release only when its target-relative geometry deficit is also small
nontransferable_details: species-specific maneuver timing and curvature, published gains, clock phase, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame lateral target offset to qualify half-cycle-asymmetry release and bounded constant-course predicted miss to qualify posterior-pulse release; retain the two-joint state-feedback carrier and raw far-field route signals
falsification: reject if capture or closest approach and termination do not improve together, or if direct routing, compact wake, joint reserve, normalized load scale, boundedness, or reflection equivariance degrades

## Dry validation only

The lightweight policy contract and solver editable-boundary checks pass. A
deterministic `87,480`-state grid spanning normalized body-frame target
geometry and velocity, both joint angles and rates, and yaw response produced
finite commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). In a constructed still-closing,
off-center intercept, the predicted-miss-qualified release changed posterior
acceleration by `0.08056 rad/T^2` relative to the captured corridor-gated
parent, confirming that the edit is semantically active. These are algebraic
checks only; no CFD was run.

The candidate's CFD evaluation occurs only after this worker exits. Every
rollout result above is sampled or inherited prior evidence.
