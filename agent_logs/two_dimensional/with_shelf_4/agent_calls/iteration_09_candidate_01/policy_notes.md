# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the held fish above/right of the target while
  the four developed cylinder streets merge around the second-row capture
  region. This is the common initial condition; it supplies neither a reusable
  vortex phase nor a fixed route.
- Three sampled copies of the strongest progress-qualified controller reproduce
  the same finite result. Their released sheet shows a self-propelled,
  posterior-lagged alternating bend, an early turn into the wake corridor, and
  target capture after `137.357` released units with `4.184L` mean distance,
  `90228` total command energy, `0.1295` RMS relative crossflow, and
  `14.75/303.02` RMS lateral force/yaw moment. The route still contains sharp
  changes of direction, and anterior acceleration reaches `30.846` against the
  `31.416 rad/time^2` cap; extra frequency, amplitude, or direct steering effort
  is therefore not supported.
- The slower sampled policy differs by omitting closing-progress qualification
  of bearing-rate damping. It still captures, but only after `149.605` units,
  with `4.358L` mean distance, `96933` energy, `0.1321` crossflow, and
  `15.49/308.48` force/moment. Preserve the progress-qualified route response.
- The assigned parent's posterior-sharing test also preserves capture, but
  delays it to `150.210`, raises mean distance to `4.617L`, total energy to
  `99669`, crossflow to `0.1346`, and force/moment to `15.18/306.96`. Its sheet
  shows a wider first loop and later corridor entry. Posterior acceleration
  headroom did not make tail-envelope steering useful; preserve the unmodulated
  posterior-lagged target.
- The informative inherited failure visibly closes into an upper-right loop
  and exits the top boundary after `126.428` units. Its `-1.116L` upstream
  displacement, `8.610L` minimum distance, and `12.046L` final distance
  cross-check that feasible joint extrema and moderate load do not rescue a
  route that suppresses translation. Its bundled route-headroom gate, slower
  gait, and stronger moment residual are not reused.

## Candidate hypothesis

Make one mechanism change to the strongest sampled scaffold: when the existing
bounded route request is large, smoothly reduce only the symmetric cruise part
of the anterior oscillator envelope while preserving the signed half-cycle
amplitude difference. This increases redirect-to-cruise authority without
adding acceleration at the nearly capped anterior joint or moving steering to
the posterior joint. As the normalized body-frame route request approaches
zero, the full cruise envelope returns continuously. The direct normalized
yaw-moment residual remains outside this propulsion gate, so fast wake loads do
not indiscriminately suppress thrust.

The formal test is preserved target reach and upstream translation with a
tighter initial redirect, fewer route kinks, lower mean distance or load, and
less anterior cap contact. Falsify the mechanism if capture is lost or delayed,
upstream displacement weakens, the same broad loop remains, effort/load rises,
or reduced symmetric drive destroys the alternating posterior-lagged wave. CFD
evaluation occurs only after this worker exits, so these are expectations, not
same-worker outcome claims.

bookshelf_consulted: true
source_domain: nonsteady fish redirect and sensor-modulated robotic-fish CPG direction control
source_mechanism: observed large direction error favors redirect authority, followed by continuous release into stronger rhythmic cruise as alignment returns
transferable_invariant: separate target-directed half-cycle asymmetry from symmetric propulsive drive, and schedule their ratio from bounded body-frame route error rather than time or external wake phase
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve the evidenced two-joint route, yaw-load residual, anterior half-cycle difference, and posterior lag; subtract a small route-request-dependent amount only from the symmetric anterior amplitude envelope
falsification: reject if drive relief loses or slows capture, weakens upstream translation, raises distance integral, effort, load, or cap contact, suppresses the traveling bend, or recreates a loop or domain exit
