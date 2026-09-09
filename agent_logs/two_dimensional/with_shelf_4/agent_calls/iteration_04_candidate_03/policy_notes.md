# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared held-fish prewarm sheet shows the fish fixed above and to the
  right of the target while four developed, interacting vortex streets advect
  downstream. This is the common release condition, so it supports neither a
  memorized route nor a prescribed wake phase.
- The inherited static-curvature controller is self-propelled but remains in a
  compact far-right loop for the full horizon: it moves only `-1.19L`
  upstream, finishes `10.48L` from the target, and never improves beyond
  `10.28L`. The earlier target-blind seed instead exits downward after `50.13`
  units with saturated joint rates and accelerations. Together with the two
  inherited under-`20`-unit right exits, these failures contradict another
  persistent joint-center bias or scalar-only oscillator increase.
- The current prefill's zero-mean bearing-to-half-cycle controller is a clear
  semantic improvement. It visibly makes a broad targetward arc, sustains a
  traveling bend through the interacting wakes, and reaches the target after
  `179.22` units. Its mean distance is `5.04L`, but the route includes sharp
  yaw changes; RMS lateral force/yaw moment are `18.42/338.91`, and its mean
  command effort is `653.20`.
- The strongest sampled candidate changes one controller mechanism on that
  same `0.72`-period propulsive scaffold: a softly saturated `moment_z_L2`
  residual is added to the bearing route request before half-cycle modulation.
  Its keyframes retain the alternating wave and upstream approach, but it
  reaches in `149.57` units with mean distance `4.38L`, RMS lateral force
  `16.22`, and RMS yaw moment `314.99`. Thus arrival improves by `29.65` units,
  force and moment fall by about `12%` and `7%`, and total command energy falls
  from `117065` to `101995`; mean command effort rises about `4%` because the
  episode is shorter. Its `30.92 rad/time^2` peak acceleration is only about
  `1.6%` below the hard cap, so stronger feedback or a faster gait is not
  supported.
- A different sampled load-feedback combination is an informative failure:
  simultaneously relaxing the period to `0.76`, raising rejection gain,
  and gating the residual by route headroom produces a top-boundary exit after
  `126.43` units, only `-1.12L` upstream displacement, and `12.05L` final
  distance. Because three changes are confounded, this does not isolate the
  bad element; it does show that the direct residual's success cannot be
  generalized to arbitrary gating/gain/period combinations.
- The lower-effort two-joint half-cycle policy also reaches the target, but its
  visibly wandering approach takes `268.49` units. That result supports
  preserving the faster anterior-only steering site rather than trading route
  authority for another effort-only change.

## Candidate hypothesis

Materialize the strongest sampled architecture on the current prefill: keep
the successful zero-mean radial oscillator, state-inferred half-cycle bearing
steering, and posterior lag exactly intact, and add the already evidenced
small direct normalized yaw-moment residual. This is one mechanism change, not
a gain sweep. Target bearing owns the slow route; the residual only trims the
active half-cycle while hydrodynamic torque is present. No clock, cylinder
coordinate, external wake phase, or static curvature is introduced.

The later formal rollout should reproduce target reach while improving arrival,
mean distance, total command energy, and force/moment load relative to the
prefill. Reject this transfer outside the sampled condition if it loses
capture or upstream translation, produces a loop/domain exit, raises RMS load
or cap contact, or if its response is dominated by self-generated beat torque.
Do not increase the residual without new actuator evidence because the sampled
successful realization already approaches the acceleration cap.

bookshelf_consulted: true
source_domain: adaptive biological wake swimming and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate persistent route regulation from a small bounded sensor-mediated response to fast alternating yaw loads
transferable_invariant: normalized body-frame target geometry should own the route while normalized measured yaw load may provide a smaller disturbance residual without replacing the propulsive traveling wave
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact Karman-vortex phase, cylinder coordinates, recurrent-network state, and source-task routes
policy_translation: preserve the sampled bearing-controlled state-inferred anterior half-cycle asymmetry and add the evidenced softly saturated `moment_z_L2` residual to its turn request before the unchanged posterior follower
falsification: reject if target reach or upstream thrust is lost, arrival worsens, looping or boundary exit returns, RMS force/moment or actuator clipping rises, or self-generated beat torque dominates the residual
