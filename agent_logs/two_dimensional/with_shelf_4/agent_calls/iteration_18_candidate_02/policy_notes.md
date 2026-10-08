# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting cylinder streets. The vortices already fill the
  target corridor at release; this is a common initial condition, not a
  transferable phase, route, or candidate-specific advantage.
- All four sampled policies actively self-propel upstream and reach the target
  with a posterior-lagged alternating bend intact. Their approximately
  `-10.9L` to `-11.1L` upstream head displacements, despite mean local
  streamwise flow of only `-0.057` to `-0.066`, rule out passive advection as
  the main explanation. No termination failure is sampled, so the informative
  negative contrast is a slower or more highly loaded successful topology.
- The prefilled anterior-only action response captures after `135.019` units
  with `3.6855L` mean distance and `110448` command energy. Its released sheet
  shows a deep lower-midcourse fold before wake-corridor entry, while its RMS
  crossflow/force/moment are `0.1535/18.53/362.61`.
- Applying an unguarded response to both joints reaches in `130.729` units,
  but costs `115750` energy and `0.1543/18.30/359.97` RMS crossflow/force/
  moment. The assigned-parent course-alignment branch is smoother and lower
  load (`91401` energy and `0.1336/14.91/306.50`) but takes `137.247` units
  and `4.0767L` mean distance. Thus neither visual smoothness nor short action
  history alone establishes an improved controller.
- The assigned parent's signed-power guard on the coherent two-joint response
  is the strongest surviving mechanism. Its keyframes retain alternating
  propulsion through a shorter targetward fold and capture after `123.018`
  units with `3.5936L` mean distance. Against the prefill it also lowers total
  energy to `95084` and RMS crossflow/force/moment to
  `0.1429/17.03/334.45`; against the unguarded two-joint response it improves
  every one of those metrics. This is evidence for phase-safe actuator
  continuity, not a scalar gain inference.

## Policy hypothesis

Make one architecture change to the prefilled candidate: extend its short
previous-action response to the posterior joint so both commands preserve the
traveling bend coherently, and continuously bypass each joint's history term
only when that term would add positive joint kinetic power relative to the raw
state-feedback request. Preserve body-frame bearing as route owner, closing-
qualified bearing-rate damping, the direct bounded moment residual,
state-inferred half-cycle steering, oscillator regulation, and the posterior
lag target. This adopts the completed parent mechanism rather than adding a
new residual or tuning a scalar.

The formal expectation is reproduction of target capture, alternating
propulsion, and roughly `-11L` upstream translation, with arrival and mean
distance no worse than the prefilled `135.019`/`3.6855L` and with lower energy
and load. Falsify the transfer if evaluation loses capture, breaks the
posterior traveling wave, delays beyond the prefill, or fails to reduce energy
and RMS crossflow/force/moment together. The new CFD evaluation occurs only
after this worker exits, so the sampled result is evidence for the mechanism,
not a claim about this unevaluated materialization.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG actuator control
source_mechanism: preserve a coherent posterior-lagged propulsive wave while shaping actuator continuity with observed state feedback
transferable_invariant: action continuity should preserve inter-joint wave coherence but must not keep injecting joint kinetic energy after the current rhythmic feedback requests less drive
nontransferable_details: published gains, servo time constants, linkage geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: apply the observed previous-action response to both two-joint commands, normalize its signed added power by the gait scale, and continuously bypass only energy-injecting lag while retaining the body-frame route and load loops
falsification: reject if capture, upstream translation, or the alternating bend is lost, arrival or mean distance regresses beyond the anterior-only prefill, or energy and RMS crossflow/force/moment fail to improve together
