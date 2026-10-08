# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts satisfy the released evidence contract: direct
uniform initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm, finite
dynamics, and `left_domain` termination. In both rows of every combined sheet,
the fish self-propels rather than drifting: a strong alternating mid-plane
street and tail-connected three-dimensional Lambda2 loops develop by about
`4T` and remain coherent through exit. The control failure is planar. The
fish initially advances left and slightly down, then its path and wake axis
arc upward while the target stays below; no wake collapse precedes the exit.

The unrelieved `4 deg` course-redistribution prefill has the best sampled
closest approach, `3.161L` at `18.227T`, but it is still moving at about
`0.846U` with body-frame bearing `-0.985 rad` and target-to-velocity course
error `-1.488 rad`. It then recedes to `8.569L` and exits high. The `3 deg`
version reaches `4.419L` and recedes to `6.383L`. Distance-only anterior
amplitude relief activates while useful closure is still strong and worsens
the closest approach to `5.126L`; course-misalignment damping is worse still
at `6.397L`. At the unrelieved prefill's `6/5/4/3.5L` inbound crossings,
reconstructed closure remains about `0.687/0.823/0.629/0.427 L/T`, so
proximity alone cannot distinguish useful transit from the actual overshoot.
All variants retain high action and joint-speed residence, confirming that
lower scalar effort in the two failed relief variants is not by itself a
route solution.

The assigned parent's completed predicted-miss burst is a further negative
result. Opening the existing anterior redirect from projected miss and closure
worsened its inherited carrier's `3.135L` minimum to `3.448L` and still
receded to `9.596L`. Its signed course cue can also oppose the small bearing
near the first target-line crossing. Do not add another early anterior gate or
more curvature to the already saturated posterior route sum.

## Single candidate hypothesis

Preserve the prefilled `4 deg` transient anterior redistribution, full
joint-state oscillator, crossflow-assisted posterior mean, course brake,
recent-yaw term, posterior lag, and smooth acceleration bound. Add one
terminal hold mechanism at the posterior joint only. A smooth proximity gate
is multiplied by a smooth closure-deficit gate; therefore the complete
posterior traveling wave remains active during strong inbound progress. When
the fish is near and measured normalized closure approaches zero or becomes
negative, reduce only the oscillatory posterior lag component while retaining
the anterior rhythm and the bounded posterior steering mean. If closure is
restored, the wave continuously returns without a stage flag or clock.

This translation tests propulsion-to-steering redistribution rather than a
new scalar gain: it changes neither the far route nor the anterior carrier,
and it does not ask proximity to brake a still-useful approach. The expected
semantic change is preservation of the `3.161L` inbound path followed by less
post-minimum recession and enough retained mean-curvature authority to bend
back toward the target. Falsify it if closest approach worsens materially, the
same receding upper exit persists, closure-gated tail relief destroys the
alternating wake, or joint/load excursions increase beyond the unrelieved
carrier (`|F_x|<=0.0200`, `|F_y|<=0.0276`, `|M_z|<=0.0175` in the sampled
trace). The new CFD rollout occurs only after this worker exits and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: terminal fish capture control combined with elongated-body posterior-thrust organization
source_mechanism: retain the propulsive traveling wave during targetward closure, then continuously shift posterior actuation from oscillatory thrust toward steering when near-target closure stalls
transferable_invariant: posterior wave amplitude is a propulsion lever, so terminal relief should depend on normalized measured closure as well as proximity and should preserve the route mean and anterior rhythm
nontransferable_details: published gains, species-specific tail envelopes, dimensional capture distances, exact vortex phases, source-platform braking kinematics, and task-specific routes
policy_translation: multiply only the posterior oscillatory lag target by a bounded product of body-frame distance proximity and closing-speed deficit; retain the joint-state oscillator, transient anterior course redistribution, and posterior steering mean
falsification: reject if the 3.161L inbound approach degrades, post-minimum recession or upper exit is unchanged, closure does not restore the full wave, wake coherence is lost, or actuator and hydrodynamic-load excursions grow materially
