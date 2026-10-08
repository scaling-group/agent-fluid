# Candidate diagnosis and hypothesis

## Inherited evidence

- The sole sampled rollout is a direct-uniform, still-water L64 evaluation of
  the assigned parent (`score=-11.170165`, `termination=left_domain`).  There
  is no inherited optimizer log or second sampled solver to claim as a
  comparison; the useful finite segment and the later failure segment of this
  rollout are therefore kept distinct below.
- Both visual rows show genuine self-propulsion rather than advection: the
  top-down sheet develops a strong alternating wake and the oblique Lambda2
  sheet shows coherent three-dimensional shed structures.  The fish reduces
  head-to-target distance from `12.3277L` to `4.7800L` by `t=17.853T`.
- The same sheets show the failure topology clearly.  The body and wake rotate
  into an increasingly downward path, cross below the target, and continue
  toward the lower virtual boundary.  Distance rises to `9.7089L`, and the
  episode exits at `t=27.495T` with center `(12.1870, 0.7982)L`.
- The target stays on the positive body-lateral side during the failed late
  approach (cycle-resolved bearing is positive, about `0.26--0.37` rad), but
  the parent maps its negative turn request through a negative curvature gain
  to a positive mean tail tangent.  Across late tailbeat bins the measured
  mean `phi1+phi2` is predominantly positive (roughly `6--15 deg`) while the
  cycle-mean body angle grows from about `0.5` to `1.5` rad and the course turns
  farther downward.  This is evidence of a steering-polarity mismatch, not a
  missing propulsive gait.
- Short-history bearing-rate and turn-rate terms range roughly `-1.93..1.86`
  and `-3.00..3.14` per T at the within-beat sampling window, repeatedly
  saturating the parent's rate correction.  Requested joint accelerations also
  exceed the configured `1800 deg/T^2` cap on about 71%/77% of samples.  These
  derivative branches are not clean evidence of slow route error in this
  rollout, so the candidate will not use them to select mean curvature.

## Policy hypothesis

Preserve the parent's state-feedback anterior oscillator and lagged posterior
traveling bend, because they generated the only demonstrated useful mechanism:
stable thrust and a coherent 3D wake.  Replace the multi-branch derivative,
recovery, direct-acceleration, and half-cycle steering stack with one bounded
mean-tail-curvature command computed from normalized body-frame bearing and
target-vector angle.  Calibrate its sign from this rollout: positive lateral
target error must request negative mean tail tangent, opposing the observed
positive-bend/downward-turn association.  Retain continuous near-target
curvature relief, although the inherited rollout never entered that regime.

Falsification: reject the transfer if the next rollout loses the coherent
propulsive wake or early distance reduction, if positive body-frame target
error still produces growing positive cycle-mean heading, or if it retains the
same below-target/lower-boundary exit topology.  A closer approach alone is
not sufficient if the trajectory becomes unstable or actuation saturation
materially worsens.

bookshelf_consulted: true
source_domain: robotic-fish turning with asymmetric rhythmic actuation, interpreted through classical traveling-wave propulsion
source_mechanism: bounded target-directed mean-curvature bias layered on a posterior-lagged propulsive bend
transferable_invariant: preserve the traveling wave for thrust and change its cycle-mean signed curvature according to persistent body-frame target error
nontransferable_details: published gains, species-specific envelopes, clock-driven CPG phase, exact tailbeat asymmetry, and task-specific routes
policy_translation: map normalized body-frame bearing and target-vector angle to one bounded mean tail tangent with rollout-calibrated polarity; retain the joint-state oscillator and posterior lag
falsification: the mechanism fails if correct-sign body-frame error does not reverse the late cycle-mean yaw trend, if propulsion collapses, or if the same lower-boundary exit persists
