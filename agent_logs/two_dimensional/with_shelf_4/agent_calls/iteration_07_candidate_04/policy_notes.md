# Multi-Wake Candidate Diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the fixed four-cylinder streets fully developed
  around the held fish; it is common initial-condition evidence, not a policy
  comparison.
- All four sampled rollouts reach the target, so there is no sampled failure
  keyframe to compare.  The informative finite comparison is the direct
  moment-residual controller (`149.57` release time, `4.384L` mean distance,
  `16.22/314.99` RMS lateral force/yaw moment) against the assigned current
  parent with closing-qualified bearing-rate feedback (`137.36`, `4.184L`,
  `14.75/303.02`).  The parent also lowers relative-crossflow RMS from `0.1362`
  to `0.1295` and command energy from `101995` to `90228` while preserving
  capture.
- The best keyframe sheet shows genuine self-propulsion: mean upstream body
  velocity is `-0.0791` while mean local flow is only `-0.0542`, and the fish
  crosses the interacting wake corridor while retaining alternating bends.
  The centerline nevertheless contains several sharp yaw reversals before the
  final approach.  These reversals coexist with `303.02` RMS yaw moment and
  `0.1295` RMS relative crossflow; they are therefore a disturbance-response
  target, not evidence for changing the successful route or gait gains.
- The assigned parent's inherited optimizer notes add two boundaries: a
  confounded period/moment-headroom edit formed an upper-right loop and exited
  after `126.43` with only `-1.12L` upstream progress, while a sign gate that
  attenuated the direct moment residual still captured but worsened mean
  distance to `4.578L`.  Together with the older static-bias exits in durable
  guidance, this says to preserve the direct moment residual, established gait,
  and route owner; any response feedback must be a separately bounded additive
  mechanism rather than another gate on the proven load term.

## Policy hypothesis

Preserve the parent's target-bearing route term, closing-progress qualification,
moment residual, state-derived beat side, and posterior lag.  Add one small,
bounded body-yaw-rate damping term to the same half-cycle steering request.
Moment feedback reacts to the applied load; yaw-rate feedback reacts to the
resulting body response, so their small combination is a load/response residual
that should reduce wake-driven overshoot without introducing static curvature,
external phase, or a route schedule.  Reject the mechanism if the later CFD
rollout loses capture or upstream translation, erases the alternating bend, or
fails to improve at least one of route time/mean distance and yaw/load effort
without materially worsening the others.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation with sensor feedback
source_mechanism: bounded sensory residuals modulate a rhythmic gait while the oscillator retains propulsion
transferable_invariant: separate the propulsive rhythm and slow route command from a small feedback term on measured disturbance response
nontransferable_details: published gains, robot geometry, actuator dynamics, clock phase, obstacle routes, and species-specific kinematics
policy_translation: normalize observed body yaw rate, softly saturate it, and add a low-authority damping residual to the existing normalized moment residual before state-encoded half-cycle steering
falsification: reject if capture or upstream progress is lost, alternating propulsion collapses, yaw reversals persist, or reduced yaw load is purchased with worse distance topology or command effort
