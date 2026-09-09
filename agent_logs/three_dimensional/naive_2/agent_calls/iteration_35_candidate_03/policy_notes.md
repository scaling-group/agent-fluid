# Carrier-phase joint-reserve allocation candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected each combined keyframe sheet from release through capture,
including both the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The score-best tail-only residual
`solver_e749afa61520` and weakest-score absolute allocator
`solver_bcdc57eba4e8` visibly self-propel along the same direct down-left route
behind a compact, alternating, body-connected three-dimensional wake. The
assigned parent `solver_db935956483b` and directional allocator
`solver_c4ca102cc4ad` preserve that topology. None shows passive advection,
wake breakup, boundary interaction, pre-existing vortices, or instability.
There is no current semantic failure sheet, so the weakest finite capture is
the visual contrast and the inherited `1.01--1.22L` left-domain misses remain
the actual failure boundary. The carrier, route, and far-field handoff should
be preserved.

The sampled trajectories isolate a useful allocation tradeoff. The tail-only
residual arrives earliest and scores best (`15.1403T/-0.01094`) but crosses on
a `0.651L` constant-course miss, puts the posterior joint above `40deg` for
`1.269%` of samples, and reaches `0.04041/0.01902` peak normalized planar
force/moment. Absolute posterior-reserve spillover improves the miss to
`0.362L` but is slower (`15.4464T/-0.01764`) and merely exchanges limit burden:
anterior/posterior `>40deg` dwell is `0.285/0.996%` with
`0.03970/0.01889` peak loads. Requiring reserve on both joints in the assigned
parent removes anterior dwell, reduces posterior dwell to `0.898%`, lowers the
load class to `0.03872/0.01876`, and recovers arrival/score to
`15.2957T/-0.01484`, while retaining capture and improving on the tail-only
miss at `0.556L`. Thus shedding redirect authority when neither joint has
reserve is an evidenced actuator-quality improvement, but the wider miss shows
that indiscriminate absolute reserve also discards useful rhythmic correction.

The directional allocator is the informative follow-up. Letting a joint retain
authority when the residual sign is restoring reduces posterior `>40deg` dwell
again to `0.681%` and improves miss to `0.461L`, with no anterior dwell and
nearly unchanged arrival/score (`15.3385T/-0.01502`). Its
`0.03959/0.01889` peak load is slightly above the parent but below the
tail-only sample. It still misses the absolute allocator's `0.362L` course and
does not meet that worker's stated margin boundary. The remaining mismatch is
that residual sign is only the desired half-cycle asymmetry; because it
multiplies the carrier magnitude, it is not the sign of the joint's actual
acceleration on both beat halves. Capacity should follow the observed carrier
phase rather than treating the target-relative residual as a direct torque.

## Single candidate hypothesis

Start from the directional allocator while preserving the evidenced
state-feedback oscillator, posterior lag and pulse, normalized body-frame
pursuit/course blend, constant-course predictor, common response-plus-miss
handoff, cubic redirect magnitude, and smooth acceleration envelope. Change
one mechanism: compute each joint's reserve direction from its bounded previous
acceleration, which is the immediately observed carrier-command phase. Keep
redirect authority when that command is restoring relative to joint angle and
rate; smoothly withhold outward-phase authority near the corresponding soft
limits. Tail authority remains primary, unavailable tail share reaches the head
only when its own carrier phase has capacity, and any remainder returns to the
unmodified cruise carrier. This is state feedback, continuous through carrier
reversal, reflection equivariant, and independent of time, route, world
coordinates, target identity, or exact vortex phase.

The hypothesis is that carrier-phase capacity preserves the useful redirect
that residual-sign gating unnecessarily removes while retaining the dual-
reserve protection that eliminated anterior dwell and lowered loads. Support
requires capture with terminal constant-course miss at or below the directional
allocator's `0.461L`, no anterior `>40deg` dwell, posterior dwell below its
`0.681%`, peak normalized planar force/moment no worse than approximately
`0.040/0.019`, and arrival/score comparable to the current
`15.30--15.34T/-0.015` class. The direct route and compact alternating 3D wake
must survive. Falsify on lost capture, a miss above `0.461L`, a new joint-limit
exchange, higher load class, slower arrival without reserve improvement,
changed far-field behavior, nonfinite action, or loss of reflection
equivariance. Formal CFD is deferred to EvE and is not evidence available to
this worker.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping turning and sensor-modulated CPG direction tracking
source_mechanism: align bounded directional modulation with the observed propulsive half-cycle and release it through sensed actuator state
transferable_invariant: preserve the autonomous traveling carrier while applying target-relative rhythmic authority only on carrier phases with usable joint reserve
nontransferable_details: published gains, dimensional frequencies, hardware duty ratios, robot linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: use normalized body-frame predicted miss for redirect direction and each joint's bounded previous acceleration plus angle/rate state to allocate the residual tail-first during admissible carrier phases
falsification: reject if capture margin, arrival, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without running CFD.
A deterministic `25,000`-state grid spanning normalized body-frame target and
velocity geometry, yaw response, both joint angles and rates, and both previous
carrier actions produced finite commands within the owned `30 rad/T^2`
envelope with exact left/right reflection (maximum error `0.0`). The carrier-
phase allocator changed `17,833` states relative to the assigned dual-reserve
parent and `14,304` relative to residual-sign directional allocation, so the
candidate is an active observation/feedback mechanism rather than a comment or
scalar-only edit. These are algebraic checks only; capture, wake, loads, and
joint histories remain falsifiable in the downstream formal CFD evaluation.
