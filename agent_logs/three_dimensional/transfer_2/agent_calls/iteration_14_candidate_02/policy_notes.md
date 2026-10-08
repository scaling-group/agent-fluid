# Candidate diagnosis and hypothesis

The sampled evidence is direct-uniform still water (`U_infinity=0`) with no
prewarm or cylinders, and every sample terminates by capture.  Three repeated
rollouts of the prefilled course-preview policy are numerically identical:
capture at `24.5795T`, mean distance `2.36044L`, and final distance
`0.74697L`.  The top-down sheets show self-propulsion along a shallow curved
route, a coherent alternating wake rather than passive advection, and a late
target-directed bend that reaches the capture sphere from below.  The oblique
Lambda2 row confirms coherent three-dimensional structures remain attached to
the traveling posterior wave through the approach; there is no release-time
wake artifact.  The weaker sampled policy is not a failed termination but is
the most informative contrast: its predictive posterior stroke guard retains
the same wake and capture topology at `24.5960T` while changing the terminal
joint/load history.

The inherited optimizer score logs independently preserve capture across the
three subsequent recorded descendants, with terminal distances
`0.74858--0.74984L` and scores `-0.46428--0.46227`.  They establish that the
new semantic class survives later controller refinements, while the sampled
trajectories provide the mechanism and load evidence used below.

Cross-checking the trajectories shows that the predictive guard reduces time
with either joint at the `45 deg` hard angle from `23.38%` to `12.63%` and
reduces peak planar force coefficient from `0.3228` to `0.1543` and peak yaw
moment coefficient from `0.1426` to `0.0667`.  It costs only `0.0165T` and
`0.00159` score, but raw commands still exceed the `1800 deg/T^2` envelope on
`72.74%` of samples and reach `6473 deg/T^2`.  The maximum is an anterior
carrier command while that joint is already at its rate limit, so a
posterior-only guard cannot close the remaining safety gap.

The candidate hypothesis is therefore a single actuator-envelope mechanism:
retain the sampled predictive stopping-stroke guard, then project both final
joint commands onto the owned acceleration envelope.  Under the frozen
downstream integrator this projection should preserve the guarded rollout's
applied accelerations, coherent wake, and capture, because the episode already
performs the same hard acceleration clamp.  It should additionally make the
public policy bounded, reduce raw command-envelope exposure to zero, and keep
direct policy consumers from receiving impossible accelerations.  This is not
a propulsion or steering gain change.

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual control under a physical actuator envelope
source_mechanism: bounded residual steering around a state-feedback rhythmic carrier
transferable_invariant: preserve the useful traveling-wave carrier while constraining the composed two-joint command to available actuator authority
nontransferable_details: published CPG gains, species-specific envelopes, dimensional beat settings, exact wake phase, and task-specific routes
policy_translation: use normalized body-frame feedback already present in the successful controller, anticipate posterior stopping stroke from joint state, and project both composed accelerations with the parameter-owned symmetric limit
falsification: reject if capture or trajectory changes beyond numerical tolerance under the frozen evaluator, raw command exceedance remains nonzero, hard-angle exposure rises above the guarded sample, or the coherent alternating wake degrades
