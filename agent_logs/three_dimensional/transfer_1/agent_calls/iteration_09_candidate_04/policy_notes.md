# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- All four sampled diagnostics satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and a moving inertial storage window. The visual motion is
  therefore self-propulsion, not background advection.
- The assigned parent (`solver_5c5f9d80447b`) retains a coherent alternating
  top-down wake and compact paired three-dimensional Lambda2 structures, but
  its phase-compensated bearing/yaw-rate cascade follows the wrong broad route.
  It reaches only `3.0031L`, then leaves the left boundary at `32.0485T` with
  final distance `8.8259L`. The target remains displaced from the trajectory
  in the late top-down frames; more rate-loop gain is not supported.
- The most informative sampled near miss (`solver_a8af0d71b0de`) shows that the
  achieved-course outer loop fixes broad routing and reaches `1.2669L`.
  However, opposing-half carrier attenuation stops laying down a substantial
  new alternating wake after the pass: the late top-down body is nearly
  straight and the oblique sheet has only weak isolated structures. The trace
  corroborates the visual collapse, ending with joint excursions near zero
  while the fish coasts below the target to a lower-boundary exit at
  `30.1180T`.
- The strongest sampled policy (`solver_29faa601686c`) preserves the same
  traveling-bend carrier and achieved-course route, releases shared steering
  only when joint-compensated yaw shows a correct response, and restores it
  when inertial line-of-sight motion predicts a growing miss. Its top-down row
  retains a coherent reverse-vortex street through the terminal approach and
  its oblique row retains paired three-dimensional wake structures. It reaches
  first-crossing capture at `0.7493L` and `18.6065T`, with monotonically useful
  terminal progress rather than the repeated lower-exit topology.
- Inherited optimizer logs sharpen the comparison: additive target-normal
  velocity curvature worsened a `0.9532L` carrier-preserving pass to `1.0561L`,
  and response release without a line-of-sight guard reached `0.9312L` but
  still exited below. The sampled guarded release is the positive completion
  of that sequence. The current candidate therefore selects this demonstrated
  mechanism without scalar-only gain tuning or an unevaluated extra residual.

## Candidate hypothesis

Replace the assigned parent's bearing/yaw-rate mean-curvature cascade with the
sampled successful achieved-course servo plus response-gated steering release.
Compute inertial line-of-sight angular rate from the normalized body-frame
target and velocity cross product, so beat-frequency body yaw cannot falsely
authorize release. Preserve the propulsive carrier on both half-cycles and
smoothly restore only the existing bounded shared steering when line-of-sight
motion predicts a miss. This should retain the evidenced coherent wake and
change the assigned parent's `left_domain` result to capture. Falsify the
hypothesis if evaluation loses capture, weakens the alternating wake, changes
the broad course before `4L`, or increases instability/load excursions; do not
interpret a scalar improvement without semantic capture as confirmation.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: release strong bounded curvature after measured heading response, while preserving the rhythmic carrier and re-engaging on persistent target-motion error
transferable_invariant: separate propulsive rhythm from a bounded redirect command and schedule redirect authority from observed response plus target-relative motion
nontransferable_details: species kinematics, published CPG gains, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: retain the joint-state traveling bend; use body-frame target-versus-achieved-course error for the route request, joint-compensated yaw for response release, and the target/velocity cross product divided by range squared to veto release during a growing inertial line-of-sight miss
falsification: reject if capture is lost, the far route changes, the coherent terminal wake collapses, saturation or loads materially worsen, or the former lower-exit topology returns
