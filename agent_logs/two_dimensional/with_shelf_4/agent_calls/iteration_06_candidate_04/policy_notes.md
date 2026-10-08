# Multi-wake candidate diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and to the right of the
  target while four developed vortex streets merge downstream. This is the
  common release condition for every policy, not evidence for a memorized
  route or prescribed vortex phase.
- The informative inherited failure combines a slower `0.76` gait, stronger
  moment rejection, and route-headroom gating. Its released sheet shows an
  initial targetward segment followed by a broad reversal and top-boundary
  exit after `126.43` units. It advances only `-1.12L` upstream, regresses from
  `8.61L` minimum to `12.05L` final distance, and has RMS crossflow/force/yaw
  moment `0.1336/16.54/317.27`. This confounded result rules out copying that
  combination and supplies a failure topology, but does not isolate a gain.
- The direct bearing-plus-moment controller and its bearing-rate descendant
  are both self-propelled semantic successes. Their sheets show a sustained
  alternating bend, broad upstream targetward travel, entry into the merged
  wakes, and capture rather than passive downstream advection, collision, or
  domain exit. Adding only bounded `bearing_window_rate` feedback preserves
  arrival (`149.61` versus `149.57`) while improving mean distance (`4.358L`
  versus `4.384L`), command-energy mean (`647.93` versus `681.91`), RMS
  crossflow (`0.1321` versus `0.1362`), RMS force (`15.49` versus `16.22`),
  RMS yaw moment (`308.48` versus `314.99`), and joint extrema. The remaining
  polyline still contains alternating lateral kinks through the wake corridor
  and final approach, so the missing capability is response damping rather
  than propulsion or route sign.
- The most recent inherited directional moment-authority gate also captures
  and slightly reduces RMS force/moment to `15.30/306.15`, but its visibly
  wider middle arc worsens mean distance to `4.578L` and score to `-2.6293`
  despite crossing `0.90` units earlier. Thus multiplying moment rejection by
  a bearing/rate helpfulness classifier trades route quality for a small load
  reduction and should not be repeated on the current scaffold.

## Policy hypothesis

Preserve the sampled `0.72`-period radial oscillator, posterior lag, bounded
bearing plus bearing-rate route request, and direct normalized yaw-moment
residual. Add one new mechanism: a much smaller softly saturated term from
normalized measured body yaw rate to the same half-cycle turn request. The
known bend-to-yaw sign maps positive yaw rate to the positive bend request that
produces opposing yaw acceleration. Because the term acts only through the
existing state-inferred half-cycle envelope, it adds angular-velocity damping
without a static curvature center, clock, external wake phase, or change to
the propulsive equilibrium. The `0.5` soft scale is shared with the already
successful angular bearing-rate response, while the new authority is kept
well below both persistent route and moment terms.

The next CFD rollout should retain capture and upstream translation while
reducing the visible lateral kinks, mean distance, yaw load, or command effort.
Reject the extension if it delays or loses capture, raises distance/load/cap
contact, damps the targetward turn, suppresses the posterior traveling bend,
or reproduces the loop/domain-exit topology. The formal CFD evaluation occurs
after this worker exits, so these are falsifiable expectations, not results.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and adaptive swimming in organized wakes
source_mechanism: separate persistent direction tracking from bounded measured angular-response damping while preserving the propulsive rhythm
transferable_invariant: body-frame target geometry should own the route while a smaller normalized yaw-rate residual may damp fast body rotation without cancelling the traveling wave
nontransferable_details: published gains, dimensional frequencies, species kinematics, robot linkage geometry, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: retain the evidenced joint-state half-cycle oscillator, bearing-rate route feedback, and direct `moment_z_L2` residual, then add a softly saturated `heading_rate` damping residual before the existing turn and amplitude bounds
falsification: reject if capture or upstream thrust is lost, arrival or mean distance worsens, yaw/load/effort do not improve, actuator clipping rises, or the alternating posterior wave is suppressed

## Pre-evaluation actuator audit

A joint-only semi-implicit integration of the candidate equations (not CFD or
rollout evidence) sampled 81 constant combinations of bearing, windowed
bearing rate, normalized moment, and normalized heading rate for 25 time
units. Peak absolute joint angles were `23.12/19.66 deg`, velocities were
`192.11/163.85 deg/time`, and raw accelerations were
`1770.55/1454.48 deg/time^2`, within the configured `45/260/1800` envelope.
The public contract check returned two finite accelerations, and every direct
`params.FIELD` reference matched a field returned by `target_policy_params()`.
These checks establish bounded equation realization only; hydrodynamic yaw
damping, trajectory quality, capture, and load reduction remain for the later
formal rollout.
