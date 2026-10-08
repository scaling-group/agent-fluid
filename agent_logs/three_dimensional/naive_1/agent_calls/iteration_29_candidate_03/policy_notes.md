# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- The four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three independently evaluated
  posterior velocity-quadrature policies reproduce exactly `23.122009T`,
  `0.749507L` crossing distance, `2.133413L` scored mean distance, and score
  `-0.237071`. The assigned whole-carrier parent captures later at
  `23.331013T`, with `2.135772L` mean distance and score `-0.239045`.
- The sampled top-down sheets show self-propelled S-shaped approaches: an
  alternating red/blue caudal street forms by about `4T`, remains attached,
  and follows the fish through capture. The phase-lag allocation is behind the
  whole-carrier parent at `4T` (`11.450L` versus `11.300L`), passes it between
  `9T` and `12T`, and is ahead at `20T` (`2.029L` versus `2.158L`). This
  isolates an early-propulsion versus later-route allocation trade rather than
  a uniformly better scalar drive gain. The phase-lag policy also lowers peak
  normalized force/moment from `0.030861/0.016213` to
  `0.030360/0.015861`, although mean action rises from `59.044` to `60.062`
  and anterior/posterior rate-cap occupancy rises from about `11.34/6.27%` to
  `11.92/7.06%`.
- Both rows were inspected. Every current sampled oblique row is a black render
  artifact, so the numerical repetitions and identical top-down rows are not
  new three-dimensional wake confirmation. The inherited self-motion-course
  correction supplies the informative completed failure with a valid oblique
  row: it retains discrete Lambda2 structures and a rhythmic top-down street,
  but curls past a `0.813329L` near miss and exits the domain at `36.409981T`
  with `6.290125L` final distance. Its `-7.210659` score therefore reflects a
  route failure rather than wake collapse.
- The assigned parent's newly completed target-side half-cycle redistribution
  is a second concrete negative result. It preserves capture and the broad
  top-down wake topology, but delays arrival to `23.452015T`, raises mean
  distance to `2.142002L`, regresses score to `-0.244905`, and raises peak
  force/moment to `0.031112/0.016113`. Its claimed complete oblique evidence is
  actually blank. Together with the earlier harmful angle stacking and
  tail-rate unloading, this rejects another phase-local modifier; it does not
  reject mutually exclusive allocation between the two completed recovery
  quadratures.

## One candidate hypothesis

Use the reproduced velocity-quadrature policy as the base and preserve its
through-water course observation, anterior oscillator recovery, full target
geometry, anterior redirect, phase-selective carrier, reactive rudder, and
terminal relief. Keep the evidenced posterior recovery share fixed at `0.12`,
but allocate it by the existing smooth full-angle redirect gate. With small
body-frame target error, apply the share to the complete lagged carrier, which
reproduces the parent's stronger early progress. As redirect demand rises,
move the same share continuously to only the anterior-velocity quadrature,
which reproduces the sampled policy's later route benefit. Construct this as a
convex blend of the two completed targets so no angle term is stacked on top of
the phase increment and the total recovery budget is not increased.

The hypothesis is that target-error-conditioned quadrature allocation can keep
the whole-carrier lead while alignment is already good, then retain the
phase-lag route advantage when steering becomes important. The mechanism uses
normalized joint state, through-water axial speed, and body-frame target
geometry. It adds no clock, step, coordinate, target identity, route memory,
force or moment residual, modeled vortex phase, scalar recovery increase, or
self-motion subtraction.

Falsify this mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, the early distance deficit remains, or the
`9--20T` route advantage disappears. Also reject it if mean action exceeds
`60.062`, anterior/posterior rate-cap occupancy exceeds `11.92/7.06%`, peak
normalized force/moment exceed `0.030360/0.015861`, or a valid top-down and
oblique sheet does not preserve the established alternating 3D wake. Any win
would remain fixed-pose still-water evidence rather than robustness to changed
pose, inflow, or hydrodynamics.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a posterior-delayed traveling bend while reallocating a bounded gait-recruitment budget between amplitude and phase according to measured steering demand
transferable_invariant: when posterior amplitude favors aligned propulsion but posterior phase favors a later turn, measured body-frame route demand can move one fixed recovery budget between those quadratures without stacking them or breaking the carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: convexly blend the completed whole-carrier and velocity-quadrature posterior recovery targets with the existing smooth full-angle redirect gate while preserving the evidenced `0.12` budget and every independent steering path
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, the early lead or later route benefit is absent, or valid two-view wake, action, saturation, force, or moment envelopes worsen
