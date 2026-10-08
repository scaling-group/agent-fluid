# Course-aligned approach steering-relief candidate

## Visual and quantitative diagnosis before the policy edit

- All four sampled solver evaluations are deterministic materializations of
  the same error-qualified policy. They satisfy the frozen direct-uniform
  still-water contract, capture at `17.7265T`, score `-0.08139542`, and share
  identical combined keyframes. I inspected both the top-down vorticity row
  and oblique Lambda2 row. The fish self-propels from rest, sustains a coherent
  alternating wake with compact posterior three-dimensional structures, and
  reaches the target without collision, wake breakup, passive advection, or
  out-of-plane instability. There is no sampled termination failure; the
  assigned parent's weaker finite capture is the informative negative control.
- The assigned parent changed only the carrier gate inside the `2.10L`
  approach, replacing the sampled policy's course corridor with all-positive
  progress quality. Its trajectory first diverges after approach entry at
  about `15.95T`; it still captures on the same step and preserves visually
  indistinguishable two-view wake topology, but score regresses to
  `-0.08416658`, score mean distance rises from `1.967391L` to `1.969622L`,
  and final distance rises from `0.747287L` to `0.749986L`. Direct trajectory
  calculations also show path increasing from `12.84682L` to `12.84834L`,
  mean/final approach alignment falling from `0.8993/0.6010` to
  `0.8980/0.5869`, final yaw magnitude rising from `0.901` to
  `0.943 rad/T`, and final speed rising from `0.898U` to `0.905U`, with no
  cross-track benefit. Positive closure alone is therefore too permissive a
  terminal propulsion qualification for this rollout.
- The sampled winner's remaining approach behavior is not weak propulsion.
  Reconstructing its normalized body-frame observations from the trajectory
  shows several phases with excellent inertial course alignment but large
  gait-scale body yaw and a strong geometric turn demand: near `16.18T`,
  course alignment is `0.969` while recent yaw is about `+2.99 rad/T`; near
  `16.84T`, alignment is `0.990` while yaw is about `+2.80 rad/T`; and near
  `17.50T`, alignment is `0.991` while yaw is about `+2.55 rad/T`. The
  corresponding geometric steering request remains large and same-signed with
  the rate correction. This distinguishes oscillatory body attitude from
  actual route error and motivates feedback-authority allocation rather than
  another drive, saturation, or terminal-course injection.

## One policy hypothesis

Preserve the sampled error-qualified line-of-sight observer, odd curvature
map, anterior phase-plane carrier, posterior lag/emphasis, course-qualified
cadence, half-cycle steering, and reversal-preserving rate governor. Add one
approach-only course-aligned steering relief: when the existing normalized
course corridor reports fast target-directed translation, continuously reduce
only the geometric target-bearing/vector request in proportion to approach
depth. Keep turn-rate feedback, recovery/braking terms, and the far/middle
line-of-sight residual unchanged. The relief vanishes outside approach and
whenever course alignment falls below the validated corridor, so full target
steering returns without a clock, stored stage, coordinate, or route.

Expected evidence is retention of capture, the coherent two-view traveling
wake, and the sampled sub-`0.52L` cross-track while improving score-distance,
path, and late alignment/yaw by avoiding gait-phase body chasing on an already
productive inertial course. Falsify the mechanism if capture or route
directness regresses, if yaw/load or actuator-limit residence rises, if the
relief prevents necessary recovery as the course degrades, or if a reflected
target/pose fails to produce a reflected response.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic locomotion and classical far/middle/near terminal capture control
source_mechanism: preserve the traveling-wave carrier while qualifying slow steering authority by observed translational course quality near the target
transferable_invariant: body oscillation is not itself route error, so near-target geometric steering may be relieved while target-directed translation is strong, provided rate damping remains and full steering returns when course quality degrades
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, switching distances, and task-specific routes
policy_translation: use the existing normalized body-frame target-to-velocity alignment and approach depth to attenuate only geometric turn demand; preserve the two-joint carrier, yaw-rate correction, recovery terms, and odd reflection symmetry
falsification: reject if capture, score-distance, path, cross-track, terminal alignment, yaw/load scale, actuator residence, reflection symmetry, or either visual wake view regresses

## Dry activation audit after the edit

Replaying only the new algebraic gate over the sampled winner's recorded
observations (not CFD and not a claim about the new trajectory) makes the
relief exactly zero outside `2.10L`. It is nonzero on `247/329` recorded
approach rows, averages `0.0875`, and peaks at `0.2742`, so the edit is both
material and bounded well below removal of geometric steering. Static checks
also confirm balanced delimiters, one public parameter constructor, one public
policy function, one two-joint return surface, and no undefined direct
`params.FIELD` reference.
