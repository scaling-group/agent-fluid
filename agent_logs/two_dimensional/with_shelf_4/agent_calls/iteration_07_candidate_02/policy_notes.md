# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while four developed cylinder streets merge around the target.
  This is the common initial condition, so it supplies neither a fixed route
  nor a reusable vortex phase.
- The informative inherited failure combines a slower gait, stronger moment
  residual, and route-headroom gating. Its released sheet closes into a large
  upper-right loop and exits the top boundary after `126.43` units, moving
  only `-1.12L` upstream and regressing from `8.61L` minimum distance to
  `12.05L` final distance. Moderate RMS moment and feasible joint extrema did
  not diagnose the lost route; the successful scaffold should be extended one
  feedback mechanism at a time.
- The direct-moment controller reaches the target after `149.572` units with
  `4.384L` mean distance, `681.91` mean command energy, `0.1362` RMS relative
  crossflow, and `16.22/314.99` RMS lateral force/yaw moment. Two otherwise
  identical samples with bounded `bearing_window_rate` damping reproduce
  capture at `149.605` units while improving mean distance to `4.358L`, mean
  command energy to `647.93`, relative crossflow to `0.1321`, and force/moment
  to `15.49/308.48`. Their sheets retain the alternating posterior-lagged bend
  and targetward upstream passage, making rate damping a load/route refinement
  rather than a speed mechanism.
- The prefilled progress-qualified descendant changes only that rate term. It
  reaches the target in `137.357` units with `4.184L` mean distance and the
  best sampled score (`-2.242`), while preserving `-10.91L` upstream travel,
  lowering total command energy to `90228`, and reducing RMS crossflow,
  force, and moment to `0.1295`, `14.75`, and `303.02`. Mean command energy
  rises slightly to `656.89`, so the evidence supports qualifying route
  damping with progress, not a generic effort reduction. Its sheet shows a
  quicker broad redirect and successful entry into the second-row wake, but
  the targetward polyline still contains sharp yaw reversals.
- The assigned parent's otherwise identical rate-damped candidate adds only
  unconditional bounded `heading_rate` damping. It still captures, and lowers
  mean command energy to `624.50`, relative crossflow to `0.1275`, force to
  `14.71`, and moment to `298.03`; however, arrival slips to `150.832`, mean
  distance rises to `4.387L`, and score falls to `-2.437`. Its keyframes retain
  the useful route but do not tighten it. Thus measured-yaw damping has a real
  load benefit but resists some purposeful redirects when applied everywhere.

## Candidate hypothesis

Preserve the prefill's state-feedback oscillator, zero-mean half-cycle
steering, posterior lag, direct normalized moment residual, progress-qualified
bearing-rate damping, and every sampled gait parameter. Add one mechanism:
route-consistent yaw damping. The normalized `heading_rate` residual is active
only when positive `window_closing_speed_L` corroborates translation and the
normalized body-frame bearing is already near alignment. Far from alignment
or while stalled/receding, the gate vanishes so yaw damping cannot oppose the
prefill's evidenced fast redirect. Once aligned and closing, the residual may
dissipate wake-driven yaw while the persistent bearing request remains route
owner.

This isolates whether the parent's lower effort and loads can be retained
without its route delay. Falsify the mechanism if capture is lost or delayed
materially from `137.36`, mean distance or score regresses toward the
unconditional-yaw result, upstream travel falls, effort/load metrics rise,
the alternating traveling bend is suppressed, actuator-cap contact increases,
or a loop or boundary exit returns. The new CFD evaluation runs only after
this worker exits, so these are test criteria rather than outcome claims.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and adaptive wake swimming
source_mechanism: gate bounded angular-response damping by corroborating target alignment and approach progress
transferable_invariant: persistent normalized body-frame target geometry owns the route, and measured yaw should be treated as a disturbance only when alignment and target-distance progress show that it is not the purposeful redirect
nontransferable_details: published gains, dimensional beat frequency, robot linkage and species kinematics, exact vortex phase, cylinder layout, recurrent state, and source-task routes
policy_translation: preserve the evidenced joint-state half-cycle traveling bend, direct `moment_z_L2` residual, and progress-qualified bearing-rate loop; add a small `heading_rate` residual multiplied by smooth near-alignment and positive-closing gates before the existing turn and amplitude bounds
falsification: reject if conditional yaw damping loses or slows capture, worsens mean distance or score, weakens upstream translation, raises effort/load or cap contact, destroys posterior lag, or recreates a loop or domain exit
