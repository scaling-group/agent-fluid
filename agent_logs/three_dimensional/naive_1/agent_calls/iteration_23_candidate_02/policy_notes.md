# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver rollouts are finite captures from the required
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. Their
  top-down sheets show continuous target-directed translation on the
  established S-shaped route while an alternating red/blue caudal street
  remains attached to the fish through capture. This is self-propulsion, not
  imposed advection. Every sampled oblique row is black, including the
  view-specific sheets; those render failures were inspected and provide no
  new three-dimensional wake evidence.
- The two strongest sampled policies differ only cosmetically and replace the
  prefilled controller's inertial axial recovery signal with normalized
  body-water axial speed. They reproduce exactly a `23.424515T`, 4,259-step
  capture, `0.749902L` crossing, `2.184349L` score-metric mean distance, and
  `-0.287480` score. The matched prefill captures at `23.864521T`, with
  `0.749310L` crossing, `2.192138L` mean distance, and `-0.294271` score.
  Both have identical `12.222539L` distance at `2T`, so the improvement occurs
  after initial wake formation and supports the semantics of through-water
  locomotor sensing rather than a stronger startup gain. Peak normalized
  force/moment remain close (`0.029780/0.015287` versus
  `0.029479/0.015344`), although mean and near-target action rise from about
  `57.572/41.557` to `58.289/45.013`.
- The assigned parent's completed adverse-moment composition is the most
  informative mechanism failure. Four independently authored copies reproduce
  exactly a `23.853519T` capture, `0.749418L` crossing, `2.194872L` mean
  distance, and `-0.297049` score. It therefore loses essentially all of the
  water-relative recovery advantage and worsens the distance integral even
  relative to the inertial prefill. Its mean action falls to about `57.423`,
  but peak normalized force/moment rise to `0.030338/0.015511` and anterior
  rate-cap occupancy rises to about `11.99%`. At `16T` and `20T` its distance
  is `4.497/2.501L`, behind the water-relative baseline's `4.425/2.386L`.
  The complete top-down and oblique sheet for one repeat retains the attached
  alternating street and discrete three-dimensional Lambda2 structures, so
  this is an adverse posterior feedback interaction rather than carrier-wake
  collapse. A load pathway that helped with inertial recovery is not additive
  with the more meaningful body-water recovery observation.

## One candidate hypothesis

Use the twice-reproduced water-relative axial-recovery controller as the sole
candidate. Preserve its joint-state traveling carrier, water-relative lateral
route feedback, full body-frame target geometry, anterior redirect,
phase-selective posterior carrier, reactive-rudder sign, and phase-qualified
terminal relief. Change only the prefilled locomotor observation from
`-state.velocity_body_U[1]` to the sign-equivalent
`state.relative_flow_velocity_body_U[1]`. Do not carry forward the adverse-yaw
moment residual: its four-copy completed composition falsifies compatibility,
and reducing its limit would be scalar tuning of a mechanism whose useful
effect did not survive the better observation semantics.

This candidate is falsified if it does not reproduce capture by
`23.424515T`, mean distance at or below `2.184349L`, and the established
top-down route, or if action, `11.74/6.65%` rate-cap occupancy,
`0.029780/0.015287` peak force/moment, or the inherited coherent 3D carrier
envelope materially worsens. Fixed-pose still-water reproduction would confirm
the candidate, not establish robustness to changed pose, inflow, or imposed
wakes; a nonblank oblique render is required for any new 3D-wake claim.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction feedback
source_mechanism: preserve a traveling rhythmic carrier while measuring locomotor deficit relative to surrounding water and separating it from hydrodynamic-load rejection
transferable_invariant: normalized body-water advance may recruit bounded carrier energy, but a fast load residual must be retained only when completed evidence shows compatibility with the slow target and locomotor loops
nontransferable_details: published gains, dimensional thresholds and frequencies, species or robot kinematics, exact vortex phases, cylinder geometry, prescribed maneuver timing, and task-specific routes
policy_translation: feed the existing bounded anterior recovery gate with body-frame `relative_flow_velocity_body_U[1]`, preserve all evidenced carrier and steering allocation, and omit the falsified posterior moment residual
falsification: reject if capture is later than 23.424515T or lost, mean distance exceeds 2.184349L, or route, wake, saturation, effort, force, or moment envelopes worsen
