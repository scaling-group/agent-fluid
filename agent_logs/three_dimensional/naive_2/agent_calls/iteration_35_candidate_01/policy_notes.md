# Braking-half-cycle redirect candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm. Each terminates in capture. I inspected the
combined keyframe sheets from release through termination for the score-best
tail-residual sample `solver_e749afa61520` and the weakest-score sampled
allocator `solver_bcdc57eba4e8`, including both the top-down mid-plane
vorticity row and the oblique body/Lambda2 row. Both fish visibly self-propel
down-left on essentially the same direct route. Their compact alternating
vortex streets remain body-connected and three-dimensional through capture;
neither sheet shows passive advection, wake breakup, boundary interaction, or
instability. The current contrast is therefore terminal steering allocation,
not a propulsion or gross-route failure.

Trajectory and diagnostic cross-checks support reserve-aware allocation but
reject more scalar reserve tuning. The tail-only residual is earliest and
score-best (`15.1403T/-0.01094`) but crosses with `0.651L` reconstructed
constant-course miss, `1.269%` posterior `>40 deg` dwell, and
`0.04041/0.01902` peak normalized planar force/moment. Absolute posterior
reserve allocation is slower (`15.4464T/-0.01764`) but improves miss to
`0.362L`; it retains `0.996%` posterior dwell and transfers `0.285%` dwell to
the head at `0.03970/0.01889` peak load. Adding absolute reserve protection
on both joints yields `0.556L` miss with zero head dwell, `0.898%` tail dwell,
and `0.03872/0.01876` peaks. Directional two-joint protection, the assigned
prefill, gives the useful compromise `0.461L`, zero head dwell, `0.681%` tail
dwell, and `0.03959/0.01889` peaks, but does not beat the absolute allocator's
margin. All four still occupy the near-rate band on roughly `22--24%` of
samples. The allocator mechanism survives; no sampled capacity definition
improves margin, dwell, rate reserve, loads, and arrival together.

Inherited logs also close the carrier-separated lateral-force branch. Its
bounded candidate captured at `15.7384T/-0.01874` with narrow
`0.03563/0.01764` loads but retained a `0.744L` tangential miss, far worse
than the inherited `0.179L` centered handoff. Corridor release, posterior
drive relief, and response-only residual release likewise retained the wide
terminal class. Another force gain, drive brake, release threshold, static
bend, or soft-limit threshold is not supported.

## Single candidate hypothesis

Preserve the assigned directional allocator's state-feedback oscillator,
posterior lag and pulse, normalized body-frame pursuit/course blend,
constant-course predictor, shared response-plus-miss handoff, cubic residual
magnitude, far-field behavior, and smooth acceleration envelope. Change one
mechanism: replace permissive signed-rate capacity with a braking-half-cycle
capacity. A requested residual may act on a joint when that joint is moving
against the requested bend, so the residual decelerates the return stroke and
prolongs the useful side of the beat rather than adding outward kinetic
energy. Directional angle capacity suppresses this braking action beyond the
soft angle so the carrier can restore the joint. Tail authority remains
primary; unavailable share transfers to the head only on its own admissible
braking half-cycle, and any remainder returns continuously to the carrier.

This is a state-feedback duty-asymmetry mechanism, not a scalar gain change.
The half-cycle comes from signed normalized joint rate, while direction comes
from body-frame predicted miss. It uses no clock, route, target identity,
world coordinate, force fit, or prescribed vortex phase. The hypothesis is
that the sampled terminal-margin benefit comes from prolonging the corrective
beat side, whereas accelerating an already outward-moving joint creates the
observed dwell/load trade-off. Support requires capture with reconstructed
terminal miss no worse than the assigned prefill's `0.461L`, lower near-rate
occupancy and no new `>40 deg` dwell, arrival/score competitive with
`15.34T/-0.01502`, peak normalized planar force/moment below
`0.03959/0.01889`, and preservation of the direct compact-wake route. Falsify
on lost capture, miss above `0.461L`, slower arrival without reserve/load
improvement, loss of useful translation, a new joint-limit exchange, wake
decoherence, nonfinite action, or loss of reflection equivariance. Formal CFD
is deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping and sensor-modulated CPG turning
source_mechanism: steer a propulsive rhythm by changing the effective duty of the useful half-cycle while retaining an autonomous carrier
transferable_invariant: apply target-relative redirect authority on the braking/restoring half-cycle so it prolongs the useful beat side without continually injecting outward joint energy
nontransferable_details: published gains, hardware duty ratios, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: derive turn direction from normalized body-frame predicted miss and admit the bounded cubic residual through signed joint-rate and directional angle capacity, tail first and then head, inside the two-joint state-feedback carrier
falsification: reject if capture margin, arrival, translation, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Validation boundary

The required guidance-materiality, lightweight Julia policy-contract, and
solver editable-boundary checks pass. All `32` direct `params.FIELD`
references resolve to the `32` fields returned by `target_policy_params()`. A
deterministic `32,400`-state grid spanning normalized body-frame target and
velocity geometry, heading response, and both joint angles and rates produced
finite commands strictly inside the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). Relative to the assigned
directional allocator, the braking-half-cycle mechanism changed `31,044`
grid states and reached a maximum command difference of
`8.34248 rad/T^2`, confirming an active feedback change rather than a comment
or scalar carrier edit. These are algebraic checks only. Formal CFD will run
only after this worker exits and remains unavailable as evidence here.
