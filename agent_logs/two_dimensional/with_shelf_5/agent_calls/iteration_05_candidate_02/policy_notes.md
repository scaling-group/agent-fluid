# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The common prewarm sheet shows the held fish at the upper-right release pose
while the four staggered cylinders have already established interacting vortex
streets across the target corridor. This flow is shared initial-condition
evidence, not a candidate difference.

The inherited right-exit failure never establishes target-directed motion: its
three released frames stay near the upper-right boundary, and the metrics end
after `16.791` with head displacement `(2.175,-0.869)L`, negative `-0.147`
progress, and final distance `14.251L`. The assigned-parent logs supply the
complementary seed failure: adverse advection and a target-blind curl carry the
fish toward the lower boundary after `50.127`, with only about `0.038U` mean
motion relative to local flow. Together they rule out more scalar drive or a
larger static mean-curvature bias.

All four current solver samples reach the target, but only the posterior
half-cycle-curvature policy changes the useful trajectory topology. Its sheet
shows an immediate sharp redirect followed by a comparatively straight,
self-propelled diagonal approach into the merged wake and target. It reaches
the `0.75L` boundary in `43.951`, versus `92.988--93.032` for the prefill,
bearing-rate lead, and local-frequency duty variants; mean distance improves
from about `4.031L` to `2.139L`. This is controlled swimming rather than
passive advection: its mean velocity is `(-0.247,-0.102)` while mean local flow
is `(-0.134,-0.156)`, leaving relative motion `(0.113,-0.054)U`.

The faster policy also lowers total command energy from about `9.05e4` to
`5.31e4`, RMS lateral force from about `95.5` to `49.4`, and RMS moment from
about `1147` to `701`, although its shorter, more vigorous episode has higher
mean command energy (`1208` versus about `973`) and power proxy (`89.7` versus
about `66.9`), and it still reaches both joint-rate and acceleration caps. The
benefit is therefore specifically faster route establishment and lower
episode-integrated load/effort, not removal of saturation or lower
instantaneous actuation.

The actuator distinction matters. The assigned parent tested a near-target
local-frequency half-cycle duty asymmetry and retained the slow broad loop,
arriving at `92.988`; a localized bearing-rate lead likewise arrived at
`93.027`. In contrast, the strong sample kept the anterior oscillator and
posterior lag but redistributed posterior steering curvature onto the
target-favored joint-state half-cycle throughout the bearing-directed turn.
That is a controller mechanism with a semantic improvement, not a scalar gain
delta.

## Policy hypothesis

Use the evaluated posterior half-cycle-curvature controller as the sole
candidate. Preserve the `0.55`-period, `28 deg` anterior state oscillator, the
bounded `8 deg` body-frame bearing bias, the posterior velocity-dependent lag,
and the inherited smooth approach envelope. Reduce the always-on posterior
mean-bias share and add a bounded target-favored posterior curvature term,
with beat side inferred from centered anterior joint state. This preserves the
carrier and approximately preserves cycle-average posterior curvature while
placing steering authority on the useful half-cycle.

The expectation is reproduction of the sampled fast correct-sign redirect and
target entry without the early right exit, slow broad loop, or route
memorization. Falsify the selection if the post-worker rollout loses or delays
capture relative to the sampled `43.951` trajectory, if the alternating
traveling bend collapses, or if force/moment and effort rise without the
sampled distance-integral benefit. Do not interpret unchanged hard-limit hits
as falsification by themselves: prior evidence shows the gain is not a
saturation-removal mechanism.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological turning by asymmetric tail beats
source_mechanism: target-directed half-cycle steering asymmetry superposed on a traveling propulsive bend
transferable_invariant: persistent body-frame turn error can redistribute posterior curvature toward the target-favored joint-state half-cycle while preserving the anterior propulsive rhythm and approximate cycle-average bend
nontransferable_details: published gains and duty ratios, clocked phase, robot or species kinematics, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the normalized bearing-to-anterior-curvature carrier and posterior lag; use the sign of bounded bearing request times centered anterior joint state to gate a parameter-owned posterior curvature boost while reducing the always-on posterior share
falsification: reject if the fast target-reaching topology is not reproduced, capture is delayed or lost, the traveling bend collapses, or load and effort increase without improved distance progress

## Pre-evaluation verification

The candidate is byte-identical to the sampled posterior half-cycle policy
whose prior evaluation reached the target in `43.951` (SHA-256
`23a6c95704632db0ceb779d6317d3808fc43a4858b7331e02e0e36eab2831dc5`).
This is prior rollout evidence for selection, not a claim that the current
worker ran CFD. The prescribed guidance semantic/schema check, Julia policy
contract check, and solver editable-boundary check pass. A no-CFD state sweep
over approach range, bearing, joint angles, and capped joint rates returns only
finite actions and confirms zero action at zero bearing and zero joint state.
