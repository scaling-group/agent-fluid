# Multi-Wake Candidate Notes

## Evidence reviewed before architecture

- The assigned parent is the deliberately naive, target-blind state-feedback
  oscillator in `solver_4b03cd285d3a`. This fresh lineage contains no inherited
  optimizer-note log and only this one sampled solver rollout, so there is no
  positive finite example to compare against; the seed is both the prefill and
  the informative failure.
- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. The release sheet then shows
  active body waves and a self-propelled trajectory, but no sustained turn
  toward the green target. The fish rotates into an almost vertical southbound
  path and exits through the lower boundary while remaining downstream of the
  target/cylinder region.
- The metrics agree with that reading: `left_domain` occurs after only
  `50.1269` release time; head displacement is `(-3.545, -13.300)L`; the
  closest approach is still `8.615L`; and progress is only `0.0243`. Both
  joints reach about `0.46 rad`, both acceleration commands reach the
  `31.416 rad/time^2` envelope, and RMS force-y/moment-z are `21.94/541.70`.
  Thus the gait makes motion, but target-blind propulsion cannot reject the
  accumulated yaw/lateral departure. The evidence does not support increasing
  oscillator gain or adding an uncalibrated wake-phase cancellation term.

## Candidate hypothesis

Preserve the seed's joint-state oscillator and posterior lag, but center the
oscillation on a bounded mean bend computed from the scale-free body-frame
target bearing. Remove that mean from the oscillatory coordinate before
constructing the posterior lag, then add a smaller same-sign posterior mean
bend. This should retain the traveling component while providing persistent
turn authority whenever the target moves laterally in the body frame.

Falsification: reject this mechanism if the next CFD rollout does not bend the
trajectory toward the target before the seed's approximately `50`-time-unit
domain exit, if the closest approach does not improve materially from
`8.615L`, or if mean curvature suppresses propulsion, increases joint-limit
residence/load spikes, or merely changes which boundary is crossed.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and tail-beat-bias turning
source_mechanism: sensor-driven target error modulates the mean curvature of an oscillatory gait
transferable_invariant: persistent body-frame bearing error should create a bounded same-sign mean bend while the zero-mean traveling wave remains available for propulsion
nontransferable_details: published CPG gains, robot geometry, species kinematics, dimensional beat rates, exact vortex phase, and source-task routes
policy_translation: map clamped body-frame bearing through a smooth saturation to an owned mean-bend limit; run the anterior oscillator about that moving center and give the posterior joint a smaller mean-bend share while retaining its state-derived lag
falsification: no targetward trajectory deflection or improved closest approach, loss of upstream propulsion, greater saturation/load spikes, or a different domain-exit path without semantic improvement
