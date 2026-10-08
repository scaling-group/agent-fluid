# Phase-rejected course-bias candidate

## Evidence diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm) in the inertial
  moving window. The motion and wakes in both visual rows are therefore
  controller-driven rather than imposed advection or frame motion.
- The assigned solver parent, `solver_aaab22dcaa09`, is the strongest physical
  carrier in the current samples. Its top-down row shows a persistent
  alternating wake and nearly horizontal leftward translation through
  `38.671T`; the oblique row confirms a coherent three-dimensional caudal
  Lambda2 trail. It improves the prior anterior half-cycle carrier from a
  `5.156L` to a `4.676L` closest approach while keeping the center in
  `y=13.753--14.271L`, but it still passes about `4.73L` above the target and
  exits left at `(0.800,13.990)L`.
- The parent's explicit phase pump and phase-rejected yaw estimate preserve
  the useful long-path topology, but bearing alone supplies weak persistent
  route authority. From `8T` through closest approach, mean body-frame bearing
  grows from about `-0.51` to below `-1.2 rad`, while normalized target-versus-
  velocity cross product grows from about `+0.48` to `+0.93`. The latter says
  the translating course continues to miss the target on a consistent side.
  Yet the reconstructed mean half-cycle selector remains only about `-0.24`
  because the bounded bearing request tops out at a normalized yaw ratio of
  `+0.04`.
- The best scalar sample, `solver_12fc3441a636`, is an informative failure.
  Adding the same persistent course signal to the old raw-yaw closure makes
  distance decrease monotonically to `6.268L`, but the top-down row bends the
  wake toward the upper boundary and the oblique trail ends at only `20.790T`.
  Metrics agree: the center exits at `(12.027,15.200)L`, with course error near
  `+1`. Its within-beat yaw remains phase contaminated
  (`corr(heading_rate,phi_dot1)=-0.931`), so the geometric setpoint is mapped
  through the response sign that the inherited logs found to be wrong.
- `solver_65e67137c3f9` supplies a second control: phase rejection without the
  response-sign inversion preserves a long wake but stays in the high corridor
  and reaches only `5.264L`. Across all long samples the same raw-yaw/phase
  correlation is about `-0.93`, and speed/acceleration limit residence remains
  material. More carrier drive or another raw-rate gain change is therefore
  unsupported.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, symmetric
anterior pump, posterior lag, phase-rejected yaw estimate, evidenced
error-to-half-stroke sign, and existing angle headroom. Add one bounded slow
route mechanism: once body-frame translation is observable, use the normalized
cross product of velocity and target vectors to bias the desired yaw ratio
tracked by the phase-rejected loop. At low speed it fades continuously to the
existing bearing request. It does not directly select a half-cycle and does not
increase carrier or steering acceleration.

Expected result: the long coherent leftward wake survives, while the persistent
positive course error makes the correctly signed negative half-cycle selector
stronger and produces downward cross-track motion before the longitudinal
target crossing. Falsify the mechanism if the near-`21T` upper exit recurs, if
the fish again passes above `y=14L` with no improvement over `4.676L`, if the
alternating 3D wake loses coherence, or if speed/acceleration limit residence
increases despite unchanged drive bounds.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and turning averaging models
source_mechanism: persistent course error biases a rhythmic mean-turn request while state feedback preserves the propulsive carrier
transferable_invariant: separate fast gait-synchronous yaw from slow target-versus-course error, then map the bounded slow request through an empirically calibrated turn-response sign without erasing the traveling wave
nontransferable_details: published gains, linkage geometry, clocked CPG phase, species-specific kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: form a bounded normalized cross product from body-frame velocity and target vectors, fade it at low speed, add it to desired yaw, and track that request with the parent's joint-state phase rejection and anterior half-cycle allocation
falsification: reject if the upper curl returns, cross-track target progress does not improve, wake coherence collapses, or actuator-limit residence worsens
