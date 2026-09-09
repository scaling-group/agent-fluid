# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common certified initial
  condition, not evidence of candidate-specific wake selection or robustness
  to a different release phase.
- The three code-equivalent positive-only planar-wrench samples reproduce the
  strongest result: each turns down and upstream, sustains a posterior-
  traveling body wake, clears all cylinders, and reaches the target nose first
  on the same compact diagonal at `30.4865` release time. Mean velocity
  `(-0.35660,-0.14740)L/time` exceeds mean local upstream flow
  `(-0.20216,-0.19779)`, confirming self-propulsion rather than passive
  advection. Their common mean distance is `1.56766L`, score `0.302848`,
  relative-crossflow RMS `0.23534`, force/moment RMS `65.80/872.96`, and mean
  command energy `1416.41`.
- The prefilled adverse-load-consensus candidate preserves the same visible
  route and target capture, but delays arrival to `31.3335`, increases mean
  distance to `1.59773L`, lowers score to `0.273753`, and raises mean command
  energy to `1420.90`. Its force/moment RMS falls to `62.68/845.71`, yet peak
  excursions rise from `0.5094/0.5190` to `0.5169/0.5482 rad`; both branches
  still touch velocity and acceleration ceilings. This is a load-versus-
  navigation trade, not desaturation or improved efficiency.
- The isolated code difference is the new unanimous-opposition veto applied
  to the maximum of actuator pressure and positive fluid assistance. Thus an
  opposing planar wrench can restore optional posterior half-cycle effort even
  when joint-state headroom independently says to yield. The slower arrival,
  higher mean effort, and larger excursions are evidence against coupling
  those two withdrawal reasons. The compact route survives, so the evidence
  does not support altering mean curvature, the oscillator, or phase lag.
- No sampled rollout terminates in failure. The inherited adverse boundary is
  textual: unrestricted bearing-trend feedback erased the traveling wave and
  exited downstream, undirected physical-limit damping delayed capture, and
  distributing withdrawal across controller layers regressed. These results
  constrain the candidate but are not claimed as newly inspected failure
  visuals.

## Candidate hypothesis

Produce one candidate by removing only the adverse-load veto and restoring the
three-times-reproduced positive-only planar-wrench supervisor. Target-aligned
lateral force or yaw moment may withdraw the bounded optional `8%` posterior
half-cycle residual during coherent closure; opposing fluid loads do not
override the independently observed actuator-pressure withdrawal. Preserve
the filtered body-frame bearing, distributed `12 deg` mean curvature,
`40/60 -> 35/65` allocation, anterior state-feedback oscillator, posterior
lag and damping, and unit-gain traveling wave.

This is a mechanism correction rather than a scalar gain change. The
falsifiable expectation is recovery of the compact `30.4865` capture class and
its lower mean effort and excursions relative to the prefill. The downstream
CFD evaluation occurs after this worker exits, so no same-worker outcome is
claimed.

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may preserve useful vortex-induced assistance by yielding optional active effort instead of cancelling every fluid load
transferable_invariant: keep the propulsive traveling wave and route steering intact, and withdraw only bounded incremental effort when normalized body-frame loading agrees with coherent target-directed motion
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: retain the stronger of positive target-signed lateral force and yaw moment at the sole optional posterior half-cycle residual, while leaving actuator-state withdrawal, distributed mean curvature, and the unit-gain traveling wave independent of opposing fluid loads
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival and distance integral fail to recover the reproduced planar-wrench class, or loads rise without retaining the navigation benefit in repeated or held-out wakes

## Scope

The candidate does not infer vortex phase, cancel crossflow, add actuation, or
encode coordinates, time, or a route. The current evidence argues for pruning
one harmful composition, not adding a new wake-response layer.
