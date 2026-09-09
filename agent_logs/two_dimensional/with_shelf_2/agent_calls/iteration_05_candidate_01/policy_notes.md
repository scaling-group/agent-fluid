# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the same upper-right release
  pose while four developed cylinder streets merge across the target corridor.
  Because this initial condition is common, the released trajectory differences
  below are attributable to controller structure rather than wake maturity.
- The assigned posterior-curvature parent actively travels `-10.51L` upstream
  with much lower force/moment RMS (`116/1278`) than the distributed policies,
  but its keyframes arc above the target wake, reverse into a near-vertical
  posture, and exit the upper boundary after `84.22`. Its `2.43L` closest and
  `6.64L` mean distances show that low aggregate load alone does not supply the
  target-directed anterior steering that this release needs.
- The distributed heading-response sample takes the complementary bad route:
  it reaches `1.65L`, then folds into a nearly vertical downward exit at
  `75.09`, with force/moment RMS `487/4680`. The related bearing-rate variant
  also exits downward and reaches only `6.45L`. These outcomes reject another
  scalar increase or response-prediction tweak on ungated half-cycle steering.
- The sampled yaw-magnitude-gated distributed policy is the only semantic
  success. Its keyframes show sustained self-propulsion along the diagonal,
  entry into the merged wake, and first crossing of the `0.75L` target circle
  at `51.47`; metrics agree with `0.748L` final/minimum distance, `1.82L` mean
  distance, and `-11.28/-4.94L` head displacement. It retains high but finite
  load (`426/4084`) and stays just inside the candidate-owned acceleration
  limit. This directly confirms the inherited load-gate hypothesis and makes
  it a stronger candidate than the assigned parent.

## Candidate hypothesis

Materialize the successful distributed half-cycle scaffold with its smooth,
floor-bounded gate on `abs(moment_z_L2)`. The normalized moment magnitude is
used only to reduce the target-steering residual; it cannot suppress the
zero-centered traveling bend. This is a structural transfer from the sampled
success, not a scalar gain sweep. Do not add a signed wake residual in this
candidate because the compact evidence reports RMS/mean loads but no
sign-resolved event correlation from which to validate the convention.

The next CFD rollout falsifies this candidate if the successful termination is
not reproduced, if closest/mean distance regress beyond the assigned parent's
`2.43L`/`6.64L`, or if a new saturation, collision, instability, or boundary-
exit topology appears. A later worker may test directional disturbance
feedback only after sign-resolved evidence links moment or crossflow to a
specific route-error event.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve rhythmic propulsion while bounding target-steering modulation during large observed hydrodynamic yaw loads
transferable_invariant: a normalized body-frame load magnitude may reduce only the steering residual during strong disturbances while leaving the traveling propulsion wave active
nontransferable_details: published gains, dimensional load scales, species-specific kinematics, CPG topology, exact vortex phases, and task-specific routes
policy_translation: retain the zero-centered two-joint traveling bend and response-aware distributed half-cycle steering; multiply only that steering term by a smooth floor-bounded function of abs(moment_z_L2)
falsification: reject if target success is not reproduced, propulsion or approach regresses, loads become unstable, or the gate merely changes the boundary-exit direction
