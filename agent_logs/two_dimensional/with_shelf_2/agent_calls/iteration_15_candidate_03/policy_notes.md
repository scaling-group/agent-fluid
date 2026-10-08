# Wake-policy candidate notes

## Evidence diagnosis before edit

- The shared prewarm sheet is the same common initial condition used by every
  sample: the fish is held near the upper-right boundary while four developed,
  interacting streets fill the target corridor. It provides no candidate-specific
  phase or route information.
- All four sampled released sheets are finite captures and show the same useful
  topology: the zero-centered traveling bend immediately produces a body wake,
  the fish actively swims down-left through the merged streets, and a broad
  lateral correction enters the target circle without approaching a cylinder.
  This is self-propulsion rather than passive advection: the strongest sample's
  mean x velocity is `-0.2416` versus `-0.1768` mean local flow, its head moves
  `-10.962/-4.568L`, and minimum cylinder clearance is `3.404L`.
- The assigned-parent mechanism is a terminal time-to-go cap on heading-rate
  extrapolation. Three samples reproduce it exactly at `target_reached`,
  `45.2210`, mean/final distance `1.71458/0.74854L`, score `0.165860`, and mean
  command energy `1030.39`. The otherwise matched uncapped sample reaches at
  `45.2595` with `1.71529/0.74937L`, score `0.165009`, and energy `1030.54`.
  The cap is therefore a small terminal tracking benefit, not evidence for
  changing the propulsive wave or wake route.
- The remaining visible/metric symptom is terminal velocity-direction
  oscillation. In the strongest trajectory, body-frame target bearing versus
  body-course angle is `0.291/0.879` rad at `2.05L`, `0.572/0.872` at `1.77L`,
  `0.031/-0.368` at `1.15L`, and `-0.051/0.283` at `0.753L`. Thus the fish can
  be aligned in position while its translational course is already crossing
  the line of sight. Both joint rates still touch `4.538` and accelerations
  reach `28.78/28.40`, with force/moment RMS `439/4345`, so extra broad steering
  or propulsion is not supported.
- No sampled solver is a failure. The inherited failure boundary remains the
  propulsive-priority allocator that passed below capture and collided after a
  `1.872L` closest approach with `537/4995` force/moment RMS. This candidate
  leaves the base wave and every posterior propulsion allocator unchanged.

## Policy hypothesis

Add exactly one route-response mechanism to the successful scaffold: a smooth
near-target course-mismatch damper. Compute the signed body-course angle from
normalized body-frame velocity, compare it with target bearing, and subtract a
bounded fraction of that mismatch from the existing heading-response-predicted
bearing. A normalized distance gate makes the residual negligible on the
established far/middle route and increasingly active during approach. The
oscillator, half-cycle steering structure, yaw-magnitude gate, positive-closure
residual, course allocator, and soft acceleration limiter remain unchanged.

Expected evidence is preserved diagonal capture with less terminal course
crossing and no material effort or load increase. Reject this mechanism if it
loses capture, changes wake-entry topology, worsens arrival or mean distance
beyond deterministic replay variation, or increases force/moment or command
effort without a compensating tracking benefit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-interaction approach control
source_mechanism: sensor feedback applies a bounded course/slip residual around an established rhythmic gait during target approach
transferable_invariant: preserve the propulsive rhythm while damping measured body-frame velocity-direction mismatch with the target line of sight as remaining normalized range shrinks
nontransferable_details: published gains, dimensional approach distances, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture radius, and task-specific routes
policy_translation: smoothly gate the difference between body-frame velocity course angle and target bearing by `distance_L`, then subtract that bounded residual from the existing predicted bearing before the same two-joint half-cycle steering law
falsification: reject if target capture or diagonal topology is lost, terminal course crossing persists, arrival or mean distance regresses beyond replay variation, or load or effort rises materially
