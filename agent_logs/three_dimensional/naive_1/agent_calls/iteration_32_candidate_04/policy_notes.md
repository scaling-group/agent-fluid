# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no instability. The assigned-parent policy and two
  executable-identical siblings reproduce exactly `22.307997T` capture,
  `2.107401L` scored mean distance, `0.748057L` crossing, and score
  `-0.212396`. This improves the inherited current-error recovery allocation
  boundary of `22.500492T/2.120233L/-0.225086`.
- Both visual rows were inspected from release through capture. The strong
  parent sheet shows self-propelled motion on the established S-shaped route:
  an alternating red/blue mid-plane street is attached to the caudal region by
  `4T`, remains coherent during the turn, and reaches the target without wake
  collapse or inertial coasting. Its oblique row is valid and shows discrete
  three-dimensional Lambda2 structures behind the moving tail at `4T`, `12T`,
  `20T`, and capture. The weaker `solver_ca36667feae4` top-down row retains the
  same broad wake and route but trails from roughly `8T` onward and captures at
  `22.423492T`, with `2.117908L` mean distance and score `-0.222711`; its
  oblique row is black and supplies no independent 3D-wake evidence.
- The repeated parent result is a semantic improvement with a bounded cost,
  not merely a new scalar score. It advances capture by about `0.193T` and
  lowers mean distance by `0.012832L` relative to the previous composition.
  Mean action is about `59.675`, anterior/posterior exact rate-cap occupancy is
  about `11.54/6.36%`, and peak normalized force/moment is
  `0.030897/0.015839`. The force peak is slightly above the inherited
  `0.030527` bound, so the predictive allocation is reusable for pursuit but
  cannot be described as a load improvement.
- The weaker branch is deliberately treated as a confounded negative control:
  it both restores current-error recovery allocation and increases rudder
  look-ahead by up to half a cycle with proximity. Its later capture therefore
  does not isolate proximity lead. What the four current results do establish
  is that one-cycle predicted full-angle error is repeatably useful as the
  selector of the fixed posterior recovery budget; later workers should not
  discard that selector or attribute the weaker branch to one of its two edits.

## One candidate hypothesis

Preserve the assigned parent's through-water course feedback, anterior
oscillator recovery, current-error anterior redirect, line-of-sight-led
reactive rudder, response-plus-stroke terminal relief, and fixed `0.12`
posterior recovery crossfade. Change one actuator path: use the already
bounded one-cycle predicted full-angle error gate for the established
posterior carrier relief and target-side half-cycle asymmetry, while leaving
the anterior redirect on current target error. No parameter value or actuator
limit changes.

The hypothesis is that the predictor which repeatably advances the posterior
recovery quadrature can also recruit the existing target-side posterior stroke
shaping before the current heading error catches up. This is a closed-loop
phase-allocation mechanism, not a scalar gain increase: it retains the same
traveling carrier, half-cycle ceiling, rudder sign, recovery budget, and
terminal law. Keeping current geometry on the anterior joint prevents one
short-window prediction from coherently advancing every steering path.

Falsify the mechanism if capture is lost or later than `22.307997T`, scored
mean distance is not below `2.107401L`, or score does not exceed `-0.212396`.
Also reject it if the parent route changes materially before `8T`, mean action
exceeds about `59.675`, anterior/posterior exact rate-cap occupancy exceeds
about `11.54/6.36%`, peak normalized force/moment exceeds
`0.030897/0.015839`, or a valid two-view sheet does not retain the alternating
three-dimensional wake. A positive result would show fixed-pose still-water
compatibility only, not robustness to changed pose, inflow, hydrodynamics, or
external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and elongated-body reactive swimming
source_mechanism: bounded target-side half-cycle asymmetry of a posterior-delayed traveling bend
transferable_invariant: slowly predicted body-frame turn demand may schedule existing posterior stroke asymmetry while retaining the traveling carrier and fixed authority
nontransferable_details: published gains, dimensional frequencies and speeds, robot calibration, species-specific envelopes, distributed-body kinematics, fixed coordinates, prescribed routes, and exact vortex phases
policy_translation: use the existing bounded one-cycle full-angle prediction gate only for posterior carrier relief and half-cycle shaping, while current geometry continues to drive anterior redirect and the fixed recovery and rudder limits remain unchanged
falsification: reject if capture is later than 22.307997T or lost, mean distance is not below 2.107401L, or route, valid two-view wake, action, saturation, force, or moment envelopes worsen
