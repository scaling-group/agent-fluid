# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract and
  capture. Their top-down sheets show self-propelled, alternating streets that
  remain attached to the target-directed trajectory, while the oblique sheets
  show compact caudal Lambda2 structures rather than advection or a diffuse
  failed gait.
- The three geometry-scheduled/reference variants capture at
  `18.6505--18.6835T` with mean distance `2.09340--2.09405L`. The inherited
  half-cycle envelope redistribution also preserves both wake views and
  capture, improves mean distance to `2.08855L` and score to `-0.20041`, and is
  already closer from about `6T` through `16T`, but it passes to the low side
  of the target and captures later at `18.8265T`.
- This is not evidence for posterior-specific allocation or more carrier
  demand. The inherited step-16 failures reached only `3.1735--3.4260L`
  before `left_domain`, and the assigned guidance ties related failures to
  unequal joint allocation. In the sampled captures, half-cycle redistribution
  leaves rate contact essentially unchanged at about `11.1%/14.9%` and
  acceleration contact at `60.9%/73.3%`.

## Policy hypothesis

Preserve the evidenced common envelope redistribution during redirect, but
multiply its strength by the existing one-sided correcting-yaw response gate.
This leaves target geometry as the only route-sign source and cannot invert
curvature. It should retain the early distance-integral advantage while
releasing the new half-cycle asymmetry when observed yaw is already correcting,
reducing the low-side terminal excursion and recovering earlier capture. The
formal rollout falsifies the candidate if it loses capture or either coherent
wake view, gives back the `2.08855L` route-integral improvement, does not improve
the `18.8265T` arrival, or materially worsens rate/acceleration contact or
planar loads.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological burst redirect
source_mechanism: bounded asymmetric rhythmic action during redirect followed by observed-response release
transferable_invariant: preserve propulsion while route error requests asymmetry, then relax that asymmetry once correcting body response is present
nontransferable_details: published gains, duty ratios, species-specific kinematics, exact timing, vortex phase, and task routes
policy_translation: multiply normalized body-frame target-signed displacement-half-cycle envelope redistribution by the existing non-inverting correcting-yaw response gate
falsification: reject if capture, the coherent top-down street, compact oblique caudal structures, the inherited mean-distance lead, arrival, or load and saturation behavior worsens
