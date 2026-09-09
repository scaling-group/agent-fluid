# One-sided harmonic-peak reserve candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the completed inherited rollouts satisfy
the frozen-flow contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
termination. I inspected their combined sheets from release through capture,
including both the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The score-leading tail-only residual, directional prefill,
assigned-parent phase projection, and sibling envelope-preserving wave target
all visibly self-propel on the same direct down-left route behind a compact
alternating mid-plane wake and sparse body-connected three-dimensional vortex
train. None shows passive advection, wake breakup, boundary interaction, or
numerical instability. The established oscillator, posterior lag, far-field
navigation, and response-plus-miss handoff should therefore remain unchanged;
the evidence isolates terminal residual representation and reserve prediction.

The sampled directional prefill captures at `15.3385T/-0.01502`, with a
`0.461L` head-relative constant-course miss, zero/`0.681%` anterior/posterior
`>40 deg` dwell, and `0.03959/0.01889` peak normalized planar force/moment.
Tail-only allocation is faster (`15.1403T/-0.01094`) but widens miss to
`0.651L`, raises posterior dwell to `1.269%`, and reaches
`0.04041/0.01902` loads. Previous-action allocation is also inferior to the
directional prefill (`0.631L`, `1.878%` posterior dwell, `0.01922` moment), so
an action or carrier-sign proxy is not usable reserve evidence on this carrier.

The assigned parent's completed linear phase-space projection is a mixed
positive result rather than a reason to repeat it. It improves miss to
`0.421L`, eliminates both joints' `>40 deg` dwell, and lowers loads to
`0.03628/0.01798`, while retaining the direct compact wake; however, capture
slows to `15.5850T`, score worsens to `-0.02349`, and the outcome falls outside
the inherited `15.14--15.34T` arrival class. The sibling envelope-preserving
posterior wave target also retains capture and lowers loads to
`0.03506/0.01724`, but slows further to `15.8431T` and widens course miss to
`0.725L`. Thus envelope protection is useful only if it preserves terminal
translation and geometry; more linear projection gain or posterior wave-offset
tuning is not supported.

## Single candidate hypothesis

Start from the directional prefill and preserve every carrier, navigation,
handoff, residual-magnitude, threshold, and acceleration-limit parameter.
Change one mechanism: replace the instantaneous directional angle test with a
one-sided harmonic peak predicted from the joint's observed phase-plane state.
As a joint moves in the requested redirect direction, smoothly approach
`sqrt(q^2 + (q_dot/omega)^2)` as its next same-direction angular peak; while it
moves inward, use its current signed directional angle. The existing rate-width
parameter supplies the continuous outward-phase blend as well as the retained
direct directional rate guard; the tail-first spillover is unchanged. Compared
with the failed linear sum `q + q_dot/omega`, the harmonic norm does not
double-count simultaneously outward angle and velocity, but it still detects
momentum that will carry an opposite-side joint through the requested peak. No
new gain is introduced.

Support requires capture with the direct compact wake, terminal miss at or
below the directional prefill's `0.461L`, zero anterior dwell and posterior
dwell at or below `0.681%`, peak normalized planar force/moment near or below
`0.040/0.019`, and recovery into the `15.14--15.34T` arrival class. Falsify on
lost capture, a wider miss, increased dwell or loads, retention of the linear
projection's arrival penalty, changed far-field translation, nonfinite action,
or loss of exact reflection equivariance. Formal CFD remains deferred to EvE
and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and oscillator phase-plane analysis
source_mechanism: preserve a traveling propulsive carrier while admitting bounded steering only through observed phase-space reserve
transferable_invariant: joint angle and oscillator-normalized velocity jointly predict the next rhythmic excursion, so residual steering should respect that excursion without replacing the carrier
nontransferable_details: published gains, dimensional frequencies, hardware duty ratios, robot linkage geometry, species-specific envelopes, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: use normalized body-frame predicted miss for redirect sign; derive each joint's one-sided harmonic peak from its observed angle and rate at the owned oscillator frequency, retain the directional rate guard, and shed residual no joint can accept
falsification: reject if capture margin, arrival, direct compact wake, two-joint reserve, normalized loads, bounded finite action, or reflection equivariance worsens

## Dry validation boundary

The prescribed guidance-materiality and deterministic parameter-schema check,
lightweight Julia policy contract, and solver editable-boundary check pass; no
CFD was run. A deterministic `2,187`-state grid spanning normalized body-frame
target/course geometry, heading response, both joint angles, and both joint
rates produced finite commands inside the owned `30 rad/T^2` smooth envelope
with exact left/right reflection (maximum error `0.0`). The harmonic-peak
mechanism changed `618` grid states relative to the directional prefill, with a
maximum command difference of `0.904998 rad/T^2`; it also changed `696` states
relative to the evaluated linear projection, with a maximum difference of
`2.32184 rad/T^2`. These checks establish an active, distinct, bounded feedback
mechanism only. Capture, wake, arrival, terminal miss, loads, and joint histories
remain for EvE's downstream formal evaluation.
