# Phase-space projected reserve candidate

## Visual and metric diagnosis before editing

All four sampled rollouts and the inherited completed rollouts satisfy the
frozen experiment contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
termination. I inspected their combined sheets from release through capture in
both the top-down mid-plane vorticity row and oblique body/Lambda2 row. The
score-leading tail-only residual, directional prefill, dual-absolute allocator,
receiver-safe allocator, delayed-action allocator, and analytic-carrier
allocator all visibly self-propel on the same direct down-left route behind a
compact alternating mid-plane wake and sparse body-connected 3D vortex train.
None shows passive advection, wake breakup, boundary interaction, or numerical
instability. The useful carrier, response-plus-miss handoff, and far-field
navigation therefore remain fixed; terminal joint-residual allocation is the
informative difference.

The sampled directional prefill is the best current geometry/reserve
compromise: capture at `15.3385T`, `0.461L` head-relative constant-course miss,
zero/`0.681%` anterior/posterior `>40 deg` dwell, and `0.03959/0.01889` peak
normalized planar force/moment. Tail-only allocation arrives at `15.1403T` but
widens miss to `0.651L`, raises posterior dwell to `1.269%`, and reaches
`0.04041/0.01902` loads. Dual absolute reserve reduces loads to
`0.03872/0.01876` but widens miss to `0.556L` with `0.898%` posterior dwell.

The assigned parent's receiver-safe mechanism does not survive its inherited
repeat. The identical policy captured once with `0.516L` miss, no `>40 deg`
dwell, and `0.03988/0.01906` loads, but the parent evaluation moved to `0.619L`,
`0/0.397%` dwell, and `0.04087/0.01968`, failing both its directional-prefill
margin and load boundaries despite retaining the same compact wake. The
analytic contemporaneous-carrier follow-up also captures but worsens to
`0.619L`, `0/2.233%` dwell, and `0.04184/0.01961`; together with the delayed
`previous_action` result (`0.631L`, `1.878%` posterior dwell), this rejects more
carrier-sign, action-scale, absolute-tail, or receiver-spillover tuning. These
are allocation failures, not propulsion failures.

## Single candidate hypothesis

Start from the directional prefill and preserve its oscillator, posterior lag
and pulse, normalized body-frame pursuit/course blend, constant-course
predictor, common response-plus-miss release, cubic residual, tail-first
allocation, and smooth acceleration envelope. Change one mechanism: replace
each instantaneous directional angle-reserve test with a short oscillator-
normalized phase-space projection `q + projection * q_dot / omega`, while
retaining the direct directional rate guard. This observes current joint state,
anticipates an outward-moving joint before it reaches the angle boundary, and
restores capacity to a near-boundary joint already moving inward. It does not
use delayed action, infer carrier acceleration sign, or alter residual gain.
Tail authority remains primary, excluded share reaches the head only through
its own projected directional reserve, and authority neither joint can accept
is shed continuously back to the evidenced carrier.

Support requires capture with the direct compact wake, miss at or below the
directional prefill's `0.461L`, zero anterior `>40 deg` dwell, posterior dwell
at or below `0.681%`, peak normalized planar force/moment within approximately
`0.040/0.019`, and arrival in the evidenced `15.14--15.34T` class. Falsify on
lost capture, wider miss, increased dwell or loads, slower arrival without a
reserve improvement, changed far-field translation, nonfinite commands, or
loss of exact reflection equivariance. Formal CFD is deferred to EvE and is
not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG steering and phase-plane oscillator control
source_mechanism: preserve a traveling propulsive oscillator while releasing bounded steering through observed joint-state reserve
transferable_invariant: keep the traveling carrier intact and condition target-relative residual authority on a current phase-space estimate of whether each actuator can safely receive it
nontransferable_details: published gains, dimensional frequencies, hardware duty ratios, linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: use normalized body-frame predicted miss for redirect sign; project each joint's observed angle by its oscillator-normalized velocity before tail-first directional allocation, retain a direct rate guard, and shed residual no joint can accept
falsification: reject if capture margin, arrival, direct compact wake, two-joint reserve, normalized loads, finite bounded action, or reflection equivariance worsens

## Dry validation boundary

The configured check-runner independently reports PASS for guidance
materiality, the lightweight Julia policy contract and parameter schema, and
the solver editable-file boundary; no CFD was run. A deterministic `19,683`-
state grid spanning normalized body-frame target/course geometry, heading
response, both joint angles, and both joint rates produced finite commands
inside the inclusive owned `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). The phase-space projection changed `4,710`
grid states relative to the directional prefill and reached a maximum command
difference of `7.08341 rad/T^2`, confirming an active feedback mechanism rather
than a comment or scalar-only edit. These algebraic checks do not establish
capture, wake, loads, joint histories, or terminal margin; those remain
falsifiable in EvE's downstream formal evaluation.
