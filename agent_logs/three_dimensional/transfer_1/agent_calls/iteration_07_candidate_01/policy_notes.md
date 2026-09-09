# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled diagnostics report direct uniform initialization in still
  water with `flow_velocity_L_per_T=[0,0,0]`, no prewarm, and no cylinders.
  Translation is therefore self-propelled rather than background advection.
- The highest scalar-score finite example (`solver_5c5f9d80447b`, score
  `-10.0272`) lays down a coherent alternating mid-plane wake and a persistent
  three-dimensional Lambda2 trail.  It swims almost horizontally through the
  target x-coordinate, reaches only `3.0031L` at `21.56T`, and exits the left
  boundary at y=`11.16L`; it demonstrates a useful carrier but inadequate
  route steering.
- The more informative terminal failures turn much more strongly.  The
  preserved-carrier terminal mean-curvature example
  (`solver_213717a6b100`) reaches `1.5454L` at `18.24T` with speed `0.809L/T`
  and about `51 deg` joint excursion, while the inherited energy-guarded
  half-cycle example (`solver_9ddd873113a3`) reaches `1.7708L` at `18.51T`
  with speed `0.779L/T`; its excursion falls to about `40 deg` during the pass
  but returns to about `50 deg` by `24T`.  Both combined sheets retain an
  alternating wake and show the same excessive downward turn before a lower
  boundary exit.  Thus neither visible wake loss nor lack of speed explains
  the miss.  Their force RMS (`0.005/0.014` and `0.005/0.013` in body axes),
  moment RMS (`0.008` and `0.007`), and local-flow RMS are also comparable to
  the highest-score example, and diagnostics mark both runs finite rather
  than unstable.
- Trace reconstruction exposes a signed-feedback defect.  At `16T` in the
  preserved-carrier example, the normalized body-frame target angle is about
  `+0.23 rad`, achieved-course angle about `-0.67 rad`, and the inherited
  route request about `+0.99`.  Yet positive course requests correlate with
  positive cycle-smoothed yaw, whereas this body convention (forward is
  `-x`) requires negative yaw to rotate the achieved course toward a positive
  target-minus-course angle.  The request remains saturated while the fish
  crosses below the target.  This is positive terminal feedback, not merely
  insufficient gain.  The same examples clip head/tail acceleration on about
  `70/72%` and `68/70%` of rows, respectively.
- Inherited step-6 score logs contain still closer passes at `1.1444L` and
  `0.9532L`, but both remain `left_domain` and finish farther away at
  `10.39L` and `11.27L`.  Closer scalar misses without a changed termination
  class are not evidence for adding still more same-sign steering authority.

## Policy hypothesis

Keep the observed state-feedback traveling bend, speed-gated target-versus-
course geometry, and low-energy release of terminal half-cycle reallocation.
Change the route-to-actuator map so the bounded steering request is the
negative of target-angle-minus-course error, and use that same corrected sign
to decide which half-cycle is opposing the turn.  This converts the loop from
positive to negative feedback without copying a route, adding a clock, or
raising any gain.  The falsifiable expectation is earlier course-error release,
less persistent command saturation, and capture or at least removal of the
below-target/lower-exit topology while the coherent carrier remains visible.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and asymmetric flapping
source_mechanism: sensory direction error modulates a bounded tail-beat asymmetry while the propulsive rhythm continues
transferable_invariant: a slow route error must drive mean bend or half-cycle authority with an empirically verified corrective sign, while joint-state phase retains the traveling carrier
nontransferable_details: published gains, robot or species kinematics, exact duty ratio and beat phase, dimensional cadence, and task-specific world routes
policy_translation: negate the normalized body-frame target-versus-achieved-course request at the steering actuator, and apply the existing energy-gated opposing-half relief using that corrected bend request
falsification: reject the transfer if early distance closure or the alternating wake degrades, actuator saturation grows, or the rollout retains the same below-target lower exit without a better termination class

bookshelf_consulted: true
source_domain: wake-disturbance rejection with route-servo separation
source_mechanism: keep a slow geometry request distinct from a soft residual built from lateral load, yaw moment, and recent turn response
transferable_invariant: persistent target geometry should steer the mean bend, while fast wake-induced load or rate perturbations only subtract a bounded correction
nontransferable_details: source-specific wake phase, gain schedule, geometry, and any world-frame route or timing assumptions
policy_translation: subtract a small normalized disturbance residual from the corrected route request, and keep it clamped so the carrier sign remains dominant
falsification: discard the residual if it adds saturation, weakens the corrected turn sign, or improves the wrong-exit topology without better capture or clearance
