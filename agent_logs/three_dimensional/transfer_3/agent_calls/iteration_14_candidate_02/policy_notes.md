# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the prefilled v26 crossflow-supported curvature-relief
  controller. Three sampled evaluations (`solver_44f6e53e7268`,
  `solver_d752dde732c6`, and `solver_166ad9203bfa`) are byte-identical and
  reproduce capture at `25.1185226 T`, score `-0.528107835`, mean distance
  `2.42911137 L`, and final distance `0.74616754 L`.
- `solver_65ec0c80e778` adds course-alignment support to a small paired carrier
  release. It preserves the same capture step and improves score to
  `-0.528103217`, mean distance to `2.42910773 L`, and final distance to
  `0.74616265 L`. The improvement is only `4.62e-6`; it is a narrow terminal
  refinement, not evidence for more carrier authority. Its inside-`1.6 L`
  action maxima rise slightly from about `0.0964/0.2431` to
  `0.0979/0.2456 rad/T^2`, and the lateral-force maximum rises from about
  `0.00204` to `0.00214`, while both remain quiet and far below the envelope.
- All four observations confirm direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no prewarm snapshot, capture, and no instability.
  The inherited step-12 log is also a negative boundary: moving the helpful
  crossflow cue onto mean-curvature unloading retained capture but regressed
  to score `-0.529558` and final distance `0.747693 L`.

## Two-view visual diagnosis

The combined sheets for the strongest finite sample (`solver_65ec0c80e778`)
and the repeated v26 baseline (`solver_44f6e53e7268`) are visually
indistinguishable from release through capture. In the top-down row, the fish
self-propels along one compact target-directed arc and sheds a coherent
alternating mid-plane wake; there is no passive advection or late loop. Near
the target the oscillatory wake and body sweep subside into a quiet glide. In
the oblique Lambda2 row, compact three-dimensional vortex packets follow the
same outer arc without a visible out-of-plane instability, and the final two
frames retain the quiet terminal handoff. Thus the course-supported edit has
the desired outer noninterference, but the scalar and load differences are too
small to justify broadening its gate or amplitude.

## Policy hypothesis

Use the measured-best v28 mechanism as the single candidate: retain v26's
target-angle mean curvature, closure preview, settled two-joint allocation,
and crossflow relief; compute the angle between normalized body-frame target
direction and body-frame velocity course; and permit at most a `3.5%`
additional *paired* carrier release only where the already validated late
crossflow/closure/settled-response support is active. This is a response gate,
not a new turn command, and is exactly absent on the outer approach. The
falsifiable expectation is the sampled result: unchanged coherent outer
trajectory and capture step with a very small distance-integral improvement.
Reject it in later evidence if capture slows or is lost, the outer path
changes, terminal action/load growth becomes material, or the gate is inactive
under replayed states.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG control
source_mechanism: apply strong curvature for large observed error, then release toward propulsion when the measured response is established
transferable_invariant: release a redirect only from bounded observed response, while preserving the propulsive traveling-bend scaffold
nontransferable_details: published gains, species-specific bend envelopes, duty ratios, exact beat or vortex phase, and prescribed routes
policy_translation: body-frame target/velocity course alignment supplies a bounded late response gate for a small coordinated release across both joints
falsification: reject on changed outer motion, delayed or lost capture, renewed oscillation or saturation, material force/moment growth, or an inactive replay gate
