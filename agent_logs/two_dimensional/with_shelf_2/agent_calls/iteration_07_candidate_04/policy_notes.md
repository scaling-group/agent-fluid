# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheets are byte-identical and show the fish held above
  and downstream of four developed, interacting cylinder streets. The wake is
  therefore a common initial condition rather than evidence for a particular
  candidate.
- All four sampled released sheets are also byte-identical. Their policy files
  differ only in comments, and every rollout reproduces `target_reached` at
  `51.47`, final/minimum distance `0.748L`, mean distance `1.82L`, displacement
  `-11.28/-4.94L`, command-energy mean `995`, and force/moment RMS `426/4084`.
  The keyframes show an active traveling body wave, continuous diagonal
  down-left self-propulsion through the merged wake, and first crossing of the
  target circle; this is not passive advection. These duplicates establish
  deterministic materialization only, not robustness or further improvement.
- No informative failure sheet is present in the current sampled solver set.
  The assigned-parent and inherited notes supply bounded negative context: an
  ungated response-aware version approached to `1.65L` but folded into a lower
  exit with `487/4680` force/moment RMS, while a low-load posterior-curvature
  controller passed above the target and exited upward after approaching only
  `2.43L`. Those results support preserving the distributed propulsive scaffold
  and magnitude-only yaw gate; they do not establish a signed disturbance
  convention.
- The remaining measurable weakness in the successful reference is high
  steering/load effort during a capture that terminates at the circle's edge.
  After three consecutive inherited completions with the identical mechanism
  and outcome, another comment clone or scalar-only gain change would add no
  semantic evidence.

## Candidate hypothesis

Preserve the successful zero-centered oscillator, posterior velocity lag,
heading-response bearing prediction, distributed half-cycle steering, and
absolute-yaw-load gate. Add one mechanism only: a smooth function of normalized
`distance_L` that attenuates the already gated steering residual as the fish
enters the terminal approach, while retaining a nonzero steering floor. The
symmetric traveling bend is not distance-gated, so propulsion remains active
and the failed recentered-equilibrium architecture is not revisited.

At route-scale distance the new factor tends to one, making the candidate
nearly identical to the sampled successful controller. Near capture it should
reduce unnecessary asymmetric acceleration and yaw loading without coasting
before first crossing. The post-exit CFD evaluation falsifies this hypothesis
if target capture is lost or delayed enough to worsen the distance history, if
the diagonal topology or strong upstream travel changes materially, if loads
or effort fail to fall, or if a boundary, collision, instability, or nonfinite
termination appears. Because the current evaluation stops at first crossing,
it cannot establish station keeping or post-capture stability.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: preserve rhythmic propulsion while continuously reducing only route-steering modulation during the near-target approach
transferable_invariant: once broad target-directed propulsion works, use normalized target distance to relieve excess steering near capture without suppressing the propulsive rhythm
nontransferable_details: published gains, dimensional distances and frequencies, species-specific kinematics, CPG topology, exact vortex phases, capture radius, and task-specific routes
policy_translation: multiply only the yaw-gated distributed two-joint half-cycle residual by a smooth floor-bounded function of state.distance_L; leave the zero-centered traveling bend unchanged
falsification: reject if target success, upstream displacement, or distance history regresses, if effort and yaw load do not improve, or if terminal relief causes a miss or boundary exit
