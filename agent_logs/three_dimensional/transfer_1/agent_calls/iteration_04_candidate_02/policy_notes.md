# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=[0,0,0]`, no cylinders, and `left_domain`; the images are
  therefore released self-propulsion evidence rather than advection or a
  pre-warm artifact.
- Both rows of the combined keyframe sheets were inspected for the closest
  sampled trajectory (`solver_39c7e6e70772`) and the inherited candidate
  (`solver_95d1e880b3e5`), with the best-score phase-rate rollout
  (`solver_5c5f9d80447b`) as a second failure contrast. In every case the
  top-down row shows a persistent alternating vorticity street and the oblique
  row shows compact alternating three-dimensional Lambda2 structures attached
  to a translating fish. Propulsion and the traveling posterior bend survive;
  loss of wake coherence is not the diagnosed limitation.
- The inherited achieved-course/rate cascade stays on a nearly straight leftward
  trajectory, reaches only `3.1135L`, and exits at `(0.80,11.19)L`. Its trace is
  still moving at about `0.762L/T` at closest approach with course error about
  `-1.60 rad`. The phase-compensated bearing/rate alternative is semantically
  similar (`3.0031L`, left exit). Routing the course residual through the
  bounded posterior-curvature/rate cascade therefore did not retain the useful
  turn of the direct course actuator.
- The direct achieved-course servo with mild distance-only cadence relief makes
  the visibly different useful trajectory: it bends down toward the target and
  reaches `1.5424L` before exiting the lower boundary. At closest approach it
  is still moving about `0.738L/T`, its target-versus-course error is about
  `1.28 rad`, and its requested joint acceleration exceeds the nominal
  `31.42 rad/T^2` envelope on most recorded samples before plant clamping. The
  `0.72` cadence floor did not create enough steering headroom to capture.

## Policy hypothesis

Restore the evidenced direct, speed-gated achieved-course-to-shared-acceleration
path, but place the final action inside the hard acceleration envelope. Add one
continuous terminal control-allocation mechanism: only when distance is small,
closing speed is positive, and achieved course is misaligned, reduce the
oscillator contribution so bounded shared steering owns more of the available
joint acceleration. Outside that conjunction the sampled traveling-bend
carrier is unchanged; after a miss or stall, propulsion returns continuously.
This is intended to retain the direct servo's target-directed arc while
reducing the high-speed below-target pass, without a clock, route, or
world-frame direction.

bookshelf_consulted: true
source_domain: biological/robotic terminal capture and nonsteady fish redirection
source_mechanism: continuous approach hold with drive relief and bounded response-gated redirect
transferable_invariant: preserve the far propulsive gait, then reallocate limited actuation from drive to redirection only when normalized near-target geometry and closing behavior show that excess approach speed competes with capture
nontransferable_details: published gains, species kinematics, exact tail-beat or vortex phase, dimensional distances, and any task-specific route
policy_translation: multiply the joint-state oscillator by a bounded gate formed from distance_L, positive window_closing_speed_L, and body-frame target-versus-velocity course error; retain a bounded shared two-joint steering residual and clamp the composed action
falsification: reject if the alternating wake or early closure weakens before the terminal gate, if drive relief stalls outside 0.75L, if the closest approach fails to beat 1.5424L, or if the same high-speed lower-boundary pass persists
