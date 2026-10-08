# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- The assigned parent (`solver_7c8c0623a821`) and all three sampled
  comparisons use direct uniform still-water initialization and terminate in
  capture.  The combined sheets were inspected in both the top-down
  vorticity/body row and oblique body/Lambda2 row.  The parent keeps the same
  organized traveling wake, target-directed translation, and shallow terminal
  hook as the duplicated no-recovery examples (`solver_c65157fcb0b0` and
  `solver_cd2b31e85ca6`); the oblique views show no breakup, passive advection,
  or new three-dimensional instability.  The bend-phase comparison
  (`solver_08d41e0117b7`) is likewise a coherent capture but follows the same
  useful topology more slowly.
- Adding the parent's instantaneous body-normal-velocity recovery changed the
  score from `-0.596086` to `-0.595593`, mean distance from `2.498175L` to
  `2.497592L`, and capture time from `25.971T` to `25.916T`.  This is a finite
  tie-break, not evidence that sideslip was recovered.  At `20/22T`, body-normal
  velocity is `0.270/0.239U` in the parent versus `0.269/0.239U` without the
  recovery, and projected miss is `2.900/2.125L` versus `2.898/2.140L`.
  Peak planar force/yaw moment remains in the same modest regime
  (`0.01902/0.01016` versus `0.01885/0.01010`).
- The point samples inherited as a “sideslip” signature landed on one carrier
  phase.  Across every row from `18--24T`, normalized body-normal velocity has
  mean about `-0.156` and correlation about `-0.86` with normalized anterior
  joint rate; its mean sign is already target-side while the instantaneous
  samples are positive.  Consequently the parent's slip-recovery gate exceeds
  `0.01` on only `168/1091` rows and is phase-locked rather than a persistent
  drift detector.  In contrast, target-normal course error keeps a positive
  full-beat mean (`0.536` over `18--22T` and `0.576` over `20--24T` in the
  no-recovery trace), and its carrier-phase coefficient is stable near
  `-0.18` per normalized anterior joint rate over that corridor.
- Posterior phase also separates hydrodynamic response without making force a
  route command.  Over `18--24T` in the duplicated no-recovery trace, the
  course-side projection of body-normal force averages `+0.00598` while joint
  2 moves opposite the requested course side, versus `-0.00516` while it moves
  toward that side.  This supports a small reaction-thrust half-cycle test; it
  does not support instantaneous force commutation or copying a vortex phase.

## Policy hypothesis

Preserve the captured carrier, course-triggered redirect, line-of-sight
response, upstream vectoring, capture controller, coupled command governor,
and angle/rate guards.  Remove only the phase-confounded middle-distance
body-normal-slip target shift.  Estimate persistent target-normal course error
by subtracting the evidenced anterior-rate carrier component, require its side
to agree with raw target geometry, and use it to strengthen the posterior
half-cycle moving opposite the desired fish course.  The tail/water reaction
then acts on the course side while all gates remain normalized, body-frame,
reflection-equivariant, closing-qualified, and inactive outside the
`1.75--4.5L` middle corridor.

Expected test: compared with the parent, the candidate should reduce
full-beat target-normal course error and projected miss at `20/22/24T`, not
merely rotate the body or change one sampled lateral-velocity phase.  Reject
the mechanism if capture is lost, the organized wake changes adversely, any
actuator contact returns, peak force/moment materially exceeds the sampled
`0.0191/0.0102` regime, or full-beat course error and projected miss do not
improve.

A frozen-state audit on the parent's `18--24T` trace confirms that this is a
material but bounded mechanism change: the new gate exceeds `0.01` on
`837/1091` rows (rather than the old phase-confounded `168/1091`), while the
added joint-2 command has mean absolute magnitude `0.136` and peak `0.861
rad/T^2`, well below the `30 rad/T^2` policy envelope.  This audit checks
engagement and boundedness only; it is not CFD outcome evidence.

bookshelf_consulted: true
source_domain: wake-interaction sensing and robotic-fish asymmetric flapping
source_mechanism: separate slow target response from fast alternating motion, then apply bounded half-cycle amplitude asymmetry
transferable_invariant: do not treat beat-synchronous lateral motion as persistent drift; qualify a geometry-owned correction with state-derived phase and strengthen only the hydrodynamically useful half-cycle
nontransferable_details: published gains, species envelopes, clock phase, exact vortex phase, cylinder geometry, and source-task routes
policy_translation: phase-reject normalized body-frame course error with anterior joint rate and gate a small opposite-tail-motion joint-2 half-cycle inside the evidenced closing middle corridor
falsification: reject if full-beat course error or projected miss at 20--24T fails to fall, capture or wake coherence is lost, or actuator and load exposure exceed the parent regime
