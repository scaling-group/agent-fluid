# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows four developed, interacting vortex streets
  between the fish and target before every release. The fish starts above and
  to the right of the target, outside the organized second-row wake corridor;
  this common flow does not support a memorized vortex phase or route.
- The informative target-blind seed failure visibly produces a traveling wave
  and some upstream propulsion, but folds into a steep bottom exit instead of
  entering the wake corridor. It exits after `50.13` units with head motion
  `(-3.55,-13.30)L`, regresses from `8.61L` minimum to `12.12L` final target
  distance, reaches both joint-speed and acceleration limits, and has `541.70`
  RMS yaw moment. More oscillator gain is contradicted by that topology.
- The assigned parent guidance reports that static bearing-dependent oscillator
  centers are also a dead end: one regulated candidate survives the horizon
  but loops on the far-right with only `-1.19L` upstream motion, while two
  simpler variants are advected out the right boundary in under `20` units.
  This supports retaining zero-mean, phase-dependent steering.
- All four current solver samples reach the target. Two independent zero-mean
  half-cycle-asymmetry forms establish the useful mechanism: the posterior-
  modulated form arrives in `268.49` units, while the simpler anterior-only
  form arrives in `179.22` units and follows a broad targetward arc through the
  interacting streets. The faster form is the current prefill.
- Against that identical `0.72`-period prefill, adding only a softly saturated
  `moment_z_L2` residual improves arrival from `179.22` to `149.57`, mean
  distance from `5.041` to `4.384L`, RMS lateral force from `18.42` to `16.22`,
  and RMS yaw moment from `338.91` to `314.99`. Its keyframes preserve the
  alternating body wave and shorten the broad approach instead of cancelling
  lateral motion indiscriminately. Peak anterior acceleration rises only from
  `30.40` to `30.92 rad/time^2`, still below the `31.42` hard cap.
- An inherited post-success variant warns that the residual is not portable
  across simultaneous scaffold changes. Combining a slower `0.76` period,
  stronger residual, and route-headroom gating exits the domain after `126.43`
  units with only `-1.12L` upstream displacement and `12.05L` final distance.
  The confounded rollout does not isolate which change caused failure, but it
  directly argues against importing that combination or claiming that any
  moment feedback is beneficial.

## Candidate hypothesis

Make one mechanism change from the prefill: preserve its evaluated `0.72`
state-feedback radial oscillator, bearing-driven anterior half-cycle
asymmetry, and posterior lag exactly, then add the evaluated small normalized
yaw-moment residual to the turn request. Bearing remains the persistent route
signal; instantaneous moment can only trim the same half-cycle envelope and
cannot create a static bend, clock phase, or separate tail command. Selecting
the already isolated successful form avoids the confounded period, gain, and
headroom changes that produced the inherited post-success exit.

The formal rollout should reproduce target reach, retain the broad upstream
arc and posterior traveling bend, and improve arrival/distance integral and
yaw load relative to the prefill. Falsify this transfer under a later wake
phase or layout if it loses success, turns with the wrong sign, suppresses
upstream propulsion, increases force/moment or cap contact, or only reacts to
self-generated beat torque without improving the trajectory.

bookshelf_consulted: true
source_domain: biological and computational wake-adaptive swimming in organized vortex streets
source_mechanism: separate slow route regulation from a bounded sensor-mediated response to fast alternating wake loads
transferable_invariant: persistent body-frame target geometry should set the route while a much smaller normalized yaw-load signal may reject fast disturbances without cancelling the propulsive wave
nontransferable_details: published gains, species and robot kinematics, single-cylinder Karman-gait phase, dimensional frequencies, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: retain bearing-controlled state-inferred half-cycle amplitude asymmetry and add one softly saturated `moment_z_L2` residual to its turn request before the existing two-joint traveling-bend envelope
falsification: reject if target success or upstream thrust is lost, arrival materially slows, the residual has the wrong yaw sign, RMS force or moment and visible yaw reversals do not fall, or joint/load saturation increases

## Contract and verification boundary

The candidate uses only normalized body-frame bearing, normalized yaw moment,
and the two joint states. Every active scalar will remain owned by
`target_policy_params()`. The mandated semantic-guidance check and solver
boundary check pass, and a deterministic schema comparison confirms that all
ten direct `params.FIELD` references are declared. With comments removed, the
candidate equations match the isolated evaluated `149.57`-unit success. The
Julia contract command was attempted in login and non-login shells but cannot
execute because this environment exposes no Julia binary. No CFD was run in
this workspace; hydrodynamic reproduction and held-out robustness remain later
evaluation evidence.
