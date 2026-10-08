# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite
  dynamics, and `capture` termination. The assigned prefill captures at
  `22.159500T`, with `0.748393L` crossing distance, `2.105808L` scored mean
  distance, and score `-0.211168`.
- Three samples of the predictive posterior-half-cycle policy reproduce the
  exact `22.154001T`, `0.748384L`, `2.105583L`, and `-0.210952` result. The
  sampled variant that also extends prediction into posterior recovery is
  trajectory-identical, so that added gate has no semantic authority on the
  encountered route and is not part of this candidate.
- Both rows of the assigned prefill and the stronger
  `solver_e00ec3b50664` combined sheets were inspected from release through
  capture. Their top-down rows show self-propulsion rather than advection: an
  alternating red/blue mid-plane street forms behind the caudal region by
  `4T`, follows the smooth S-route, and remains coherent at target crossing.
  Both oblique rows are complete and show discrete three-dimensional Lambda2
  structures following the beating posterior body through capture. There is
  no visible wake collapse, coasting phase, domain exit, or instability to
  repair.
- The stronger policy preserves the pre-proximity `4/8T` distances
  (`11.300/8.629L`) and the parent's peak normalized force/moment
  (`0.030897/0.015839`). Its mean action rises modestly from `59.830` to
  `59.932`, while anterior/posterior exact-rate-cap occupancy remains
  comparable at `11.49/6.41%` versus `11.47/6.40%`. The gain is therefore a
  small but repeatable route and phase-allocation improvement, not free thrust
  or lower effort.
- Inherited optimizer evidence supplies two useful boundaries. Previewing the
  anterior redirect regressed to `22.285997T`, `2.106929L`, and `-0.212075`,
  while releasing that path under target-signed moment reduced action but did
  not beat the parent's score. The later inherited proposals to preview the
  anterior redirect remain unevaluated hypotheses and do not overturn those
  completed negative controls. Scalar increases to rudder, recovery, or
  carrier gain are also already excluded by the experience bank.

## One candidate hypothesis

Materialize exactly the sampled best architecture from the assigned prefill.
Preserve the through-water course observation, anterior speed recovery,
full body-frame target geometry, proximity-previewed slow curvature,
fixed-lead posterior recovery allocation, proximity-led reactive rudder,
terminal relief, carrier, and every authority ceiling. Apply the existing
bounded, de-yawed, proximity-grown target-line preview only to the magnitude
of posterior half-cycle asymmetry. Keep instantaneous target side and
anterior joint velocity as the turn-sign and stroke selectors.

This is one compact state-feedback phase-allocation mechanism. It neither
adds steering authority nor changes a scalar gain, and it introduces no
clock, step count, coordinate, target identity, route memory, prescribed wake
phase, or mutable state. Because three completed samples already reproduce
the result, falsify the materialization if it fails to match capture no later
than `22.154001T`, mean distance no greater than `2.105583L`, and score at
least `-0.210952`; also reject it if the `4/8T` launch changes, the valid
two-view wake is lost, or action, saturation, force, or moment materially
exceeds the sampled envelope. Reproduction establishes fixed-pose still-water
determinism only, not robustness to changed pose, inflow, hydrodynamics, or
external wakes.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: retain a traveling propulsive rhythm while steering through bounded redistribution between useful and return strokes
transferable_invariant: measured body-frame target evolution may schedule an existing oscillatory steering envelope while instantaneous joint state retains stroke phase and the established carrier remains intact
nontransferable_details: published gains, clock phase, duty ratios, robot linkage geometry, species-specific kinematics, dimensional prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: apply the already bounded de-yawed target-line preview only to the posterior half-cycle-asymmetry envelope, retaining instantaneous target-side sign, anterior joint-rate phase, fixed posterior recovery allocation, and all authority ceilings
falsification: reject if capture is later than 22.154001T, mean distance exceeds 2.105583L, score falls below -0.210952, the launch changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
