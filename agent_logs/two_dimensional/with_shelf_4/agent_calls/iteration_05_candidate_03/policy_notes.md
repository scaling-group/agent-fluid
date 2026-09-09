# Multi-wake candidate diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the same held fish and four developed,
  interacting vortex streets for every sampled policy, so it is an initial
  condition rather than candidate-specific evidence.
- All four sampled releases reach the `0.75L` target; no sampled failure sheet
  is available. The informative comparison is therefore the three equivalent
  direct-moment-residual successes against the bearing-rate descendant. Their
  keyframes all show self-propelled upstream travel into the wake region, not
  passive downstream advection, but the targetward polyline retains repeated
  lateral kinks through the final approach.
- Adding windowed bearing-rate feedback leaves arrival essentially unchanged
  (`149.605` versus `149.572`) while improving mean distance (`4.358L` versus
  `4.384L`), total command energy (`96933` versus `101995`), RMS relative
  crossflow (`0.1321` versus `0.1362`), RMS lateral force (`15.49` versus
  `16.22`), and RMS yaw moment (`308.48` versus `314.99`). Joint velocity and
  acceleration maxima also fall. This supports response damping as a load and
  trajectory-smoothing mechanism, not as evidence for a faster gait.
- Inherited guidance reports that static-curvature steering loops or exits,
  whereas zero-mean half-cycle steering reaches the target. It also records a
  confounded higher-gain/slower-period route-headroom gate that exited the top
  boundary. The successful oscillator, posterior lag, bearing-rate route
  feedback, and direct small moment residual should therefore be preserved;
  gating by `1 - abs(route_turn)` should not be repeated.

## Policy hypothesis

Introduce one mechanism: a smooth directional-response gate on the existing
normalized yaw-moment residual. Bearing error times normalized windowed
bearing rate distinguishes target divergence (same sign) from improving
alignment (opposite sign). Keep full load-rejection authority as the bearing
diverges, retain a nonzero floor when the response is ambiguous or improving,
and leave the route term and zero-mean half-cycle gait unchanged. This should
avoid rejecting useful wake-assisted correction while retaining the proven
residual for harmful yaw events.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and organized-wake fish interaction
source_mechanism: modulate a rhythmic gait with measured response while preserving potentially useful wake-induced motion
transferable_invariant: separate persistent target routing from bounded disturbance rejection, and reject a disturbance most strongly when the measured target response is harmful
nontransferable_details: published gains, clock-driven oscillator phase, species kinematics, single-cylinder vortex phase, and prescribed routes
policy_translation: use normalized body-frame bearing and its windowed rate to gate the existing normalized yaw-moment residual before it modulates state-inferred half-cycle amplitude
falsification: reject the gate if capture or upstream translation is lost, arrival materially slows, lateral kinks persist without lower load and effort, or reduced rejection permits a domain exit
