# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The certified prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is common initial-condition
  evidence; it does not establish candidate-specific wake selection or
  robustness to another release phase.
- Three sampled, functionally identical planar-wrench policies reproduce the
  strongest result: a persistent posterior-traveling bend actively propels the
  fish down and upstream on one compact diagonal, stays clear of every
  cylinder, enters the merged developed wakes only near capture, and reaches
  the target at `30.4865`. Mean velocity `(-0.3566,-0.1474)L/time` versus mean
  local flow `(-0.2022,-0.1978)` confirms self-propulsion rather than passive
  advection. The repeated metrics are score `0.302848`, mean distance
  `1.56766L`, relative-crossflow RMS `0.23534`, force/moment RMS
  `65.80/872.96`, and mean command energy `1416.41`.
- The sampled opposing-load-veto sibling preserves the visible route and
  capture class but delays arrival to `31.3335`, raises mean distance to
  `1.59773L` and mean command energy to `1420.90`, and increases relative
  crossflow to `0.23913`. It lowers aggregate force/moment to `62.68/845.71`,
  but that load trade is not worth the navigation regression and demonstrates
  that one adverse instantaneous wrench component should not cancel a
  simultaneous helpful component.
- An inherited targetward-force-projection extension is a second, narrower
  negative result. It still captures on the direct route but regresses to
  `30.5580`, `1.56958L`, and score `0.300983`, while force/moment rise to
  `69.18/902.43`. Thus adding another positive force projection broadens the
  assistance detector without improving the fixed-snapshot result.
- Every current sampled rollout is a target capture, so no sampled failure
  keyframe exists. The inherited adverse boundary remains the documented
  downstream-exit topology produced when target-rate feedback erased the
  traveling bend. Both joints in the current winner still touch velocity and
  acceleration ceilings, so the evidence supports route/load improvement but
  not desaturation, energetic efficiency, or robustness.

## Candidate hypothesis

Keep the twice-proven target-signed yaw and lateral-force cues, but replace
their hard maximum with a bounded cooperative union. Either positive cue still
recovers exactly its existing authority when the other is absent; when both
agree, their overlap provides extra confidence that the fluid wrench is
helping the requested turn and translation. This may withdraw more of only the
optional `8%` posterior half-cycle residual during coherent target closure.
Opposing components remain unable to veto assistance, and no targetward-force
projection is added.

Preserve the filtered body-frame bearing, bounded distributed mean curvature,
anterior state-feedback oscillator, posterior lag and damping, unit-gain base
traveling wave, trajectory-efficiency supervisor, and actuator-state headroom
paths. The candidate changes one signal-fusion mechanism at the already
evidenced optional-residual locus; it adds neither controller authority nor a
new observation. Formal CFD evaluation remains downstream, so this worker
does not claim that cooperative fusion improves the sampled winner.

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may preserve useful vortex-induced translation and rotation by yielding optional active effort rather than cancelling organized fluid loading
transferable_invariant: preserve the propulsive traveling wave and route steering while withdrawing only bounded incremental effort when normalized body-frame loading agrees with coherent target-directed motion
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: combine the two already evidenced nonnegative target-signed yaw-moment and lateral-force cues with a bounded cooperative union only at the optional posterior half-cycle residual; leave adverse cues, mean curvature, and the unit-gain traveling wave outside that fusion
falsification: reject if capture or the compact self-propelled diagonal is lost, arrival or mean distance regresses from 30.4865 and 1.56766L, force or moment rises without navigation benefit, or held-out wakes expose switching, propulsion loss, or phase sensitivity
