# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled policies are finite captures from the required direct-
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent is
  the hydrodynamic-response-gated policy: it captures earliest at
  `22.093502T`, with `0.749422L` crossing distance, `2.105699L` scored mean
  distance, and score `-0.211397`.
- The assigned parent and the highest-score comparison were inspected in both
  visual rows from release through capture. Their top-down sheets show
  self-propulsion rather than advection: an alternating red/blue caudal street
  forms by `4T`, stays attached along the target-directed S-route, and remains
  coherent through capture. Their oblique rows show discrete three-dimensional
  Lambda2 structures following the caudal region at `4/12/20T` and capture.
  The slower anterior-preview comparison retains the same top-down topology,
  but its oblique row is blank after the labels; that is a render-evidence
  failure and not evidence of wake collapse or an independent 3D confirmation.
- Relative to the `22.159500T`, `2.105808L`, `-0.211168` inherited baseline,
  unloading only the anterior redirect when normalized target-signed yaw
  moment appears advances capture by `0.065998T` and lowers mean distance to
  `2.105699L`. It also lowers mean action from `59.830` to `59.717` and
  anterior exact-rate-cap occupancy from `11.47%` to `11.10%`; posterior
  occupancy stays about `6.42%`, and peak normalized force/moment remain
  `0.030897/0.015839`. Its slightly worse scalar score is explained by the
  first-crossing sample landing closer to the `0.75L` threshold, not by a
  worse route, later arrival, instability, or higher load.
- A separate comparison that predicts only the existing posterior half-cycle
  asymmetry envelope gives the best scored result: `22.154001T` capture,
  `2.105583L` mean distance, and score `-0.210952`. It preserves the complete
  two-view wake and load ceiling, while mean action rises modestly to `59.932`
  and rate-cap occupancy remains `11.52/6.41%`. Prediction applied instead to
  the anterior redirect is the matched negative control: it delays capture to
  `22.285997T`, raises mean distance to `2.106929L`, and worsens terminal
  heading error to `0.6853 rad` despite slightly lower action. Do not spread
  the predictor into that anterior burst.

## One candidate hypothesis

Preserve the assigned parent's through-water course observation, speed-
deficit carrier recovery, full body-frame target geometry, proximity-previewed
slow curvature center, fixed-lead posterior recovery allocation, proximity-led
reactive rudder, terminal relief, and target-signed yaw-moment unloading of the
anterior redirect. Add exactly the independently positive posterior scheduling
change: as normalized proximity fills, use the bounded de-yawed target-line
preview only to open the existing posterior half-cycle asymmetry envelope.
Continue to select target side from instantaneous body-frame geometry and beat
side from anterior joint velocity. This leaves the `0.30` asymmetry ceiling,
the traveling carrier, every acceleration limit, and all other actuator paths
unchanged.

The two sampled improvements act on distinct causal roles: measured favorable
fluid moment releases a redundant anterior burst, while predicted slow target-
line evolution schedules when the existing posterior useful-stroke allocation
is available. Their small bounded composition should retain the parent's lower
effort and early capture while recovering the comparison's lower distance
integral. It introduces no scalar authority increase, external phase, clock,
step count, coordinate, target identity, route memory, or prescribed wake
phase.

Falsify the composition if capture is lost or later than `22.093502T`, scored
mean distance exceeds `2.105583L`, or score fails to exceed `-0.210952` without
a compensating semantic improvement. Also reject it if the unchanged launch
no longer reaches about `11.297/8.629L` at `4/8T`, mean action exceeds
`59.932`, anterior/posterior exact-rate-cap occupancy materially exceeds
`11.52/6.42%`, peak normalized force/moment exceed `0.030897/0.015839`, or a
valid top-down and oblique sheet does not preserve the established alternating
three-dimensional wake. Any positive result remains fixed-pose still-water
evidence, not robustness to altered pose, inflow, hydrodynamics, or wakes.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping combined with bounded biological burst redirect and hydrodynamic-response release
source_mechanism: retain a traveling propulsive carrier, schedule target-side half-cycle effort from measured route evolution, and release transient redirect effort when target-signed body response appears
transferable_invariant: distinct state-feedback paths may allocate an existing oscillatory stroke prospectively while yielding redundant mean-turn effort reactively, provided neither increases carrier or steering authority
nontransferable_details: published gains, dimensional moment scales, source prediction horizons, clocked CPG phase, linkage or species kinematics, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use normalized body-frame target geometry and clamped de-yawed line-of-sight rate to gate only the existing posterior asymmetry, while the assigned-parent `geometric_turn * moment_z_L2` response continues to release only the anterior redirect
falsification: reject if the composition fails to beat the `22.093502T` arrival and `2.105583L` mean-distance bounds or worsens the established route, valid two-view wake, action, saturation, force, or moment envelopes
