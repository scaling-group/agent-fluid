# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet is byte-identical across the sampled solvers. It
  shows the fish held at the upper-right release while four developed,
  interacting vortex streets fill the target corridor, so it is a common
  initial condition rather than candidate-specific wake-phase evidence.
- Every current sampled solver reaches the target. The best released sheet
  retains the established zero-centered traveling bend, actively swims
  down-left through the merged wakes, and enters capture without cylinder
  contact or a domain exit. Its mean body x velocity is `-0.2470`, stronger
  upstream than the `-0.1848` mean local flow, and its head moves
  `-10.910/-4.263L`; the useful trajectory is self-propelled rather than
  passive advection.
- The assigned parent's near-target course-mismatch damper is now a matched
  positive result. Relative to the otherwise identical time-to-go-capped
  predictor, it improves arrival from `45.221` to `44.121`, mean distance from
  `1.71458L` to `1.70618L`, score from `0.165860` to `0.173450`, and
  force/moment RMS from `439/4345` to `389/3909`. Command-energy mean rises
  only from `1030.39` to `1036.49`. The keyframes preserve the same diagonal
  wake-entry topology while showing less terminal excursion, so this supports
  preserving the course damper and propulsive scaffold.
- The most informative inherited degraded controller is not a failed
  termination but a poor finite capture: adding an independent signed
  line-of-sight-rate forecast created a long down-then-up loop, arrived at
  `70.790`, raised mean distance to `2.71465L`, and scored `-0.817366`. Its
  lower `200/2132` force/moment RMS does not compensate for the corrupted
  route. The inherited actual failure boundary is broader optional propulsion,
  which passed below capture and collided after a `1.872L` closest approach.
- The current best still reaches the `4.538` joint-rate cap on both joints and
  approaches its candidate soft acceleration limit at `28.79/28.39`. The
  policy separately bounds heading-rate response, but then adds the validated
  course response outside that angular bound. This supports an authority-
  allocation test in the slow route channel, not extra propulsion, another
  signed wake residual, or a scalar gain sweep.

## Policy hypothesis

Add exactly one mechanism to the successful scaffold: a shared bounded angular
response budget for heading-rate prediction and near-target course-mismatch
damping. Preserve both evidenced terms, sum them, and clamp their combined
forecast by the existing heading-response limit before forming predicted
bearing. Opposing yaw and course corrections can still cancel, while aligned
corrections cannot stack into a larger route command than the already tested
heading-response envelope. Leave the oscillator, posterior lag, half-cycle
steering, yaw-magnitude gate, positive-closure residual, course allocator, and
soft acceleration limiter unchanged.

Expected evidence is preserved first-crossing capture and diagonal topology,
with arrival and mean distance matching the assigned parent and either less
rate-limit contact or lower force/moment load. Reject the mechanism if it loses
capture, delays arrival or worsens mean distance beyond deterministic replay
variation without a material load benefit, recreates the inherited loop or
below-target collision, or increases command effort or hydrodynamic loads.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal approach control
source_mechanism: bounded sensor-feedback route residual around a preserved low-dimensional propulsive rhythm
transferable_invariant: preserve the propulsive gait and keep compatible yaw-response and measured-slip corrections inside one bounded slow route-response authority envelope
nontransferable_details: published gains, dimensional response horizons, robot or species kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: sum the normalized body-frame heading-rate forecast and distance-gated body-course mismatch response, clamp their combination with the existing angular-response limit, and feed the result to the unchanged yaw-gated two-joint half-cycle law
falsification: reject if capture or diagonal topology is lost, arrival or mean distance regresses without material load relief, or the long-loop or below-target failure topology returns
