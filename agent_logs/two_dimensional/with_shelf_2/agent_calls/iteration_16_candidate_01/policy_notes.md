# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows a developed, asymmetric interaction of four
  vortex streets before release. It is a common initial condition, not evidence
  for a candidate-specific wake response.
- The assigned parent's policy and three sampled copies all preserve a
  zero-centered traveling bend, self-propel diagonally upstream through the
  interacting wake, and reach the target. Their identical fixed-snapshot result
  is `45.221` release time, `1.71458L` mean distance, `1030.39` mean command
  energy, and `439.16/4344.77` force/moment RMS. The image sheet shows useful
  upstream propulsion and route acquisition, so neither the base oscillator nor
  the progress-qualified posterior residual should be replaced.
- The strongest sampled finite policy adds a speed-qualified, near-target
  comparison between observed body-course angle and target bearing. Its sheet
  retains the same far/middle diagonal topology but finishes with less lateral
  overshoot. The metrics agree: it reaches at `44.121`, lowers mean distance to
  `1.70618L`, total command energy to `45731.1`, and force/moment RMS to
  `388.95/3908.93`; relative-crossflow RMS is essentially unchanged
  (`0.28935` versus `0.28893`). This isolates terminal route response rather
  than a calmer wake or a new gait.
- No sampled solver example provides a semantic-failure keyframe sheet. The
  inherited informative failure boundary is therefore the documented
  propulsive-priority trajectory that passed below capture and collided at
  `58.93` after a `1.872L` closest approach with `537/4995` RMS loads. The
  inherited low-score rollout reached only at `70.790` with `2.71465L` mean
  distance despite lower `200/2132` RMS loads. Together they rule out trading
  away the proven route merely to reduce aggregate load.

## Candidate hypothesis

Adopt the sampled near-target body-course mismatch correction as the one
candidate mechanism. Preserve the parent's oscillator, lagged posterior wave,
yaw-gated target steering, positive-closure qualification, course-consistency
allocation, joint-rate headroom gate, and time-to-go heading horizon. Compute
course only from normalized body-frame velocity; qualify it by observed speed;
and apply it through a smooth distance gate only to `predicted_bearing`. This
should preserve far/middle propulsion while correcting lateral momentum before
the tight capture boundary. Do not gate or rescale the base propulsive wave.

bookshelf_consulted: true
source_domain: fish and robotic-fish terminal target capture in disturbed flow
source_mechanism: approach hold with measured course/slip damping after broad target-directed propulsion is established
transferable_invariant: near a tight target, line-of-sight bearing alone can understate crossing momentum, so a smooth speed-qualified course mismatch may refine steering without changing the propulsive rhythm
nontransferable_details: published gains, animal kinematics, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use normalized body-frame velocity to form bounded body course minus bearing, activate it smoothly with normalized target distance and speed confidence, and subtract only this residual from the heading prediction that drives two-joint half-cycle steering
falsification: reject if evaluation loses capture or the diagonal topology, weakens upstream travel, increases mean distance or arrival time without a material load/effort benefit, or recreates the below-target collision boundary
