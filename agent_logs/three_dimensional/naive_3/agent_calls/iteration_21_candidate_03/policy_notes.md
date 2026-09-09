# Candidate diagnosis and hypothesis

The four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite dynamics. In both
the top-down vorticity and oblique Lambda2 rows, all four fish self-propel from
rest, retain a long coherent alternating three-dimensional wake, make the same
broad clockwise arc past the target, and remain powered until they cross the
lower boundary around `31.2--31.7T`. The motion is therefore not advection, and
the repeated failure is terminal course control rather than absent propulsion
or wake breakup.

The assigned parent's course-selected anterior duty action reaches only
`2.433L` minimum / `8.434L` scored mean distance and exits low. The simpler
yaw-selected posterior brake reaches `2.385/8.436L`; the response-gated
posterior equilibrium S-bend is worse at `2.536/8.436L`. The sampled posterior
phase-lag modulation is the strongest current result at `2.326/8.424L`, but it
also exits low at `9.213L` final distance. At its closest approach (`17.908T`),
speed is still `0.687U` and target-ray-to-course error is `1.088 rad`; inside
`2.7L`, mean speed remains `0.684U` and mean absolute course error is
`1.544 rad`. Its anterior/posterior acceleration clamps are already occupied
for about `0.749/0.355` of samples, so more drive or command limit is not an
evidence-backed remedy.

Policy hypothesis: retain the coherent alignment-gated carrier, yaw-selected
posterior brake, command reserve, and phase-lag actuator topology of the best
sample. Replace its distance/course-error-only phase activation with a bounded
forming-miss selector: normalized body-frame lateral target geometry must be
large and normalized target closure must have fallen before joint-velocity phase
can shift posterior lag. This asks for the evidenced non-equilibrium action
only when a lateral pass is forming, while leaving far-field propulsion and
the mean-curvature equilibrium unchanged. The candidate is falsified by the
same lower-exit topology without material improvement below `2.326L`, by a
tight curl or upper exit, by degraded coherent cruise progress, or by increased
actuator-limit residence without capture or a target-return leg.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and two-joint traveling-wave control
source_mechanism: sensor-gated posterior phase-lag modulation preserves a propulsive traveling bend while changing turn authority over selected beat phases
transferable_invariant: route error should select a bounded posterior wave-shape change through observed beat state, while the propulsive carrier and mean equilibrium remain intact
nontransferable_details: published gains, clock phases, species-specific envelopes, exact tail kinematics, dimensional frequencies, and task-specific routes
policy_translation: combine normalized body-frame lateral target geometry with normalized closing response, then use measured anterior joint velocity as beat phase to modulate posterior lag within the two-joint acceleration contract
falsification: reject if capture, recovery, termination class, or a material closest-approach improvement below 2.326L does not occur, or if the change breaks wake coherence, curls tightly, or raises limit residence
