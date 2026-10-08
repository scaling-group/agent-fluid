# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while four developed cylinder streets merge around the capture
  region. This is the common release condition, not a transferable vortex
  phase or route.
- The current rate-only prefill is a finite self-propelled success. Its released
  sheet retains an alternating posterior-lagged bend and traverses the
  interacting wakes, but follows a wider lower midcourse arc before capture at
  `149.605` released units. Its mean distance is `4.35835L`, total command
  energy is `96932.99`, RMS relative crossflow is `0.13206`, and RMS lateral
  force/yaw moment are `15.49/308.48`.
- Three sampled policies differ from the prefill only by qualifying
  `bearing_window_rate` damping with positive `window_closing_speed_L`; all
  three reproduce capture at `137.357` units with a visibly tighter redirect
  and earlier wake-corridor entry while preserving the alternating bend. Mean
  distance falls to `4.18356L`, total command energy to `90228.38`, RMS
  relative crossflow to `0.12955`, and RMS force/moment to `14.75/303.02`.
  Their `-10.914L` upstream head displacement confirms active targetward
  swimming rather than passive downstream advection. Because the policies are
  otherwise identical under the common wake snapshot, this is direct evidence
  for the progress-qualification mechanism, though not yet for robustness to
  changed wake phase.
- The strongest rollout already reaches `30.846 rad/time^2` anterior
  acceleration against the `31.416` cap. More oscillator gain, amplitude, or
  additive turn authority is unsupported.
- The assigned parent's one-change bearing-dependent posterior-lag relief also
  preserves capture, but its keyframes show a wider lower excursion. It delays
  arrival to `158.147` units, worsens mean distance to `4.69192L`, raises total
  energy to `103628.53`, and raises RMS crossflow/force/moment to
  `0.13199/15.66/311.93` relative to the progress-qualified baseline. Relieving
  posterior traveling-wave authority merely because instantaneous bearing is
  large therefore does not improve this redirect.
- Inherited circular-bearing smoothing, relative-crossflow addition, and a
  lateral-target residual likewise preserve capture but delay it and increase
  distance and load. These negative results argue against another parallel
  route/flow term or an observation filter in the present candidate.

## Policy hypothesis

Make exactly one controller-mechanism change from the prefill: multiply the
bounded `bearing_window_rate` damping term by a smooth gate from positive
normalized `window_closing_speed_L`. Instantaneous body-frame bearing remains
the route owner. If bearing changes without target-distance closure, keep the
full redirect instead of accepting body rotation as useful route response;
once the fish is closing on the target, restore the existing rate damping
continuously. Preserve the oscillator, zero-mean state-inferred half-cycle
asymmetry, direct normalized yaw-moment residual, posterior lag, and all other
gait and load parameters.

The expected formal test is reproduced target capture near `137.357` units,
lower mean distance and total effort than the prefill, preserved upstream
translation and alternating propulsion, and no increase in actuator-cap
contact or load. Falsify the transfer if capture is lost or delayed toward the
`149.605` rate-only baseline, distance or load rises, the posterior wave is
suppressed, or a loop, boundary exit, or passive-advection topology appears.
CFD evaluation occurs only after this worker exits, so these are expectations,
not claims about the unevaluated candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady fish redirect control
source_mechanism: qualify target-response damping by measured targetward translation while persistent target geometry continues to own the route
transferable_invariant: normalized body-frame route error should remain authoritative until observed response includes useful target-distance closure rather than body rotation alone
nontransferable_details: published gains, dimensional beat settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend and direct normalized yaw-moment residual, then gate only normalized bearing-rate damping with positive normalized closing speed
falsification: reject if progress qualification loses or slows capture, weakens upstream translation, raises distance integral, effort, loads, or actuator-cap contact, destroys posterior lag, or recreates a loop or boundary exit
