# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled evaluations satisfy the frozen experiment: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm. The
  visible translation and wakes are therefore policy-generated rather than
  ambient advection.
- Every combined sheet shows the useful part of the inherited controller. The
  top-down row develops a coherent alternating signed-vorticity street, while
  the oblique row resolves persistent three-dimensional Lambda2 structures.
  The body keeps self-propelling after the moving window shifts; none of the
  sampled failures is a wake-collapse or numerical-instability failure.
- The unscheduled bearing-minus-body-slip controller remains the strongest
  geometric approach. It descends from center `y=14.000L` to `12.324L`, reaches
  `2.960L` at `17.699T`, and maintains about `0.78U` body-forward speed at the
  minimum. Its target bearing is already about `-0.87 rad` at `16T` and
  `-0.97 rad` at the minimum, however, so it passes the target roughly `2.87L`
  high, hooks upward with its wake, and exits left at `26.637T`. This is active
  propulsion with insufficient redirection, not a stall.
- The three sampled approach reallocations all preserve the same left-exit
  termination and fail to beat that `2.960L` minimum. The prefilled joint-one
  envelope and posterior-carrier relief reaches `3.032L`; tail-only relief
  reaches `3.162L`; and anterior damping plus a posterior carrier floor reaches
  only `3.592L`. Within `5L`, tail-only relief cuts posterior raw acceleration
  above `1800 deg/T^2` from about `71.2%` to `6.0%`, while the damping variant
  lowers mean absolute joint rates to about `0.58/0.40 rad/T` and raw
  over-envelope fractions to about `5.9%/2.6%`. The latter is nearly motionless
  in joint space by `16--21.5T`, yet still coasts left around `0.7U` and misses
  farther above the target. Free actuator reserve alone is therefore not
  corrective authority; simply removing the beat also removes the
  hydrodynamic action needed to redirect the inertial body.
- Earlier inherited evidence gives the complementary boundary: recentering
  both joints throughout the broad approach collapsed anterior excursion to
  about `8 deg` and worsened final distance to `13.403L`. A useful redirect
  must consequently be state-conditioned, late enough to preserve the
  demonstrated far-field carrier, and retain a nonzero active beat rather than
  replacing locomotion with a static posture.

## Policy hypothesis

Restore the demonstrated unscheduled bearing/slip carrier outside the failed
approach schedules and add one different mechanism: a bounded C-start-like
redirect. Only when normalized target distance is near, closing speed is
positive, and the bounded body-frame steering error is large does the policy
smoothly allocate part of the anterior oscillation envelope to a same-sign
mean bend shared with the existing posterior curvature. It retains a nonzero
traveling carrier during the maneuver. As closing stops or alignment improves,
the gate releases continuously back to the unchanged carrier; there is no
clocked mode, stored stage, global route, or target identity.

The next rollout should match the sampled controller through the far field,
then convert active body curvature into target-normal displacement before the
high-speed x crossing. Falsify the mechanism if it changes the trajectory
before the close/misaligned approach, collapses the coherent wake into the
near-static coasting seen in the damping sample, creates destructive joint
limits, fails to beat `2.960L`, or repeats the left-exit topology without a
meaningfully different corrective arc.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large observed direction error recruits a transient bounded whole-body bend, then measured alignment or loss of closing urgency releases back into rhythmic propulsion
transferable_invariant: preserve the traveling carrier for broad locomotion, but when observed normalized geometry shows an imminent misaligned pass, temporarily reallocate a bounded portion of rhythmic shape authority to active curvature and release from state response
nontransferable_details: published gains, species-specific C-start angles and timing, dimensional switch distances, exact vortex phases, clock phase, and task-specific routes
policy_translation: combine normalized distance, positive closing speed, bounded body-frame bearing-minus-slip error, and joint state into a smooth redirect gate; shift only the gated anterior oscillator center toward the requested bend, retain the posterior mean-curvature sign, and keep a nonzero joint-state carrier
falsification: reject if far-field propulsion changes, the redirect gate produces coasting or limit-heavy transients, target-normal miss does not improve below `2.960L`, or the same left exit persists without a distinct recovery trajectory
