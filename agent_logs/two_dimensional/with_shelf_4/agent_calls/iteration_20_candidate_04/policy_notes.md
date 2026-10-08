# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting cylinder streets. The released controller must
  cross that wake corridor, but its exact vortex phase is only a common initial
  condition and is not used as a clock, route, or case identifier.
- The three independent-guard samples are executable copies despite cosmetic
  source differences. Their released sheets retain the alternating posterior-
  lagged wave, redirect from the upper-right, make a broad lower-midcourse fold,
  and enter the capture circle from the right after `123.018` released units.
  Their matching evidence is `3.5936L` mean distance, `95084` total command
  energy, and `0.14287/17.03/334.45` RMS relative crossflow/lateral force/yaw
  moment. Approximately `-11.04L` upstream head displacement against only
  `-0.0630` mean local streamwise flow confirms active propulsion.
- The current best sample changes only the two independent action-history
  gates to one gate driven by total signed joint power. Its sheet preserves the
  same targetward topology and alternating wave while reaching the wake
  corridor and capture about `5` units sooner. It captures in `118.024` units
  with `3.5600L` mean distance, lowers total energy to `89079`, and lowers RMS
  crossflow/force/moment together to `0.13833/16.74/329.67`. Peak angles and
  speeds also fall, although anterior acceleration still reaches the hard cap.
  Because the route and all aggregate physical metrics improve together, this
  supports coherent inter-joint action-history treatment rather than a scalar
  gain inference.
- The inherited response-qualified C-start analogue is the informative
  regression absent from the sampled set. Its keyframes show a deeper lower
  fold, and it delays capture to `130.053` units with `3.7583L` mean distance
  and `99377` energy. Its `0.14391/16.77/331.13` RMS crossflow/force/moment do
  not improve coherently over the shared-gate sample. Added initial steering
  authority is therefore not supported; the remaining one-change opportunity
  is inside the actuator-coordination mechanism that just produced the best
  completed result.

## Policy hypothesis

Start from the completed shared-power-gate sample and preserve its normalized
body-frame bearing route loop, positive-closing-qualified bearing-rate damping,
direct bounded yaw-moment residual, state-inferred half-cycle steering,
regulated oscillator, and posterior-lagged traveling bend. Make one actuator-
coordination change: express the previous-action residual and joint velocity in
the gait's normalized acceleration and velocity scales, then smoothly remove
only the component of that residual parallel to joint velocity when it adds
positive total kinetic power. Retain the orthogonal component, which changes
the coupled command direction and phase relationship without adding
instantaneous joint power, as well as all neutral or energy-removing history.

This is a projection of action continuity, not a new route residual, a scalar-
only gain edit, or a claim that physical actuator power is modeled. The formal
expectation is preserved target capture, roughly `-11L` upstream translation,
and the alternating posterior wave, with no regression beyond the shared
gate's `118.024` arrival, `3.5600L` mean distance, `89079` energy, or aggregate
load metrics. Falsify the mechanism if retaining the non-energizing history
component widens the lower fold, loses or delays capture, weakens upstream
translation, increases cap contact, or trades a distance improvement for
higher effort/crossflow/force/moment. The new CFD evaluation occurs only after
this worker exits, so these are testable expectations rather than outcomes.

bookshelf_consulted: true
source_domain: coupled CPG rhythmic locomotion and sensor-modulated robotic-fish direction control
source_mechanism: preserve inter-joint phase coordination while measured state feedback modulates a low-dimensional rhythmic command
transferable_invariant: feedback at a coupled propulsive actuator should suppress excess drive without discarding command components that preserve the traveling-wave phase relationship
nontransferable_details: published gains, oscillator equations, servo constants, robot linkage geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: normalize joint velocity and previous-action residual by the gait scales, then smoothly project out only their positive-power aligned component while retaining orthogonal phase-shaping continuity in the two-joint command
falsification: reject if capture, upstream translation, or the alternating bend is lost, or if arrival, mean distance, effort, load, actuator-cap contact, and trajectory folding do not jointly match or improve on the shared-gate sample
