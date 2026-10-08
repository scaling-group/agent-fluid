# Wake-policy diagnosis and candidate hypothesis

## Inherited evidence

- The assigned parent `solver_f90703a6f2af` and sampled
  `solver_c23f2d8df241` are deterministic repeats of the water-relative route
  and propulsion-recovery policy. Both capture at `23.424515T`, score
  `-0.287480`, and have scored mean distance `2.184349L`.
- The matched `solver_1fcbc36bb25f` and `solver_4f671efd576e` pair differs in
  the recovery observation only: inertial body-forward speed replaces local-
  water-relative axial speed. Both still capture, but at `23.864521T`, with
  score `-0.294271` and mean distance `2.192138L`. Thus the local-water-relative
  observation advances capture by `0.440006T` and improves the distance
  integral without changing a scalar gain.
- Rate-cap occupancy stays close across the paired classes (water-relative
  about `11.74/6.65%`, inertial about `11.75/6.41%` for anterior/posterior), as
  do peak normalized force (`0.02978` versus `0.02948`) and yaw moment
  (`0.01529` versus `0.01534`). The better arrival therefore does not come
  with a materially different sampled load or saturation class, although mean
  action is modestly higher (`58.29` versus `57.57`).

## Visual diagnosis

Both top-down sheets show self-propulsion rather than passive advection: a
spatially alternating wake is established by `5T`, remains coherent through
the broad S-shaped redirect, and is carried continuously into capture. The
water-relative class is already about `0.1L` closer at the `14T` and `18T`
keyframes and reaches the capture circle sooner, while the inertial-speed
class shows the same useful trajectory topology rather than a distinct turn.
The oblique rows and view-specific oblique sheets are black render artifacts
for all four samples. They cannot support a new claim about three-dimensional
Lambda2 structure; the current candidate must preserve the established wake
and be judged numerically plus by a complete future two-view rendering.

## Candidate hypothesis

The observed recovery loop adds energy only to the anterior oscillator even
though the sampled early deficit lasts roughly through `3--4T` and the
posterior joint is the thrust-producing end of the retained traveling carrier.
Use the same smooth, normalized local-water-relative axial-speed gate to add a
small posterior-only carrier scale. This changes actuator allocation, not the
gate thresholds or global drive gain, and leaves the evidenced lag, route,
reactive-rudder sign, and terminal phase-qualified relief untouched. The
candidate is falsified if it captures later than `23.424515T`, raises scored
mean distance above `2.184349L`, materially increases the `11.74/6.65%`
rate-cap or `0.02978/0.01529` force/moment envelope, or weakens the alternating
wake in a complete render.

A non-CFD counterfactual replay on the assigned-parent trace confirms that the
new term is confined to the intended regime: the recovery gate is nonzero on
`697/4259` samples and last activates at `4.8345T`. The resulting posterior
acceleration delta has mean absolute magnitude `4.073 rad/T^2` while active
and a `12.021 rad/T^2` maximum, below the fixed `31.416 rad/T^2` acceleration
limit. This bounds the proposed intervention but is not rollout evidence and
does not predict its closed-loop score.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming theory
source_mechanism: posterior traveling-wave kinematics supply reactive thrust by accelerating water laterally near the tail
transferable_invariant: preserve the traveling bend and place a bounded share of locomotor recovery at the posterior actuator when measured through-water speed is deficient
nontransferable_details: published gains, distributed-body envelopes, species-specific amplitudes and frequencies, and exact vortex phases
policy_translation: smoothly scale only the lagged posterior carrier by the existing normalized local-water-relative axial-speed recovery gate while retaining joint-state phase and all target-feedback paths
falsification: reject if capture exceeds 23.424515T, scored mean distance exceeds 2.184349L, or saturation, action, force, moment, route, or complete two-view wake evidence worsens
