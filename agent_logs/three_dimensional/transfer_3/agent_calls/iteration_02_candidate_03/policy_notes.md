# Candidate wake-policy notes

## Visual and diagnostic comparison

All three finite sampled rollouts satisfy the direct-uniform still-water
contract: `U_infinity=(0,0,0)`, no prewarm, and no cylinders. Their movement
is self-propulsion rather than advection.

- `solver_19f251537923` provides the strongest useful trajectory. Its
  top-down row develops an organized alternating vortex street, and its
  oblique row shows paired three-dimensional structures persisting as the fish
  travels. Distance falls from `12.328L` to `6.138L` at `16.505T`; the wake
  remains coherent, but the body continues its downward arc and exits the
  lower boundary at `26.147T`, after distance reopens to `10.460L`. The
  trajectory agrees: recent yaw rate grows from `0.211rad/T` at closest
  approach to `1.571rad/T` at exit while local flow stays small. This is a
  steering-arrest failure, not passive advection or loss of thrust. However,
  at least one raw acceleration exceeds `1800deg/T^2` in 4650/4754 samples,
  so its clipped `0.55T`, `28deg` operating point is not a reusable carrier
  calibration.
- The scalar-best sibling `solver_97bc3c03d55b` still has a worse closest
  approach (`9.175L`) and exits the upper boundary at `11.132T`. Both views
  show sustained propulsion and alternating structures, but the compact
  posterior mean-curvature rate loop rotates the fish from `0.506` to
  `-0.791rad` and leaves with velocity `(-0.783,+0.595)U`; 1213/2024 samples
  exceed the acceleration envelope. Its lower distance-integral score does
  not establish controlled pursuit.
- `solver_e6325a747ec1` is the informative low-action comparison. It never
  exceeds the acceleration envelope, yet its `14deg` posterior mean-curvature
  loop makes essentially no initial progress (`12.323L` minimum), turns to
  `-1.387rad`, and exits the upper boundary at `9.394T` with distance
  `13.616L`. The top-down row shows the body curling away before a useful
  streamwise wake develops, and the oblique row shows compact shed structures
  following that redirect rather than a productive target approach.

The assigned parent's inherited `v19` yaw-arrest candidate is also negative
evidence. Adding a response-gated posterior curvature residual to the dense,
clipped inherited controller degraded the `6.138L` closest approach to
`9.319L`, reopened distance to `16.264L`, and produced another domain exit.
The failed `solver_117f1b60a271` supplies no hydrodynamic evidence because its
parameter schema omitted the required `control_period` field.

## Policy hypothesis

Retain a joint-state traveling bend but move its nominal period/amplitude
inside the actuator envelope. Replace persistent mean-curvature steering with
one new actuator primitive: normalized body-frame line-of-sight error
asymmetrically scales the posterior wave target by observed half-cycle. A
positive-side target strengthens the positive posterior bend and weakens the
negative bend; reflection reverses both the target command and joint phase.
This creates a bounded average turn while every cycle retains both signs and
the posterior lag. It also avoids using the eight-step recent-yaw estimate as
a slow turn response, since the sampled traces show beat-scale yaw excursions
large enough to reverse the two prior rate loops.

The candidate is falsified if initial target-relative turn has the wrong sign,
distance does not improve beyond `9.175L`, the same upper-boundary exit
recurs, the alternating wake collapses, or the final acceleration guard is
persistent rather than exceptional. A future evaluation must establish the
hydrodynamic effect; the same-worker dry check can establish only finite,
contract-compatible joint commands.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated rhythmic steering
source_mechanism: strengthen the target-consistent half-cycle of an ongoing propulsive rhythm instead of imposing a static bend
transferable_invariant: persistent body-frame target error biases the cycle average through bounded half-cycle asymmetry while posterior lag and both bend directions preserve propulsion
nontransferable_details: published gains, duty ratios, dimensional beat frequencies, linkage geometry, clock-driven CPG phase, exact vortex phase, and source-task routes
policy_translation: map normalized target_body_L/distance_L to a bounded signed command and use observed joint-state wave sign to scale only the posterior traveling-wave target within the two-joint feedback law
falsification: reject if turn sign is wrong, the upper exit or poor closest approach persists, the coherent alternating wake is lost, or joint/action saturation becomes persistent
```

## Dry mechanism check

A non-CFD `0.0055T` joint integration applied the episode's angle/rate limits
for `60T`. With a centered target, the carrier reached approximately
`24.0/23.8deg`, `177.6/177.3deg/T`, and
`1327.0/1286.9deg/T^2` on the anterior/posterior joints. Fixed normalized
lateral target components of `+/-0.25` produced mirrored posterior mean bends
of `+3.51/-3.59deg` while retaining `28.0deg` posterior excursions; peak rate
remained below `185deg/T`, peak acceleration below `1462deg/T^2`, and the
`1700deg/T^2` guard was never reached. This establishes finite commands,
reflection behavior, and actuator-envelope margin only. It does not establish
thrust, turn response, wake quality, or target progress without the later CFD
evaluation.
