# Carrier-separated line-of-sight-rate candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm. I inspected the combined top-down mid-plane vorticity and oblique
body/Lambda2 rows for the highest-score and weakest-score samples. Both, like
the other two sampled captures, show self-propelled nearly direct down-left
travel behind a compact body-connected alternating wake with localized 3D
posterior structures. There is no visible passive advection, broad loop, wake
collapse, collision, or instability before capture. The sampled policies all
capture at `15.501--16.027T` and `0.74729--0.74998L`; their normalized distance
integrals differ only from `1.90236L` to `1.90787L`. The best score is the
unified response-and-miss handoff (`-0.021089`), while the corridor-gated
shared-release sample is weakest (`-0.025487`).

The assigned parent's inherited actuator-specific consensus candidate also
captured at `0.74916L`, but its `-0.026118` score is worse than all four
samples. Thus corridor, response-only, predicted-miss-qualified, unified, and
actuator-specific release arrangements are all compatible with threshold
capture, but the evidence does not support another rearrangement or scalar
retune of their release gates. The useful carrier, raw far-field route, and
low-load compact-wake topology should remain intact.

The remaining defect is a mismatch between terminal interception geometry
and beat-scale sensing. In the actual adapter, `bearing_window_rate` is the
body-frame head-to-target bearing rate and `turn_rate_recent` is measured body
yaw over the same observation window. Their sum is therefore inertial
line-of-sight rate. A least-squares replay over every sampled state inside
`3L` found that the common two-joint-rate carrier component was approximately
`-2.11*phi_dot[1] + 0.16*phi_dot[2]`. Removing that term reduced within-rollout
line-of-sight-rate standard deviation from `5.97--6.85` to
`0.70--0.80 rad/T`, without replacing raw target position, center course, or
the established far-field predictor. This is offline diagnosis of inherited
evidence, not a claim about the unevaluated candidate.

## Single candidate hypothesis

Preserve the prefilled traveling-bend carrier, pursuit/course blend,
constant-center-course predicted miss, terminal mean bend, response-gated
half-cycle handoff, geometry-qualified posterior-pulse release, and all of
their gains. Add one terminal observation mechanism only: form an inertial
line-of-sight rate from the two matched-window measurements, subtract its
rollout-evidenced joint-rate carrier, map the residual smoothly to a bounded
turn request, and blend a small share into the existing terminal request only
under the already established `3L` distance gate. This supplies phase-separated
terminal damping while leaving the far-field route and propulsive rhythm
unchanged.

Support requires capture with a lower distance integral or earlier arrival
than the `-0.023351/16.027T` prefill, or repeat evidence showing a wider capture
margin, while retaining the direct route, compact alternating wake, negligible
`>40 deg` dwell, comparable rate reserve, and normalized planar force/moment
near or below the sampled `0.035/0.019` scale. Falsify on loss of capture,
another left exit or larger miss, phase-locked command chatter, route change,
wake broadening, joint/load growth, nonfinite action, or loss of reflection
equivariance. The new CFD evaluation occurs only after this worker exits.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological steering superposed on a preserved propulsive rhythm
source_mechanism: separate fast carrier-correlated motion from persistent target-direction feedback before modulating rhythmic steering
transferable_invariant: estimate and remove the observable rhythmic carrier from a target-relative rate, then apply only a bounded residual correction while preserving propulsion
nontransferable_details: published CPG gains, species-specific kinematics, dimensional frequency, exact vortex phase, robot linkage geometry, task coordinates, route, and the rollout-fitted coefficients themselves
policy_translation: combine normalized body-frame bearing-window rate with matched-window yaw rate, subtract a two-joint-rate carrier owned by policy parameters, and blend the bounded residual into the near-target two-joint request without changing far-field control
falsification: reject if capture or closest pass and termination fail to improve together, or if direct routing, compact wake, joint reserve, low normalized loads, boundedness, or reflection symmetry degrades
