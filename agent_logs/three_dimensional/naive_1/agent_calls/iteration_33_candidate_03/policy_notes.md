# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent and
  two semantically identical replicas reproduce exactly `22.187000T` capture,
  `0.748118L` crossing distance, `2.106255L` scored mean distance, and score
  `-0.211504`. The fixed-lead-only comparison captures later at `22.307997T`,
  with `0.748057L` crossing, `2.107401L` mean distance, and score `-0.212396`.
- Both rows of the assigned-parent and fixed-lead comparison sheets were
  inspected from release to capture. Their top-down rows show self-propulsion:
  a compact alternating red/blue caudal street develops by `4T`, remains
  attached along the captured S-route, and lengthens into a coherent paired
  wake through the crossing. Every current sampled oblique row is black after
  its frame labels, so none supplies new Lambda2 evidence. The inherited
  `22.500492T` composition sheet has a valid oblique row with discrete
  three-dimensional caudal structures through capture and remains the visual
  3D-wake bound; the blank current rows are render failures, not wake collapse.
- The sampled difference isolates a reusable observation-to-actuator result.
  Extending only the independently capped rudder's de-yawed target-line lead
  from one cycle toward one and a half cycles as normalized `8.0--5.5L`
  proximity fills advances capture by `0.120997T` and lowers scored mean
  distance by `0.001146L`. The three semantic replicas have byte-identical
  trajectories. Their route is unchanged through `8T`, then reaches
  `3.983/1.872/0.830L` at `16/20/22T` versus
  `3.993/1.884/0.876L` for fixed lead.
- The gain has a measured cost boundary rather than being free thrust. Mean
  action rises from about `59.675` to `59.850`; exact anterior/posterior
  rate-cap occupancy remains comparable at `11.53/6.40%` versus
  `11.54/6.36%`; and peak normalized force/moment remain unchanged at
  `0.030897/0.015839`. The current trace retains full head-relative error near
  `0.77 rad` at `16--20T` and about `0.90 rad` at `22T`. Offline reconstruction
  shows the bounded de-yawed target-line trend consistently reinforces, rather
  than reverses, the existing slow route request after the proximity gate
  opens. This supports testing prediction in a still-unpredicted allocation
  path, not increasing rudder magnitude, recovery gain, or carrier energy.

## One candidate hypothesis

Preserve the reproduced parent's through-water course observation, anterior
speed recovery, full body-frame target geometry, fixed-lead posterior recovery
allocation, proximity-led reactive rudder, phase-selective carrier, and
stroke-qualified terminal relief. Add one new bounded signal path: while the
existing normalized proximity gate fills, apply at most the already sampled
half-cycle of clamped de-yawed target-line prediction to the slow route error
that selects the anterior-only curvature center. Keep the `8 deg` curvature
cap and every posterior, oscillator, threshold, and actuator limit unchanged.

The hypothesis is that the parent has validated anticipation on posterior
steering but still waits for current folded bearing before moving its anterior
mean curvature. A small derivative preview on that existing mean-turn channel
should begin target-signed body alignment during the middle approach while the
state-feedback traveling carrier continues unchanged. It adds no clock,
coordinate, route memory, target identity, external phase, force/moment
residual, scalar authority increase, or fitted beat-motion subtraction.

Falsify the mechanism if capture is lost or later than `22.187000T`, scored
mean distance exceeds `2.106255L`, score does not exceed `-0.211504`, or the
unchanged pre-proximity route no longer reaches about `11.300/8.629L` at
`4/8T`. Also reject it if the `16/20/22T` distance sequence fails to improve,
mean action exceeds `59.850`, exact anterior/posterior rate-cap occupancy
exceeds `11.53/6.40%`, peak normalized force/moment exceed
`0.030897/0.015839`, or a valid top-down and oblique sheet does not preserve
the established alternating 3D wake. A positive result would remain
fixed-pose still-water evidence, not robustness to changed pose, inflow,
hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded asymmetric fish turning
source_mechanism: preserve a posterior-delayed propulsive rhythm while measured target-line evolution modulates a separate slow mean-turn command
transferable_invariant: a bounded derivative preview of body-frame route demand can advance mean curvature without increasing gait authority or replacing the traveling carrier
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: add the clamped `bearing_window_rate - turn_rate_recent` preview to only the existing anterior curvature request as normalized proximity fills, while retaining the completed carrier, recovery, rudder, terminal relief, and all authority ceilings
falsification: reject if capture is later than 22.187000T or lost, mean distance exceeds 2.106255L, the pre-proximity route changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
