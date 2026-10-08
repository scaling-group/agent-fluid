# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the held fish above and far to the right of
  the target while four developed cylinder streets merge around the second-row
  capture region. This is the common initial condition and provides neither a
  reusable vortex phase nor a fixed route.
- All four sampled solver sheets are finite successes. The two unqualified
  bearing-rate policies reach the `0.75L` target after `149.605` released time
  units with `4.358L` mean distance, `96933` total command energy, `0.1321`
  RMS relative crossflow, and `15.49/308.48` RMS lateral force/yaw moment.
  Their paths are self-propelled upstream, preserve the alternating
  posterior-lagged bend, and enter the interacting wake, but retain a broad
  initial redirect and repeated lateral kinks.
- The two otherwise identical sampled policies qualify bearing-rate damping
  with positive window closing speed. Both reproduce capture after `137.357`
  units, `4.184L` mean distance, `90228` total energy, `0.1295` relative
  crossflow, and `14.75/303.02` force/moment, with about `-10.91L` upstream
  displacement. Their sheets show earlier wake-corridor entry without loss of
  the traveling bend. Since the controller files differ only in progress
  qualification, this supports that mechanism; exact duplication under the
  common snapshot does not establish changed-wake-phase robustness.
- The strongest policy's anterior acceleration reaches `30.846 rad/time^2`
  against the `31.416` hard cap. Faster gait, larger amplitude, or more direct
  steering effort is therefore not a credible next repair.
- The informative inherited failure bundles a slower gait, stronger moment
  gain, and route-headroom gating. It exits the top boundary after `126.428`
  units with only `-1.116L` upstream displacement and regresses from `8.610L`
  closest distance to `12.046L` final distance. Moderate load and feasible
  joint extrema do not validate a route that loses targetward translation.
- A later inherited circular-mean filter of the eight-observation bearing
  history remains successful but regresses the progress-qualified scaffold:
  arrival becomes `149.853`, mean distance `4.423L`, total/mean command energy
  `100638/671.58`, and RMS force/moment `15.58/312.62`. The filter therefore
  blunts useful route response rather than separating only beat-scale yaw on
  this rollout; it should not displace current bearing without new evidence.

## Candidate hypothesis

Make one structural change to the current prefill: qualify its bounded
`bearing_window_rate` damping with positive normalized
`window_closing_speed_L`, exactly as in the two strongest sampled policies.
Persistent instantaneous body-frame bearing remains the route owner, while
the closing-progress gate prevents mere body rotation from being mistaken for
useful directional response. Once target distance is decreasing, the sampled
rate damping returns smoothly to limit overshoot. Preserve the evidenced
state-feedback oscillator, zero-mean half-cycle asymmetry, posterior lag,
direct normalized yaw-moment residual, and every existing gait/load gain.

The expected formal test is replicated target capture near `137.357` units,
roughly `4.184L` mean distance, preserved upstream propulsion, and no increase
in load or actuator-cap contact. Falsify the transfer if capture or upstream
translation is lost, arrival and distance regress toward the unqualified-rate
or bearing-history results, loads rise, the alternating bend disappears, or a
loop/boundary exit returns. CFD evaluation occurs only after this worker exits,
so these are tests rather than claims about the new candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady fish redirect control
source_mechanism: release target-direction response damping only after measured response is corroborated by target-distance progress
transferable_invariant: persistent normalized body-frame target geometry should own route steering, while response damping should depend on observed targetward translation rather than elapsed time or assumed wake phase
nontransferable_details: published gains, dimensional beat settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend and direct `moment_z_L2` residual, then smoothly gate only normalized `bearing_window_rate` damping with positive normalized `window_closing_speed_L`
falsification: reject if progress qualification loses or slows capture, weakens upstream translation, raises distance integral, effort, loads, or cap contact, destroys posterior lag, or recreates a loop or boundary exit
