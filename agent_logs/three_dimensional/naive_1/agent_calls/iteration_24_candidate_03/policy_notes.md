# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four assigned rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, zero cylinders,
  no prewarm snapshot, and no reported instability. Three independently
  materialized copies of the assigned-parent controller reproduce exactly the
  same `23.424515T` capture, `0.749902L` crossing, score-metric mean distance
  `2.184349L`, and score `-0.287480`, establishing a deterministic comparison
  rather than held-out robustness.
- The strongest sampled policy replaces only the parent's raw body-water
  lateral-speed correction with a bounded through-water course angle. It
  captures at `23.369514T`, lowers mean distance to `2.152884L`, and improves
  score to `-0.255909`. Its distance is lower at each inspected checkpoint
  from `2T` through `23T`; mean and near-target action fall from about
  `58.30/45.01` to `58.19/44.40`, anterior/posterior exact rate-cap occupancy
  falls from about `11.74/6.64%` to `11.16/6.10%`, peak normalized force falls
  from `0.029780` to `0.029468`, and peak moment changes only slightly from
  `0.015287` to `0.015365`. This supports the course observation as a route
  mechanism, not a scalar steering-gain result.
- The best combined sheet shows self-propelled target-directed translation,
  not advection: with zero imposed flow, the fish advances continuously while
  an attached alternating red/blue caudal street forms by `4T` and persists
  through the S-shaped approach and capture. Its oblique row contains discrete
  three-dimensional Lambda2 structures from release through capture. The
  lower-performing parent sheet has the same useful top-down wake class but a
  black oblique render artifact, so it contributes no independent 3D-wake
  confirmation. Neither sheet shows collision, domain exit, wake collapse, or
  numerical instability.
- A separate inherited completed rollout allocates a small share of the same
  through-water speed-deficit recovery to the lagged posterior carrier. Against
  the raw-lateral-route parent it captures at `23.347515T`, lowers mean distance
  to `2.161137L`, and improves score to `-0.263925`; at `2T/4T`, distance falls
  from `12.2225/11.4899L` to `12.1852/11.3481L`. Mean action falls to about
  `57.83`, rate-cap occupancy remains near `11.64/6.08%`, and peak normalized
  force/moment remain bounded at `0.029827/0.015516`. Its oblique row is blank,
  and its route bows farther below the initial line, so it is evidence for
  early propulsion allocation only, not improved route geometry or a new 3D
  wake class.
- The inherited adverse-moment composition is the relevant negative control:
  independently positive loops did not compose and regressed to
  `23.853519T/2.194872L`. Therefore compatibility must be judged against the
  stronger course controller on distance, route, wake, action, saturation,
  and load—not inferred from the two separate positive scores.

## One candidate hypothesis

Use the sampled course-angle controller as the baseline and add only the
completed posterior recovery allocation unchanged. Preserve the joint-state
traveling carrier, body-water axial recovery, full target geometry, anterior
redirect, phase-selective posterior carrier, reactive-rudder sign, and
response-plus-anterior-stroke terminal relief. The same smooth speed-deficit
gate is active only during measured locomotor slowdown and scales only the
lagged posterior carrier by at most `1.12`; it does not alter target steering,
the posterior rudder, gait phase, or the terminal law. This tests whether the
posterior allocation's early progress and the course observation's later route
improvement are compatible without adding a clock, coordinate, route memory,
raw load residual, or scalar-only course tuning.

Falsify the composition if capture is lost or later than `23.369514T`, scored
mean distance exceeds `2.152884L`, score falls below `-0.255909`, or the
preterminal route, alternating top-down street, discrete 3D wake, about
`58.19/44.40` mean/near-target action, `11.16/6.10%` rate-cap occupancy,
`0.029468` peak force, or `0.015365` peak moment materially worsens. Even a
positive fixed-pose still-water result would establish compatibility, not
robustness to imposed wakes or changed poses.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling rhythmic carrier while placing bounded locomotor recovery at the posterior thrust-producing actuator
transferable_invariant: measured body-water slowdown may recruit a small posterior share of an existing state-feedback traveling bend while target-relative course feedback remains responsible for the route
nontransferable_details: published gains, dimensional frequencies and speed thresholds, distributed species-specific envelopes, robot calibration, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: start from the evidenced body-frame course controller and scale only its lagged posterior carrier by the inherited smooth through-water recovery gate, leaving steering and rudder paths unchanged
falsification: reject if capture is later than 23.369514T or lost, mean distance exceeds 2.152884L, score worsens below -0.255909, or route, two-view wake, action, saturation, force, or moment envelopes worsen
