# Multi-wake target-policy candidate

## Visual diagnosis and evidence

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered-cylinder streets develop and merge around the target. This is
  a common initial condition, not a candidate-specific vortex phase or route.
- The rate-only prefill is a finite self-propelled success. Its released sheet
  preserves an alternating posterior-lagged bend and reaches the target, but
  follows a wider, more jagged lower-midcourse arc before capture at `149.605`
  released units. It records `4.35835L` mean distance, `96932.99` total command
  energy, and `0.13206/15.49/308.48` RMS relative crossflow/lateral force/yaw
  moment.
- Three sampled policies are deterministic replications of one mechanism:
  positive normalized closing speed qualifies `bearing_window_rate` damping.
  Their released sheets show a tighter redirect and earlier wake-corridor
  entry while retaining the alternating bend. All capture at `137.357` units,
  with `4.18356L` mean distance, `90228.38` total energy, and
  `0.12955/14.75/303.02` RMS crossflow/force/moment. Their `-10.914L` upstream
  head displacement and body streamwise velocity more negative than local
  flow confirm active targetward swimming rather than passive advection.
- The best sampled first-joint acceleration reaches `30.846 rad/time^2`
  against the `31.416` cap. More unconditioned oscillator or steering
  authority is unsupported.
- Inherited step-11 through step-13 rollouts provide the informative negative
  comparison absent from the sampled set. Bearing-divergence gating of moment
  rejection, posterior route half-cycle asymmetry, and yaw-power gating all
  preserve capture but delay it to `149.490`, `196.317`, and `205.519` units.
  Their keyframes show increasingly deep or prolonged midcourse detours, while
  mean distance rises to `4.428L`, `5.718L`, and `6.209L`, and total energy to
  `97418`, `131294`, and `134893`. These failures do not support another
  disturbance gate, posterior route term, or scalar authority increase.

## Policy hypothesis

Make exactly one evidence-backed mechanism change from the rate-only prefill:
qualify the bounded bearing-rate damping term by a smooth gate from positive
normalized `window_closing_speed_L`. Instantaneous body-frame bearing remains
the route owner. If bearing changes without target-distance closure, retain
the full redirect instead of treating body rotation as useful response; once
the fish is closing, restore the existing rate damping continuously. Preserve
the state-inferred zero-mean half-cycle asymmetry, direct yaw-moment residual,
oscillator, posterior lag, and every sampled gait/load parameter.

The formal expectation is reproduction of the sampled `137.357`-unit capture
topology, lower distance integral and effort than the rate-only prefill, and
preserved upstream translation and alternating propulsion. Falsify the
candidate if it loses capture, regresses toward the `149.605` prefill, raises
distance/load/cap contact, suppresses posterior lag, or creates a loop,
boundary exit, or passive-advection trajectory. The new CFD evaluation occurs
after this worker exits, so this is an expectation rather than a claimed new
result.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady fish redirect control
source_mechanism: retain persistent route authority until observed response contains useful targetward translation
transferable_invariant: normalized body-frame error damping should be qualified by measured target-distance closure so body rotation alone is not accepted as route progress
nontransferable_details: published gains, dimensional beat settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: preserve the two-joint state-feedback traveling bend and direct normalized yaw-moment residual, and gate only normalized bearing-rate damping with positive normalized closing speed
falsification: reject if progress qualification loses or slows capture, weakens upstream translation, raises distance integral, effort, loads, or actuator-cap contact, destroys posterior lag, or recreates a loop or boundary exit
