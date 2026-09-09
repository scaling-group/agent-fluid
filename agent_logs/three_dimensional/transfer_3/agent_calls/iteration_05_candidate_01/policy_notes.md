# Course-response steering candidate

## Evidence read before the policy edit

- All four sampled observations report direct uniform quiescent initialization
  (`U_infinity=(0,0,0)`), no cylinders, finite dynamics, and `left_domain`
  termination. The inherited optimizer logs add three more upper/lower domain
  exits with minimum distances of `12.195L`, `12.030L`, and `11.764L`; none is
  a semantic success.
- The combined top-down/oblique sheet for `solver_adc862529891` shows genuine
  self-propulsion and a persistent, alternating 3D wake rather than background
  advection. It retains a nearly straight, coherent carrier but passes above
  the target and exits the upper boundary. Metrics agree: it is the strongest
  sampled finite result (`min=5.658L`, `final=5.843L`, `t=16.77T`) and local
  flow near exit is small (about `0.03U`), so route control—not imposed flow—is
  the primary failure.
- The combined sheet for the coherent clean-B parent
  `solver_19f251537923` shows sustained clockwise curvature, a coherent wake,
  then a lower-boundary exit after the fish has turned almost vertical. Its
  `min=6.138L` followed by `final=10.460L` at `t=26.15T` confirms productive
  propulsion but wrong/over-persistent route curvature rather than instability.
- The two simpler correct-sign mean-curvature variants also exit through the
  upper boundary: `solver_97bc3c03d55b` reaches `9.175L` and
  `solver_2bf5e06dbda4` only `11.764L`. Thus another static curvature bias or a
  scalar-only gain change is not supported.
- Reconstructing normalized body-frame geometry and velocity from the strongest
  trace exposes an earlier response signal: body LOS error crosses zero near
  `3.6T`, while target-course minus actual velocity-course crosses near `2.5T`.
  Heading-only pursuit therefore keeps its initial turn for roughly two extra
  carrier cycles after the trajectory already needs release/countersteer.

## Policy hypothesis recorded before editing

Preserve `solver_adc862529891`'s joint-state traveling-bend carrier and its
anterior-velocity phase compensation. Replace heading-only LOS demand with a
bounded course-response demand: compare target direction with observed
body-frame velocity direction, smoothly suppress the velocity angle at low
speed, and feed that course error to the existing bounded yaw/curvature loop.
This is one semantic mechanism, not a route or gain sweep. It should retain the
coherent wake while releasing the initial turn about one beat earlier and
correcting hydrodynamic sideslip before the upper exit.

bookshelf_consulted: true
source_domain: sensor-modulated CPG direction tracking in robotic fish
source_mechanism: preserve a rhythmic propulsive carrier while sensory direction error modulates a bounded steering residual
transferable_invariant: steering should respond to the error between desired target course and observed motion course, then release as those directions align
nontransferable_details: published CPG gains, robot geometry, actuator mapping, clock phase, species kinematics, and task routes
policy_translation: form target and velocity angles only from normalized body-frame observations, low-speed-gate the velocity angle, and map their bounded difference through the two-joint state-feedback curvature contract
falsification: reject if upper-route loss is not reduced, minimum distance fails to beat 5.658L, or action/wake coherence degrades despite earlier course-error reversal
