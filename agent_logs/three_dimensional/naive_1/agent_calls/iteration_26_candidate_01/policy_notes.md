# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three executable-equivalent
  copies of the assigned-parent whole-carrier recovery policy reproduce
  `23.331013T`, `0.749672L` crossing distance, `2.135772L` scored mean
  distance, and score `-0.239045`. The only semantic alternative reallocates
  the same bounded posterior recovery share into velocity-quadrature phase
  lag and improves all four task scalars to `23.122009T`, `0.749507L`,
  `2.133413L`, and `-0.237071`.
- The top-down sheets show genuine self-propulsion in quiescent water. Both
  policies form a coherent alternating red/blue caudal street by `4T`, retain
  it along the inherited S-shaped target approach, and capture without
  collision, exit, coasting, or visible wake collapse. The phase-lag policy is
  initially farther from the target at `2--8T`, becomes closer by `12T`, and
  reaches `1.0955L` rather than `1.1916L` at `22T`; its benefit is therefore a
  changed traveling-bend trajectory and terminal alignment, not simply more
  startup translation. Its final full heading error is `0.786` rather than
  `1.042 rad`.
- The assigned-parent and best-score combined sheets have black oblique rows,
  which are render failures and provide no direct three-dimensional wake
  comparison. A complete sheet from an executable-equivalent parent repeat
  shows discrete three-dimensional Lambda2 structures at `4T`, `12T`, `20T`,
  and capture. This bounds the inherited carrier's 3D wake class only; the
  phase-lag candidate still requires a complete oblique evaluation before its
  wake preservation can be claimed independently.
- The phase-lag reallocation has a mixed but bounded effort tradeoff. Against
  the parent it lowers mean action through `5T` from `79.968` to `79.110`,
  near-target mean action from `44.015` to `43.656`, peak normalized force
  from `0.030861` to `0.030360`, and peak normalized moment from `0.016213` to
  `0.015861`. Total mean action rises from `59.044` to `60.062`, and exact
  anterior/posterior rate-cap occupancy rises from `11.34/6.27%` to
  `11.92/7.06%`, so the result supports actuator-path allocation rather than
  permission to increase recovery gain.
- Two inherited same-generation controls reject obvious extra gates. A
  posterior-amplitude envelope is numerically identical to the parent at
  `-0.239045`, so its recorded condition does not create a useful semantic
  change. Suppressing whole-carrier recovery by inferred incremental joint-work
  sign worsens score to `-0.247507` despite retaining capture. Together with
  the older adverse-yaw-moment regression, this argues against stacking a new
  phase, amplitude, or load gate on the evaluated phase-lag allocation.

## One candidate hypothesis

Adopt the sampled phase-lag reallocation exactly. Preserve the assigned
parent's through-water course observation, anterior speed-deficit oscillator
recovery, full target geometry, redirect, phase-selective carrier, reactive
rudder, and terminal stroke-qualified relief. During the existing normalized
through-water speed deficit, move the bounded `0.12` posterior share from a
scale on the whole lagged carrier to the velocity-quadrature coefficient in
the posterior target. The increment therefore reinforces traveling-bend delay
at anterior mid-stroke and vanishes at anterior stroke reversal, without
changing the mean curvature, rudder, terminal schedule, or measured cruise
law. This is normalized, body-frame, memoryless state feedback and introduces
no clock, coordinate, route, case identity, or exact vortex phase.

The deterministic expectation is to reproduce the sampled `23.122009T`
capture, `2.133413L` mean distance, and `-0.237071` score. Falsify reuse if
capture is lost or later than the assigned parent's `23.331013T`, mean
distance exceeds `2.135772L`, the late distance lead or lower terminal
heading error disappears, or a complete evaluation shows degraded route,
three-dimensional wake, early/near action, force, or moment. The observed
increase in total action and rate-cap occupancy is an explicit cost boundary;
a later refinement must reduce it without surrendering the task improvement.
Fixed-pose still-water success does not establish robustness to changed pose,
inflow, or hydrodynamics.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming theory and sensor-modulated robotic-fish CPG control
source_mechanism: reactive thrust depends on a directed traveling bend with posterior delay, while measured locomotor deficit can recruit rhythmic authority without prescribing time
transferable_invariant: preserve the joint-state traveling carrier and place bounded recovery in posterior velocity-quadrature lag so it reinforces wave direction without adding stroke-reversal excursion
nontransferable_details: published gains, dimensional frequencies and speeds, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain all established body-frame route and terminal feedback, but add the existing normalized speed-deficit recovery share to the coefficient multiplying anterior joint velocity in the lagged posterior target instead of scaling the entire target
falsification: reject if capture is later than 23.331013T or lost, mean distance exceeds 2.135772L, the late-route and alignment gains disappear, or complete wake, action, saturation, force, or moment evidence violates the sampled bounds
