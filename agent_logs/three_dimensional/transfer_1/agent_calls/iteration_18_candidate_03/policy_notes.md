# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no prewarm, and capture termination.
- The exact `dogfish3d_intercept_guarded_speed_reserve_v1` policy has three
  sampled captures at `0.7466--0.7494L` and `18.205--18.601T`, with scores
  `-0.15856`, `-0.15828`, and `-0.15140`. The assigned prefill
  `dogfish3d_course_servo_los_guarded_release_v1` has one slower sampled
  capture at `0.7493L`, `18.6065T`, and `-0.16296`, while inherited guidance
  also records an exact-byte lower exit at `1.7715L`.
- The fastest speed-reserve keyframe sheet and the prefill sheet both show
  self-propelled motion and an active, coherent alternating wake in the
  top-down vorticity row and the oblique Lambda2 row through termination.
  Their terminal paths differ, but neither shows advection, carrier collapse,
  or numerical instability. Trajectory speed remains approximately
  `0.85--0.91L/T` near capture, so terminal geometry rather than propulsion is
  the discriminating mechanism.
- Sampled optimizer guidance sharpens the projected-miss result that the
  assigned parent treated as a one-capture compatibility test: exact
  `dogfish3d_speed_reserve_projected_miss_turn_v1` repeats produced two stable
  lower exits after the first threshold capture (`1/3`), versus `3/3` captures
  for the achieved-course/intercept speed-reserve baseline. Inherited logs
  also show that a carrier-phase steering allocator and a total-command speed
  governor retained coherent wakes but changed capture into lower exits.

## Policy hypothesis

Restore the exact three-repeat achieved-course/intercept speed-reserve policy.
Its normalized body-frame target/velocity projection vetoes response-based
steering release unless the fish is approaching inside a projected capture
corridor, while sparse joint-speed/previous-action feedback softens only
outward carrier effort already unusable near the actuator envelope. This is a
mechanism-level reversion from the fragile prefill, not scalar gain tuning.
Preserve its traveling bend, phase-independent additive steering, carrier
reserve, and parameter schema without stacking projected-miss replacement,
carrier-phase allocation, or a new yaw/slip residual in the same evaluation.

Expected result: recover the repeat-supported capture class and score range
without weakening the alternating wake. Falsify the choice if a new exact
evaluation leaves the domain, loses the coherent traveling wake, materially
increases force/moment or actuator saturation beyond the three sampled
repeats, or establishes that the apparent `3/3` baseline capture record is not
repeatable.

bookshelf_consulted: true
source_domain: classical undulatory propulsion and robotic-fish closed-loop turning
source_mechanism: preserve a posterior-lagged traveling bend while bounded target-geometry feedback supplies steering
transferable_invariant: separate an active propulsive wave from bounded closed-loop route correction; near-target correction must not erase the carrier
nontransferable_details: published gains, dimensional cadence, species kinematics, exact wake phase, and task-specific routes
policy_translation: retain the state-feedback two-joint traveling bend and the normalized body-frame achieved-course/intercept guard, with sparse actuator-state carrier reserve only near the envelope
falsification: reject if repeat capture fails, terminal self-propulsion or wake coherence degrades, or loads and saturation leave the sampled baseline envelope
