# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the held fish above and far to the right of
  the target while the four cylinder wakes develop into interacting streets.
  It fixes the initial flow condition but supplies neither a reusable vortex
  phase nor a case-specific route.
- The duplicated rate-only prefill policies sustain the alternating,
  posterior-lagged bend and each reach the target after `149.605` released
  time units. Their sheets show self-propelled upstream motion through the
  wakes, but the broad initial redirect contains repeated lateral kinks;
  aggregate evidence is `4.35835L` mean distance, `96932.99` total command
  energy, `0.13206` RMS relative crossflow, and `15.49/308.48` RMS lateral
  force/yaw moment.
- The two otherwise identical sampled policies qualify bearing-rate damping
  with positive `window_closing_speed_L`. Both show a tighter initial redirect,
  retain the alternating wave, enter the useful wake corridor, and reach the
  target after `137.357` units with `4.18356L` mean distance, `90228.38` total
  command energy, `0.12955` RMS relative crossflow, and `14.75/303.02` RMS
  force/moment. Their `-10.914L` upstream head displacement and matching
  diagnostics confirm self-propulsion rather than passive downstream
  advection. The anterior acceleration peak is already `30.846 rad/time^2`
  against the `31.416` cap, so more propulsion or faster scalar tuning is not
  a supported next step.
- The informative inherited architecture failure changes gait and load
  rejection together. Its sheet closes into an upper-right loop and exits the
  top boundary after `126.428` units, moving only `-1.116L` upstream and
  regressing from `8.610L` minimum distance to `12.046L` final distance.
  Moderate RMS moment (`317.27`) and sub-cap joint extrema do not rescue lost
  targetward route topology.
- The latest inherited test changes only the strongest policy's route bearing
  from instantaneous `state.bearing` to the circular mean of
  `state.bearing_history`. It still captures, but its sheet takes a wider,
  lower midcourse arc and arrival regresses to `149.853` units. Mean distance
  (`4.42329L`), total and mean command energy (`100638.11`, `671.58`), RMS
  crossflow (`0.13387`), force (`15.58`), and moment (`312.62`) all worsen.
  Short-history bearing averaging therefore blunts useful redirect response
  on this scaffold rather than cleanly separating route from beat-scale yaw.

## Policy hypothesis

Make exactly one mechanism change from the prefill: multiply its bounded
`bearing_window_rate` damping by a smooth gate from positive normalized
`window_closing_speed_L`. Persistent instantaneous body-frame bearing remains
the route owner. When bearing changes without targetward translation, the
controller keeps the full redirect instead of treating body spin as useful
route response; once distance is closing, rate damping returns continuously
to limit overshoot. Preserve all gait parameters, the state-inferred zero-mean
half-cycle asymmetry, direct normalized moment residual, and posterior lag.

The expected formal test is reproduction of capture near `137.36` units with
the sampled improvements in mean distance, total effort, crossflow, and load.
Falsify the transfer if capture or upstream translation is lost, arrival or
distance integral regresses toward the rate-only baseline, actuator-cap
contact increases, the alternating traveling bend disappears, or a loop or
boundary exit returns. The new CFD evaluation occurs after this worker exits,
so these are expectations rather than same-worker results.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and nonsteady fish redirect control
source_mechanism: release target-response damping only after observed response is corroborated by targetward translation
transferable_invariant: persistent normalized body-frame target geometry should own route steering, while response damping should depend on normalized measured progress rather than elapsed time or assumed wake phase
nontransferable_details: published gains, dimensional gait settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced joint-state half-cycle traveling bend and direct `moment_z_L2` residual, then gate only normalized `bearing_window_rate` damping with positive normalized `window_closing_speed_L`
falsification: reject if progress qualification loses or slows capture, raises distance integral or loads, increases actuator-cap contact, destroys posterior lag, or recreates a loop or boundary exit
