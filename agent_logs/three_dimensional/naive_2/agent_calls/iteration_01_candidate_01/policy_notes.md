# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- The assigned sample set contains one completed finite rollout, the common
  drive-only seed (`solver_989ac6cdbb99`), and no successful or near-miss
  comparator. It is therefore both the best available finite example and the
  informative failure; conclusions below are limited to that comparison.
- The assigned parent guidance contains the naive-seed contract and general
  evidence-reading boundaries but no prior candidate-specific control lesson;
  no inherited optimizer notes were present under `logs/optimize/`.
- The rollout is contract-valid direct uniform still water
  (`U_infinity=[0,0,0]`) with no prewarm. It terminates `left_domain` at
  `8.547 T`, at the upper virtual boundary, rather than from numerical failure.
- In the top-down frames the fish creates a coherent alternating wake and
  translates under its own actuation, but the wake path bends upward after
  roughly `4-6 T`. The head then rotates away from the target and the fish
  exits upward. The oblique Lambda2 frames likewise show a finite, organized
  three-dimensional tail wake rather than passive advection or wake collapse.
- The trajectory supports that reading: distance falls only from `12.328 L`
  to a minimum `12.078 L` at `6.358 T`, then rises to `12.380 L`; heading
  changes from `29 deg` initially to about `-45 deg` near exit. The body-frame
  target bearing grows from about `+8.9 deg` initially to roughly `-63 deg`
  by `8 T`. Joint speeds touch the `260 deg/T` cap in about `1-2%` of samples,
  while raw requested acceleration exceeds `1800 deg/T^2` in about one third
  of samples, so stronger unguided drive is not the missing capability.

## Policy hypothesis

Preserve the seed's state-feedback anterior oscillator and lagged posterior
target because they already make a coherent self-propelled wake. Add one new
mechanism: map normalized body-frame target bearing through a bounded smooth
nonlinearity to a small mean-curvature offset, then oscillate both joints
about compatible shares of that offset. This should bias the average bend
toward the target without replacing the propulsive rhythm or reacting to its
fast within-beat yaw. The first semantic test is avoiding the same early upper
boundary exit while making substantially more target progress. Reject the
translation if the turn sign is wrong, the minimum distance does not beat
`12.078 L`, the same exit topology remains, or curvature destroys the coherent
wake/increases sustained limit activity.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning by mean-curvature or tail-beat bias
source_mechanism: a slow directional request adds bounded average bend while the propulsive oscillation continues
transferable_invariant: persistent body-frame lateral target error should bias mean joint curvature smoothly without erasing posterior wave lag
nontransferable_details: published gains, species-specific envelopes, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: saturate observed body-frame bearing into a small curvature center for joint 1 and a compatible reduced center for joint 2, retaining the joint-state oscillator and lagged tail target
falsification: reject if target progress fails to exceed the seed, steering reverses the required turn, the upper-boundary exit recurs, or the wake and actuator histories show propulsion collapse or more sustained saturation
