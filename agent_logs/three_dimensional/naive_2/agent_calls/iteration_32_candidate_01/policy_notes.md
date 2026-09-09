# Response-gated posterior predicted-miss residual

## Visual and metric diagnosis before editing

All four current samples satisfy the frozen rollout contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I compared the combined sheets for the scalar-best posterior-residual
capture `solver_e749afa61520`, the prefilled target-line-rate capture
`solver_f792c48d0852`, and the weakest finite target-line-consensus capture
`solver_8600d052eff8` from release through termination. This included both the
top-down mid-plane vorticity row and the oblique body/Lambda2 row. Each fish
self-propels along the same nearly direct down-left route behind a compact,
alternating, body-connected three-dimensional wake with localized posterior
structures. None shows passive advection, wake breakup, a boundary event, or
numerical instability. No current sample is a non-capture; the informative
failure is therefore the terminal-course and actuation boundary falsified by
finite captures, while inherited `1.01--1.22L` left exits remain the semantic
failure boundary.

The predicted-miss posterior residual is a real progress result but not a
terminal-margin result. `solver_e749afa61520` improves score from the prefill's
`-0.01965` to `-0.01094` and arrives at `15.1403T` instead of `15.6893T`.
Its head-relative predicted course miss improves only from `0.674L` to
`0.651L`, however, and absolute target-line rate worsens from `1.562/T` to
`1.745/T`. The posterior residual also raises peak normalized planar
force/moment from `0.03631/0.01797` to `0.04041/0.01902`, produces `1.269%`
posterior dwell above `40 deg`, and terminates at raw body heading rate
`-4.637 rad/T`. The images retain the same coherent route and wake, so the
faster capture is attributable to a useful rhythmic tail intervention, while
the terminal load, joint, and lateral-motion costs show that the intervention
persists after a strong physical turning response has appeared.

The other current mechanisms do not supply a better completion rule.
Carrier-separated force-deficit steering `solver_0abf107c2bc4` captures with
low `0.03563/0.01764` peak force/moment but widens terminal predicted miss to
`0.744L`; window-consensus target-line steering `solver_8600d052eff8`
similarly ends at `0.747L`. Assigned-parent logs also show that target-line
posterior phase-lag modulation captured with a `0.727L` miss and weaker score,
and reject further scalar work on static bend, broad carrier braking,
pulse-phase selection, and moment-residual steering. These results support
preserving the posterior residual's early rhythmic authority while changing
how observed response releases it.

## Single candidate hypothesis

Start from the best-scoring sampled posterior-residual controller, preserving
its state-feedback anterior oscillator, posterior traveling carrier and pulse,
far-field pursuit/course blend, predicted-miss geometry, bounded mean bend,
common response-plus-miss handoff, shared two-joint half-cycle steering, and
smooth command envelope. Keep the tail-only residual recruited by cubed signed
predicted miss on a closing terminal intercept, but multiply only this added
residual by the deficit of the already carrier-separated corrective-yaw
response. The residual acts while a large miss lacks correct-sign physical yaw
and fades continuously as that response appears. The base shared redirect and
posterior pulse remain available, so release does not coast or change the
far-field carrier.

The hypothesis is that response qualification retains the posterior residual's
earlier useful redirect while preventing it from driving the high-load,
high-tail-angle terminal half-cycles after corrective yaw is established.
Support requires capture with score better than the prefill's `-0.01965` and
arrival no later than `15.69T`, head-relative predicted miss below `0.590L`,
negligible `>40 deg` dwell, and normalized peak planar force/moment at or below
about `0.038/0.019`, while the direct compact-wake route remains intact.
Falsify on non-capture or left exit, loss of the posterior residual's
arrival/score improvement without a clear margin improvement, terminal miss at
or above `0.590L`, unchanged high residual action after a correct response,
wake decoherence, joint/load growth, nonfinite commands, or loss of reflection
equivariance. Formal CFD remains deferred to EvE and is not evidence available
to this worker.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit a bounded asymmetric rhythmic redirect for large observed error and release the added burst when a corrective physical response appears
transferable_invariant: strong posterior rhythmic authority should persist only while target-relative error is large and carrier-separated corrective response is deficient
nontransferable_details: published gains, dimensional frequencies, species-specific C-start kinematics, robot linkage geometry, exact phase lags, vortex phases, task coordinates, capture routes, and source-task waypoints
policy_translation: multiply the closing body-frame predicted-miss tail residual by one minus the existing carrier-separated corrective-yaw gate while retaining the two-joint state-feedback carrier, base posterior pulse, and common geometry-response handoff
falsification: reject if capture, arrival and score benefit, terminal margin, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality/parameter-schema, lightweight Julia policy
contract, and solver editable-boundary checks pass. A deterministic
`43,740`-state grid over normalized target geometry and velocity,
carrier-separated
heading response, and both joint angles and rates produced finite commands
strictly inside the smooth `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). The response gate changed `10,764` grid
states relative to the sampled ungated posterior residual, by as much as
`8.80712 rad/T^2`. Replaying commands on the sampled residual rollout changed
`138` of its `316` observations inside `3L`, with mean/max near-field command
differences `1.13942/8.76894 rad/T^2`. This establishes an active,
terminal-scheduled response mechanism rather than a comment or scalar-only
carrier edit. These checks are algebraic and counterfactual only; formal CFD
is deferred to EvE.
