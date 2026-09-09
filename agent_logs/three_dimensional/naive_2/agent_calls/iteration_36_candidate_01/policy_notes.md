# Current-carrier restoring-margin allocator candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected every combined keyframe sheet from release through
capture, including the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The score-best tail-only residual `solver_e749afa61520` and
the newly completed carrier-phase allocator `solver_acc3a9086425` visibly
self-propel down-left on the same direct route. The dual-reserve parent
`solver_db935956483b` and directional allocator `solver_c4ca102cc4ad` preserve
that topology. Each develops a compact alternating wake attached to the
undulating body; none shows passive advection, pre-existing vortices, wake
breakup, boundary interaction, or instability. There is no sampled
termination failure sheet, so the weakest finite capture is the visual quality
comparator and the inherited `1.01--1.22L` left exits remain the semantic
failure boundary. The carrier, far-field route, and common terminal handoff
should remain unchanged.

Trajectory and load cross-checks isolate a failed allocation proxy. The
tail-only residual remains the fastest and score-best sample
(`15.1403T/-0.01094`) but crosses on a `0.651L` constant-course miss, puts the
posterior joint above `40deg` for `1.269%` of samples, and reaches
`0.04041/0.01902` peak normalized planar force/moment. Absolute dual-reserve
shedding improves posterior dwell to `0.898%`, load to `0.03872/0.01876`, and
miss to `0.556L` at `15.2957T/-0.01484`. Directional residual-sign capacity is
the best sampled actuator-quality compromise: `0.461L` miss, zero anterior and
`0.681%` posterior `>40deg` dwell, `0.03959/0.01889` peak load, and
`15.3385T/-0.01502` capture.

Using bounded previous action as the carrier-phase proxy is a concrete
negative result. `solver_acc3a9086425` still captures with the same compact
wake, but predicted miss widens to `0.631L`, posterior `>40deg` dwell jumps to
`1.878%`, peak yaw moment rises to `0.01922`, and score worsens to `-0.01708`.
Its `15.2107T` arrival and slightly lower `0.03930` peak planar force do not
rescue the failed joint/margin tradeoff. Previous action includes redirected
control and lags the present restoring reversal, so it is not an admissible
proxy for current carrier capacity. This result rejects further action-scale
or one-step carrier-phase tuning.

## Single candidate hypothesis

Preserve the assigned parent's state-feedback oscillator, posterior lag and
pulse, normalized body-frame pursuit/course blend, constant-course predictor,
terminal mean bend, common response-plus-miss handoff, cubic redirect
magnitude, and smooth acceleration envelope. Change one mechanism: compute the
present carrier-plus-common-redirect acceleration before allocating the cubic
residual. Near a signed soft angle or rate boundary, retain only the residual
share that fits inside this current command's restoring acceleration margin.
Unavailable tail share transfers to the head under the same test; any share
that would turn the combined command outward is shed continuously. Away from
the soft boundaries, the evidenced residual is unchanged.

This current-command margin differs from both sampled alternatives. Unlike
residual-sign capacity, it can retain an outward-signed incremental correction
when a stronger current carrier command still returns the joint toward center.
Unlike the failed previous-action proxy, it evaluates the present algebraic
state-feedback command and prevents admitted residual from reversing that
restoring direction at the boundary. It uses joint state and normalized
body-frame predicted miss, has no clock or mutable history, and is reflection
equivariant.

Support requires capture with constant-course miss at or below the
directional allocator's `0.461L`, zero anterior `>40deg` dwell, posterior dwell
at or below `0.681%`, and peak normalized planar force/moment no worse than
approximately `0.040/0.019`, while keeping arrival/score in the sampled
`15.14--15.34T/-0.015` useful class. The direct route, alternating compact 3D
wake, bounded finite commands, and exact reflection symmetry must survive.
Falsify on lost capture, miss above `0.461L`, renewed joint-limit exchange,
higher load class, slower arrival without margin/reserve improvement, changed
far-field motion, nonfinite commands, or reflection error. Formal CFD remains
deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst-redirect release
source_mechanism: preserve an autonomous propulsive rhythm while bounded redirect authority is admitted and released through current geometry, response, and actuator state
transferable_invariant: keep the traveling carrier intact and retain corrective authority only within the actuator's presently observed restoring capacity, returning continuously to cruise when that capacity is exhausted
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific burst kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: allocate the cubic body-frame predicted-miss residual tail-first against the current carrier-plus-shared-command restoring margin at each joint's signed angle/rate boundary, shedding any share that would reverse the combined command outward
falsification: reject if capture margin, arrival, direct routing, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Validation boundary

The mandated guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without running CFD.
A deterministic `50,625`-state grid spanning normalized body-frame target and
velocity geometry, heading response, both joint angles, and both joint rates
produced finite commands inside the owned inclusive `30 rad/T^2` envelope with
exact left/right reflection (maximum error `0.0`). The new allocator changed
`49,479` states relative to the assigned dual-reserve parent and reached a
maximum command difference of `11.548174 rad/T^2`, confirming an active
feedback mechanism rather than a comment or scalar-only edit. All `33` direct
`params.FIELD` references resolve to the `33` returned fields. Formal CFD will
be run only by EvE after this worker exits; these algebraic checks cannot
establish capture, wake quality, loads, or joint dwell.
