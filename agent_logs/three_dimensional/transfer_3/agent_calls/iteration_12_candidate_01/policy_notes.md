# Response-released distributed C-bend candidate

## Prior-evidence diagnosis

- All four sampled diagnostics confirm the required direct uniform still-water
  initialization (`U_infinity=[0,0,0]`) and contain both visual rows. The two
  capture sheets show a self-propelled fish with a persistent alternating
  top-down vortex street and repeated finite three-dimensional Lambda2
  structures; neither view shows passive advection, wake collapse, or a
  prewarm artifact before capture. The posterior-only LOS-rate failure retains
  a similarly coherent long wake, so wake coherence alone is not the missing
  steering capability. The phase-conditioned posterior-only failure has a
  visibly sparser oblique wake and exits above the target.
- The otherwise matched posterior-only LOS-rate policy misses by `3.369L`,
  crosses the target x station near `y=12.995L`, and exits left. Adding a
  bounded anterior oscillator-center shift changes the trajectory class: the
  response-triggered and intercept-gated variants both capture, at `19.585T`
  and `19.784T`, with final head y positions `10.119L` and `10.208L`. Their
  local-flow RMS values remain small (`0.01825U` and `0.01842U`), so the route
  change is controller-driven rather than ambient-flow advection.
- The response-triggered capture is the stronger parent: score `-0.20397`
  versus `-0.20824`, lower distance integral `2.0934L` versus `2.0982L`, and
  slightly earlier capture. Preserve its `28 degree`, `0.55T` traveling-bend
  carrier, LOS-rate route request, joint-conditioned yaw residual, posterior
  mean curvature, and bearing-triggered distributed C-bend.
- Its supplemental anterior gate depends on the magnitude of requested yaw,
  not the observed yaw response. It therefore stays nearly fully recruited
  late whenever the bounded request saturates, even on samples where the
  phase-conditioned yaw response already outruns the request. Raw anterior and
  posterior acceleration exceed the actuator envelope in about `39.5%` and
  `71.6%` of trajectory rows. This does not invalidate the capture, but makes
  response-led release the smallest evidence-supported refinement to test.

## Policy hypothesis

Replace only the request-magnitude supplemental gate with a smooth,
directional yaw-response-deficit gate. Recruitment rises when requested yaw
and `(requested - phase-conditioned measured yaw)` have the same sign, and
releases when measured response meets or outruns the request. Retain the
independent large-bearing gate as a geometry-safe floor, and keep the carrier
and both curvature limits unchanged. This translates the existing
joint-conditioned response signal into a closed-loop C-bend release rather
than another scalar gain change. Expected evidence is capture with the same
coherent wake and route topology, but less unnecessary anterior recruitment
and no slower distance integral. Reject the mechanism if capture is lost, the
path reverts toward the `3.369L` high miss, the response gate chatters into a
weaker or disorganized wake, or acceleration occupancy/load spikes increase.

bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: recruit a strong geometry-driven body bend when a turn is needed, then release it as observed directional response develops while the propulsive rhythm continues
transferable_invariant: steering authority should depend on the signed deficit between route demand and observed response, not remain recruited solely because demand is large
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional beat frequencies, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target bearing and LOS rate for yaw demand, subtract joint-correlated recoil from measured yaw, and gate the bounded anterior oscillator-center shift by signed yaw-response deficit while preserving posterior lag
falsification: reject if the evaluated policy loses capture, reproduces the high left pass, weakens wake coherence, or fails to reduce needless recruitment without worsening the distance integral
