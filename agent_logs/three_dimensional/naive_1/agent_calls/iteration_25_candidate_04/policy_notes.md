# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three independently
  materialized copies of the assigned-parent composition reproduce exactly
  `23.331013T`, `0.749672L` crossing distance, scored mean distance
  `2.135772L`, and score `-0.239045`. This is deterministic fixed-pose
  evidence, not held-out robustness.
- The matched course-only control captures at `23.369514T`, with
  `0.748821L` crossing, `2.152884L` mean distance, and score `-0.255909`.
  Thus adding the bounded `0.12` posterior share of the existing through-water
  speed-deficit recovery clears both prior component boundaries: it advances
  arrival by `0.038502T` and lowers mean distance by `0.017112L` relative to
  the course controller. The prior architecture hypothesis survives; this is
  positive compatibility evidence, not permission for more recovery gain.
- The complete top-down rows show both policies self-propel along the same
  broad S-route while an attached alternating red/blue caudal street forms by
  `4T` and persists through capture. One composition repeat and the course
  control also have complete oblique rows with discrete three-dimensional
  Lambda2 structures behind the posterior body through capture. The other two
  composition oblique rows are black render artifacts and add no independent
  3D-wake evidence. No visible wake collapse, collision, or domain exit
  precedes either capture.
- The composition's extra early progress is not free: mean action rises from
  `58.179` to `59.044`, anterior/posterior exact rate-cap occupancy from about
  `11.16/6.10%` to `11.34/6.27%`, peak normalized force from `0.029468` to
  `0.030861`, and peak normalized moment from `0.015365` to `0.016213`.
  Reconstruction of the assigned-parent state feedback shows its recovery
  gate remains concentrated before `4T`. About `42.56` of `432.76` total
  gate-weight, or `9.8%`, occurs while `lagged_carrier * qd2 < 0`; there the
  added posterior target has negative incremental joint-work sign and opposes
  the observed tail velocity rather than extending its power stroke.

## One candidate hypothesis

Preserve the reproduced assigned-parent course feedback, anterior recovery,
full target geometry, redirect, phase-selective carrier, reactive rudder, and
terminal relief. Change only the posterior share of early propulsion recovery:
normalize the instantaneous incremental-work sign as
`lagged_carrier * qd2 / (omega * amp^2)`, and smoothly attenuate the extra
posterior target only when that reflection-invariant quantity is negative.
Positive-work and zero-velocity states retain the full completed `0.12`
allocation, so this is a joint-state power-stroke qualification rather than a
gain reduction, clocked startup stage, exact vortex-phase command, or new
steering residual.

Falsify the mechanism if capture is lost or later than `23.331013T`, scored
mean distance exceeds `2.135772L`, or score falls below `-0.239045`. Also
reject it if the preterminal S-route or alternating two-view wake degrades,
mean action exceeds `59.044`, anterior/posterior rate-cap occupancy leaves the
approximately `11.3/6.3%` class, or peak normalized force/moment materially
exceed `0.030861/0.016213`. A fixed-pose still-water win would establish only
phase-allocation compatibility; it would not establish robustness to imposed
wakes, changed poses, or hydrodynamic perturbations.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling tail-emphasized carrier while sensor feedback recruits posterior thrust during locomotor deficit
transferable_invariant: posterior recovery should add energy when the lagged tail target and measured tail velocity have the same instantaneous work sign, while leaving slow body-frame course steering separate
nontransferable_details: published gains, dimensional frequencies and speeds, distributed-body envelopes, species-specific power strokes, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the completed through-water recovery and course controller, but smoothly suppress only the posterior recovery increment when normalized `lagged_carrier * qd2` is negative; keep the full increment at zero or positive work
falsification: reject if capture is later than 23.331013T or lost, mean distance exceeds 2.135772L, score worsens below -0.239045, or route, two-view wake, action, saturation, force, or moment envelopes worsen
