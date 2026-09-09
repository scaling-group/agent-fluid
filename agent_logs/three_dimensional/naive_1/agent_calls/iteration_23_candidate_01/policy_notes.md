# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled rollouts use the required direct uniform still-water
  initialization. The strongest scalar sample, `solver_649d7e789a5a`, is one
  of two executable-identical half-cycle envelope-redistribution captures; it
  reaches `0.74757L` at `18.8265T`. The most useful conservative comparison,
  `solver_02eaf03fe1d2`, is the geometry-scheduled carrier and reaches
  `0.74981L` sooner at `18.6505T`. The redistribution trace does not relieve
  demand: reconstructed rate contact is about `11.07%/14.93%` and acceleration
  contact is `60.85%/73.27%`, versus `11.03%/15.10%` and `60.96%/73.19%` for
  the carrier.
- In both combined sheets, the top-down row develops an alternating,
  target-directed vortex street from quiescent water and bends toward the
  target; the oblique row shows compact alternating caudal Lambda2 structures
  through approach. Translation is therefore self-propulsion, not imposed-flow
  advection, and neither successful allocation visibly loses its traveling
  wave. The sampled set contains no semantic failure sheet, so failure-shape
  conclusions are limited to inherited completed evidence rather than inferred
  from these capture images.
- The assigned-parent evidence reports that a behind-route reserve retained an
  energetic two-view wake but missed at `0.85155L` and exited left. It first
  became broadside (`|target_body_y|/distance = 0.60`) at `2.0134L` while the
  target was still ahead, and the route request was already about `0.995` of
  saturation at closest approach. The sampled rearward multiplier captured,
  but its forward target fraction never became negative, so that branch was
  never exercised. Multiplying the saturated route argument or waiting until
  the target is behind cannot supply or test the missing authority.
- The inherited optimizer score logs contain both capture-class results and a
  `left_domain` result (`min_distance=3.92476L`, `final_distance=6.74099L`),
  but those compact logs do not include the executable policy or wake sheet.
  They bound population robustness but cannot attribute a controller
  mechanism; the candidate therefore preserves the sampled reliable carrier
  and changes exactly one feedback architecture.

## Policy hypothesis

Start from the geometry-scheduled carrier, retaining displacement-only
half-cycle steering, target-owned sign, one-sided correcting-yaw release,
posterior lag, common rhythmic-amplitude relief, and final acceleration
projection. Add one independent broadside redirect channel after the bounded
route command: a smooth normalized body-lateral gate directly adds a small,
bounded reserve to both established mean-curvature shares while the target is
still ahead. Because the reserve bypasses the saturated route argument, it can
change actuator authority before overshoot; because it uses the same route
sign and response release, it cannot invent a route sign or invert correcting
yaw. This is a feedback-architecture test, not scalar-only carrier tuning.

Expected evidence: ordinary capture and both coherent wake rows survive, while
the trajectory either captures earlier/with a meaningfully different approach
or avoids the inherited broadside near-miss topology. Falsify the mechanism if
capture is lost, the fish again exits left after a near miss, the reserve
destroys the top-down street or compact caudal structures, or force/moment and
joint-limit contact exceed the established carrier band without semantic gain.

bookshelf_consulted: true
source_domain: biological burst turning and robotic-fish mean-curvature steering
source_mechanism: geometry-gated C-start-like redirect expressed as bounded tail-beat bias with response-triggered release
transferable_invariant: large persistent target error may temporarily receive a separate bounded curvature reserve, then release as correcting yaw appears while the propulsive traveling wave remains active
nontransferable_details: species-specific C-start kinematics, published gains, dimensional timing, prescribed beat phase, full-body shapes, and task-specific routes
policy_translation: use normalized body-frame forward and lateral target fractions to gate a small additive two-joint mean-curvature reserve; preserve target-owned sign, observed displacement phase, posterior lag, and one-sided yaw-response release
falsification: reject on lost capture, repeated broadside-to-left-exit topology, degraded two-view wake coherence, or larger actuator/load contact without a semantic route benefit
