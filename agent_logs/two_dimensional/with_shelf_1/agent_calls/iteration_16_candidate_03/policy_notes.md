# Wake Policy Candidate Notes

## Evidence diagnosis

- The four sampled solver examples all reproduce the same successful rollout:
  target capture at `34.7105`, mean distance `1.62283L`, total/mean command
  energy `46985.9/1353.65`, relative-crossflow RMS `0.24023`, and force/moment
  RMS `68.96/1036.40`. Their only sampled source difference is a comment, so
  they provide replication evidence rather than a parameter-response contrast.
- The common prewarm sheet shows a fully developed, interacting four-cylinder
  wake before release. The released sheet shows an immediate down-left turn,
  followed by a long, self-propelled upstream traverse into the merged wake and
  first-crossing capture. The fish does not simply drift with the wake, collide,
  or lose the target-directed course; the most conspicuous remaining behavior
  is the large initial redirect and sustained high-amplitude body wave.
- The compact diagnostics agree with that visual reading: displacement is
  `(-10.923,-4.166)L`, progress is `0.93991`, mean local flow is
  `(-0.2018,-0.1721)`, and mean relative flow is `(0.1114,-0.0444)`. Both
  joint-speed maxima equal the configured `260 deg/time` limit and both
  acceleration commands reach the `30.0` envelope, while force and moment
  loads remain substantially above the earlier non-burst successful baseline.
- No sampled failure keyframe exists in this workspace. The most informative
  inherited failures therefore bound the comparison: putting bearing trend
  into persistent mean steering exited after `18.304` with negative progress,
  while replacing the proven carrier with a slower/smaller curvature carrier
  became unstable with force/moment RMS `16749.8/290421`. The current carrier,
  raw-bearing mean route, base asymmetry, and acceleration-residual interface
  should remain intact.
- The assigned parent reports response-gated burst arrival at `34.821` with
  force/moment RMS `77.09/1142.74`; the sampled coherent speed-release child
  improves these to `34.7105` and `68.96/1036.40`. Inherited step-10 and
  step-11 logs are slower (`34.9415` and `34.8535`) and more highly loaded.
  Joint-speed pressure is therefore useful only as a coherent release of the
  optional burst, not as a reason to change the propulsive gait or mean route.

## Policy hypothesis

Replace the optional burst's bearing-window response cue with direct
targetward body-yaw response. Bearing-window rate mixes heading change with
line-of-sight sweep caused by translation and wake advection; `heading_rate`
isolates the yaw response that a burst redirect is intended to produce. A
positive response is `soft_sign(bearing) * heading_rate`, normalized by the
existing bearing scale and control period. All other controller mechanisms and
parameters remain unchanged, including coherent two-joint speed-pressure
release and signed assisting-moment release.

Expected result: preserve the sharp correct-sign redirect, upstream propulsion,
and capture while releasing surplus burst on physical yaw response rather than
translational bearing closure, reducing force/moment load or limit contact
without lengthening the route. Falsify the candidate if it loses capture,
changes the coherent redirect-and-traverse topology, worsens arrival/mean
distance, or fails to reduce load/limit pressure enough to justify the new
observation.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: strong bounded curvature for large heading error, released when targetward heading response appears
transferable_invariant: a transient redirect should be gated by target error and released by measured maneuver response while the cruise rhythm and persistent route feedback remain intact
nontransferable_details: published gains, species-specific C-start kinematics, clocked CPG phase, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: replace optional-burst bearing-window closure with bounded `soft_sign(bearing) * heading_rate * control_period / bearing_scale`; retain normalized body-frame bearing, joint-state phase, coherent two-joint speed pressure, and the two-acceleration contract
falsification: reject if capture or route topology is lost, arrival or mean distance regresses, or force/moment and actuator-limit evidence does not improve enough to support direct yaw-response release
