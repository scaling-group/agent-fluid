# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held-fish release condition: four
  developed and interacting vortex streets fill the diagonal corridor while
  the fish is held near the upper-right boundary. It is initial-condition
  evidence, not candidate-specific wake-phase or route information.
- All four sampled solvers are finite captures. The strongest distinct policy
  actively swims down-left through the merged wakes with a zero-centered
  traveling bend and no cylinder approach. Its mean x velocity is `-0.2470`
  versus `-0.1848` mean local flow, and the head moves `-10.910/-4.263L`, so
  the useful route is self-propelled rather than passive advection.
- The matched near-target course-mismatch damper is a positive result over the
  time-to-go-only scaffold: arrival improves from `45.221` to `44.121`, mean
  distance from `1.71458L` to `1.70618L`, score from `0.165860` to `0.173450`,
  and force/moment RMS from `439/4345` to `389/3909`. Mean command energy rises
  modestly from `1030.39` to `1036.49`. The keyframes retain the same wake-entry
  topology and show less downward terminal excursion, supporting a small
  terminal route-response refinement while leaving propulsion unchanged.
- An inherited sibling tested a shared clamp around heading-rate and course
  responses. It retained capture but regressed to `45.727`, `1.72692L`, and
  score `0.153609`, while force/moment RMS rose to `449/4408`. This rejects
  limiting the course damper inside the pre-existing heading-response budget;
  the two observed corrections need independent bounded authority.
- No current sampled solver is a semantic failure. The inherited actual
  failure boundary remains broader optional propulsion, which passed below
  capture and collided after a `1.872L` closest approach. Both joints still
  touch the `4.538` rate cap in the successful policies, so this candidate does
  not add propulsion, change the base wave, or increase global steering gain.

## Policy hypothesis

Add one state-dependent terminal mechanism to the successful scaffold:
positive normalized range closure modestly strengthens only the already
validated near-target course-mismatch damper. Reuse body-speed-normalized
closing speed so rapid target approach earns extra slip damping, while a stall
or reversal receives the existing course response rather than additional
actuation. Keep the distance and speed-confidence gates, and do not place the
combined heading and course terms inside a shared clamp. Preserve the
oscillator, posterior lag, yaw-magnitude steering gate, half-cycle steering,
posterior allocator, and soft acceleration limiter.

Expected evidence is the same diagonal capture with a shallower terminal
crossing and arrival/mean distance at least matching `44.121/1.70618L`, without
raising force/moment or mean command effort materially. Reject the mechanism
if capture or wake-entry topology is lost, if the terminal path hooks or passes
below the target, or if extra course authority increases cap contact, load, or
effort without a tracking benefit. Fixed-prewarm success would not establish
changed-wake robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal approach control
source_mechanism: sensor feedback schedules a bounded slow route residual around an unchanged rhythmic gait according to observed approach state
transferable_invariant: preserve the propulsive rhythm and use positive body-speed-normalized closure to strengthen only near-target slip damping when translational momentum is carrying the swimmer toward capture
nontransferable_details: published gains, dimensional approach ranges or speeds, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: multiply the distance-gated body-course mismatch residual by a bounded function of positive `closing_speed_L / body_speed`, leaving the heading response and the two-joint propulsive and steering scaffold unchanged
falsification: reject if capture or diagonal topology is lost, arrival or mean distance regresses, the terminal crossing deepens, or rate contact, load, or effort rises without a compensating tracking benefit
