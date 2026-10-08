# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Two executable-equivalent
  posterior velocity-quadrature baselines reproduce `23.122009T` capture,
  `2.133413L` scored mean distance, `0.749507L` crossing, and score
  `-0.237071`.
- Both visual rows were inspected. The complete baseline sheet shows that the
  fish is self-propelled rather than advected: an attached alternating red/blue
  mid-plane street forms by `4T`, remains coherent along the S-shaped approach,
  and discrete oblique Lambda2 structures trail the caudal region through
  capture. The best-score allocation sheet has the same coherent top-down
  route and street, but its oblique row is black; that is a render failure and
  cannot provide independent 3D-wake confirmation.
- Full-angle target-error allocation of the fixed `0.12` posterior recovery
  budget is the best-score sample. It applies whole-carrier recovery while
  aligned and velocity-quadrature recovery under redirect demand. Relative to
  the reproduced baseline it preserves the `23.122009T` capture, lowers mean
  distance to `2.127679L`, improves score to `-0.231273`, lowers mean action
  from `60.062` to `58.990`, lowers posterior rate-cap occupancy from about
  `7.09%` to `6.21%`, and lowers peak normalized moment from `0.015861` to
  `0.015817`. Its early distance is better at `4/8T`
  (`11.300/8.646L` versus `11.450/8.822L`), but it is worse by `20T`
  (`2.104L` versus `2.029L`). This is allocation evidence, not support for a
  larger recovery gain.
- The assigned parent supplies the complementary positive result. Its bounded
  body-frame line-of-sight lead leaves the baseline launch unchanged, then is
  closer by `20/22T` (`1.976/0.979L`) and advances capture by `0.550T` to
  `22.572023T`. Mean distance improves over baseline to `2.127978L`, but is
  slightly worse than the allocation sample; mean action rises to `60.545`
  and rate-cap occupancy to about `12.11/7.24%`. Its complete top-down and
  oblique rows retain the alternating three-dimensional carrier wake, and peak
  normalized force/moment remain at the baseline `0.030360/0.015861`.
- Inherited logs bound the edit. Speed-selected amplitude/phase crossfade,
  posterior half-cycle redistribution, tail-rate unloading, angle-quadrature
  stacking, fitted beat self-motion subtraction, and an unqualified yaw-moment
  residual all regress the established route. Independently useful mechanisms
  are therefore not assumed additive; this candidate explicitly tests one
  small composition while preserving both measured authority budgets.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, anterior
oscillator recovery, full target geometry, anterior redirect, phase-selective
carrier, bounded line-of-sight-led rudder, and response-plus-stroke terminal
relief. Replace only its always-on `0.12` posterior velocity-quadrature recovery
with the sampled full-angle allocation: apply the same share to the complete
lagged carrier while the body-frame target error is small, and move it smoothly
to the anterior-velocity quadrature as the existing redirect gate rises. This
is a convex blend of two completed posterior targets, so the recovery budget is
neither stacked nor increased. The pursuit lead continues to affect only the
existing rudder error gate.

The hypothesis is that separating slow target-error allocation from target-line
lead will retain the allocation sample's early progress and lower effort while
retaining the parent's later pursuit and earlier crossing. The controller uses
only normalized body-frame target, water-relative velocity, provided response,
and joint-state observations; it adds no clock, route memory, fixed coordinate,
case identity, modeled wake phase, or scalar authority increase.

Falsify the composition if capture is lost or later than `22.572023T`, scored
mean distance is not below `2.127679L`, or score does not exceed `-0.231273`.
Also reject it if the early `4/8T` allocation lead or late `20/22T` pursuit lead
disappears, mean action exceeds `60.545`, anterior/posterior rate-cap occupancy
exceeds about `12.11/7.24%`, peak normalized force/moment exceed the sampled
`0.030527/0.015861` envelope, or a valid two-view sheet fails to preserve the
coherent alternating 3D wake. A positive result would remain fixed-pose
still-water compatibility evidence, not robustness to changed pose, inflow,
hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a posterior-delayed traveling bend while sensor feedback allocates a bounded gait budget between amplitude and phase separately from bounded steering response
transferable_invariant: amplitude-like carrier recruitment and velocity-quadrature phase delay are distinct allocations of one posterior locomotor budget, so measured body-frame route demand can crossfade between them without stacking either onto the carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, fixed coordinates, prescribed routes, and exact vortex phases
policy_translation: preserve the parent's line-of-sight-led rudder and convexly allocate the fixed 0.12 posterior recovery share between the completed whole-carrier and velocity-quadrature targets with the existing full-angle redirect gate
falsification: reject if capture is later than 22.572023T or lost, mean distance is not below 2.127679L, score does not exceed -0.231273, or route, valid two-view wake, action, saturation, force, or moment envelopes worsen
