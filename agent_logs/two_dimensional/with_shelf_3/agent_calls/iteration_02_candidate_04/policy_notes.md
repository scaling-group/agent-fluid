# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The assigned parent candidate is the target-bearing mean-bend controller in
  `solver_ad1db499142c`. The sampled set also contains the target-blind seed,
  `solver_4b03cd285d3a`, and two independently proposed bearing-to-curvature
  policies that reached the target, `solver_cf905c92f9f7` and
  `solver_96495c5b1e65`. Inherited worker notes identify all four edits as
  translations of the same mean-curvature turning primitive, so the useful
  comparison is the curvature allocation, trajectory topology, and loads—not
  merely whether target bearing was read.
- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets. This is identical initial-flow
  evidence for the sampled candidates, not evidence for any controller.
- The target-blind seed visibly sustains a body wave and initially moves left,
  but curls almost vertically downward and exits the lower domain. Its metrics
  support substantial passive advection during that departure: mean vertical
  velocity is `-0.2633` while mean local vertical flow is `-0.2414`; it
  moves only `-3.545L` upstream, comes no closer than `8.615L`, and exits
  after `50.127` release-time units.
- The assigned parent does not repair that failure. Its released sheet ends
  after only three keyframes with the fish still far downstream, and the head
  displacement is `(+2.195,-1.302)L`: it leaves the domain on the downstream
  side after `18.683` units, ends `14.172L` from the target, and has
  negative progress. Thus adding a bearing signal is not sufficient when its
  mean bend is allocated as a full `10 deg` anterior equilibrium plus a
  `5 deg` posterior share.
- In contrast, both sibling variants enter the developed wake corridor and
  then swim almost directly through it to the green capture circle.
  `solver_96495c5b1e65` is the strongest finite example: it reaches the
  target in `39.737` release units with mean distance `1.934L`, head
  displacement `(-10.912,-4.332)L`, and mean streamwise swimming relative to
  local flow of about `-0.120U`. `solver_cf905c92f9f7` independently
  reaches in `42.856` units with mean distance `2.119L`, confirming the
  semantic improvement is not unique to one parameterization.
- The success is not evidence of an efficient actuator regime: both successful
  policies touch the `260 deg/time` joint-velocity and
  `1800 deg/time^2` acceleration envelopes, with moment RMS
  `712.999`–`761.948`. The keyframes do not show repeated targetward yaw
  reversals, and only aggregate flow/load metrics are available, so the
  evidence does not identify a signed wake-rejection residual. Adding one now
  would confound the already demonstrated navigation mechanism.

## Candidate hypothesis

Use the strongest evaluated sibling's single mechanism: interpret the bounded
bearing command as a *total curvature budget* and partition it between the two
joint equilibria, while retaining the target-blind seed's state-encoded
oscillator phase and posterior lag. A `12 deg` total command with
`45%/55%` anterior/posterior centers limits the anterior mean equilibrium to
`5.4 deg`, rather than applying the assigned parent's full `10 deg` there.
This is a structural redistribution of steering authority, not a scalar-only
drive retune, and it preserves the exact policy that already produced the best
sampled target-reaching trajectory.

Expected test: the new rollout should reproduce a sustained upstream-left
approach, remain in-domain beyond the assigned parent's `18.683`-unit exit,
enter the interacting-wake corridor, and capture the target on a trajectory
comparable to the sampled `39.737`-unit success. Falsify this transfer if it
turns downstream, retains either left-domain topology, collapses the traveling
bend, misses the `0.75L` circle, or increases saturation/load beyond the
already high successful-sibling envelope. The current worker does not claim
new CFD evidence; evaluation occurs after exit.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and classical fish turning
source_mechanism: sensor-driven mean-curvature bias superposed on a lagged propulsive traveling bend
transferable_invariant: persistent normalized body-frame bearing error may set a bounded total average curvature while the zero-mean posterior-lagged wave remains available for propulsion
nontransferable_details: published gains, robot or species geometry, dimensional beat rates, exact vortex phase, task routes, and source actuator allocations
policy_translation: map clamped body-frame bearing through smooth saturation to one owned total-curvature budget, partition that budget across the two joint equilibria, and retain state-derived oscillator phase and posterior lag
falsification: reject if targetward turning, wake-corridor entry, or capture is lost; also reject if the traveling bend collapses or saturation and moment loads exceed the demonstrated sibling envelope
