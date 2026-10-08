# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled solver diagnostics and the inherited split-yaw rollout report
direct uniform initialization in still water, zero imposed velocity, and
finite `left_domain` termination. Their combined top-down and oblique sheets
show self-propulsion: an alternating mid-plane street and tail-connected
three-dimensional Lambda2 structures form by about `4T` and remain visible
through exit. The common failure is trajectory control, not advection or wake
collapse. Every path eventually crosses the upper boundary while the target
is below it.

The prefilled posterior-mean controller reaches only `9.880L` at its
`11.594T` upper exit. A `3 deg` course-triggered anterior redistribution
preserves the full wake, survives to `23.260T`, and improves minimum/final
distance to `4.419/6.383L`. Increasing that redistribution to `4 deg` reaches
an even better `3.161L` at `18.227T`, but then recedes to `8.569L` before its
`27.572T` upper exit. At closest approach those two fish are still moving at
about `0.833U` and `0.846U`; their body-frame target-to-velocity angles are
approximately `-pi/2` and `-1.49 rad`, respectively. Their anterior/tail
actions also spend about `42.7/55.7%` and `44.1/56.7%` of the rollout above
90% of the soft acceleration limit. Thus small early redistribution is a
positive route mechanism, but the new limiting failure is a fast middle
approach followed by overshoot, not insufficient far-field drive.

The inherited independently bounded yaw-recoil hypothesis is a concrete
negative result: despite retaining the full nominal wave, it exits at
`10.626T` and reaches only `10.738L`. Its keyframes show a shorter leftward
path, and its tail still spends `42.1%` of the run above 90% of the soft
acceleration limit. Do not add another yaw channel or rely on lower effort as
a route remedy in this carrier.

## Single candidate hypothesis

Start from the best-score `3 deg` redistribution controller: retain its
joint-state Van der Pol rhythm, complete posterior lag, crossflow residual,
centerline course brake, yaw term, bounded posterior mean, and soft action
limit. Add one approach mechanism only. Smoothly reduce the anterior
oscillator's limit-cycle amplitude as normalized head-to-target distance falls
below roughly `5L`, while leaving frequency, phase lag, and steering curvature
unchanged. The gate is negligible at the `12.328L` release, becomes material
only after broad leftward progress exists, and bottoms at 60% nominal
amplitude. Because the posterior target remains referenced to the actual
anterior state, the traveling-bend topology is preserved while propulsion is
relieved relative to steering.

The expected semantic change is slower target-line crossing, more time for
the existing bearing/crossflow/yaw feedback to rotate the velocity toward the
target, and less receding motion after the `3--4L` closest-approach regime.
Falsify the mechanism if it fails to beat `4.419L`, recedes without improving
the upper-exit class, loses the alternating 3D wake, stalls outside the
approach gate, or increases joint saturation and force/moment peaks relative
to the `3 deg` carrier. The new CFD evaluation occurs after this worker exits
and is not evidence claimed here.

bookshelf_consulted: true
source_domain: fish terminal capture control and closed-loop robotic-fish rhythmic modulation
source_mechanism: preserve target-directed propulsion far away, then continuously relieve excess rhythmic drive during a fast approach while retaining steering and phase organization
transferable_invariant: when a propulsive carrier reaches a useful closest approach at high speed and then recedes, schedule propulsion-to-steering authority from normalized target distance rather than increasing far-field curvature
nontransferable_details: published gains, species-specific approach distances, dimensional frequencies, exact vortex phases, prescribed routes, and source-platform braking kinematics
policy_translation: use finite normalized `distance_L` to reduce only the joint-state oscillator amplitude through a smooth bounded gate; retain body-frame bearing, relative crossflow, target-to-velocity course, recent yaw, posterior lag, and the sampled 3-degree course redistribution
falsification: reject if closest approach does not beat 4.419L, the fish stalls before the gate, the same receding upper exit persists without useful delay, or wake coherence, saturation, and loads worsen
