# Phase-confidence-gated yaw demodulation

## Evidence read before policy editing

- The assigned parent `solver_5ef271950e5a` is a direct-uniform, still-water
  capture at `0.747896L` and `16.631994T` with 232 moving-window shifts. The
  other three sampled rollouts are exact repeats of one another and capture at
  `0.747714L` and `16.637493T`; their policies differ from the assigned parent
  only in subtracting raw `q1` rather than the mean-removed `q1_carrier` in the
  yaw-phase model.
- In both inspected combined sheets, the top-down row shows self-propelled
  target approach behind an alternating signed vortex street, not passive
  advection. The oblique row shows wake structures connected to the caudal
  region through the turn and target entry. No sampled visual example is a
  failure, so no failed-wake appearance is inferred. The inherited scalar log
  for the state-triggered startup-recruitment descendant is used only as a
  negative control: it left the domain after reaching `3.490652L` and finished
  at `10.765474L` instead of preserving capture.
- Trajectory cross-checks place the assigned-parent capture at `16.632T`, with
  peak planar force/moment about `0.03678/0.01827`. Joint speeds occupy at
  least 95% of their hard limits for about `16.0%/20.0%` of samples and joint
  accelerations for about `30.7%/50.6%`; this rules out stronger carrier or
  curvature as a justified score edit. The normalized anterior phase radius
  first reaches `0.55` near `3.152T`, after only `0.135L` of progress, while
  the mature rollout subsequently closes at roughly `1U` and captures.

## Candidate hypothesis

The fixed joint-phase subtraction is evidence-calibrated on developed carrier
motion, but it is applied at full authority while the anterior oscillator is
still small. Fade that subtraction in with a reflection-invariant confidence
computed from `hypot(q1_carrier/A, q1_dot/(omega*A))`, reaching full confidence
at the observed developed-phase radius. This isolates an observer/reliability
change: the full-amplitude carrier, mean-preserving coordinate, posterior
half-cycle steering, route signs, and acceleration bound remain unchanged.
The intended result is less false directional-yaw correction during startup
without repeating the failed actuation-recruitment mechanism, followed by the
assigned parent's exact demodulated response semantics once the carrier is
observable.

bookshelf_consulted: true
source_domain: robotic-fish CPG control with sensor feedback and wake-response separation
source_mechanism: modulate a rhythmic controller with feedback only after separating locomotor phase from slower directional response
transferable_invariant: confidence in a phase-correlated disturbance estimate should follow the observed oscillator state while the slow route command remains independently body-frame
nontransferable_details: published CPG gains, species-specific envelopes, dimensional frequencies, exact wake phases, and task-specific routes
policy_translation: smoothly gate the existing joint-state yaw contamination model with normalized anterior phase radius; leave the two-joint carrier and target-relative route channels unchanged
falsification: reject if capture is lost or delayed, if the target-crossing route or connected alternating wake changes materially, or if joint-limit residence and peak force or moment exceed the assigned-parent envelope

