# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the frozen initialization contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, finite moving-window shifts, and no numerical instability.
  Their translation is self-propulsion rather than advection.
- The combined sheets show the useful mechanism in both required views. The
  top-down rows develop an alternating red/blue mid-plane wake, and the oblique
  rows show organized three-dimensional caudal Lambda2 structures. The
  `solver_8cbc18979df7` failure preserves that wake but makes a broad curling
  pass, reaches only `1.733L`, loops across its old path, and exits high at
  `6.793L`; propulsion or wake breakup is not its primary failure.
- The assigned parent `solver_e9097b34f122` adds a target-angle/yaw-response
  gated C-bend to that approach allocator and changes the failure into capture
  at `21.225T`, with mean distance `2.182L`. The sampled
  `solver_28bd83fceb82` instead gates the terminal bend by actual body-frame
  velocity-course error; it also captures and is slightly better at `21.170T`
  and `2.178L` mean distance. Its mean absolute commands are about
  `(18.65,18.03) rad/T^2`, below the assigned parent's
  `(21.33,19.74) rad/T^2`, while both retain coherent wakes and similar
  command-limit residence. Course error is therefore the better evidenced
  terminal response coordinate, although the performance difference is small.
- The course-redirect trace still applies the full distance/closing drive
  relief even as its course response improves. From about `18T` to capture,
  distance falls from `2.99L` to `0.75L`, speed remains about `0.74--0.75U`,
  and the joints settle near a static aligned bend with nearly zero command.
  This supports a conservative release of drive relief from observed course
  response; it does not support a new oscillator, a larger command bound, or
  scalar-only route-gain tuning.

## One-candidate hypothesis

Use the sampled velocity-course redirect as the successful scaffold. Add one
continuous response coupling: multiply near-target drive relief by a bounded
course-misalignment factor with a nonzero floor. When measured speed is
meaningful and velocity course remains misaligned with the full body-frame
target direction, retain the curvature-dominant approach. As course aligns or
speed becomes too small to define a useful course, restore part of the
joint-state traveling wave while keeping the same bounded mean bend. This is a
single semantic mechanism; all cadence, curvature, and command limits remain
unchanged.

Expected evidence: preserve the far-field alternating wake and the sampled
capture topology, but maintain slightly more propulsive activity during the
aligned portion of approach and reduce arrival time or mean distance. Falsify
the mechanism if capture is lost, the path reverts to the `1.733L` broad loop,
course error grows near the capture disk, wake coherence worsens, or command
and joint-limit residence rises materially.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and biological burst redirect
source_mechanism: measured directional response continuously releases a curvature-dominant maneuver back toward a propulsive rhythm
transferable_invariant: preserve a posteriorly lagged traveling bend, allocate actuation to mean curvature only while normalized body-frame velocity course is observably misaligned, and restore drive as course response improves
nontransferable_details: published gains, species-specific bend envelopes, dimensional cadence, clock phase, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: compute target and velocity-course angles from `target_body_L` and `velocity_body_U`; use bounded speed-weighted course misalignment to modulate the existing distance/closing drive relief and terminal aligned bend, with joint state retaining gait phase
falsification: reject if the sampled capture is not preserved, arrival or mean distance does not improve, the broad-loop failure returns, or wake coherence and actuator-limit histories worsen
