# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-identical
  velocity-quadrature phase-lag policies reproduce `23.122009T`, `2.133413L`
  scored mean distance, `0.749507L` crossing distance, and score `-0.237071`.
  The matched whole-carrier posterior recovery captures later at `23.331013T`,
  with `2.135772L` mean distance and score `-0.239045`.
- The complete top-down rows show self-propelled S-shaped approaches with an
  attached alternating red/blue caudal street through capture. Two complete
  oblique rows for the phase-lag policy show discrete three-dimensional
  Lambda2 structures following the moving tail. The remaining phase-lag row
  and the whole-carrier row are black render failures, so they provide no
  independent 3D-wake evidence.
- The weaker whole-carrier policy nevertheless isolates useful startup
  behavior. It is ahead at `2T` (`12.156L` versus `12.207L`) and `4T`
  (`11.297L` versus `11.447L`), while the phase-lag policy passes it between
  `9T` and `12T` and is closer at `20T` (`2.026L` versus `2.155L`). In the
  phase-lag trace, mean through-water forward speed is approximately
  `-0.002U` over `0--1T`, `0.122U` over `1--2T`, `0.276U` over `2--3T`, and
  `0.441U` over `3--4T`; the inherited recovery gate is correspondingly
  `1.000`, `0.976`, `0.673`, and `0.120`. Thus whole-carrier amplitude is the
  better observed near-zero-speed response, whereas velocity quadrature is
  associated with the later route benefit.
- The phase-lag allocation also lowers peak normalized force/moment relative
  to whole-carrier recovery (`0.030360/0.015861` versus
  `0.030861/0.016213`), though it raises mean action (`60.062` versus
  `59.044`) and exact anterior/posterior rate-cap occupancy
  (`11.92/7.06%` versus `11.34/6.27%`). The inherited tail-headroom gate
  reduced action, cap occupancy, and loads but delayed capture to
  `23.314514T`; the following target-side half-cycle redistribution delayed it
  further to `23.452015T` and raised mean distance to `2.142002L`. Along with
  the assigned-parent angle-quadrature regression to `23.265013T`, these are
  evidence against unloading, half-cycle scaling, or additive posterior angle
  amplitude throughout the recovery interval.

## One candidate hypothesis

Preserve the reproduced phase-lag policy's through-water course feedback,
anterior oscillator recovery, target geometry, anterior redirect,
phase-selective carrier, reactive rudder, and terminal relief. Preserve the
same bounded `0.12` posterior recovery share, but encode it as a convex handoff
between the two independently sampled posterior responses: whole-carrier
amplitude only at near-zero through-water speed and velocity quadrature above
that startup band. A smooth gate is fully on below `0.05U` and fully off by
`0.20U`; these thresholds bracket the observed `0--2T` startup without using a
clock. The two recovery paths are blended rather than added, so the candidate
does not stack posterior angle amplitude onto the phase-lag increment.

The hypothesis is that the whole-carrier path can recover part of its measured
`0--4T` progress advantage while the early handoff leaves the route-forming
velocity quadrature intact. This is a new state-dependent actuator-quadrature
allocation, not scalar-only tuning. It uses normalized body-water speed and
joint state, with no elapsed time, step count, fixed coordinate, target
identity, route memory, or prescribed vortex phase.

Falsify the mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, the candidate is not ahead of the phase-lag
parent by `4T`, or its `12--20T` route advantage over whole-carrier recovery
disappears. Also reject it if mean action exceeds `60.062`, anterior/posterior
rate-cap occupancy exceeds `11.92/7.06%`, peak normalized force/moment exceed
`0.030360/0.015861`, or a complete two-view sheet does not retain the
alternating three-dimensional carrier wake. A win would remain fixed-pose
still-water evidence, not robustness to changed poses, hydrodynamics, or
imposed wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics supply reactive thrust while sensory feedback can continuously schedule the kinematic expression of a rhythmic carrier
transferable_invariant: preserve a posterior-delayed traveling bend and use measured locomotor state to hand finite posterior authority between thrust-producing kinematic quadratures
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: blend the same bounded recovery share from whole-carrier amplitude below `0.05U` to the reproduced posterior velocity quadrature by `0.20U`, using normalized through-water axial speed and joint state
falsification: reject if capture is later than `23.122009T` or lost, mean distance exceeds `2.133413L`, the early progress deficit remains, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
