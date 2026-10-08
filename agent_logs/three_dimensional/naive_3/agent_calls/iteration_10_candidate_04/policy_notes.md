# Wake-policy candidate notes

## Evidence and visual diagnosis

- Every sampled and inherited diagnostic used direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  combined sheets therefore show policy-generated motion: their top-down rows
  contain alternating vorticity streets and their oblique rows contain
  persistent three-dimensional Lambda2 structures while the fish translates
  at up to roughly `0.95--1.05U`; sampled local flow stays below `0.034U`.
- The assigned parent and three sampled variants preserve that propulsive wake
  but repeat the high pass and upper-boundary hook. The parent static redirect
  reaches `2.999L`; posterior relief and carrier-wide hold reach `3.162L` and
  `3.592L`; anterior half-cycle stiffness asymmetry is still rhythmic but
  worsens closest approach to `4.859L` and raises raw acceleration-envelope
  exceedance to about `53/64%`. Thus held bends, distance-only relief, and
  anterior stiffness shaping do not supply the missing course correction.
- The inherited speed-gated body-frame course controller is the first semantic
  break in that topology. It compares the target ray with actual velocity
  direction, keeps the zero-centered traveling carrier, reaches `0.857L`, and
  exits through the left boundary instead of the upper boundary. Its combined
  sheet shows an active alternating wake through the approach, and the trace
  confirms self-propulsion: maximum speed is `1.052U` while maximum local flow
  is `0.031U`.
- That rollout is a narrow terminal miss, not failed broad steering. At
  `18.0T` the head is about `(9.66,10.60)L` at `1.281L` distance; by the
  `19.058T` minimum it is `(8.85,10.34)L`, only about `0.84L` above the target,
  and still moving left/down near `(-0.80,-0.27)U`. The constant-course
  cross-track prediction grows beyond the `0.75L` capture corridor only late,
  while both joints remain rhythmic. The posterior raw command already exceeds
  the acceleration envelope in about `68%` of samples, so more global drive or
  steering amplitude is not supported.
- A separate inherited posterior phase-lag asymmetry retains the wake but
  reaches only `3.532L` and repeats the upper exit. Phase modulation alone is
  therefore not reusable evidence; the course-angle observation is the
  demonstrated improvement that should be preserved.

## Policy hypothesis

Restore the inherited speed-gated full-quadrant course controller exactly for
broad approach. Add one terminal collision-corridor mechanism: derive a
normalized constant-course miss distance from the body-frame target vector and
velocity. Only when the fish is close, still closing, and that predicted miss
leaves an inner capture corridor, use anterior joint angle as observed beat
side and attenuate the posterior oscillatory carrier on the half-cycle whose
measured yaw sign opposes the current course correction. Keep the useful half,
posterior mean curvature, and zero-centered anterior oscillator active.

This is intended to trade a bounded amount of counterproductive terminal
thrust for corrective yaw without the nearly fixed joints seen in prior holds.
The broad trajectory and wake must be identical while the geometry gate is
zero. Falsify the candidate if it degrades the course controller before `2.5L`,
loses alternating shedding, raises posterior limit occupancy, fails to cross
`0.75L`, or merely changes the eventual boundary exit without a smaller and
slower near pass.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping combined with terminal target capture
source_mechanism: sensor-gated half-cycle authority allocation inside a predicted collision corridor
transferable_invariant: preserve the propulsive rhythm during broad approach, then reduce only the beat half that opposes requested yaw when observed course geometry predicts a terminal miss
nontransferable_details: published gains, duty ratios, species kinematics, clock phase, dimensional switch distances, exact vortex phases, and task-specific routes
policy_translation: compute target-versus-velocity course error and constant-course miss distance from normalized body-frame observations; near a closing miss, use anterior joint angle as beat side and smoothly attenuate only the opposing posterior carrier half while retaining mean curvature
falsification: reject if broad approach changes, the alternating wake or useful half-cycle collapses, actuator occupancy rises, or minimum distance does not improve below 0.857L and cross the 0.75L capture radius
