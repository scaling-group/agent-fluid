# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `initialization_mode=uniform_direct`, `direct_quiescent_init=true`, no
  prewarm, no cylinders, and `U_infinity=(0,0,0)`. All four capture, so the
  informative failure is actuator protection rather than a failed termination
  class.
- The top-down vorticity and oblique Lambda2 rows for the fastest
  uncancelled-work governor and the independently guarded comparison both show
  self-propulsion: an alternating wake grows at the tail, remains coherent
  through the broad initial turn, and follows the fish to capture. There is no
  visible background advection or 3D wake breakup to justify replacing the
  established response-aware capture scaffold.
- The uncancelled positive-work governor is the strongest trajectory sample.
  It advances the `10/8/6/2L` milestones to
  `6.496/8.938/11.220/16.027T`, captures at `17.688T`, and improves the
  distance integral to `1.96419L`. Against the dominant-joint governor it is
  `0.302T` faster, but its head path is longer (`12.330L` versus `12.170L`),
  anterior/posterior residence above 99% of the rate bound is worse
  (`12.13/2.02%` versus `8.44/0.89%`), and peak planar force/yaw moment is
  higher (`0.03198/0.01651` versus `0.02909/0.01499`).
- The uncancelled governor sums nonnegative carrier work and applies one scale
  to both carrier commands. When only one joint needs protection, that common
  scale can weaken inward or reversal work at the other joint. Its faster
  trajectory therefore does not establish the intended actuator-headroom
  benefit, despite the coherent wake and best scalar score.

## Policy hypothesis

Start from the fastest uncancelled-work controller and preserve its full
body-frame target, course, distance, response handoff, carrier/steering
decomposition, and soft output limits. Replace whole-carrier attenuation with
one smooth rate-triggered dissipative coefficient applied against each joint's
measured carrier velocity. This common damping mechanism withdraws kinetic
energy without suppressing carrier restoring/reversal acceleration or directly
scaling either target-conditioned steering residual. It should retain the
fast coherent trajectory while reducing near-bound rate residence and the
force/moment increase. Reject it if capture or the early milestones regress
toward the slower `18.111T` class, if the short-path advantage does not recover,
or if both-joint rate residence, load peaks, command residence, joint margin,
terminal yaw, or either wake view worsens.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: Preserve a posterior-lag traveling bend while measured state modulates rhythmic energy rather than the target-conditioned route command.
transferable_invariant: Actuator protection should dissipate excessive carrier kinetic energy without erasing the coupled traveling-wave structure or bounded steering authority.
nontransferable_details: Published gains, dimensional frequencies, full-body envelopes, species-specific kinematics, exact vortex phases, and task-specific routes.
policy_translation: Use normalized maximum joint-rate proximity to set one bounded damping coefficient, apply it against both observed joint velocities inside the carrier channel, and retain the normalized body-frame target, course, distance, and steering residuals.
falsification: Reject if capture, early milestones, distance integral, short path, coherent top-down and oblique wakes, joint margin, terminal yaw, or load class regresses, or if near-bound residence is not lower than the uncancelled-work sample.
