# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The only sampled solver is the assigned iteration-20 2D-champion transfer,
  evaluated in direct uniform still water (`U_infinity=(0,0,0)`) without a
  prewarm snapshot. No inherited optimizer rollout log or separate successful
  solver comparator is present in this first-iteration workspace.
- It is self-propelled rather than advected: the fish starts from rest, travels
  from `(21,14)L` to `(14.18,0.80)L` in `26.13T`, and the top-down sheet shows a
  strong alternating wake. The oblique Lambda2 row confirms coherent paired 3D
  structures rather than a flat or reciprocal wiggle. Preserving the
  state-feedback oscillator and posterior lag is therefore better supported
  than increasing gait amplitude or cadence.
- Target progress is initially useful but not retained: distance falls from
  `12.328L` to `6.127L`, then rises to `10.542L` before `left_domain`. The
  keyframes show the fish sweeping through a long turn toward the lower edge;
  there is no collision or numerical instability immediately before exit.
- Reconstructing normalized body-frame geometry from `trajectory.csv` exposes
  the missing signal. Near `t=4T`, target bearing is about `-0.04 rad` (nearly
  centered) while the velocity course relative to the fish's forward axis is
  roughly `-0.95 rad`. The inherited controller mostly treats the centered
  body axis as a centered route; it reverses the initially useful heading
  correction even though the fish is still translating strongly below the
  target line. By `t=10T`, target bearing has grown to about `+0.63 rad` and
  the recovery arrives too late to prevent the miss.

## One candidate mechanism

Preserve the inherited traveling-wave drive and existing bounded target
curvature actuator, but add one speed-gated course-error residual to the
geometric turn request. Compute actual course angle from normalized body-frame
velocity relative to the model's `-x` forward axis, compare it with the
body-frame target angle, and smoothly suppress the term near zero speed where
course is undefined. This is a semantic feedback addition, not scalar-only
gain tuning.

Expected result: after the first useful alignment, continuing cross-target
translation should keep the corrective turn sign instead of allowing the
body-axis bearing alone to reverse it. The coherent wake should remain because
the oscillator, amplitude, posterior lag, and actuator envelope are unchanged.

Falsification: reject the mechanism if evaluation loses the seed's early
distance closure, destroys the alternating 3D wake, produces sustained joint
saturation/load spikes, or retains the same lower-boundary turn topology and
`left_domain` termination. A later candidate should then test direct yaw-rate
braking or a different steering actuator rather than increasing course gain.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking over a rhythmic CPG; classical bounded curvature steering
source_mechanism: sensor feedback modulates a low-dimensional propulsive rhythm so steering follows achieved course rather than an open-loop body heading alone
transferable_invariant: preserve the propulsive rhythm and use bounded feedback on the error between target direction and measured direction of travel
nontransferable_details: published gains, robot geometry, dimensional speeds, oscillator parameters, species kinematics, exact vortex phases, and task routes
policy_translation: form target and velocity angles only from normalized body-frame observations; add a speed-gated course-error residual to the two-joint bounded curvature request
falsification: reject if early closure or wake coherence degrades, actuation becomes persistently saturated, or the trajectory still turns through the target line into the lower-boundary exit
