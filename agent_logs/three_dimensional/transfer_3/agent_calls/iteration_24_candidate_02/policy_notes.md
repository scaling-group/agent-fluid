# Wake-policy candidate diagnosis

## Sampled evidence

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=[0,0,0]`, no prewarm, finite
  trajectories, and capture termination.
- The three byte-identical v34 direction-conditioned limiter rollouts reproduce
  exactly: capture at `21.912008 T`, score `-0.3246592933`, mean distance
  `2.218947189 L`, and final distance `0.747680604 L`. The top-down sheets show
  self-propelled, coherent alternating shedding throughout the compact curved
  approach. The oblique sheets show finite three-dimensional Lambda2 structures
  behind the moving body rather than passive advection or wake collapse. Below
  `4 L`, the carrier settles into the already validated held-bend glide with no
  acceleration-cap samples in these reproductions.
- The assigned v35 parent adds a common outward-command attenuation near either
  joint-rate envelope. It retains the same visible wake class and capture, but
  regresses to `22.038506 T`, score `-0.3276334301`, mean distance
  `2.222065709 L`, and final distance `0.748223662 L`. A trace reconstruction of
  the guard's declared rate/sign conditions finds support on 683 outer stored
  states from about `2.37 T` through `15.97 T`; nevertheless, the rollout still
  records 246/313 anterior/posterior states above `4.53 rad/T`. The change also
  reaches `4 L` in a different gait phase and produces five greater-than-30
  commands per joint just inside that boundary, although the guard law itself
  is outer-gated. The evidence therefore rejects stacking this rate attenuation
  on the winning direction-conditioned limiter: it reduces useful outer carrier
  response without buying physical rate headroom or a better terminal state.

## Policy hypothesis

Restore the exactly reproduced v34 saturation baseline and leave its mean
curvature, coupled limiter, and complete terminal controller unchanged. Add one
outer, response-conditioned redirect release: a large body-frame redirect still
forms the same bounded curvature and initially relieves the carrier, but a small
part of that drive relief is released only when both recent body turn and
body-frame bearing motion have the sign that reduces the current redirect
error. The release is common to the two-joint carrier, is continuously bounded,
and is exactly dormant at and below `4 L`. On the stored v34 trajectory, the
proposed conjunction is independently active on about 350 states, with a
maximum drive-frequency-scale restoration of about `0.0425`; it does not depend
on clock time, a world route, exact beat phase, or a force reconstruction.

The intended effect is to retain strong geometry-gated redirection while
recovering propulsion after an observed correct-sign turn, shortening the outer
approach without reviving the rejected terminal cadence mechanism. Falsify the
hypothesis if capture is slower or lost, mean/final distance regresses, the
outer path ceases to be compact, either wake view loses coherence, joint-stop
dwell or load spikes grow, or the nominally dormant terminal law is directly
modified.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG control
source_mechanism: strong error-triggered curvature followed by response-gated release back into propulsion
transferable_invariant: let observed target error initiate a bounded redirect, then restore propulsive authority only after measured motion has the correct response sign
nontransferable_details: species-specific burst shape, published CPG gains, dimensional cadence, exact vortex phase, and any timed maneuver sequence
policy_translation: preserve body-frame redirect curvature; beyond 4 L only, conjunct normalized recent turn and bearing-convergence support to release a small common fraction of existing carrier relief
falsification: reject on slower or lost capture, worse distance integral, changed terminal commands, renewed stops or load spikes, or degradation of coherent top-down and oblique wakes
