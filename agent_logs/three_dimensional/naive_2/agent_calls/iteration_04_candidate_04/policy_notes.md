# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled diagnostics report `uniform_direct` initialization,
`U_infinity=(0,0,0)`, no prewarm snapshot, and `left_domain` termination.  The
top-down and oblique sheets show self-propulsion rather than advection: an
alternating mid-plane vortex street and paired three-dimensional tail loops
develop by about `4T` and remain coherent through exit.  They also show the
same useful-but-wrong topology: the body and wake axis hook toward the upper
virtual boundary after roughly `6--8T` instead of settling onto the target
line.

The bearing-plus-yaw posterior-mean controller (`807c205ad607`) exited at
`9.823T` with minimum/final distance `11.512/11.518L`.  Adding a speed-gated
course cue without relative crossflow (`1c13be698c3a`) retained the wake and
improved that to `11.303/11.303L`.  The prefilled response-gated redirect
(`30523fc0e073`) reduced near-limit acceleration residence, but its wave relief
reached only `11.330L` and then receded to `11.546L`; therefore reduced command
saturation alone did not improve the route.  The strongest sampled policy
(`e6b85456cd83`) kept the full posterior wave and added head-relative
crossflow to the posterior mean.  It remained finite to `10.785T`, achieved
minimum/final distance `10.513/10.513L`, and had the lowest mean distance
(`10.638L`), although it still exited through the upper boundary.

The sampled trajectory histories sharpen the visual diagnosis.  In the
crossflow run, beat-averaged bearing falls from about `+0.15 rad` to zero near
`4.4T`, but the delayed turn continues: bearing is about `-0.30 rad` by
`6.6T` and the posterior mean command is mostly saturated in the corrective
direction after `7T`.  The target-versus-velocity course error becomes
negative while forward motion is established and before the large negative
bearing is locked in.  It is therefore useful as an anticipatory brake near a
target-line crossing, but the inherited course and strong lateral-velocity
results do not support replacing the proven crossflow residual or applying a
large course term at every bearing.

## Single candidate hypothesis

Preserve the `e6b85456cd83` zero-mean anterior oscillator, full lagged
posterior wave, relative-crossflow residual, recent-yaw damping, soft
acceleration bound, and `12 deg` posterior mean-curvature envelope.  Add one
bounded centerline course-brake mechanism: construct the signed
target-to-velocity angle entirely in the body frame, gate it smoothly from
zero at rest using forward body speed, and concentrate it near small bearing
with a continuous alignment window.  This should release or reverse the
initial steering before the delayed body response carries the fish across the
target line, without weakening propulsion or adding more far-error
curvature.  The CFD evaluation after this worker exits must falsify the idea
if the negative-bearing accumulation and upper exit are unchanged, if minimum
or final distance fails to improve on `10.513L`, or if joint-limit residence,
loads, or wake coherence materially worsen.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual gait modulation
source_mechanism: sensor feedback modulates a low-dimensional propulsive rhythm, with target geometry supplying route intent and measured motion supplying corrective response
transferable_invariant: preserve the self-sustaining traveling wave while a bounded motion-response cue releases or countersteers route curvature before accumulated course error becomes large
nontransferable_details: published CPG gains, oscillator phases, robot morphology, dimensional speed thresholds, species kinematics, and task-specific routes
policy_translation: retain joint-state oscillator phase and posterior mean curvature; add only a normalized body-frame target-to-velocity course angle, forward-speed gate, and target-bearing alignment window to the existing crossflow-assisted turn command
falsification: reject if the rollout repeats the upper-boundary hook without beating the sampled 10.513L minimum/final distance, loses the alternating 3D wake, or increases saturation and hydrodynamic load excursions
