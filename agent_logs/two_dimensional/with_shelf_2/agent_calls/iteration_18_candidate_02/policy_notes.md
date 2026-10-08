# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet is the common held-fish initial condition: four
  developed, interacting vortex streets fill the diagonal target corridor
  while the fish is held near the upper-right boundary. It supplies no
  candidate-specific phase or memorized route.
- All four sampled released sheets are finite captures with the same useful
  topology. A zero-centered traveling bend creates a body wake immediately,
  actively propels the fish down-left through the merged wakes, and enters the
  target circle without a cylinder approach. For the strongest distinct
  policy, mean body x velocity is `-0.2470` versus `-0.1848` mean local
  flow and head displacement is `-10.910/-4.263L`; this is self-propulsion,
  not passive advection.
- The three byte-identical strongest samples add a fixed, distance-gated
  body-course-mismatch damper to the prefilled time-to-go heading predictor.
  They reproduce `target_reached` at `44.121`, mean/final distance
  `1.70618/0.74893L`, score `0.173450`, and force/moment RMS
  `389/3909`. The prefill without the damper reaches at `45.221`, has
  `1.71458/0.74854L` mean/final distance and score `0.165860`, and carries
  higher `439/4345` loads. Mean command energy rises modestly from
  `1030.39` to `1036.49`; the visual route is preserved with a shallower
  terminal excursion.
- Inherited matched refinements bound this result. Clamping heading and course
  responses into one shared budget delays capture to `45.727`, worsens mean
  distance to `1.72692L`, and raises loads to `449/4408`. Scaling the
  damper up with positive normalized closure reaches at `45.689` with
  `1.71923L` mean distance, and suppressing the heading forecast only when
  it opposes measured course reaches at `45.331` with `1.72584L`. Both
  retain capture but lose the sampled fixed damper's tracking benefit.
- No sampled solver is a failure. The inherited semantic failure boundary is
  broader optional posterior propulsion, which passed below capture and
  collided after a `1.872L` closest approach. Both successful baselines
  already touch the joint-rate cap, so the present candidate does not change
  the gait, add propulsion, strengthen global steering, or add a signed wake
  residual.

## Policy hypothesis

Starting from the prefilled time-to-go-capped scaffold, add exactly one
route-response mechanism: the evidence-backed fixed near-target course-mismatch
damper. Estimate body-course angle from normalized body-frame velocity, compare
it with target bearing, and subtract a speed-confident, smoothly
distance-gated fraction of that mismatch from predicted bearing. Keep this
response independently bounded rather than sharing authority with the heading
forecast, strengthening it with closure, or arbitrating its sign. Preserve the
oscillator, posterior lag and allocation, yaw-magnitude steering gate,
half-cycle law, and soft acceleration limiter unchanged.

Expected later CFD evidence is the already sampled diagonal capture topology
with arrival, mean distance, and force/moment load near the replicated
`44.121/1.70618L/389/3909` reference. Reject the mechanism outside that
boundary if capture or wake-entry topology is lost, if terminal crossing
returns, or if arrival, mean distance, load, or effort regresses without a
compensating benefit. Fixed-prewarm replication is not evidence of robustness
to wake phase, inflow, geometry, or target changes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and wake-interaction terminal approach control
source_mechanism: bounded sensor feedback damps approach course or slip error around an established rhythmic gait
transferable_invariant: preserve the propulsive rhythm while using normalized body-frame translational course mismatch as a small independently bounded terminal route residual
nontransferable_details: published gains, dimensional approach ranges and speeds, species-specific kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: smoothly gate body-course-minus-bearing by normalized remaining distance and body-speed confidence, then subtract that fixed bounded residual before the unchanged yaw-gated two-joint half-cycle steering law
falsification: reject if target capture or diagonal topology is lost, terminal course crossing persists, arrival or mean distance regresses beyond replay variation, or load or effort rises materially
