# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, and
  finite dynamics. All are self-propelled `left_domain` failures rather than
  advection, collision, or numerical instability.
- The best scalar sample (`solver_5c5f9d80447b`, score `-10.0272`) keeps a
  coherent alternating top-down vortex street and compact oblique Lambda2
  structures, but travels almost horizontally past the target's latitude. It
  approaches only `3.003L`, then exits the left boundary. Its raw acceleration
  exceeds the nominal envelope on about `91.3%` of trace rows and both joints
  reach `260 deg/T`, so adding another undifferentiated acceleration gain is
  not supported.
- The most informative sampled trajectory is the terminal-relief candidate
  (`solver_39c7e6e70772`). Both visual rows retain the traveling wake while it
  turns toward the target and passes below it; the trajectory confirms that
  the head is near `(10.26,8.62)L` at its `1.542L` closest approach, then
  continues toward the lower boundary. Local flow remains bounded
  (`max |u_local| about 0.0255U`) and there is no wake blow-up immediately
  before the miss.
- The inherited note's continuous frequency relief is a concrete negative
  result. It slows the fish to about `0.738L/T` at closest approach but worsens
  the inherited `1.044L` near miss to `1.542L`, retains the same below-target
  pass and lower exit, reaches the `260 deg/T` joint-speed limit, and still has
  raw acceleration outside the envelope on about `95.5%` of rows. Later
  candidates should not deepen scalar cadence relief as the next terminal
  answer.
- Replaying its normalized course guidance shows the route command already
  near `+1` from about `17.5T` through closest approach. The missing capability
  is therefore steering realization under a saturated carrier, not more
  route-error gain. A phase-selective actuator can redistribute existing
  half-cycle authority instead of increasing the already clipped command.

## One candidate mechanism

Use the evidenced achieved-course servo and shared-acceleration steering as
the far-field scaffold. Remove the failed frequency-relief schedule. Inside a
continuous `4L` approach gate, add one half-cycle reallocation primitive:
for each joint, detect from its observed velocity whether it is moving away
from the signed bend requested by the course servo, and attenuate only that
opposing carrier acceleration. The requested-side half-cycle and full carrier
cadence remain unchanged. The operation is bounded, uses only joint phase,
normalized distance, and body-frame achieved-course error, and cannot amplify
the carrier acceleration.

Expected test: reproduce the course servo's far-field closure exactly outside
`4L`, preserve the alternating 3D wake, and turn the terminal path upward far
enough to cross the `0.75L` capture circle while reducing rather than adding to
opposing-half saturation.

Falsification: reject this translation if behavior changes before `4L`, the
traveling wake or forward speed collapses, the attenuation selects the
requested rather than opposing stroke, joint clipping remains persistent
without a closer pass, or the rollout retains the same below-target
`left_domain` topology. A later worker should then test a separately bounded
terminal yaw/slip damper or a longer-horizon course estimator, not more cadence
relief or global course gain.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: steer a rhythmic propulsor by changing the authority of one beat half-cycle while feedback releases the asymmetry when the requested course response changes
transferable_invariant: preserve the traveling carrier and obtain bounded mean turning by reallocating phase-specific authority instead of adding a larger static or broadband command
nontransferable_details: published gains, robot geometry, dimensional cadence, species kinematics, prescribed duty ratios, exact vortex phase, and task-specific routes
policy_translation: use normalized distance and body-frame target-versus-velocity course error for the turn request; use each observed joint velocity as phase and attenuate only acceleration on the half-cycle moving opposite the requested bend
falsification: reject if far-field behavior changes, wake coherence or speed collapses, the wrong half-cycle is attenuated, saturation persists without a closer approach, or the same below-target exit remains

## Non-CFD verification

- The formal synthetic-state policy call returned two finite accelerations
  inside the owned `1800 deg/T^2` bound, and the deterministic parameter-schema
  and solver-boundary checks passed.
- Replaying the sampled terminal-relief states through the old and new policy
  equations gave exact bounded-action equality on all `4159` rows at or beyond
  `4L`. Inside `4L`, the new gate selected both joints' opposing half-cycles
  and kept carrier scales bounded between approximately `0.358` and `1.0`.
  This verifies gating, direction, and the far-field invariance only; it is not
  CFD evidence of a closer trajectory or capture.
