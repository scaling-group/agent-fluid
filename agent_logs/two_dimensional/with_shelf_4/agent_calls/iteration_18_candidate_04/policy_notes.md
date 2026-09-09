# Wake-policy candidate notes

## Evidence-led diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
developed, mutually interacting vortex streets; it is common initial-condition
evidence, not a policy result. All four sampled released episodes reach the
target, so this sample contains no semantic failure to substitute for the
required visual comparison. The least effective finite example is instead
`solver_5d367b13159b`: its keyframes show a deeper, slower midcourse sweep
before it enters the target wake, consistent with `137.247` arrival and
`4.077L` mean distance. The assigned parent `solver_9925cd6bfbd3` keeps the
alternating bend and takes a tighter targetward arc, but its anterior-only
unconditioned response still reaches the acceleration cap and records
`18.53/362.61` RMS force/moment.

The strongest sampled example, `solver_f54bbab0ba47`, visibly preserves the
same alternating traveling wave while completing a shorter broad arc into the
interacting wakes and reaching in `123.018` units. Its signed-power-conditioned
two-joint response improves mean distance from the parent's `3.685L` to
`3.594L`, total command energy from `110448` to `95084`, RMS crossflow from
`0.1535` to `0.1429`, and RMS force/moment from `18.53/362.61` to
`17.03/334.45`. Compared with the unconditioned two-joint response, it also
improves arrival by `7.711`, energy by `20666`, and both load measures while
reducing peak anterior/posterior bend to `0.438/0.396` rad. It still touches
the anterior acceleration cap, so the evidence supports energy-conditioned
response but not a load-relief or saturation-resolution claim. The inherited
`solver_a88b7a00782c` result (`162.222` arrival, `4.433L` mean distance,
`136964` energy) further shows that retaining capture alone is too weak a
criterion, although its available log does not identify a mechanism and is
therefore not used causally.

## Candidate hypothesis

Keep the assigned parent's successful target-bearing, progress-qualified
half-cycle steering, direct yaw-moment residual, and direct posterior
traveling-wave tracking. Add the sampled signed-power guard only to the
parent's anterior previous-action response. The normalized product of anterior
joint velocity and action-filter lag distinguishes response continuity that is
neutral or removes joint kinetic energy from lag that continues to inject it.
Attenuating only the latter should retain the parent's useful phase continuity
without letting stale anterior action amplify the already capped route-owning
joint. Direct posterior tracking makes this a joint-selective A/B rather than
stacking another posterior or scalar change.

Expected evidence after evaluation: retain `target_reached`, upstream
translation, and alternating bends; reduce anterior bend, command effort, and
force/moment relative to `solver_9925cd6bfbd3` without regressing its
`135.019` arrival or `3.685L` mean distance. Falsify the mechanism if it loses
capture, produces the slower/deeper midcourse topology, removes the traveling
wave, or merely trades lower effort for worse arrival/distance. The current
worker does not claim that outcome before CFD evaluation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual control
source_mechanism: sensor feedback modulates a rhythmic command instead of replacing the locomotor scaffold
transferable_invariant: condition rhythmic actuation changes on bounded observed state feedback so modulation withdraws when its measured effect is adverse
nontransferable_details: published gains, clock-driven phase, robot hardware, species kinematics, exact vortex phase, and source-task routes
policy_translation: preserve the state-encoded half-cycle oscillator and use normalized signed anterior joint power from action lag to attenuate only energy-injecting response; leave posterior lag tracking direct
falsification: reject if capture, upstream progress, or alternating propulsion is lost, or if arrival/distance and effort/load do not improve together against the assigned parent
