# Wake-policy candidate notes

## Prior-evidence visual diagnosis

The shared prewarm sheet establishes the common initial condition: the held
fish starts high and downstream of four developed, interacting vortex streets,
with the target inside the merged second-row wake. The four current sampled
solver sheets are byte-identical replications of the same strongest finite
policy, not four independent mechanisms. After release, that policy first
redirects from the upper-right starting pose, then maintains a coherent
posterior-lagged traveling bend while traversing left through the wake and
crosses the target circle from the right. The metrics confirm self-propelled
targeting rather than passive advection: it reaches `0.74927L` after `49.142`
released time, has head displacement `(-10.914,-4.207)L`, mean distance
`2.1560L`, and finite RMS relative crossflow/force/moment
`0.230/39.05/617.13`.

The inherited curvature-centered failure supplies the informative visual
contrast. It remains to the right of the useful corridor, reverses through a
compact loop, and finishes in a body/vortex blow-up. That agrees with
`unstable_dynamics`, minimum distance `9.238L`, only `0.227` progress, RMS
relative crossflow `1.138`, and force/moment `16749.8/290421`. Broadly slowing
and shrinking the carrier therefore did not create safer navigation.

The inherited direct acceleration-residual success reaches the target in
`62.304` time with mean distance `2.460L`. Reserving steering inside a `30.0`
candidate acceleration envelope produced the replicated best result above:
arrival improved to `49.142`, mean distance to `2.156L`, and mean command
energy to `1272.3`, although force and moment increased and both joint speeds
still touched the episode cap. A later speed-headroom guard retained target
reach and lowered RMS force/moment to `25.90/497.89`, but arrival regressed to
`55.732`, mean distance to `2.294L`, and total command energy rose from
`62522` to `70189`; its small mean-effort reduction is not rewarded by this
zero-effort-weight score. Thus the next mechanism should preserve the proven
carrier rather than attenuate it.

## Candidate policy hypothesis

Keep the replicated best oscillator, posterior lag, bearing residual,
acceleration envelope, and fixed minimum steering reservation. Add one compact
error-scheduled redirect mechanism: when the absolute normalized body-frame
bearing is large, smoothly increase the fraction of the steering residual
reserved inside the same envelope; as bearing approaches zero, continuously
return to the proven `0.20` cruise reservation. The mechanism cannot raise the
`30.0` acceleration ceiling. It instead weakens the carrier half-cycle that
opposes an urgent turn while leaving aligned propulsion unchanged. This should
shorten the visible initial redirect without the inherited velocity guard's
continuous propulsion loss.

Expected test: retain coherent leftward propulsion and target reach while
reducing arrival time or mean distance below the replicated `49.142` and
`2.156L` baselines. Falsify the redirect if it produces a tighter off-route
curl, loses capture, delays arrival, materially increases loads without a
distance benefit, or merely reproduces the fixed-reservation trajectory. The
new CFD result is unavailable to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish closed-loop CPG direction tracking
source_mechanism: large observed direction error temporarily prioritizes bounded turning asymmetry before a continuous return to the propulsive gait
transferable_invariant: allocate more directional half-cycle authority for large persistent body-frame error and restore the validated cruise allocation as alignment improves
nontransferable_details: species-specific C-start shape, published gains, robot actuator limits, clocked phase, dimensional beat rate, exact vortex phase, and task route
policy_translation: map absolute body-frame bearing through a smooth bounded schedule that increases only the steering-reserve fraction inside the existing two-joint acceleration envelope
falsification: reject if capture or coherent propulsion is lost, arrival or mean distance regresses, off-route curvature grows, or loads rise without a route benefit
