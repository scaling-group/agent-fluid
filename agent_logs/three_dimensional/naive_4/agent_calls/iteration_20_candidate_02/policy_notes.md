# Wake policy candidate notes

## Evidence diagnosis before the edit

- The assigned parent is the prefilled terminal yaw-response-release policy.
  The sampled rollouts all report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no prewarm, no cylinders, finite dynamics, and capture
  at `16.05448T` after 2,919 steps and 239 moving-window shifts.
- I inspected the combined sheets for the best finite sample
  `solver_d198bc53b207` and the lowest-scoring informative contrast
  `solver_0b4f3f55c611`. In both top-down rows, the fish develops a strong,
  alternating reverse-street-like wake and turns smoothly onto the target; the
  lateral oscillation is propulsive rather than passive advection. In both
  oblique rows, compact alternating Lambda2 structures remain attached to a
  coherent three-dimensional tail wake through capture. There is no visible
  collision, virtual exit, prewarm artifact, wake breakup, or instability.
  The sheets are effectively indistinguishable at their sampling cadence, so
  they do not support changing the established traveling-bend carrier or
  cruise route.
- Metrics and diagnostics agree with the visual reading. The no-terminal-
  release yaw-residual sample `solver_0b4f3f55c611` captured with distance
  integral `1.93125693L`, final distance `0.74753046L`, and score
  `-0.04865406`. Two copies of the assigned-parent release
  (`solver_10780c7bba63` and `solver_3964226d73c0`) are byte-identical in
  trajectory evidence and improve those values to `1.93077290L`,
  `0.74695450L`, and `-0.04805483` without changing capture time. The sampled
  alignment-escape extension `solver_d198bc53b207` changes only the final 17
  commands/trace states and reaches `1.93077154L`, `0.74695289L`, and
  `-0.04805316`, again with unchanged capture time and wake topology.
- The inherited optimizer logs reinforce both sides of that boundary:
  `solver_344b70e5964e` repeats the assigned-parent `-0.04805483` result,
  whereas the distinct `solver_b2d799c7da39` terminal experiment is worse at
  `-0.04876323`. A terminal gate is therefore not beneficial merely because it
  is local; it must preserve the base steering law and demonstrate better
  distance/crossing evidence.
- Trace reconstruction localizes the remaining mismatch. During the final
  approach the body-frame bearing passes through zero near `0.86L`, then its
  magnitude reopens while the supplemental carrier-residual yaw correction is
  still active. The sampled alignment-escape policy releases it only after the
  stricter predicted-miss corridor begins opening, explaining its very small
  effect. This is a response-allocation issue, not evidence of weak propulsion
  or a need for broader curvature.

## Candidate hypothesis

Add one alignment-turnaround release to the existing supplemental yaw branch.
On a closing approach, use normalized bearing rate to detect growth of absolute
body-frame target bearing and a smooth small-bearing cone to confine the
release to the alignment crossing. This removes only the extra yaw-residual
curvature; the anterior oscillator, base target/course redirect, posterior
traveling wave, one-sided wave relief, actuator allocation, and the existing
safe-corridor release remain unchanged. The release restores itself
continuously if the bearing grows outside the cone, so a large unresolved turn
cannot coast.

Expected evidence: all `8/6/4/2/1.25L` milestones and the coherent two-view
wake remain unchanged, while terminal bearing rebound and final/distance-
integral error improve by more than the corridor-only alignment release. Reject
the mechanism if it affects the pre-approach route, delays or loses capture,
weakens the coherent alternating wake, or improves command effort without a
distance benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological terminal approach control
source_mechanism: modulate a rhythmic carrier from measured directional response, with near-target yaw or slip relief that does not remove necessary propulsion
transferable_invariant: separate the proven propulsive rhythm from a bounded response correction, and release only the correction when measured target alignment shows that it has become counterproductive
nontransferable_details: published controller gains, clock-driven CPG phase, species-specific kinematics, exact vortex phase, and source-task routes
policy_translation: use body-frame bearing, bearing rate normalized by the joint-state carrier frequency, target distance and closing response to gate only supplemental posterior mean curvature in the two-joint acceleration contract
falsification: reject if cruise milestones or wake coherence change, capture is delayed or lost, the release persists for a large bearing error, or terminal distance and distance integral do not beat the corridor-only release
