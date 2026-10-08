# Predictive two-joint envelope candidate

## Visual and trace diagnosis before the edit

- All four current solver samples, the prefilled candidate, and the assigned
  parent's completed solver have the same policy SHA-256. The four samples also
  have the same combined-keyframe SHA-256 and reproduce the same direct-uniform
  still-water capture at `27.6045T` and `0.749769L`. Thus they are useful
  deterministic confirmation of one fixed policy, not four independent
  controller mechanisms or robustness trials. The diagnostics confirm
  `U_infinity=(0,0,0)`, zero cylinders, no prewarm snapshot, and integer-cell
  moving-window transport.
- In the successful combined sheet, the top-down row shows self-propelled
  translation with a regular alternating wake from release through the broad
  approach, followed by continued target-side path rotation into the capture
  circle. The oblique row shows an organized body-attached three-dimensional
  Lambda2 wake rather than advection, wake collapse, or numerical instability.
  Peak planar force and yaw moment are modest (`0.03397` and `0.01548`), and
  terminal speed remains about `0.642L/T`, so the carrier and inertial
  line-of-sight response closure are useful behavior to preserve.
- The inherited informative failure `solver_c38995a8136f` provides the needed
  topology contrast. Both its top-down and oblique rows retain self-propulsion
  and a coherent alternating wake, but the path straightens after the target
  neighborhood and continues left; diagnostics report a `0.831781L` closest
  approach followed by a left-domain exit at `40.073T`. Its lower peak planar
  force/yaw moment (`0.02142/0.00979`) rules out load instability as the reason
  for missing. The sampled capture's continued target-side rotation, rather
  than stronger propulsion or a different wake class, remains the semantic
  improvement.
- The capture is nevertheless actuator-fragile. Across its `5019` trace rows,
  either joint is at or above 95% of the `45 deg` angle envelope for `13.25%`,
  at or above 95% of the `260 deg/T` speed envelope for `36.78%`, and at or
  above 95% of the candidate's `30 rad/T^2` clamp for `44.69%`. Joint 2 reaches
  exactly `45 deg` at `16.918T` (`6.220L` from the target), while joint 1 later
  reaches `44.84 deg` at `20.647T` (`4.192L` away). At both extrema the existing
  controller is already braking, but too late to stop the accumulated joint
  speed before the boundary. This supports anticipation from joint state, not
  another steering, terminal-depth, or propulsion-gain edit.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, sign-corrected body-frame
bearing/course steering, response-released same-sign redirect, projected-miss
release veto, and inertial line-of-sight response residual exactly up to their
two raw acceleration outputs. Add one symmetric state-feedback envelope
mechanism to both joints. For each joint, estimate the angle at which it would
stop under the owned acceleration limit,
`q_stop = q + qdot*abs(qdot)/(2*a_limit)`. When this projected stop travels
toward a boundary and enters a normalized `40--44 deg` guard band, blend the
raw command toward maximum braking opposite the observed joint velocity. In a
separate narrow `250--258 deg/T` band, blend only toward mild braking before
the angle guard is applied. Both gates are bounded smoothsteps, so ordinary
carrier motion and steering allocation remain unchanged outside measured
envelope risk; there is no clock, route, world coordinate, or hidden phase.

The falsifiable expectation is retained capture with the same coherent,
low-load broad approach and continued target-side rotation, while eliminating
the `45 deg` contact and materially reducing speed-limit residence. Reject the
mechanism if capture is lost, minimum distance regresses outside the capture
radius, the terminal line-of-sight turn straightens into the inherited pass-by,
carrier speed or wake coherence collapses, switching increases force/moment
loads, or either angle/speed exposure fails to improve. Because the new CFD
evaluation occurs only after this worker exits, these are prospective tests,
not claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and residual locomotion control
source_mechanism: preserve an established rhythmic carrier while bounded state feedback modifies only the residual actuation required by observed physical constraints
transferable_invariant: useful traveling-wave propulsion should remain intact outside a measured joint-state risk region, and corrective authority should grow continuously only as predicted constraint violation becomes imminent
nontransferable_details: published gains, linkage geometry, dimensional beat timing, species-specific joint envelopes, exact vortex phases, world coordinates, and task-specific routes
policy_translation: use normalized observed joint angle and velocity to predict stopping angle under the owned acceleration limit, then smoothly brake both joints only near the angle or speed envelope after the existing body-frame target response is formed
falsification: reject if capture and organized propulsion are not retained, if angle or speed exposure does not decrease, or if planar force and yaw-moment loads materially increase
