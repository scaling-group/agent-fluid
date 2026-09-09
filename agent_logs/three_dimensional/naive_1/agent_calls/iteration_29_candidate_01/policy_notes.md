# Coordinated acceleration-projection candidate

## Evidence diagnosis before the edit

All four sampled evaluations are valid direct-uniform, zero-inflow,
zero-cylinder moving-window rollouts, and all capture. The best scalar sample,
`solver_649d7e789a5a`, is executable-identical to the assigned prefill
`solver_d2a3f8408b10`: they capture at `18.8265T` and `18.8815T` with mean
distances `2.08855L` and `2.08896L`. A third sample retains the same
redistribution carrier but adds a rearward route multiplier; it arrives at
`18.9640T` with mean distance `2.09072L`. The most
informative negative comparator is the isolated broadside-reserve sample
`solver_de4c121e5685`: it crosses earlier at `18.7055T`, but its mean distance
worsens to `2.09386L`. Thus the present evidence supports preserving the
simpler half-cycle redistribution rather than stacking another route channel.

Both rows of all four combined keyframe sheets show genuine self-propulsion:
an energetic alternating top-down street develops from initially still water,
the street bends smoothly toward the target, and compact caudal Lambda2
structures persist through capture. The broadside reserve does not create a
meaningfully different wake class. These visual claims agree with monotonically
useful distance progress and finite force/moment histories. They do not imply
efficient actuation: across the four traces, anterior/posterior acceleration
commands sit at the `1800 deg/T^2` bounds on `60.84--61.17%` and
`72.97--73.27%` of rows, while joint-rate contact is `10.85--11.07%` and
`14.67--14.93%`.

## Policy hypothesis

Preserve the complete target-geometry, response-release, displacement-phase,
and common-envelope redistribution carrier. Replace only independent
componentwise acceleration clipping with a common scale on the raw two-joint
acceleration vector. This keeps the raw anterior/posterior acceleration ratio
and signs whenever either joint exceeds the envelope, while retaining the full
available acceleration on the dominant component. The change is a coordinated
actuator-allocation mechanism, not a gain change. It should retain the coherent
traveling wake and capture route while reducing rectangular two-joint command
clipping and, potentially, downstream rate contact. Reject it if capture or
either wake row is lost, if mean distance leaves the evidenced
`2.08855--2.09072L` carrier band, or if rate/load contact is not reduced enough
to compensate for any arrival penalty.

bookshelf_consulted: true
source_domain: classical reactive fish swimming and low-dimensional robotic-fish rhythmic control
source_mechanism: a directed traveling bend with posterior lag, preserved as a coordinated rhythmic command
transferable_invariant: actuator limiting should preserve the instantaneous direction and anterior/posterior relationship of the two-joint traveling-bend command
nontransferable_details: published gains, dimensional beat frequencies, species-specific body envelopes, full-body waveforms, and exact vortex phases
policy_translation: normalize the raw two-joint acceleration pair by one bounded common scale derived from its largest component, using only joint state and the existing normalized body-frame target feedback
falsification: reject if capture, the two-view coherent wake, or the established mean-distance route band is lost, or if coordinated projection fails to improve rate/load behavior enough to justify any arrival cost
