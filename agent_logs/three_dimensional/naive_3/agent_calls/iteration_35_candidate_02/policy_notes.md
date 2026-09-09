# Terminal posterior phase-response candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations and both inherited completed evaluations satisfy
  the Phase 2 contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and `horizon`
  termination at `100T`. I inspected the combined top-down mid-plane-vorticity
  and oblique body/Lambda2 rows for the strongest finite sample and informative
  broad-loop failures. The fish self-propel and retain alternating planar wakes
  with compact three-dimensional structures; the remaining problem is course
  control in a powered orbit, not advection, wake collapse, collision, domain
  exit, or numerical instability.
- The terminal course hold (`solver_6eb170b0d70a`) remains the useful scaffold:
  it reaches `1.241/4.157/2.082L` minimum/mean/final distance and spends about
  `0.47T` inside `1.25L`. At its `97.092T` minimum, speed is still `0.669U`,
  target-ray/course error is `1.692 rad`, course dot is `-0.121`, and measured
  yaw is only `-0.129 rad/T`. The body-frame target-ray rate is about
  `-speed*course_cross/distance = -0.535 rad/T`; merely matching that rate would
  preserve the near-tangential orbit, so a closing command must ask for a
  bounded turn beyond the target-ray rate while course error persists.
- The sampled rear-direction blend, fixed-sign low-activity restart, and
  joint-state unbend regress to `2.366L`, `2.369L`, and `2.215L` minimum
  distance and visibly form broader loops. Their closest states have nearly
  stationary joints. The inherited symmetric anterior activity regulator is
  also negative evidence: despite strong anterior motion at its minimum, it
  reaches only `1.615/4.089/2.811L` and has wrong-sign yaw. The inherited
  direct anterior target-ray-rate residual regresses further to
  `2.201/3.887/3.584L` and again approaches a quiet bend. Thus activity deficit
  is diagnostic but anterior energy or direct residual acceleration is not the
  missing steering actuator.

## Policy hypothesis

Return exactly to the completed course-hold scaffold and preserve its anterior
equilibrium, oscillator energy, C-turn geometry, posterior mean, base lag,
brake, wave envelope, and command bound. Add one terminal response mechanism:
form a bounded desired yaw rate from the body-frame target-ray rate plus a
course-alignment term that makes the course error shrink, compare it with
measured yaw, and translate only the unsatisfied response into a gait-synchronous
posterior lag shift. Reuse measured anterior joint velocity as the half-cycle
coordinate, so the response changes traveling-wave phase rather than adding a
static bend, direct kick, or scalar drive floor.

Support requires preserving the coherent ahead-side recovery plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a tighter return with
improved mean/final distance and comparable clamp/load residence. Reject if the
first recovery changes, course error does not contract, posterior phase action
parks or destabilizes either joint, wake coherence or loads worsen, or the same
noncapturing orbit remains.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical traveling-wave turning
source_mechanism: route error modulates a low-dimensional gait parameter while the propulsive oscillator and anterior-to-posterior wave remain intact
transferable_invariant: separate persistent geometric turn demand from measured turn response, then place bounded corrective authority in posterior wave phase instead of replacing the rhythm with a static bend or acceleration kick
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, full-body joint counts, clocked phase, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target and velocity give target-ray rate and signed course error; measured heading rate supplies response, and measured anterior joint velocity selects a reflection-equivariant posterior lag adjustment within the two-joint state-feedback contract
falsification: reject if course error and closest/near-target/mean/final distance do not improve, the ahead-side return moves, joints park or saturate, or wake/load margins worsen
```

## Evaluation boundary

The coupled CFD result is unavailable until this worker exits. Frozen-trace
replay and dry probes can establish locality, scale, reflection equivariance,
finiteness, bounds, and parameter ownership, but cannot establish hydrodynamic
improvement.

## Implemented candidate and non-CFD probes

The candidate adds five owned parameters for one response-gated posterior lag
mechanism. It computes a bounded desired yaw rate from the target-ray rate plus
a course-alignment term, compares that demand with measured heading rate, and
uses anterior joint velocity only as a half-cycle coordinate for an additional
posterior lag shift. It leaves anterior action, all joint equilibria, base
oscillator energy, wave envelope, curvature limits, distance/course gates, and
the `+/-28 rad/T^2` command reserve unchanged. It uses no time, step count,
mutable state, world coordinate, target identity, route, randomness, or file
access.

Exact Julia replay over all `18182` states of the completed course-hold trace
changes maximum-joint action by `0.0125/0.731 rad/T^2` mean/maximum overall and
only `6.56e-5/0.00361 rad/T^2` beyond `3L`. Ahead-side changes are
`7.06e-6/0.00171 rad/T^2`; inside `1.5L` they are
`0.0127/0.0327 rad/T^2`. At the `1.241L` minimum, anterior action remains
exactly `0.970 rad/T^2` and posterior action changes from `0.868` to
`0.852 rad/T^2`. Frozen anterior/posterior clamp fractions remain exactly
`0.3285/0.1016`, every action is finite and bounded, and full-trace lateral
reflection negates both actions with zero residual. These checks establish a
local bounded phase-response test only; they do not predict the coupled CFD
trajectory.
