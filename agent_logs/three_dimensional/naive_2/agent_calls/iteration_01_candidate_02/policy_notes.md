# Candidate wake-policy notes

## Evidence diagnosis

Only the common naive seed is sampled in this fresh lineage, so no successful
finite comparator or inherited candidate log is available. The rollout does
confirm the required direct, uniform still-water initialization. In both the
top-down mid-plane sheet and the oblique Lambda2 sheet, the fish generates an
increasingly coherent alternating wake and moves under its own actuation, but
the wake accompanies an uncontrolled clockwise curl rather than a useful
target approach. The top-down path crosses the desired heading near 4T and
then continues turning until the fish travels upward out of the virtual field.

The trace supports that visual reading: distance improves only from 12.328L to
12.078L, then worsens to 12.380L at the `left_domain` termination at 8.547T.
Body-axis angle changes from +0.506 rad to -0.782 rad; reconstructed body-frame
bearing starts at +0.155 rad, crosses zero near 4T, and reaches about -1.18 rad
by 8T. Thus the early correct-sign rotation is not arrested after alignment.
The naive raw acceleration commands also exceed the 1800 deg/T^2 actuator
limit on about 32% of joint-1 samples and 34% of joint-2 samples, so a visually
strong wake alone cannot establish an efficient or well-controlled gait.

## Policy hypothesis

Preserve the seed's state-feedback oscillator and posterior phase lag because
they do create self-propulsion. Add one target-vector-to-mean-curvature
mechanism: a positive body-frame bearing requests a bounded positive mean tail
tangent, while a bounded recent-yaw term opposes continued rotation after the
bearing crosses the centerline. Apply a smooth acceleration envelope at the
known actuator limit so this steering test does not rely on raw commands far
beyond the physical contract.

Expected testable change: the initial positive bearing should shrink without
the large negative-bearing overshoot, the fish should remain inside the field
past 8.547T, and minimum/final distance should improve while retaining an
alternating posterior wake. Falsify the translation if the initial bearing
grows, the same upper-boundary curl remains, the softened drive loses forward
progress, or joint-limit residence/load excursions replace the original
failure.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and classical elongated-body propulsion
source_mechanism: sensor-driven mean-curvature bias layered on a posteriorly lagged traveling bend
transferable_invariant: retain a directional posterior wave for thrust and use bounded target-error asymmetry with rotation damping for turning
nontransferable_details: published gains, species amplitudes, dimensional beat frequencies, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing and recent yaw rate to a bounded posterior mean-tangent target within the two-joint state-feedback oscillator
falsification: reject if bearing does not converge before the seed's 8.547T exit, target distance does not improve, the coherent wake collapses, or actuator/load saturation remains dominant
