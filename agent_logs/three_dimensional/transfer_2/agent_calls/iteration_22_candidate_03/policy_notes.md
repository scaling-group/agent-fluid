# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=[0,0,0]`, no prewarm snapshot,
  no cylinders, and `capture` termination at `24.6730156T`.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sample (`solver_63f2335275d2`, v38) and the informative mechanism
  failure (`solver_c68ca55be97d`, v36). The top-down row shows self-propelled
  travel from rest, a smooth broad clockwise approach, and a coherent compact
  alternating wake rather than passive advection or wasteful side-to-side
  wandering. The oblique Lambda2 row shows persistent three-dimensional vortex
  packets with no breakup, collision, domain-exit precursor, or instability at
  capture. The v36 and v35 sheets are byte-identical; v38 differs only in the
  final approach and is visually indistinguishable at sheet resolution.
- The trace cross-check agrees with the images. The replicated v35 samples and
  v36 all score `-0.4486465691`, capture at `0.7486842275L`, and have identical
  `2.3482557548L` scored mean distance. Thus the course-consistency predicate in
  v36 did not alter the realized trajectory and is a negative mechanism result,
  not evidence for more predicate or threshold tuning.
- V38 keeps course steering active after body-axis passage. It starts diverging
  only at `24.0570T` and improves the crossing to `0.7486411929L` and the score
  to `-0.4486101517`, but arrival time is unchanged and scored mean distance
  changes by only `0.0000278L`. At capture it still has material course/heading
  error (`heading_error=0.3844`) while the anterior rate is essentially at the
  `260 deg/T` limit. Its peak planar force/yaw-moment coefficients remain low
  (`0.0243/0.0316/0.0156`), and the coherent wake is preserved.
- Relative to the inherited v34 result, the sampled v35 steering-residual coast
  is already a useful allocation change: capture advances from `25.0635T` to
  `24.6730T`, score improves from `-0.452083` to `-0.448647`, and peak loads
  remain in the same low class. This supports retaining velocity-opposing
  steering when posterior carrier acceleration is coasted; it does not support
  another shared rate barrier or output clip.

## Policy hypothesis

Use v38's terminal course continuity as the parent behavior. Add one compact,
mirror-equivariant actuator-allocation mechanism: while the target is near and
still closing with a material normalized velocity-course error, continuously
reduce only the posterior traveling-wave carrier toward an owned floor. Keep
the anterior state-feedback oscillator, mean-curvature/course steering,
braking reserve, and posterior rate coast unchanged. This should free follower
stroke/rate headroom for the already successful course steering without
coasting the fish or changing the established far approach.

Falsification: reject the mechanism if evaluation loses capture, delays the
established `24.673T` arrival materially, changes the far trajectory, increases
posterior hard-stop/rate occupancy or the v35/v38 low-load class, or visibly
breaks the alternating three-dimensional wake. A scalar improvement confined
to the final integration step is insufficient unless capture and the physical
diagnostics survive.

bookshelf_consulted: true
source_domain: robotic-fish CPG modulation and terminal capture control
source_mechanism: separate rhythmic propulsion from steering and reduce follower carrier authority during a bounded near-target correction while preserving the phase anchor
transferable_invariant: reserve limited follower actuation for observed course correction without destroying the traveling bend that supplies propulsion
nontransferable_details: published CPG gains, clock phase, species-specific amplitudes, exact vortex timing, and task-specific routes
policy_translation: gate posterior carrier amplitude with normalized body-frame range, closing speed, velocity-course error, and joint-state feedback; retain mean steering and the anterior oscillator
falsification: reject if capture, far-route invariance, zero posterior hard-stop occupancy, low loads, or coherent wake structure does not survive
