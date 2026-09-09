# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while four developed cylinder streets merge around the target.
  This is a common initial condition and supplies neither a fixed route nor a
  prescribed vortex phase.
- The two direct-moment-residual samples are identical successful baselines:
  they sustain an alternating posterior-lagged bend, travel about `-10.92L`
  upstream, and reach the target after `149.572` units. Their keyframe sheets
  show a broad initial redirect followed by repeated lateral kinks through the
  interacting wakes; mean distance is `4.38415L`, mean command energy is
  `681.91`, and RMS force/moment are `16.22/314.99`.
- The two otherwise identical bearing-rate samples also reach the target in
  essentially the same time (`149.605`), while mean distance falls to
  `4.35835L`, total command energy to `96933`, RMS relative crossflow to
  `0.13206`, and RMS force/moment to `15.49/308.48`. Their keyframes retain
  upstream propulsion and the alternating wave. This is causal evidence that
  bounded `bearing_window_rate` feedback damps route response and load, but
  its `0.033`-unit arrival difference is not evidence of faster redirection.
- The informative assigned-parent failure changed the period and moment gain
  while gating moment rejection by route headroom. It closes into an
  upper-right loop and exits the top boundary after `126.43` units, moving
  only `-1.12L` upstream and regressing from `8.61L` minimum to `12.05L`
  final distance. Moderate RMS moment and feasible actuator extrema therefore
  cannot substitute for targetward translation, and confounded changes to the
  successful residual should not be repeated.
- A separate inherited descendant gates the direct moment residual using the
  sign of bearing response. It preserves capture and arrives slightly earlier
  (`148.703`), with slightly lower RMS moment (`306.15`), but worsens mean
  distance to `4.57843L` and score to `-2.62926`. That result does not support
  classifying instantaneous yaw as helpful or harmful by attenuating the
  proven load residual; the direct residual should remain unchanged.

## Candidate hypothesis

Preserve the sampled best policy's oscillator, zero-mean half-cycle steering,
posterior lag, direct normalized moment residual, and all evidenced gait
parameters. Add one response-qualification mechanism only: multiply the
existing bearing-rate damping by a smooth gate from positive normalized
`window_closing_speed_L`. Bearing remains the route owner. When alignment is
changing but the target is not getting closer, the controller does not release
the route correction merely because the fish is spinning; once target
distance is closing, the sampled rate damping returns continuously to suppress
overshoot and wake-driven kinks. The `0.05L/time` soft scale is below but of
the same order as the successful rollout's net approach rate (about
`0.08L/time`), so established progress should recover most of the sampled
damping while stall or recession releases it; it is not a published gain.

The expected test is a tighter initial redirect and lower mean distance while
retaining roughly `149.6`-unit capture, upstream displacement, lower loads, and
the alternating posterior wave. Falsify the mechanism if it loses or delays
capture, raises mean distance or loads, increases actuator-cap contact,
suppresses the traveling bend, or reproduces a loop or domain exit. The new CFD
runs after this worker exits, so none of those outcomes is claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and nonsteady fish redirect control
source_mechanism: release a strong target redirect only after observed directional response is corroborated by target-distance progress
transferable_invariant: persistent body-frame target geometry owns the route, and response damping should depend on normalized observed progress rather than elapsed time or an assumed wake phase
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, robot linkage geometry, exact vortex phase, cylinder layout, and source-task routes
policy_translation: preserve the evidenced joint-state half-cycle traveling bend and direct `moment_z_L2` residual, then smoothly gate only `bearing_window_rate` damping with positive `window_closing_speed_L`
falsification: reject if progress qualification weakens useful damping, loses or slows capture, raises distance integral or loads, destroys posterior lag, or recreates a sampled loop or boundary exit
