# Receiver-safe spillover candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen-flow contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, no
prewarm snapshot, finite dynamics, and capture termination. I inspected every
combined keyframe sheet from release through capture, including the top-down
mid-plane vorticity row and oblique body/Lambda2 row. The score-best tail-only
residual `solver_e749afa61520` and weakest-score carrier-phase allocator
`solver_acc3a9086425` both visibly self-propel on the same direct down-left
route behind a compact, alternating, body-connected three-dimensional wake.
The dual-absolute allocator `solver_db935956483b` and directional allocator
prefill `solver_c4ca102cc4ad` preserve that topology. None shows passive
advection, wake breakup, boundary interaction, or numerical instability.
There is no semantic failure sheet in the sample, so the carrier-phase result
is the informative actuator-quality failure; inherited `1.01--1.22L`
left-domain misses remain the termination boundary. The established carrier,
common response-plus-miss handoff, and far-field route should not change.

The traces isolate terminal residual allocation. Tail-only allocation arrives
earliest and scores best (`15.1403T/-0.01094`) but crosses on a `0.651L`
head-relative constant-course miss, puts the posterior joint above `40deg` for
`1.269%` of samples, and reaches `0.04041/0.01902` peak normalized planar
force/moment. Dual absolute reserve sheds authority when neither joint can
accept it, improving load and dwell to `0.03872/0.01876` and `0/0.898%`, but
widens the miss to `0.556L`. Fully directional sender/receiver reserve reaches
`0.461L` miss and `0/0.681%` dwell at `15.3385T/-0.01502`, but gives back
`0.099L` of the uniquely centered `0.362L` course previously associated with
absolute posterior reserve.

The newest carrier-phase allocator falsifies `previous_action` as a useful
reserve-direction proxy on this carrier. It captures sooner (`15.2107T`) but
widens miss to `0.631L`, increases posterior `>40deg` dwell to `1.878%`, and
raises peak moment to `0.01922`, all worse than the directional prefill; its
score also falls to `-0.01708`. Its combined sheet retains the compact wake,
so this is an allocation failure rather than a propulsion failure. Do not add
another action-scale or phase-proxy scalar to that mechanism.

## Single candidate hypothesis

Preserve the prefilled oscillator, posterior lag and pulse, normalized
body-frame pursuit/course blend, constant-course predictor, common
response-plus-miss release, cubic residual magnitude, and smooth acceleration
envelope. Change one mechanism: restore absolute posterior angle/rate reserve,
which is associated with the centered terminal course, while applying signed
directional capacity only to the anterior receiver. The share excluded by the
tail spills to the head only when the requested body-frame miss direction
would not drive that joint farther through its soft angle or rate boundary;
any share neither joint can accept returns continuously to the unmodified
carrier. This avoids the failed `previous_action` proxy and remains bounded,
state-feedback-only, reflection equivariant, and independent of clock, route,
world coordinates, target identity, or exact vortex phase.

Support requires capture with terminal course miss competitive with the
absolute-spillover reference's `0.362L`, zero anterior `>40deg` dwell,
posterior dwell at or below `0.996%`, peak normalized planar force/moment no
worse than `0.03970/0.01889`, and arrival not materially later than
`15.4464T`, while retaining the direct compact-wake route. Falsify on lost
capture, miss above the directional prefill's `0.461L`, renewed anterior dwell,
higher posterior dwell/load, slower arrival without reserve improvement,
changed far-field behavior, wake decoherence, nonfinite commands, or loss of
reflection equivariance. Formal CFD remains deferred to EvE and is not
evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG residual steering and biological burst redirect
source_mechanism: preserve a rhythmic propulsive carrier while sensor-gating a bounded redirect residual and releasing unavailable authority toward cruise
transferable_invariant: keep the traveling carrier intact; admit target-relative residual authority only through an actuator with compatible observed kinematic reserve, and shed authority no actuator can safely receive
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific burst kinematics, exact vortex phases, full-body envelopes, task coordinates, routes, and waypoints
policy_translation: retain the normalized body-frame cubic predicted-miss residual and absolute posterior reserve, transfer only its excluded share to a head joint with signed angle/rate capacity, and otherwise leave the two-joint state-feedback carrier unchanged
falsification: reject if capture, terminal course, arrival, direct routing, compact wake, two-joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The prescribed guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass after repairing the rendered README's
duplicate parent marker. A deterministic `6,561`-state grid over normalized
body-frame target and velocity geometry, heading response, both joint angles,
and both joint rates produced finite commands strictly inside the owned
`30 rad/T^2` smooth envelope with exact left/right reflection (maximum error
`0.0`). Receiver-safe spillover changed `2,160` grid states relative to the
directional prefill and reached a maximum command difference of
`5.77597 rad/T^2`, confirming an active feedback mechanism rather than a
comment or scalar-only edit. These are algebraic checks only; capture, wake,
loads, joint histories, and terminal margin remain for EvE's formal CFD.
