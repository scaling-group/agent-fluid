# Harmonic phase-space reserve candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the completed inherited rollouts satisfy
the frozen experiment contract: direct uniform still-water initialization with
`U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
termination. I inspected the combined sheets from release through capture in
both the top-down mid-plane vorticity row and the oblique body/Lambda2 row for
the score-leading tail-only sample, the weakest carrier-action allocator, the
latest assigned-parent phase-space policy, and the contemporaneous posterior
wave-target policy. Each is visibly self-propelled on the same direct down-left
route behind a coherent alternating mid-plane wake and a compact body-connected
three-dimensional vortex train. None shows passive advection, wake breakup,
boundary interaction, or instability. The carrier and common response-plus-
miss handoff therefore remain fixed; terminal actuator representation is the
informative difference.

The sampled tail-only cubic residual arrives earliest and scores best
(`15.1403T/-0.01094`), but crosses on a `0.651L` head-relative constant-course
miss with `1.269%` posterior `>40 deg` dwell and `0.04041/0.01902` peak
normalized planar force/moment. Fully directional reserve improves the
tradeoff to `15.3385T/0.461L`, `0/0.681%` anterior/posterior dwell, and
`0.03959/0.01889` loads. Delayed-action and receiver-safe variants retained
the same wake but widened miss to `0.619--0.631L`, so more action-sign or
spillover gating is not supported.

The latest assigned-parent result supplies a positive mechanism: linear
oscillator-normalized phase-space projection captured with a smaller `0.421L`
miss, zero `>40 deg` dwell in both joints, and lower `0.03628/0.01798` loads.
Its cost is slower arrival (`15.5850T`, score `-0.02349`) and lower measured
speed from the `3L` approach onward (`1.256U` versus `1.379U` for the sampled
directional allocator). The contemporaneous envelope-preserving posterior
wave target also lowered loads but widened miss to `0.725L` and slowed arrival
to `15.8431T`; do not combine that failed actuator with the projected gate.

## Single candidate hypothesis

Start from the successful phase-space parent and preserve its oscillator,
posterior lag and pulse, normalized body-frame pursuit/course blend,
constant-course predictor, common response-plus-miss release, cubic residual,
tail-first allocation, and smooth acceleration envelope. Change one mechanism:
replace the linear angle forecast `q + p*q_dot/omega` with a harmonic
phase-space rotation `q*cos(p) + (q_dot/omega)*sin(p)`. Linear projection at a
one-radian phase horizon can enlarge the normalized oscillator state instead
of transporting it along the carrier orbit; the rotation anticipates which
joint is moving outward while preserving that orbit's amplitude. The direct
directional rate guard remains, excluded tail share reaches the head only
through its own rotated reserve, and authority neither joint can accept is
shed continuously back to the evidenced carrier.

Support requires capture with the direct compact wake, terminal course miss at
or below the linear parent's `0.421L`, zero anterior `>40 deg` dwell, posterior
dwell at or below the sampled directional allocator's `0.681%`, peak normalized
planar force/moment no worse than about `0.040/0.019`, and an arrival improvement
toward the evidenced `15.14--15.34T` class. Falsify on lost capture, wider miss,
renewed dwell or load growth, no recovery from the parent's `15.585T` arrival,
changed far-field translation, nonfinite commands, or loss of exact reflection
equivariance. Formal CFD remains deferred to EvE and is not evidence available
to this worker.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG steering and phase-plane oscillator control
source_mechanism: preserve a traveling propulsive oscillator while releasing a bounded target-relative residual through observed actuator reserve
transferable_invariant: predict reserve by transporting normalized joint state consistently with the rhythmic carrier, admit only compatible residual authority, and shed authority no actuator can safely receive
nontransferable_details: published gains, dimensional frequencies, hardware duty ratios, linkage geometry, species-specific envelopes, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: rotate each observed `(q, q_dot/omega)` pair over a bounded owned phase horizon before tail-first directional predicted-miss allocation, retain the direct rate guard, and leave the normalized body-frame carrier and handoff unchanged
falsification: reject if capture margin, arrival, compact wake, joint reserve, normalized loads, finite bounded action, or reflection equivariance worsens

## Dry validation boundary

The configured guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass; no CFD was run. A deterministic
`19,683`-state grid spanning normalized body-frame target/course geometry,
heading response, both joint angles, and both joint rates produced finite
commands within the inclusive owned `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). Harmonic projection changed `4,956` grid
states relative to the inherited linear phase-space parent and reached a
maximum command difference of `5.78518 rad/T^2`, confirming an active feedback
mechanism rather than a comment or scalar-only edit. These algebraic checks do
not establish capture, wake, load, joint-history, course-margin, or arrival
improvement; those remain falsifiable in EvE's downstream formal evaluation.
