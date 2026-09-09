# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

The shared prewarm sheet establishes the common initial condition: the held
fish starts high and downstream of four fully developed, merging cylinder
wakes. In every current sampled rollout, the steering-prioritized policy then
self-propels rather than merely drifting. Its posterior traveling wake remains
coherent while the fish makes a strong initial turn, settles onto a leftward
track through the interacting wake corridor, and crosses the `0.75L` target
circle after `49.142` released time units. The metrics agree with the visible
motion: head displacement is `(-10.914,-4.207)L`, final/minimum distance is
`0.74927L`, mean distance is `2.15598L`, and progress is `0.93969`.

All four sampled solver candidates are the same controller and produce the
same trajectory and metrics, so they establish deterministic reproduction but
not four independent mechanism comparisons. Inherited logs provide the useful
comparators. The raw bearing-residual parent also reached the target, but after
`62.304` with mean distance `2.4600L` and command-energy mean `1436.3`; the
current steering-reserve allocator improved those to `49.142`, `2.1560L`, and
`1272.3` while keeping acceleration below the episode hard cap. Conversely,
the slow curvature-equilibrium variant stayed at least `9.238L` away and ended
in the visibly compact vortex/load blow-up after `121.517`, with RMS
force/moment `16749.8/290421`. That failure rules out broad carrier slowdown as
an effort fix.

The successful sheet still shows a large early heading correction before the
fish settles onto the target corridor. Inherited diagnostics report the same
`4.293L` maximum lateral target offset as the slower successful parent, both
successes touch the joint-speed limit, and the allocator's RMS force/moment
rise from `27.25/525.8` to `39.05/617.1`. Aggregate crossflow is similar across
the successes and has no sign-resolved history, so it does not justify a flow
or force cancellation term. The available body-frame bearing history does
support testing whether steering should account for an already developing
correct-sign turn.

## Candidate hypothesis

Preserve the evaluated `0.55`-period traveling-bend carrier, posterior lag,
same-sign bearing steering, and direction-prioritized acceleration allocator.
Add one bounded feedback mechanism: form the steering request from a short
prediction of body-frame bearing using `bearing_window_rate`. A converging
bearing should release some curvature before overshoot; a diverging bearing
should receive extra correction. Clamp the predicted increment so wake-driven
rate spikes cannot reverse or dominate the persistent target request.

Expected test: retain semantic target reach and coherent leftward propulsion
while reducing the large heading correction, mean distance, effort, speed-limit
contact, or force/moment load. Falsify the mechanism if arrival is delayed
without a compensating load/effort benefit, target reach is lost, the
seed-like lower exit returns, or the same lateral excursion and saturation
remain. The new candidate is not CFD-evaluated in this workspace and is not
claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor-conditioned modulation of a rhythmic carrier using both direction error and observed response
transferable_invariant: persistent direction error should command curvature, while the measured error trend should release or reinforce that command according to whether the turn is already converging or diverging
nontransferable_details: published gains, clocked CPG phase, robot actuator ratings, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: preserve the proven joint-state carrier and allocator, but add a bounded fraction-of-beat lookahead from normalized body-frame bearing window rate to the bearing residual
falsification: reject if target reach or coherent propulsion is lost, or if route compactness, effort, speed-limit contact, and force/moment loads show no compensating improvement
