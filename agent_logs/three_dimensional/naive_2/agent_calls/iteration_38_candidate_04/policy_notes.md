# Stopping-distance reserve candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the completed inherited rollouts used
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, no prewarm, finite dynamics, and capture termination. I inspected
the combined sheets from release through capture in both the top-down
mid-plane vorticity row and the oblique body/Lambda2 row. The score-leading
tail-only residual and the sampled absolute, directional, and carrier-phase
allocators all visibly self-propel on the same direct down-left route behind a
coherent alternating mid-plane wake and compact body-connected 3D vortex
train. The inherited phase-space and posterior-wave-target candidates preserve
that topology. None shows passive advection, wake breakup, boundary contact,
or numerical instability, so changing the far-field carrier or common
response-plus-miss handoff is not supported.

The sampled traces isolate terminal allocation quality. Tail-only residual
authority arrives earliest and scores best (`15.1403T/-0.01094`) but crosses
with `0.651L` head-relative constant-course miss, `1.269%` posterior
`>40 deg` dwell, and `0.04041/0.01902` peak normalized planar force/moment.
The sampled fully directional allocator improves that compromise to
`15.3385T/-0.01502`, `0.461L` miss, `0/0.681%` anterior/posterior dwell, and
`0.03959/0.01889` loads. The carrier-phase allocator retains the same visible
wake but regresses to `0.631L` miss, `1.878%` posterior dwell, and `0.01922`
peak moment, falsifying delayed action as a reserve-direction proxy.

Completed inherited evidence also closes two tempting paths. Receiver-safe
absolute-tail spillover varied from `0.516L` to `0.619L` miss and raised the
repeat's load class to `0.04087/0.01968`; the margin/load benefit did not
replicate. Moving the residual into a contracted posterior wave target reduced
loads to `0.03506/0.01724` and posterior dwell to `0.174%`, but slowed capture
to `15.8431T`, widened miss to `0.725L`, and scored `-0.02283`. A fixed
oscillator-normalized phase-space projection is the strongest new quality
result: it captured with `0.421L` miss, zero `>40 deg` dwell, and
`0.03628/0.01798` loads, but delayed arrival to `15.5850T` and scored
`-0.02349`. This supports anticipatory current-state reserve while leaving a
specific boundary: the fixed linear look-ahead sheds useful terminal authority
too early.

## Single candidate hypothesis

Preserve the prefilled oscillator, posterior lag and pulse, normalized
body-frame pursuit/course blend, constant-course predictor, response-plus-miss
release, cubic predicted-miss magnitude, tail-first residual allocation, and
smooth acceleration envelope. Change one mechanism: replace instantaneous or
fixed-horizon angle capacity with a directional stopping-position estimate.
For each joint, outward speed along the requested redirect consumes angle
reserve by `speed^2/(2 * available_acceleration)`; inward motion consumes no
stopping distance, and the existing direct rate guard remains. Tail authority
stays primary, unavailable share reaches the head only through its own
stopping reserve, and authority neither joint can accept returns continuously
to the evidenced carrier.

This is normalized current-state feedback, continuous apart from harmless
zero-direction branch points, reflection equivariant, and independent of
clock, route, world coordinates, target identity, or vortex phase. It is a
mechanism change rather than scalar tuning: the gate now represents a dynamic
braking margin, reusing the sampled soft limits and the policy-owned
acceleration envelope.

Support requires capture on the direct compact-wake route, course miss at or
below the fixed-projection result's `0.421L`, zero anterior `>40 deg` dwell,
posterior dwell no worse than the directional allocator's `0.681%`, peak
normalized planar force/moment within approximately `0.040/0.019`, and arrival
meaningfully closer to the sampled `15.14--15.34T` class than `15.5850T`.
Falsify on lost capture, wider miss, renewed dwell/load exposure, unchanged
slow-arrival class, altered far-field translation, nonfinite commands, or loss
of exact reflection equivariance. Formal CFD is deferred to EvE and is not
evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG steering and biological burst redirect
source_mechanism: preserve a rhythmic propulsive carrier while admitting a bounded target-relative redirect only through compatible observed actuator state
transferable_invariant: keep the traveling carrier intact and release transient steering authority according to current joint reserve, returning unavailable authority toward cruise
nontransferable_details: published gains, dimensional beat frequencies, hardware linkage limits, species-specific burst kinematics, exact vortex phases, full-body envelopes, task coordinates, routes, and waypoints
policy_translation: retain the normalized body-frame predicted-miss residual; estimate each joint's directional stopping position from angle, rate, and the policy-owned acceleration envelope before tail-first allocation, and shed residual that neither joint can stop safely
falsification: reject if capture margin, arrival, compact wake, joint reserve, normalized loads, finite bounded action, or reflection equivariance worsens

## Dry validation boundary

The lightweight Julia policy contract passes. A deterministic `4,374`-state
grid spanning normalized body-frame target/course geometry, heading response,
distance, both joint angles, and both joint rates produced finite commands
inside the policy-owned `30 rad/T^2` smooth envelope with exact left/right
reflection (maximum error `0.0`). The stopping-distance mechanism changed
`2,976` states relative to the tail-only prefill and `1,956` relative to the
fixed phase-space projection, reaching maximum command differences of
`4.76335` and `3.56417 rad/T^2`, respectively. These are algebraic checks
only; capture, arrival, wake, loads, joint histories, and terminal margin
remain for EvE's downstream CFD evaluation.
