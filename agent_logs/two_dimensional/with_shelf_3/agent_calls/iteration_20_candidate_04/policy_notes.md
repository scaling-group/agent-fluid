# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the common certified
  initial condition, not evidence of candidate-specific wake selection or
  robustness to a changed release phase.
- Three sampled policies reproduce the same strongest controller and result:
  a coherent posterior-traveling bend propels the fish upstream and downward
  on a compact, nose-first diagonal, stays clear of every cylinder, and enters
  the merged wakes only near capture. They reach at `30.4865`, with mean
  distance `1.56766L`, score `0.302848`, relative-crossflow RMS `0.23534`,
  and force/moment RMS `65.80/872.96`. Mean fish velocity
  `(-0.35660,-0.14740)L/time` exceeds mean local flow upstream, so this is
  active propulsion rather than passive advection.
- The only distinct sampled contrast retains the same successful topology but
  lets unanimously opposing lateral force and yaw moment veto all optional-
  residual withdrawal. It captures later at `31.3335`, increases mean distance
  to `1.59773L`, and lowers score to `0.273753`; its lower force/moment RMS
  `62.68/845.71` is a load/navigation trade rather than an improvement. Thus
  an opposing instantaneous wrench is not evidence that the posterior residual
  should be restored.
- Inherited logs provide a second adverse boundary. Expanding the winning
  lateral-force/yaw gate with positive force projected along the full target
  vector still captured, but slipped to `30.558`, raised mean distance to
  `1.56958L`, and raised force/moment RMS to `69.18/902.43`. Do not add a
  streamwise target-force cue or interpret every targetward force component as
  useful steering assistance.
- No sampled rollout has a failure termination. The weakest successful sheet
  is therefore the available visual contrast; inherited downstream-exit cases
  remain textual boundaries against moving feedback into oscillator centers or
  weakening the base traveling wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers can yield optional active effort when measured fluid loading already assists task-directed motion instead of cancelling every wake load
transferable_invariant: preserve the propulsive traveling wave and route steering while smoothly withdrawing only bounded incremental effort when normalized body-frame load components positively support the requested turn
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: keep the evidenced positive target-signed lateral-force and yaw-moment cues at the sole optional posterior half-cycle residual, replace their hard maximum with a bounded soft union that equals either cue when the other is absent and adds corroboration only when both assist, and leave opposing loads inert
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival or mean distance regresses from `30.4865/1.56766L`, force or moment rises without navigation benefit, or concurrent cues cause propulsion loss or chattering in a held-out wake

## Candidate hypothesis

Produce exactly one candidate that changes only how the two already evidenced
positive planar-wrench cues are fused. Replace the hard maximum of normalized
target-signed lateral force and yaw moment with the bounded soft union
`1 - (1 - yaw_help) * (1 - force_help)`. When only one cue is active this
recovers that cue exactly; simultaneous positive translation and rotation
provide smoothly stronger evidence to yield the optional `8%` posterior
half-cycle residual. Opposing loads remain inactive, so this does not repeat
the adverse-load veto, and no streamwise force projection is introduced.

Preserve the filtered bearing, bounded distributed mean curvature, anterior
state-feedback oscillator, posterior lag and damping, and the unit-gain
traveling wave. This is a cue-fusion mechanism test, not scalar gain tuning.
The current candidate's CFD evaluation occurs only after this worker exits, so
no same-worker improvement is claimed.
