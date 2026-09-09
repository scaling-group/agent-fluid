# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The certified shared-prewarm sheet shows the fish held above and downstream
  of four developed, interacting vortex streets. It is a common initial
  condition, not evidence that any candidate selects a wake or generalizes to
  another release phase.
- The fastest sampled planar-wrench policy and the slower yaw-only policy both
  show a compact, nose-first diagonal transit with a persistent posterior-
  traveling body wake, ample cylinder clearance, and entry into the merged
  cylinder wakes only near capture. Mean velocity `(-0.3566,-0.1474)` against
  mean local flow `(-0.2022,-0.1978)` for the faster sample confirms active
  upstream propulsion rather than passive advection.
- Adding target-signed lateral force beside target-signed yaw moment at the
  optional posterior-residual gate improved fixed-snapshot capture from
  `31.5645` to `30.4865`, mean distance from `1.60525L` to `1.56766L`, and
  score from `0.266663` to `0.302848`. It also reduced relative-crossflow RMS
  from `0.24105` to `0.23534`, force/moment RMS from `66.32/887.63` to
  `65.80/872.96`, and posterior peak excursion from `0.55553` to `0.51897 rad`.
  Both joints still touch velocity and acceleration limits, and mean command
  energy changes little, so this is evidence for a better navigation cue, not
  desaturation, efficiency, Karman synchronization, or wake-phase robustness.
- The assigned parent's two-sided yaw arbiter provides a distinct adverse-load
  comparison. Relative to yaw-only yielding it captured slightly earlier at
  `31.4985` rather than `31.5645`, but force/moment RMS rose to
  `68.66/906.29`; its released sheet retains the same compact route without a
  clearance or topology benefit. The sampled planar-wrench branch is better on
  both arrival and aggregate loads. This cautions against letting one opposing
  channel indiscriminately suppress helpful assistance from another channel.
- No sampled released failure sheet is available. The inherited adverse
  boundary is textual: target-rate feedback at oscillator centers erased the
  traveling bend and exited downstream, while an undirected physical-limit
  gate delayed capture. The present edit therefore leaves the distributed
  mean curvature, anterior oscillator, and unit-gain lagged wave continuously
  active.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: adaptive wake interaction and sensor-modulated robotic-fish rhythmic control
source_mechanism: yield optional rhythmic steering when measured hydrodynamic loading already helps the requested motion, while retaining bounded corrective authority under coherently adverse loading
transferable_invariant: preserve the propulsive rhythm and route loop; use normalized body-frame feedback only to arbitrate incremental control, with helpful motion taking priority over contradictory load channels
nontransferable_details: trout or robot kinematics, muscle activity, published CPG gains, dimensional frequency, single-cylinder vortex phase, actuator ratings, species morphology, and prescribed routes
policy_translation: retain the sampled target-signed yaw-or-lateral-force assistance gate, but add a two-sided consensus veto so actuator-state withdrawal is softened only when both normalized planar load cues oppose the persistent body-frame turn; apply the result solely to the optional posterior half-cycle residual
falsification: reject if capture or the compact self-propelled diagonal is lost, arrival or mean distance regress without a compensating load benefit, force/moment or saturation residence rises without navigation benefit, or held-out wakes expose switching, propulsion loss, or phase sensitivity

## Candidate hypothesis

Produce exactly one candidate by turning the one-sided planar-wrench gate into
a conservative two-sided arbiter. Preserve filtered bearing-to-curvature
steering, the bounded `12 deg` distributed curvature budget, its
`40/60 -> 35/65` allocation, the anterior state-feedback oscillator, posterior
lag and damping, and the unit-gain traveling wave. Either a target-aligned yaw
moment or lateral force may continue to withdraw only the optional `8%`
posterior half-cycle residual during coherent closure. Only when both signed,
soft-normalized cues oppose the requested turn may their consensus reduce the
existing actuator-state withdrawal and restore the residual toward its already
evaluated ungated value. The arbiter cannot add authority or affect any other
controller layer.

This tests whether the parent's slight adverse-load navigation benefit can be
combined with the sampled planar-wrench improvement without inheriting the
parent's load increase. Formal CFD evaluation remains downstream, so no
same-worker performance claim is made.
