# Predicted-miss posterior-lag candidate

## Visual and metric diagnosis before editing

All sampled rollouts and the assigned-parent rollout satisfy the frozen-flow
contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no prewarm, finite dynamics, and capture termination. I
inspected the combined sheets from release through capture for the score-best
tail-residual sample `solver_e749afa61520`, weakest sampled
receiver-safe result `solver_3f9023504354`, and inherited phase-decomposed
result `solver_241ec16a3591`, including the top-down mid-plane vorticity and
oblique body/Lambda2 rows. All three visibly self-propel along the same direct
down-left route behind a compact alternating mid-plane wake and sparse,
body-connected three-dimensional vortex train. None shows passive advection,
wake breakup, boundary interaction, or an initialization artifact. The useful
carrier and far-field route should therefore remain unchanged; the phase-
decomposed rollout is the informative actuator-quality failure.

The new inherited result falsifies contemporaneous analytic carrier phase as
the missing reserve proxy. Phase-decomposed gating retained capture at
`15.2469T` but produced `0.619L` terminal constant-course miss, `2.233%`
posterior `>40 deg` dwell, and `0.04184/0.01961` peak normalized planar
force/moment. It failed its own `<=0.461L`, `<=0.681%`, and approximately
`0.040/0.019` boundaries and is worse on all three measures than the sampled
directional-reserve allocator. The score-best tail-only residual arrives at
`15.1403T/-0.01094`, but its `0.651L` miss, `1.269%` posterior dwell, and
`0.04041/0.01902` loads show that multiplying a directional residual into the
posterior carrier also couples course authority to joint exposure. The
receiver-safe sample removes `>40 deg` dwell but remains wide at `0.516L` and
scores `-0.01727`; shedding alone is not centered navigation.

## Single candidate hypothesis

Preserve the prefilled oscillator, normalized body-frame pursuit/course blend,
constant-course predictor, common response-plus-miss release, shared rhythmic
steering, posterior pulse, and smooth acceleration envelope. Replace one
mechanism: remove the additive cubic posterior acceleration residual and use
the same unresolved predicted-miss magnitude to make a bounded temporary
increase in posterior phase lag. The modulation is zero for a centered course,
after the geometry/response release, and outside a closing terminal intercept.
It is even in target side, so reflection-equivariant steering direction remains
owned by the established shared half-cycle channel while the posterior joint
changes wave timing rather than accepting a one-sided acceleration bias.

This is a new wave-shape actuator, not another gain or reserve-threshold edit.
Support requires capture with the direct compact wake, terminal course miss at
or below the directional allocator's `0.461L`, no anterior `>40 deg` dwell,
posterior dwell at or below `0.681%`, peak normalized force/moment within about
`0.040/0.019`, and arrival in the sampled `15.14--15.34T` class. Falsify on
lost capture, wider terminal course, increased dwell/load, slower arrival
without margin improvement, changed far-field motion, nonfinite commands, or
loss of exact reflection equivariance. Formal CFD is deferred to EvE and is
not evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and classical traveling-wave propulsion
source_mechanism: preserve a propulsive oscillator while sensor feedback temporarily changes posterior phase lag instead of adding raw high-frequency torque
transferable_invariant: keep the evidenced traveling carrier and express unresolved course correction through a bounded wave-shape parameter that returns continuously to cruise
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phases, full-body kinematics, task coordinates, routes, and waypoints
policy_translation: use only the magnitude of normalized body-frame predicted miss and the existing response consensus to increase posterior lag during a closing terminal intercept; retain the established target-signed shared half-cycle steering
falsification: reject if capture margin, arrival, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The required guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass without running CFD. A deterministic
`13,122`-state grid over normalized body-frame target/course geometry, heading
response, both joint angles, and both joint rates produced finite commands
strictly inside the owned `30 rad/T^2` smooth envelope with exact left/right
reflection (maximum error `0.0`). The posterior-lag candidate changed `11,154`
grid states relative to the prefilled tail-residual policy and reached a
maximum command difference of `9.57678 rad/T^2`, confirming an active
wave-shape mechanism rather than a comment or scalar-only edit. These are
algebraic checks only; capture, wake, loads, joint histories, and terminal
margin remain for EvE's formal CFD evaluation.
