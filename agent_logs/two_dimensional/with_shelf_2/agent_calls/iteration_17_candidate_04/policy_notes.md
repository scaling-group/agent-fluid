# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held-fish release condition: four
  developed, interacting vortex streets fill the target corridor while the fish
  is held near the upper-right boundary. It is initial-condition evidence, not a
  candidate-specific wake phase or route.
- Every current sampled solver reaches the target. The three strongest samples
  are functionally identical and reproduce `target_reached` at `44.121`,
  `1.70618L` mean distance, and score `0.173450`; the prefill reaches at
  `45.221`, `1.71458L`, and `0.165860`. Their released sheets share the useful
  topology: a zero-centered traveling bend produces a body wake immediately,
  and the fish swims diagonally down-left through the merged cylinder wakes
  without contact. The best mean body-x velocity (`-0.2470`) is more upstream
  than its mean local flow (`-0.1848`), so the route is self-propelled rather
  than passive advection.
- Relative to the prefill, the sampled near-target body-course mismatch damper
  both improves the route metrics above and lowers force/moment RMS from
  `439/4345` to `389/3909`; its mean command energy rises modestly from
  `1030.39` to `1036.49`. The sheets show the same broad diagonal wake entry,
  with a shallower terminal excursion. This supports adopting the course
  residual while preserving the oscillator and posterior propulsion allocator.
- The inherited matched shared-angular-budget branch is the most informative
  degraded finite result. Clamping heading-rate and course responses together
  still captures, but delays arrival to `45.727`, raises mean distance to
  `1.72692L`, lowers score to `0.153609`, and raises force/moment RMS to
  `449/4408`; only mean command energy improves, to `1025.91`. Its keyframes
  retain the diagonal route but finish after a deeper lateral excursion. Thus
  aligned terminal corrections need their independent authority; a symmetric
  shared cap is not an evidenced load-control mechanism.
- No available current sample is a semantic failure. The inherited failure
  boundary remains broader optional propulsion, which passed below the capture
  circle and collided after a `1.872L` closest approach with `537/4995` loads.
  This candidate does not change the base wave or posterior propulsion.

## Policy hypothesis

Start from the strongest sampled course-damped policy and add exactly one
route-response mechanism: one-sided arbitration when extrapolated heading
response and measured body-course response oppose. Preserve their independent
sum when they agree. When they conflict, compute a bounded, scale-free balance
from their normalized product and smoothly attenuate only the extrapolated
heading response, giving the observed translational course priority during the
already distance-gated approach regime. Leave the oscillator, time-to-go cap,
half-cycle steering, yaw-magnitude gate, positive-closure/course allocator,
posterior lag, and soft acceleration limiter unchanged.

Expected evidence is preserved first-crossing capture and diagonal wake-entry
topology, with less terminal crossing and arrival/mean distance no worse than
the sampled `44.121/1.70618L` reference. Reject the mechanism if it loses
capture, recreates a deeper terminal excursion, delays arrival or worsens mean
distance without a material load or effort benefit, or raises force/moment or
command effort. Fixed-prewarm success would not establish changed-wake
robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-interaction terminal control
source_mechanism: bounded sensor-feedback route residuals preserve an established rhythmic gait while separating persistent target correction from transient yaw response
transferable_invariant: preserve the propulsive rhythm and use normalized body-frame feedback to favor measured translational slip over an opposing extrapolated yaw cue only during approach
nontransferable_details: published gains, dimensional response horizons, robot or species kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: retain independent heading and distance-gated body-course responses when aligned; when their signs oppose, use their scale-free balance to attenuate only heading extrapolation before the unchanged yaw-gated two-joint half-cycle law
falsification: reject if capture or diagonal topology is lost, the deeper terminal excursion returns, arrival or mean distance regresses without material load or effort relief, or hydrodynamic loads increase
