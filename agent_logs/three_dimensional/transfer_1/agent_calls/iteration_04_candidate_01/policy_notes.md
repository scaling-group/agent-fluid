# Replicated completion-gated redirect candidate

## Evidence and visual diagnosis before candidate selection

- All four sampled solver rollouts use direct uniform initialization in still
  water, with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion
  and wake are self-generated rather than ambient advection.
- Three samples are byte-identical copies of the completion-gated redirect and
  reproduce the same capture at `26.411 T`, minimum/final distance `0.7496 L`,
  score `-0.71050`, and distance-integral term `2.6134 L`. In both visual rows,
  the fish leaves a coherent alternating mid-plane street and compact paired
  three-dimensional Lambda2 structures. The path first moves slightly above
  the direct corridor, then sustains a smooth target-signed arc into the
  capture circle. Metrics agree with self-propelled stable motion: mean/max
  speed is `0.501/0.667 L/T`, sampled local flow stays below about `0.030
  L/T`, and peak force/moment coefficients remain about `0.030/0.015`.
- The actuator-envelope sample preserves the same visible wake and capture
  topology but is not an improvement. Its outward-speed guard reduces mean/max
  speed to `0.496/0.657 L/T` and speed-limit contact from about `11.4%` to
  `2.9%`, yet capture is delayed to `26.813 T`, the distance-integral term
  rises to `2.6382 L`, and score falls to `-0.73429`. Peak force and moment do
  not materially improve. Because the evaluator already enforces the actuator
  envelope, this extra projection removes productive joint acceleration rather
  than exposing new feasible authority.
- The inherited capture-turn-hold failure is the informative counterexample.
  Its top-down row develops a stronger alternating street and a tight terminal
  turn, while the oblique row confirms finite three-dimensional shedding, but
  it passes the target at `1.3896 L`, accelerates to `1.450 L/T`, and exits the
  domain at `37.624 T`. Its large terminal wake is therefore not evidence of
  better capture. Together with the inherited `1.2329 L` terminal-relief miss,
  it falsifies adding another cadence/amplitude hold to this captured route.

## Policy hypothesis

Use the evaluated completion-gated redirect already materialized in
`candidate_target_policy.jl` as the one candidate, without the sampled
speed-envelope projection or a new terminal carrier-relief branch. Preserve
its joint-state oscillator, posterior lag, target-signed distributed redirect,
half-cycle steering, and geometric release rule. The candidate exploits the
only mechanism reproduced by three sampled evaluations: an oscillatory yaw
sample may release a large-error redirect only as normalized body-frame target
angle contracts.

This is deliberately not scalar-only tuning. No unused shelf primitive has an
evidence-matched applicability condition here: propulsion is coherent, the
large turn completes, capture succeeds, and the fixed evaluation has no
external wake to reject. Falsify this selection if the same evaluator fails to
reproduce capture, loses the smooth terminal arc or coherent three-dimensional
wake, materially exceeds the sampled speed/load envelope, or if a later
held-out condition demonstrates a disturbance signature that calls for a new
residual mechanism.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG steering
source_mechanism: sustain bounded curvature for a large observed direction error, then release into the posterior-lag propulsive rhythm after feedback demonstrates maneuver completion
transferable_invariant: burst-turn completion requires contraction of normalized target-relative geometry, not an instantaneous correct-sign yaw excursion within an oscillatory gait
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat timing, robot geometry, exact vortex phases, and prescribed routes
policy_translation: retain normalized body-frame target-angle gating of observed-yaw release in the two-joint state-feedback controller, without adding the falsified speed or terminal-drive guards
falsification: reject if capture, early closure, or wake coherence is lost, loads materially exceed the replicated envelope, or held-out wake evidence reveals repeatable disturbance-driven yaw reversals
