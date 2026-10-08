# Candidate diagnosis and hypothesis

## Sampled evidence

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders, finite dynamics, and
  capture after `239` moving-window shifts at `16.0544T`.
- In both rows of the combined keyframe sheets, the fish is self-propelled
  rather than advected. The top-down row develops a persistent alternating
  wake from a nearly quiescent release through the final approach; the oblique
  Lambda2 row shows the same three-dimensional alternating structures without
  a collision, wake collapse, or instability. The three step-22 combination
  variants are pixel-identical despite distinct source hashes.
- The most informative relative failure is the yaw-damping-only sample. It
  retains the same wake and capture step but finishes at `0.746051L`, distance
  integral `1.930012L`, and score `-0.047113`, whereas each sampled combined
  redirect-handoff plus yaw-damping policy reaches `0.745943L`, `1.929921L`,
  and `-0.047001`. Thus the combined response is a reproducible but terminal-
  scale improvement, not a new route or semantic success.
- The inherited terminal trace diagnosis still exposes an unaddressed response
  component: while projected miss and closing speed improve over the last
  `0.0715T`, bearing reopens from `0.021` to `0.178 rad` and bearing rate rises
  from `0.568` to `2.716 rad/T`. The present yaw damper reacts to measured body
  yaw, but the body-frame target ray and velocity also show a same-direction
  translational line-of-sight drift. Treating that slip separately is a new
  feedback mechanism; changing another release threshold is not.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve a propulsive rhythm while sensor feedback supplies a bounded residual correction; near capture damp yaw and slip without coasting prematurely
transferable_invariant: separate the established traveling-wave carrier from a target-relative terminal disturbance and correct only the measured residual that is still reopening the line of sight
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: retain the evaluated carrier, redirect handoff, yaw damping, wave shaping, and anterior release; add one bounded posterior mean-curvature correction from translational target-line rate computed with normalized body-frame target and velocity, active only inside the closing capture corridor
falsification: reject if the term changes pre-corridor milestones or the coherent two-view wake, delays or loses capture, increases distance integral or final crossing error, or merely duplicates the existing yaw damper without changing feasible posterior action

## Candidate hypothesis

The target-relative translational line-of-sight rate is
`(target_y*v_forward - target_forward*v_lateral)/distance^2`. Its sign is
reflection-odd and its magnitude is normalized by the carrier frequency. A
smooth gate will open only when this rate has the same sign as the reopening
bearing, the straight-course miss lies inside the existing capture corridor,
the fish is closing, and distance is below `0.90L`. Subtracting at most one
degree of posterior mean curvature in that direction should complement the
existing two-degree yaw damper during the last fraction of a beat while
leaving cruise, route milestones, and propulsion unchanged. The new CFD result
is not available to this worker; the expectation is specifically a lower
distance integral or tighter final crossing at the same capture class and
arrival step.
