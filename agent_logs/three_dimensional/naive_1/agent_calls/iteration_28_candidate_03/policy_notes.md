# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solvers are finite captures from the required direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no instability. Three independently evaluated
  velocity-quadrature phase-lag policies reproduce `23.122009T`, `2.133413L`
  scored mean distance, `0.749507L` crossing distance, and score `-0.237071`.
  The matched whole-carrier recovery captures later at `23.331013T`, with
  `2.135772L` mean distance and score `-0.239045`.
- The best sample's complete top-down row shows self-propelled motion along the
  established S-shaped route and an attached alternating red/blue caudal
  street through capture. Its oblique row shows discrete three-dimensional
  Lambda2 structures behind the moving tail rather than passive advection. The
  whole-carrier comparison has the same top-down route class but a blank
  oblique row, so that render supplies no independent 3D-wake claim. The best
  policy is behind the whole-carrier allocation through about `8T`, passes it
  between `9T` and `12T`, and is closer at `20T` (`2.026L` versus `2.155L`):
  the positive effect is persistent wave/route allocation, not faster startup.
- The phase-lag allocation also lowers peak normalized force/moment from
  `0.030861/0.016213` to `0.030360/0.015861`, although mean action rises from
  `59.044` to `60.062` and anterior/posterior rate-cap occupancy rises from
  `11.34/6.27%` to `11.92/7.06%`. Those costs bound later reuse; they are not
  evidence to increase the recovery gain.
- The assigned parent's course-qualified posterior angle quadrature is a
  concrete negative control: despite lower mean action and a complete coherent
  two-view wake, it captures at `23.265013T`, raises mean distance to
  `2.137810L`, raises peak force to `0.031321`, and scores `-0.241061`. The
  inherited tail-rate-headroom experiment is a second, newly completed
  negative control. Removing only the phase-lag increment near the posterior
  rate ceiling lowers mean action to `59.301`, posterior cap occupancy to
  `6.65%`, and peak force/moment to `0.030257/0.015625`, yet delays capture to
  `23.314514T`, raises mean distance to `2.136120L`, and scores `-0.239352`.
  Its complete two-view sheet retains the alternating wake. Thus neither a
  stroke-reversal angle term nor actuator-headroom unloading preserves the
  useful route effect; exact-cap occupancy is not evidence that the
  velocity-quadrature command is dispensable.

## One candidate hypothesis

Preserve the reproduced phase-lag policy's through-water course observation,
anterior speed recovery, target geometry, anterior redirect, phase-selective
carrier, reactive rudder, and terminal relief. Preserve the full evidenced
`0.12` posterior velocity-quadrature recovery at every measured tail rate.
Introduce one small state-feedback mechanism: smoothly redistribute that
increment by at most 15% between the two target-signed anterior half-cycles,
using the already observed `useful_stroke_gate`. This changes neither the
nominal recovery share nor the base `0.8` tail lag; it adds no posterior angle
quadrature, clock, route memory, or scalar gain increase.

The hypothesis is that the successful early velocity quadrature creates its
later advantage through phase and yaw allocation. A bounded target-side
half-cycle redistribution should retain the tail commands that the failed rate
gate removed while placing slightly more of the same delayed-bend response on
the stroke already selected for useful turning. The symmetric carrier remains
available on the cancelling stroke, so propulsion is not switched off.

Falsify this mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, or the `9--20T` route advantage disappears.
Also reject it if mean action exceeds `60.062`, anterior/posterior rate-cap
occupancy exceeds `11.92/7.06%`, peak normalized force/moment exceed
`0.030360/0.015861`, or a complete top-down and oblique sheet does not retain
the coherent alternating 3D wake. Any win here remains fixed-pose still-water
evidence, not robustness to changed pose, imposed flow, or wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and asymmetric robotic-fish CPG turning
source_mechanism: preserve a posterior-delayed traveling bend while redistributing rhythmic effort between target-relevant half-cycles from observed oscillator state
transferable_invariant: posterior phase delay can retain propulsion while a bounded joint-state half-cycle asymmetry allocates yaw without adding a static bend
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, distributed-body kinematics, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the evidenced through-water speed-gated posterior velocity quadrature and smoothly move at most 15% of that increment toward the target-side anterior stroke selected by normalized joint rate and body-frame target geometry
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
