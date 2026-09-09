# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held-fish release: interacting
  vortex streets from all four cylinders already fill the target corridor
  while the fish remains at the upper-right boundary. It is initial-condition
  evidence, not a candidate-specific wake phase or route.
- The three byte-identical best sampled policies retain a zero-centered
  traveling bend and actively swim down-left through the merged wakes to first
  crossing at `44.121`. Mean body x velocity is `-0.2470`, exceeding the
  `-0.1848` mean local-flow magnitude, and the head travels
  `-10.910/-4.263L`; the useful route is self-propelled rather than passive
  advection. Their mean/final distance is `1.70618/0.74893L`, force/moment RMS
  is `389/3909`, and mean command energy is `1036.49`.
- The time-to-go-only sample has the same broad diagonal topology but reaches
  later at `45.221`, with `1.71458L` mean distance and higher `439/4345`
  force/moment RMS. The matched improvement establishes the prefilled
  near-target body-course mismatch damper as useful and argues against
  replacing or weakening that route response.
- The assigned parent's inherited shared-response-budget candidate is a
  concrete negative result. Clamping the sum of heading and course responses
  preserved capture but delayed it to `45.727`, worsened mean distance to
  `1.72692L`, and increased force/moment RMS to `449/4408`; only mean command
  energy fell, from `1036.49` to `1025.91`. Its sheet retains the diagonal
  corridor but shows a later, lower terminal approach. Thus aggregate command
  relief does not justify clipping the validated course correction.
- The best policy still reaches both `4.538` joint-rate caps and approaches
  its candidate soft acceleration bound, while inherited evidence says a
  broader optional-propulsion allocator passed below capture and collided.
  The safe unresolved question is therefore whether near-target translational
  misalignment should withhold only the small optional posterior
  amplification, without touching steering or the base propulsive wave.

## Policy hypothesis

Add exactly one mechanism to the best sampled scaffold: approach-gated,
body-course-consistent allocation of optional posterior propulsion. Reuse the
observed body-course-minus-bearing mismatch already validated for terminal
steering. Far from the target, retain the full established posterior residual;
near capture, smoothly withdraw only its aligned/positive-closure
amplification when the measured translation is crossing the line of sight.
Speed confidence prevents a noisy course estimate from suppressing propulsion
near zero motion. Preserve the oscillator, lagged base tail target, independent
heading and course responses, half-cycle steering, yaw-magnitude gate,
course-trend allocator, and soft acceleration limiter.

Expected evidence is preserved first-crossing capture and diagonal wake-entry
topology with a smaller terminal crossing, reduced joint-rate contact or load,
and no material arrival/mean-distance regression. Reject the mechanism if it
loses capture, recreates the below-target collision, delays arrival or worsens
mean distance without material effort/load relief, or weakens upstream
self-propulsion before the approach regime.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and terminal target capture
source_mechanism: preserve the rhythmic propulsive scaffold while approach feedback withdraws only excess drive when measured translation is off course
transferable_invariant: separate indispensable traveling-wave propulsion from optional posterior amplification, and condition only the optional part on normalized body-frame course agreement as range shrinks
nontransferable_details: published gains, dimensional approach ranges, robot or species kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: retain the two-joint state-feedback oscillator and independent route damper, then multiply only the optional posterior residual by a smooth distance-, speed-, and course-mismatch gate
falsification: reject if capture or diagonal topology is lost, upstream propulsion weakens before approach, or arrival and mean distance regress without material rate-contact, load, or effort relief
