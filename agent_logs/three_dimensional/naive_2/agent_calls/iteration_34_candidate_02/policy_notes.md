# Directional joint-reserve redirect candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen-flow contract: each reports
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm, and each terminates in capture. I inspected every
combined keyframe sheet from release through termination, including the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. The
score-best posterior-residual rollout `solver_e749afa61520` and weakest-score
prefilled drive-relief rollout `solver_902d980c2b63` both visibly self-propel
down-left on the same direct route behind a compact, alternating,
body-connected three-dimensional wake. The allocator and response-release
sheets preserve that topology; none shows passive advection, wake breakup,
boundary interaction, or instability. The carrier and far-field route should
therefore be preserved.

Trajectory and diagnostic cross-checks isolate terminal allocation rather
than propulsion as the useful difference. The tail-only residual captures at
`15.1403T/-0.01094` but crosses with a head-relative constant-course miss of
`0.651L`, peak normalized planar force/moment `0.04041/0.01902`, and `1.269%`
posterior `>40 deg` dwell. Miss-conditioned drive relief repeats nearly that
class at `15.1939T/-0.01891/0.635L`, with `0.04124/0.01984` peak loads and
`1.229%` posterior dwell; it does not support more posterior-drive relief.
Response-releasing the tail residual reaches `0.573L` miss but raises
posterior dwell to `1.551%` and peak loads to `0.04162/0.01968`, so response
release alone is also falsified as the actuator-quality solution.

The joint-reserve allocator `solver_bcdc57eba4e8` is the semantic improvement:
it preserves capture and the coherent direct route while reducing terminal
predicted miss to `0.362L`, well inside the `0.75L` capture radius. It is
slower (`15.4464T`, score `-0.01764`) and does not fully solve reserve quality:
posterior `>40 deg` dwell remains `0.996%`, anterior dwell appears at `0.285%`,
and peak normalized planar force/moment remains `0.03970/0.01889`. Its
allocator gates on absolute posterior angle/rate and transfers the residual to
the head even when the requested acceleration would return the tail toward
center or drive the head farther outward. The evidence supports preserving
allocation but making capacity directional, not adding another scalar gain,
drive brake, terminal observation, or persistent bend.

## Single candidate hypothesis

Start from the sampled joint-reserve allocator and preserve its oscillator,
posterior lag and pulse, normalized body-frame pursuit/course blend,
constant-course predictor, terminal mean bend, shared response-plus-miss
handoff, residual magnitude, and smooth acceleration envelope. Change one
mechanism: replace absolute posterior-only capacity with a directional
two-joint allocator. A joint retains redirect authority when the requested
residual acceleration is restoring relative to its angle and rate, even near
an absolute soft boundary. An outward residual is smoothly removed near that
joint's soft angle or rate boundary; unavailable tail authority transfers to
the head only when the head can accept the same direction, and otherwise
returns to the carrier. Because the direction comes from signed normalized
predicted miss and capacity uses signed joint state, the mechanism remains
continuous at zero residual, reflection equivariant, bounded, and independent
of clock, route, world coordinates, target identity, or exact wake phase.

Support requires capture with terminal predicted miss no worse than the
allocator's `0.362L`, reduced `>40 deg` dwell on both joints, peak normalized
planar force/moment below `0.03970/0.01889`, and arrival/score not materially
worse than `15.4464T/-0.01764`, while retaining the direct compact-wake route.
Falsify on lost capture, miss above `0.362L`, a new joint-limit exchange,
slower arrival without joint/load improvement, changed far-field behavior,
wake decoherence, nonfinite action, or loss of reflection equivariance.
Formal CFD remains deferred to EvE and is not evidence available to this
worker.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an autonomous propulsive rhythm while strong bounded redirect authority is admitted and released through observed target geometry, joint state, and corrective capacity
transferable_invariant: keep the carrier intact and apply a target-relative rhythmic residual only through actuators for which its instantaneous direction remains kinematically admissible, returning any unassignable share continuously to cruise
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific burst timing and envelopes, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: allocate the cubic body-frame predicted-miss residual using signed angle/rate reserve on both joints; retain restorative authority near absolute limits, transfer outward tail demand only to an admissible head channel, and suppress any remainder without changing the two-joint state-feedback carrier
falsification: reject if capture margin, arrival, direct routing, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `22,500`-state grid
over normalized body-frame target geometry and velocity, heading response, and
both joint angles and rates produced finite commands strictly inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`). Relative to the sampled absolute-reserve allocator, directional
capacity changed `19,374` grid states at numerical tolerance and reached a
maximum command difference of `3.16207 rad/T^2`, confirming an active feedback
mechanism rather than a comment or scalar-only edit. All `33` direct
`params.FIELD` references resolve to the `33` returned parameter fields. These
checks are algebraic only; formal CFD remains deferred to EvE.
