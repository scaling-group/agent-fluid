# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed cylinder streets merge around the target. It is
  common initial-condition evidence; agreement under this snapshot does not
  establish robustness to a changed wake phase.
- All four sampled released sheets are finite `target_reached` outcomes, so no
  sampled failure sheet is available. They show the same useful control
  topology: a coherent body-generated traveling wake, active diagonal
  down-left swimming, one broad correction in the merged wakes, and a low-side
  first crossing of the capture circle. The best-score sample
  `solver_8708084c57e3` reaches at `45.26` with `1.7153L` mean distance,
  `0.7494L` final/minimum distance, `1030.5` mean command energy, and `439/4342`
  force/moment RMS. Mean x velocity is about `-0.241`, versus `-0.177` local
  flow, confirming self-propulsion rather than passive advection.
- The prefilled yaw-only positive-course gate reaches slightly earlier at
  `45.11` and has lower `416/4183` force/moment RMS, but its `1.7191L` mean
  distance, `1034.8` mean command energy, and `0.1610` score are weaker than
  the best sample's `0.1650`. An unconditioned course residual reaches at
  `45.61`, with `1.7222L` mean distance and `453/4406` loads. Adding rate
  headroom plus a near-distance gate also reaches at `45.61`, with `1.7208L`
  and the largest sampled `475/4653` loads. The evidence favors rate headroom
  combined with yaw gating, without distance scheduling, on only the positive
  course-earned tail residual.
- The inherited additive course-over-ground correction is a concrete negative
  boundary. It preserved capture but regressed to `45.72`, `1.7666L` mean
  distance, and score `0.1142`; its much lower `272/2896` force/moment RMS shows
  that reducing aggregate load alone is not a better route controller. The
  older propulsive-priority allocator passed below capture and collided at
  `58.93` after only a `1.872L` closest approach. These results rule out direct
  translation-drift steering and broad propulsion reallocation here.

## Policy hypothesis

Replace the prefilled yaw-only allocation of positive course-earned posterior
motion with the sampled asymmetric headroom allocator: positive course
convergence earns the small closure-conditioned tail residual only when both
normalized joint-rate usage and yaw load leave headroom, while negative course
feedback retains its full suppressive authority. Preserve the zero-centered
oscillator, posterior phase lag, predicted-bearing half-cycle steering,
positive-closure qualifier, and smooth acceleration limiter.

This is a feedback-allocation mechanism, not scalar-only gain tuning. The
expected fixed-snapshot result is materialization of the sampled best-score
trajectory while avoiding the high-load regression of the rate-plus-distance
gate. Falsify it if the downstream replay loses `target_reached`, meaningfully
exceeds `1.7153L` mean distance, arrives later than the `45.61` baseline without
a material load reduction, or no longer reproduces the coherent diagonal
topology. A replay under the identical snapshot still does not establish wake,
geometry, inflow, or target robustness.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow route-conditioned rhythm modulation from fast wake/body yaw response while preserving the propulsive oscillator
transferable_invariant: withdraw only optional positive route-conditioned propulsion when observed actuator usage or yaw response is already large, without cancelling the base traveling wave or useful negative course correction
nontransferable_details: published gains, oscillator parameters, dimensional rate and moment scales, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: normalize maximum joint-rate usage by the candidate oscillator rate scale and combine its smooth headroom gate with the existing normalized yaw-load gate only on positive bearing-convergence amplification of the small posterior residual
falsification: reject if capture, mean-distance history, or diagonal topology regresses, or if rate and load symptoms worsen without a compensating score or route benefit
