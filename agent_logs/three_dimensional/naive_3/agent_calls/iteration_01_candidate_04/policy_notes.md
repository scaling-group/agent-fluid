# Wake-policy candidate notes

## Evidence read before architecture

- Assigned parent guidance is the fresh-lineage contract in
  `guidance/control_experience.md`; no inherited candidate-specific optimizer
  log is present in this workspace. The only sampled solver is the common
  drive-only seed `solver_35fea652543a`, so there is no successful or
  long-horizon finite example to compare against it.
- The sampled rollout satisfies the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Both the
  top-down vorticity sheet and oblique Lambda2 sheet were inspected.
- Visually, the fish is self-propelled rather than advected. An alternating,
  increasingly coherent three-dimensional tail wake develops after release,
  but the body curls toward the upper boundary instead of maintaining its
  initially near-target heading. The last frames show a strong path bend, not
  a moving-window coordinate jump.
- Metrics agree with the visual diagnosis: distance starts at `12.3277L`,
  reaches only `12.0701L` at `6.358T`, and rises to `12.3677L`; the fish exits
  the top margin at `8.602T` with center `(20.0626,15.2023)L`. Heading ranges
  from `0.6017` to `-1.1858` rad while the policy has no target observation.
  Both joint rates reach the `260 deg/T` limit and raw requested accelerations
  reach about `60` and `75 rad/T^2`, so the drive is forceful but lacks route
  control; this candidate does not claim those saturations are efficient.

## Candidate hypothesis

Preserve the only evidenced useful capability—the seed's state-feedback
traveling bend—and add one missing mechanism: a bounded target-bearing to mean
curvature reflex. Compute a smooth bend target from normalized body-frame
`bearing`, subtract normalized `heading_rate` damping, and center both joint
oscillation targets on distributed shares of that command. This keeps phase in
joint state, avoids world coordinates and elapsed time, and lets the controller
return continuously to a zero-mean gait as bearing vanishes.

The expected signature is a correct-sign steering response during the first
few beats, decreasing absolute bearing, left-and-down target progress, and
survival beyond `8.602T` while retaining an alternating posterior wake. Reject
the mechanism if the first sustained turn has the wrong sign, bearing remains
large, propulsion collapses, the same top-boundary exit topology persists, or
joint-limit residence/load spikes materially worsen. If the turn sign is
correct but the fish oscillates around the route, later work should test
bearing-rate or slip damping rather than another open-loop drive gain.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and fish mean-curvature turning
source_mechanism: sensor-modulated average bend superposed on a propulsive rhythm
transferable_invariant: slow body-frame target error should command bounded mean curvature while the posterior traveling bend continues to supply thrust
nontransferable_details: published gains, clocked CPG phase, robot geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: map clamped body-frame bearing and normalized heading rate to a smooth curvature target distributed across the two joint-state oscillators
falsification: reject if turn sign is wrong, absolute bearing does not fall, the alternating wake or target progress collapses, or actuator-limit residence worsens
