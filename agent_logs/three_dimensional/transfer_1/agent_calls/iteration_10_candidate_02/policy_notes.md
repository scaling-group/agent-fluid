# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled rollout and the inherited replay used direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. The combined top-down and oblique sheets show self-propulsion and
  finite three-dimensional wakes rather than advection or instability.
- The prefilled achieved-course/yaw-rate cascade lays down a coherent
  alternating wake but follows an almost straight path above the target,
  reaches only `3.1135L`, and exits the lower virtual boundary. The related
  phase-compensated rate controller has the same broad failure at `3.0031L`.
  Those results reject another yaw-rate cascade or scalar cadence adjustment.
- Opposing-half carrier attenuation redirects the route to `1.2669L`, but its
  top-down wake and oblique structures fade after the pass while joint action
  collapses and inertial speed remains about `0.78--0.85L/T`. It then coasts
  below the target to `left_domain`, so further carrier suppression is not a
  supported terminal correction.
- The LOS-guarded response-release controller is the only sampled semantic
  success. It preserves the traveling carrier and shared-acceleration course
  steering, keeps shedding an alternating wake, and captures at `0.7493448L`
  after `18.6065T`. Its acceleration commands reach the clamp on about `70%`
  of trace rows, however, and the margin inside the `0.75L` capture radius is
  only about `0.00065L`.
- The inherited step-9 log supplies the essential falsification boundary: a
  byte-identical replay of that capture policy under the same configuration
  and direct-uniform contract terminated `left_domain`, with a `1.7715L`
  closest pass. Its combined sheet still shows a coherent wake, but the route
  is visibly lower by the terminal approach. The trajectories are nearly
  identical through `4T`; by `14T` the replay head is about `0.49L` lower and
  by `16T` about `0.70L` lower. Near `15T`, its instantaneous angular
  target-versus-course residual is only about `0.13 rad`, although the signed
  target/velocity cross product predicts a roughly `0.43L` cross-track miss.
  The sampled capture at the same range has an opposite, roughly `-1.0L`
  projected miss. Thus a tight single capture does not establish robust
  angular-pursuit terminal guidance.

## One candidate mechanism and falsification

Retain the evaluated LOS-guarded response-release controller's joint-state
traveling bend, far-field achieved-course loop, cadence schedule, shared
steering actuator, and acceleration envelope. Inside the existing `4L` to
`1.25L` terminal gate, continuously blend its angular course residual toward
a signed projected cross-track miss,
`cross(target_body_L, velocity_body_U) / speed`. This rotation-invariant
body-frame quantity estimates the closest-pass side and distance under the
observed velocity. It gives earlier authority when angular alignment looks
small but accumulated lateral momentum already predicts a miss; it does not
attenuate the carrier, increase the steering acceleration limit, prescribe a
world-frame route, or introduce time or mutable phase.

Expected test: preserve the captured controller's early closure and coherent
wake while correcting both the successful trajectory's negative terminal miss
and the replay's positive terminal miss before either becomes a late saturated
turn. The new workspace evaluation occurs only after exit; no same-worker
success is claimed.

Falsification: reject projected-miss blending if behavior outside `4L`
changes, the alternating terminal wake weakens, clamp occupancy or joint-speed
contact grows materially, the closest pass does not beat the inherited
`1.7715L` replay, or the lower-exit class remains. Even if it captures once,
require a repeated or held-out reproduction before calling it robust.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture control
source_mechanism: preserve a propulsive rhythm while observed target-relative translation continuously modulates bounded turning authority
transferable_invariant: use normalized motion-relative target geometry to correct predicted cross-track miss without suppressing the traveling carrier
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, prescribed beat or vortex phase, exact capture radius, and task-specific routes
policy_translation: blend far-field angular course error toward signed body-frame target/velocity projected miss inside the existing approach gate, then drive the same bounded two-joint shared steering
falsification: reject if far-field closure changes, wake coherence degrades, saturation increases materially, the 1.7715L replay miss is not improved, or capture cannot be reproduced
