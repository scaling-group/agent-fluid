# Evidence-selected rhythmic-handoff rollback

## Visual diagnosis before policy editing

All four sampled evaluations satisfy the frozen Phase 2 flow contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected each combined keyframe sheet from release to
capture, including the top-down mid-plane vorticity row and oblique
body/Lambda2 row. Every fish self-propels along essentially the same direct
down-left route behind a compact, body-connected alternating wake with
localized posterior three-dimensional structures. No sampled rollout shows
advection, wake collapse, a broad loop, boundary interaction, or instability.
Because every sample captures, the weakest finite capture is the visual
contrast; the assigned-parent logs' `1.01--1.22L` left exits remain the actual
failed-termination boundary.

The useful difference is terminal course. The unified response-plus-predicted-
miss policy captures earliest at `15.5008T`, has the best sampled score
`-0.021089` and distance integral `1.90236L`, and crosses almost horizontally
at velocity `(-1.286,-0.014)L/T`. The prefilled terminal duty-skew policy also
captures and preserves the wake, but arrives at `15.9148T`, scores
`-0.022310`, and crosses strongly laterally at `(-0.711,-1.038)L/T`. It fails
its own requirement of arrival/score comparable to the unified parent and a
course outside the inherited lateral class. The active yaw-arrest sample
similarly crosses at `(-0.774,-1.012)L/T` and `15.8061T/-0.021747`; the
centered-approach drive-relief sample crosses at `(-1.128,-0.647)L/T` and
`15.6738T/-0.022886`. These distinct terminal carrier/authority changes buy no
new termination class, wake improvement, joint/load benefit, or repeatable
margin relative to the unified handoff.

Assigned-parent logs supply the robustness boundary. The unified controller
has a second semantic capture at `15.6625T`, but its known capture-course miss
still spans roughly `0.179--0.590L`, and older threshold-sensitive repeats
missed at `1.01--1.22L` before exiting left. Static bend, broad carrier
braking, posterior phase selection, raw-yaw countersteer, drive relief, and now
duty-duration steering have all failed to improve terminal geometry and
termination together. The evidence supports removing the newly falsified
actuator rather than stacking another terminal correction or tuning a scalar.

## Single candidate hypothesis

Remove only the prefilled terminal duty-skew mechanism and its owned parameter,
restoring the sampled unified response-and-predicted-miss controller exactly.
Preserve the joint-state traveling-bend carrier, posterior lag and mid-stroke
pulse, normalized body-frame pursuit/course blend, constant-course predictor,
terminal mean bend, and common carrier-separated-response plus small-miss
release gate. Released rhythmic steering authority returns to the propulsive
carrier; anterior restoring stiffness no longer changes with terminal course
phase.

The evidence-backed expectation is restoration of the strongest sampled,
semantically replicated direct-capture behavior and removal of the slower,
lateral duty-skew crossing. Support requires capture, or simultaneous closest-
pass and termination improvement, with arrival/score comparable to the unified
captures, raw terminal course miss below the replicated `0.590L` boundary,
the direct compact-wake route intact, negligible `>40 deg` dwell, near-rate
occupancy around `18%` or less, and peak normalized planar force/moment near or
below `0.037/0.019`. Falsify on a left exit or miss, terminal course above
`0.590L`, loss of route or wake coherence, or material joint/load growth. The
candidate's CFD evaluation occurs after this worker exits and is not evidence
claimed here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: return bounded rhythmic steering authority to an autonomous propulsive carrier only after measured corrective response and residual task geometry agree that the redirect is complete
transferable_invariant: neither a transient turn response nor rhythm phase alone completes a redirect; release steering only when normalized body-frame geometric miss is also small
nontransferable_details: published gains and duty ratios, robot linkage geometry, species-specific maneuver timing and curvature, dimensional beat frequency, clock or exact vortex phase, target coordinates, capture pose, and task-specific routes
policy_translation: retain the two-joint state-feedback traveling carrier and use carrier-separated yaw response together with bounded predicted miss as one reflection-equivariant release gate for both rhythmic steering channels
falsification: reject if capture margin or termination worsens, or if terminal course spread, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection symmetry degrades

## Validation boundary

The prescribed guidance-materiality check, lightweight Julia policy-contract
and parameter-schema check, and solver editable-boundary audit pass. The
candidate returns finite two-joint accelerations in the contract probe; every
direct `params.FIELD` reference is owned by `target_policy_params()`. These are
algebraic and repository checks only. Formal CFD is deferred to EvE after
exit.
