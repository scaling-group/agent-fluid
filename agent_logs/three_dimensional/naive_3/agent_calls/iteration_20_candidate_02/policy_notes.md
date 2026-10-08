# Evidence-selected posterior stopping-risk barrier

## Visual diagnosis and completed evidence

- Every sampled rollout and the assigned-parent comparisons report direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. The observed translation and wake are controller-generated,
  not ambient advection or moving-window transport.
- All four current samples capture at about `18.27T`. In both the top-down
  vorticity rows and the oblique Lambda2 rows, they preserve the same coherent
  alternating wake and visibly undulating posterior body through the target
  approach. Peak body speed is about `1.329U` against only `0.0315U` peak
  local flow. The best-scoring finite sample is the fixed-width guard at
  `0.748232L`, but the compact views are visually indistinguishable from the
  velocity-aware barriers at keyframe cadence.
- The inherited measured-moment-residual left exit is the informative visual
  failure. Its two rows also show a self-propelled alternating wake, but after
  a `0.845L` tangent miss the fish continues past the target and leaves the
  left boundary. Together with the inherited `0.834--0.876L` near-miss family,
  it supports retaining the body-frame target-ray/velocity-course observation
  and the posterior acceleration reserve that first changed termination to
  capture.
- The current samples separate score from mechanical quality. The unguarded
  reserve controller and fixed-width brake both reach exactly `45 deg` at the
  posterior joint. The fixed-width brake reduces peak force/yaw-moment
  coefficients from about `0.2076/0.0928` to `0.1718/0.0770`, but still resets
  outward joint velocity at the hard stop. In contrast, both velocity-aware
  variants retain capture, keep `|phi2|` below about `43 deg`, and reduce the
  entire-rollout force/yaw-moment peaks to about `0.0372/0.0191`. Their
  top-down and oblique sheets retain the productive wake.
- Between the successful velocity-aware variants, the continuous stopping-risk
  barrier is the evidence-selected candidate: it has the slightly better score
  (`-0.248270` versus `-0.248277`) and capture distance while avoiding the
  discontinuous maximum-braking switch. Its posterior raw-acceleration
  exceedance remains about `46.4%`, so the evidence supports constraint-aware
  redistribution, not a claim that all nominal command saturation is solved.

## Policy hypothesis written before the solver edit

Replace the unguarded prefill with the completed continuous stopping-risk
barrier while preserving its demonstrated full-quadrant target ray, measured
body-frame velocity course, speed gate, zero-centered anterior oscillator,
posterior lag and damping, `12 deg` mean-curvature request, and terminal
acceleration reserve. Inside the already evidenced allocation regime, compare
posterior kinetic stopping distance with the remaining angle margin and
smoothly cap acceleration toward the threatened boundary. Release the cap as
soon as posterior motion turns inward. This uses only joint state, normalized
body-frame task observations, and the existing owned actuator envelope.

The expected signature is reproduction of capture and the alternating 3D wake
without posterior hard-stop contact or its coincident load spike. Falsify the
selection if it loses capture or a sub-`1L` approach, changes the broad route,
creates persistent one-sided braking, raises limit occupancy, reaches the
posterior angle stop, or does not retain the sampled load reduction.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture under constrained rhythmic propulsion
source_mechanism: preserve the traveling carrier while state feedback modulates only motion that is dynamically unsafe near a mechanical boundary
transferable_invariant: constraint protection should be gated by observed stopping risk and released when the state recovers so productive rhythmic propulsion remains intact
nontransferable_details: published gains, robot linkage geometry, species-specific joint envelopes, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain target_body_L versus velocity_body_U course feedback and the allocated two-joint carrier; use posterior angle and velocity to normalize kinetic stopping distance by remaining angle margin and smoothly restrict only outward acceleration
falsification: reject if capture or alternating 3D shedding is lost, intervention changes the broad path, posterior contact returns, limit occupancy rises, or force and yaw-moment peaks no longer improve over the unguarded and fixed-width captures
```
