# Terminal course-correction candidate

## Evidence and visual diagnosis before editing

- The four sampled evaluations and the two relevant inherited terminal
  evaluations all report direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  Motion in their sheets
  is therefore self-propelled.  The top-down rows show alternating signed
  vorticity and the oblique rows show three-dimensional Lambda2 structures
  through the broad approach.
- The sampled distance hold (`3.592L`) weakens the late alternating wake and
  turns into a nearly fixed high hook.  The response-released bend (`2.989L`)
  also fails to make a recovery arc.  These views agree with their metrics:
  both retain roughly `0.77U` at closest approach yet leave the upper virtual
  boundary, so the repeated failure is controlled pass geometry rather than
  still-water advection.
- The inherited body-frame course controller is the supported broad-guidance
  mechanism: its ungated result reached `0.857L` with an alternating wake.
  Two subsequent posterior-allocation tests did not close the final gap.  A
  closing-only posterior carrier reduction reached `0.914L`; a predicted-miss
  counterstroke reduction reached `0.903L`.  Both remained stable, retained
  a visible wake, passed above the capture circle, and later exited the left
  boundary.  Thus terminal posterior relief is now a concrete negative result,
  not support for stronger or earlier relief.
- At the closing-only result's `18.914T` minimum, the head is
  `(8.951,10.413)L`, speed is `0.794U`, the body-frame target vector is about
  `(-0.360,-0.840)L`, and the target-versus-course error is `-1.686 rad`.
  The request is already saturated while beat-scale yaw alternates sign.  The
  remaining miss therefore calls for phase-aware yaw authority, not another
  scalar change to posterior thrust or curvature cap.

## Policy hypothesis

Restore the demonstrated speed-gated, full-quadrant body-frame course
controller and preserve its zero-centered anterior oscillator, full posterior
lagged carrier, and bounded posterior mean curvature.  Add one terminal
turn-side half-cycle mechanism.  It activates only while distance is inside
`2L`, measured translation is closing, and the constant-course miss lies
outside an inner capture corridor.  Observed anterior angle selects the
requested bend half-cycle.  A bounded same-sign anterior acceleration then
extends that half-cycle only while yaw is wrong-way or too weak; already
corrective yaw continuously releases the burst.  All gates are normalized,
state based, continuous, and reflection invariant.

This isolates active terminal yaw from the two failed posterior-relief tests:
the broad route is exactly unchanged at and beyond `2L`, the posterior wake is
never attenuated, and no oscillator center is held.  Falsify the mechanism if
the pre-`2L` route changes, the alternating wake collapses, acceleration/rate
limit occupancy materially rises, minimum distance fails to beat `0.857L`, or
capture/termination topology does not improve.

An offline replay of the new algebra on the closing-only trajectory is an
envelope check, not a rollout prediction.  It gives exactly zero burst for all
logged states at or beyond `2L`, activates in `1.88%` of rows, and peaks at
about `781 deg/T^2`.  On those fixed states reconstructed raw joint-1
acceleration-cap occupancy changes from `58.29%` to `58.17%`; the new term
therefore does not add clipping in the sampled envelope.  Mirroring target,
lateral velocity, yaw rate, and joint state flips both accelerations while all
terminal gates remain unchanged.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological burst turning
source_mechanism: sensor-gated turn-side half-cycle forcing with response-based release
transferable_invariant: a rhythmic swimmer can create corrective mean yaw by adding bounded work only on the requested bend half-cycle and withdrawing it once observed yaw is corrective
nontransferable_details: published gains, duty ratios, species kinematics, dimensional switching distances, exact vortex phase, gait envelope, and task-specific route
policy_translation: use body-frame target-versus-course error for turn sign, normalized distance/closing/miss geometry for terminal gating, anterior joint angle for beat side, and measured yaw rate for continuous release within the two-joint acceleration contract
falsification: reject if behavior changes outside 2L, posterior wake coherence is lost, limit occupancy materially rises, closest distance does not beat 0.857L, or the rollout again misses and leaves the domain without a distinct corrective arc
