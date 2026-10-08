# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Three executable-identical
  line-of-sight-lead plus target-error-allocation variants reproduce exactly
  `22.500492T` capture, `2.120233L` scored mean distance, `0.749267L`
  crossing, and score `-0.225086`. The allocation-only control captures at
  `23.122009T`, with `2.127679L` mean distance and score `-0.231273`.
- Both visual rows were inspected from release through capture. Every top-down
  row shows self-propelled motion along the established S-shaped approach, with
  alternating red/blue mid-plane structures attached to the caudal region
  rather than passive advection or wake collapse. One repeated composition has
  a valid oblique row: discrete three-dimensional Lambda2 structures form
  behind the moving tail by `4T` and remain visible through capture. The other
  two composition rows and the allocation-only row are black render artifacts,
  so they provide no independent 3D-wake confirmation.
- The completed composition is a positive compatibility result, not merely a
  repeated capture. It preserves the allocation control's `4/8/9T` distances,
  is closer by `16T` (`4.095L` versus `4.134L`), `20T` (`2.002L` versus
  `2.104L`), and `22T` (`0.970L` versus `1.134L`), and reaches the radius
  `0.622T` earlier. At crossing, full head-relative target error falls from
  about `1.202` to `0.760 rad` and target-directed radial speed rises from
  approximately `-0.009` to `+0.380L/T`. Peak normalized force/moment remain
  `0.030527/0.015817`; mean action rises from `58.990` to `59.671`, and
  anterior/posterior rate-cap occupancy rises only modestly to about
  `12.05/6.58%`. Thus the lead improves late pursuit and alignment without
  corrupting launch, wake, or the sampled load envelope, but it is not a
  lower-effort mechanism.
- The current lead affects only rudder recruitment. Its measured de-yawed
  target-line residual is near zero while the early target is aligned, then is
  target-error-increasing through much of the `12--22T` approach. Meanwhile,
  inherited matched tests show that whole-carrier recovery owns the early lead
  and velocity-quadrature recovery owns the later route. This supports testing
  the same slow predicted geometry as a selector between those two completed
  targets, while keeping their shared recovery budget fixed.

## One candidate hypothesis

Preserve the reproduced composition's through-water course observation,
anterior oscillator recovery, full target geometry, anterior redirect,
phase-selective carrier, line-of-sight-led reactive rudder, and
response-plus-stroke terminal relief. Change only the posterior recovery
selector: use the existing bounded `led_target_error`, rather than instantaneous
`target_error`, to construct a separate smooth allocation gate between the
whole-carrier and anterior-velocity-quadrature recovery targets. Leave the raw
full-angle gate on anterior redirect and carrier stroke shaping, so the new
observation path changes one fixed posterior budget and no other authority.

The hypothesis is that predicted growth of body-frame target error should move
the already evidenced `0.12` recovery share toward the later-route velocity
quadrature before the instantaneous error catches up, while near-zero early
residual retains the whole-carrier launch benefit. This is a bounded CPG gait
allocation coordinated with, but not stacked onto, the existing rudder. It
adds no gain, clock, route memory, fixed coordinate, case identity, modeled
vortex phase, or force/moment residual.

Falsify the mechanism if capture is lost or later than `22.500492T`, scored
mean distance is not below `2.120233L`, score does not exceed `-0.225086`, or
the inherited `4--9T` launch and `16--22T` pursuit advantages do not both
survive. Also reject it if mean action exceeds `59.671`, anterior/posterior
rate-cap occupancy exceeds about `12.05/6.58%`, peak normalized force/moment
exceed `0.030527/0.015817`, or a valid two-view sheet fails to preserve the
coherent alternating three-dimensional wake. A positive fixed-pose still-water
result would establish state-feedback compatibility, not robustness to changed
pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a posterior-delayed traveling bend while sensor feedback allocates one bounded locomotor budget between amplitude-like and velocity-quadrature phase responses
transferable_invariant: slow measured body-frame route demand may coordinate a fixed posterior gait budget with steering by crossfading between completed amplitude and phase targets without stacking either target or changing the carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, fixed coordinates, prescribed routes, and exact vortex phases
policy_translation: use the existing bounded de-yawed target-line lead to advance only the fixed-budget posterior recovery crossfade while preserving instantaneous full-angle anterior steering and all sampled limits
falsification: reject if capture is later than 22.500492T or lost, mean distance is not below 2.120233L, score does not exceed -0.225086, or launch, pursuit, valid two-view wake, action, saturation, force, or moment envelopes worsen
