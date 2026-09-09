# Wake-policy candidate notes

## Evidence diagnosis

- The sole sampled parent is a finite but unsuccessful L64 rollout in direct
  uniform still water (`U_infinity=0`, no cylinders or prewarm): score
  `-12.215352`, `left_domain` at `26.180 T`, minimum distance `6.179719 L` at
  about `17.160 T`, and final distance `10.595663 L`.
- The top-down row shows self-propulsion and a strong, alternating coherent
  wake rather than passive advection.  The oblique Lambda2 row confirms a
  persistent three-dimensional vortex train without visible instability, so
  the posterior-lag drive is useful and should be preserved.
- Target alignment initially improves: reconstructed body-frame bearing falls
  from `+8.88 deg` at release to `-2.02 deg` by `4.00 T`, while heading falls
  from `29.00 deg` to `18.19 deg`.  The controller then reverses into a large,
  sustained lower-boundary arc: bearing reaches `75.46 deg` at `16.01 T`,
  distance begins increasing after the closest approach, and the fish exits at
  center `y=0.797639 L`.
- The parent combines bearing, vector angle, bearing trend, recent turn rate,
  sweep/recovery branches, tail curvature, and half-cycle steering.  Its raw
  requested acceleration exceeds `1800 deg/T^2` on `70.4%` of joint-1 rows and
  `77.0%` of joint-2 rows.  This makes the initial correct-sign turn followed
  by severe overshoot more informative than the scalar score alone.
- There are no inherited optimizer logs in this workspace and no second solver
  sample to support wake-rejection or terminal-capture machinery.  Those
  mechanisms are deliberately excluded from this candidate.

## Policy hypothesis

Preserve the joint-state Van der Pol drive and lagged posterior target that
produced useful propulsion.  Replace the stacked transferred 2D steering law
with one compact, reflection-symmetric controller: bounded body-frame target
bearing requests a mean tail curvature, and observed recent yaw rate brakes
that request before centerline crossing.  A small same-sign anterior
acceleration gives the curvature request prompt authority; a smooth
controller-owned acceleration bound prevents the policy from relying on the
episode's hard clamp.  The candidate is falsified if the initial correct-sign
turn is not arrested near zero bearing, the lower-boundary trajectory topology
persists, coherent propulsion collapses, or commanded acceleration remains
effectively saturated.

bookshelf_consulted: true
source_domain: classical fish and robotic-fish turning with an undulatory traveling bend
source_mechanism: target-conditioned mean-curvature bias with body-rate feedback
transferable_invariant: preserve posterior-lag propulsion while a bounded target-relative average bend turns the swimmer and measured yaw rate brakes overshoot
nontransferable_details: published gains, species-specific amplitudes, dimensional beat frequencies, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing and recent yaw rate to one bounded two-joint curvature request; retain joint-state phase and posterior lag; smoothly bound final accelerations
falsification: reject if bearing does not settle after the initially correct turn, the fish again exits low, wake coherence or distance progress collapses, or command saturation persists
