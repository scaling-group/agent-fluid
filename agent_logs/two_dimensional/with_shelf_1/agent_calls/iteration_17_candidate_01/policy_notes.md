# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The common prewarm sheet shows the fish held upper-right of four fully
  developed, interacting cylinder streets. This is the same initial condition
  for every sampled policy, not controller-specific evidence.
- All four sampled released sheets are byte-identical successes. They show a
  sharp down-left redirect, a coherent traveling bend during sustained
  upstream motion, and direct first-entry capture. The metrics corroborate
  active propulsion rather than passive advection: head displacement is
  `(-10.923,-4.166)L` while mean local flow is `(-0.2018,-0.1721)`, and the
  fish reaches in `34.7105` with mean distance `1.62283L`.
- The replications also reproduce the remaining pressure signature exactly:
  `46985.9/1353.65` total/mean command energy, `0.24023` RMS relative
  crossflow, `68.96/1036.40` force/moment RMS, contact with both `260 deg/time`
  joint-speed limits, and both commands touching the `30.0` policy envelope.
- No sampled failure keyframe exists, so a visual success/failure comparison
  is impossible in this workspace. Inherited failures provide only a textual
  boundary: bearing trend placed in persistent route steering exited after
  `18.304` with negative progress, while wholesale carrier replacement became
  unstable with force/moment RMS `16749.8/290421`. The carrier, raw-bearing
  route ownership, base asymmetry, and residual interface therefore remain
  unchanged.
- The assigned parent and inherited logs establish that coherent max-joint-
  speed release improves the optional burst over independent joint release,
  whereas adding previous-command pressure regresses arrival (`34.7105 ->
  35.1285`), mean distance (`1.62283L -> 1.64127L`), energy (`46985.9 ->
  47457.0`), and force/moment RMS (`68.96/1036.40 -> 71.47/1078.27`). Another
  scalar pressure gate is not justified.

## Policy hypothesis

Preserve the validated carrier, posterior lag, raw-bearing mean steering and
reserve, course-slip correction, signed assisting-moment credit, base
half-cycle asymmetry, and coherent two-joint speed release. Change one semantic
element: release the optional redirect burst from direct targetward body-yaw
response instead of line-of-sight bearing-window closure. Bearing-window rate
mixes rotation with target-line sweep caused by translation; `heading_rate`
isolates the physical yaw response the burst is intended to produce. A smooth
bearing sign admits only yaw in the requested direction, while opposing yaw
leaves established authority intact. No new scalar gain is introduced; the
response remains normalized by the existing bearing scale and control period.

Expected evidence is preservation of capture and the redirect-to-upstream
trajectory with earlier withdrawal of surplus burst once correct-sign yaw is
observed. Falsify the candidate if it loses capture, worsens arrival or mean
distance materially, changes the coherent route, or fails to reduce load or
limit pressure enough to justify replacing the established response cue.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: strong bounded curvature for large heading error, released when targetward heading response appears
transferable_invariant: a transient redirect should be gated by target error and released by measured maneuver response while cruise propulsion and persistent route feedback remain intact
nontransferable_details: published gains, species-specific C-start kinematics, clocked CPG phase, dimensional frequency, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: replace optional-burst bearing-window closure with bounded `soft_sign(bearing) * heading_rate * control_period / bearing_scale`; retain normalized body-frame target geometry, joint-state phase, coherent two-joint speed pressure, and the two-acceleration contract
falsification: reject if capture or route topology is lost, arrival or mean distance regresses, or force/moment and actuator-limit evidence does not improve enough to support direct yaw-response release
