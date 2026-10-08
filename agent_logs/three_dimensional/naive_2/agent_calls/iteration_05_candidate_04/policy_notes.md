# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts report direct uniform initialization in still water,
zero imposed flow, no cylinders, and `left_domain` termination. Their combined
keyframe sheets show self-propulsion rather than advection: alternating
mid-plane vorticity and tail-connected three-dimensional Lambda2 loops develop
and remain coherent through exit. The failure is shared route topology, not
wake collapse: every fish hooks toward the upper virtual boundary while the
target remains below and to the left.

The assigned parent's crossflow-assisted posterior-mean controller
(`e6b85456cd83`) was the prior useful carrier, reaching `10.513L` at
`10.785T`. The prefilled centerline-course-brake child (`80d41cb1405d`)
materially improves that evidence: it survives to `11.594T`, moves the center
to `x=17.386L`, and improves minimum/final distance to `9.880/9.880L` while
retaining the coherent wake. At integer-time samples, its course brake acts
near the target-line crossings; by `10T` distance is `10.249L`, and at `11T`
it is `10.013L`. Thus the speed-gated target-versus-velocity cue is useful
when concentrated near the centerline, even though the fish still reaches
`y=15.201L` before the correction can prevent exit.

The other samples delimit the next test. A course cue without the crossflow
residual reaches only `11.303L`. Carrier-phase subtraction from yaw reaches
`11.165L`. A large-bearing response-gated anterior redirect reaches only
`11.081L`, lowers maximum anterior joint speed from `4.54` to `3.42 rad/T`,
and therefore repeats the known risk of disturbing the anterior carrier.
Those results reject another always-on course term, phase-yaw gain edit, or
large late head bend. The remaining evidence-backed question is whether the
validated course brake needs a small earlier steering lever rather than more
total curvature.

## Single candidate hypothesis

Keep the prefilled anterior Van der Pol carrier, full posterior lag, relative-
crossflow residual, yaw damping, centerline course brake, `12 deg` tail-end
mean, and smooth acceleration bounds. Use the same normalized course-response
cue to shift the anterior oscillator equilibrium by at most one quarter of
the tail curvature envelope. This shift is active only with established
forward speed and near the target line. Build the posterior target from the
actual anterior angle, not its recentered carrier coordinate, so the posterior
relative mean compensates the head shift and the total tail-end mean remains
the already tested command. The mechanism therefore redistributes curvature
forward during the predictive brake without increasing endpoint curvature or
installing a permanent anterior bend.

The testable expectation is an earlier reduction of upper drift while
retaining the prefilled rollout's leftward progress and alternating wake.
As a non-CFD boundedness check, replaying the prefilled observations through
the new gate would request at most `2.21 deg` of head shift, with `0.72 deg`
RMS and magnitude above `1 deg` on `17.3%` of samples; it therefore remains
well below and much less persistent than the failed `7 deg` redirect.
Falsify the mechanism if minimum distance does not beat `9.880L`, the same
upper exit occurs no later than `11.594T`, anterior maximum speed falls toward
the `3.42 rad/T` redirect result, or tail saturation and hydrodynamic loads
materially exceed the prefilled rollout's `31.4%` near-limit tail action,
`0.0257` peak force coefficient, and `0.0138` peak moment coefficient.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and transient body-curvature steering
source_mechanism: sensor feedback temporarily redistributes mean body curvature around a persistent rhythmic carrier
transferable_invariant: preserve the thrust-producing oscillator and posterior lag while applying a bounded steering shape only when observed target-relative course indicates an imminent line crossing
nontransferable_details: published gains, oscillator clocks, robot morphology, species-specific bends, dimensional timings, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target-to-velocity course error with forward-speed and bearing gates to shift the anterior equilibrium slightly; compensate the posterior relative target with the actual anterior angle so total tail-end mean curvature is unchanged
falsification: reject if upper drift is not delayed beyond the 11.594T baseline, closest approach fails to beat 9.880L, the anterior carrier slows materially, or actuator saturation and loads increase
