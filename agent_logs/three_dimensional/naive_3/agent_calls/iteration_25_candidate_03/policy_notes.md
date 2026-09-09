# Velocity-ray intercept candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite dynamics, and `100T` horizon
  termination. I inspected both the top-down mid-plane vorticity and oblique
  body/Lambda2 rows of all four combined keyframe sheets, using the highest
  scoring response-hold parent (`solver_2c7a9d1d6ee7`) as the strongest finite
  example and the radial-release policy (`solver_6af775e9aa4a`) as the most
  informative broad-orbit failure. Every fish self-propels from rest, leaves a
  coherent alternating planar wake with compact three-dimensional structures,
  and repeatedly circles the target. Passive advection, wake collapse,
  collision, numerical instability, and loss of propulsion do not explain the
  misses.
- Full-direction target-behind C-turn recovery is now supported as a semantic
  scaffold: unlike the inherited `31--32T` powered lower exits, all four
  sampled recovery variants survive to `100T`. The plain geometry release has
  the best first-pass minimum (`2.346L`) but a `4.714L` mean distance. Holding
  the opposite-sign recovery into ahead-but-lateral states improves mean
  distance to `4.458L` but worsens the minimum to `2.377L`; closing-selected
  carrier contraction similarly improves mean to `4.545L` while worsening the
  minimum to `2.484L`; radial release is worse on both minimum and mean
  (`2.532/4.780L`). All remain noncapturing powered orbits. This closes another
  recovery-release gate, scalar carrier contraction, or phase/amplitude retune
  as the immediate test, while preserving target-behind recovery itself.
- The first pass is a measurable collision-course failure before recovery is
  selected. On the response-hold parent, entry inside `4L` occurs at `13.976T`
  with speed `0.842U`, closure `0.829L/T`, target-forward projection `0.891`,
  and course error `0.176 rad`; by its `2.377L` minimum at `17.881T`, speed is
  still `0.694U`, target-forward projection is only `0.033`, and course error
  has grown to `1.023 rad`. The implied signed velocity-ray miss grows from
  about `0.70L` to `2.03L`. The plain geometry release shows the same pattern
  (`0.192` to `1.121 rad` course error and about `2.11L` predicted miss at its
  `2.346L` minimum). The target passes behind only after this miss is already
  established, so a stronger post-pass recovery cannot repair the first
  crossing.
- Inherited logs and guidance already falsify persistent early line-of-sight
  lead, direct sideslip-to-curvature feedback, duty asymmetry, static C/S-bend
  reallocations, posterior polarity/counterstroke, simple phase-gate changes,
  and a yaw-moment residual. The present signal differs from raw sideslip: it
  is the signed perpendicular distance between the stationary body-frame
  target ray and the instantaneous translational velocity ray, and it is used
  only for an ahead, closing, finite-speed terminal approach.

## Policy hypothesis

Use the plain geometry-release C-turn as the supported recovery scaffold and
replace the completed ahead-side response hold with one collision-course
mechanism. Compute signed velocity-ray miss as normalized distance times the
target/velocity cross product. While the target is ahead, the course is
closing, speed is finite, and distance is within a smooth terminal envelope,
blend the ordinary bearing-curvature equilibrium toward a bounded same-sign
intercept curvature on both joints. The blend releases continuously as miss
distance tends to zero or closure ends. Once the target is behind, the sampled
opposite-sign C-turn remains responsible for recovery.

Support requires preservation of the coherent inbound wake and horizon-safe
recovery plus capture, a materially smaller first-pass miss, or a useful
subsequent crossing below `2.346L` without increased clamp/load residence.
Reject the mechanism if it reproduces the earlier sideslip sign failure,
changes far-field cruise, increases saturation or load spikes, collapses the
traveling wave, exits the domain, or merely trades the current broad orbit for
another noncapturing orbit.

```text
bookshelf_consulted: true
source_domain: fish terminal-approach control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the propulsive traveling wave while a measured relative-motion error selects a bounded terminal steering correction, then release it on observed response
transferable_invariant: separate far-field propulsion and post-pass recovery from an ahead-and-closing correction that drives transverse target-relative motion toward a collision corridor
nontransferable_details: published CPG gains, dimensional frequencies, species-specific approach stages, exact vortex phases, capture radius, target coordinates, and task-specific routes
policy_translation: normalized body-frame target and velocity unit vectors form a signed velocity-ray miss distance; smooth distance, forward-projection, closure, and speed weights blend both joint equilibria toward bounded intercept curvature
falsification: reject on altered far cruise, wrong-sign first-pass turn, worse than the 2.346L sampled minimum, higher clamp/load residence, lost wake coherence, domain exit, or another horizon orbit without a closer crossing
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Controller replay on
completed trajectories may establish signal scale, locality, reflection
equivariance, finite behavior, command bounds, and schema ownership, but it
cannot establish a new hydrodynamic trajectory or score.

## Implemented candidate and non-CFD probes

The candidate removes the completed ahead-side response hold but retains the
sampled target-behind C-turn, posterior phase-lag scaffold, yaw-selected brake,
traveling-wave carrier, and `+/-28 rad/T^2` reserve. Nine owned intercept
parameters define only the normalized miss, distance, forward, closure, speed,
and curvature scales; no clock, step count, mutable state, world coordinate,
target identity, route, or file access is introduced.

Counterfactual signal replay on the plain geometry-release trace gives a
maximum intercept weight of `0.000055` in the first `2T` and a mean of `0.00324`
through `12T`. At first entry inside `4L`, its `0.762L` signed predicted miss
produces weight `0.194` and changes equilibrium curvature from `0.30` to
`2.63 deg`; at the recorded `2.346L` minimum, the `2.112L` miss produces
weight `0.528` and changes curvature from `6.13` to `11.28 deg`. Thus the new
term is negligible at release, continuous and material at the diagnosed
terminal miss, and remains below the already sampled `18 deg` recovery
curvature. These algebraic values do not predict the coupled-flow outcome.

The lightweight Julia controller probe returns `42` parameters, produces
exactly mirrored accelerations for mirrored target, velocity, joint, bearing,
and yaw state (residual `0.0`), remains finite at zero and large finite states,
and respects the declared command reserve. After repairing the rendered
README's duplicate marker for the same assigned parent, the mandated
material-guidance/notes check, Julia policy contract and parameter-schema
guard, and solver editable-boundary check all pass. No formal CFD was run.
