# Candidate-specific wake diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled evaluations satisfy the frozen rollout contract: direct
uniform initialization in still water with `U_infinity=[0,0,0]`, no cylinders,
and no prewarm snapshot.  The combined keyframe sheets were inspected from
release to termination in both their top-down vorticity and oblique Lambda2
rows.  Motion is self-propelled rather than advected: every rollout develops an
alternating three-dimensional caudal wake, but every trajectory ultimately
hooks toward the upper virtual boundary.

The target-blind seed (`solver_36a38f7240b3`) is the informative failure.  Its
wake grows while the fish turns progressively upward, reaches only `12.078L`,
then regresses to `12.380L` and exits at `8.55T`.  Anterior useful-half-cycle
steering (`solver_8596fba5898a`) preserves that wake and improves minimum/final
distance to `11.782/11.797L`, whereas the sampled large-error posterior redirect
(`solver_307c6b5c665e`) reaches only `11.838L` and regresses to `12.054L`.
This retains the inherited negative result: moving large-error authority to the
posterior joint does not cure the route failure.

Slip-damped full-stroke rectification (`solver_882a60521f5f`) is a substantial
but incomplete improvement.  The top-down row shows a longer, regular
alternating vortex street and sustained leftward travel; the oblique row
confirms coherent three-dimensional caudal structures rather than a planar
rendering artifact.  Minimum and final distance both fall to `10.062L`, a
`2.265L` improvement from release, and the fish advances to
`(17.55,15.20)L`.  Yet it still exits upward at `11.20T` with a large wrong-side
target bearing: sampled body-frame bearing is about `-45 deg` at `7T`,
`-63 deg` at `9T`, and `-67 deg` at `11T`.  Joint-rate-cap occupancy also rises
to roughly `8/9%` for joints 1/2, compared with roughly `1.5/2.1%` for the
seed.  Thus rectification improved propulsive surge and sustained progress, but
did not establish a route controller; increasing its scalar authority would
also amplify an evidenced saturation cost.

The trace supplies a reusable estimator clue.  After subtracting a one-beat
moving average, the fast bearing residual is consistently anticorrelated with
anterior joint angle across all four rollouts (`r=-0.87` to `-0.92`), with a
residual slope of about `-0.33` to `-0.39` bearing radians per joint radian.
Using `bearing + 0.35*q1` therefore removes a repeatable proprioceptive
beat-phase component without a clock, route memory, or world coordinate.  It
does not manufacture a slow history that the observation adapter does not
provide.

## One candidate hypothesis

Preserve the strong rollout's zero-centered traveling-bend carrier and its
small-error, slip-damped rectification.  Drive both from the proprioceptively
demodulated body-frame route error.  When that error becomes large, smoothly
transfer authority away from the saturation-prone rectifier and toward a
bounded common mean-curvature setpoint for both joints.  Express the posterior
traveling-wave target around the same setpoint, so the redirect creates a
whole-body bend without discarding the inherited phase lag.  This is a new
feedback/actuation mechanism, not a scalar-only change to rectification.

The expected signature is continued targetward propulsion near the route, then
a correct-sign redirect before the fish reaches the upper margin.  Falsify the
candidate if the alternating 3D wake collapses, joint-rate saturation rises
above the rectified parent's roughly `8/9%`, closest approach does not beat
`10.062L`, or the fish retains the same upper-exit topology with large
wrong-side bearing.  A modest distance improvement with the same termination
would remain only partial support; a better termination class or a visibly
useful turn back into the virtual field is the intended semantic test.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and biological burst turning
source_mechanism: sensor-modulated rhythmic locomotion with error-gated mean-curvature redirection
transferable_invariant: separate repeatable beat-phase motion from persistent body-frame route error, then trade symmetric propulsive authority for bounded whole-body curvature only while the persistent error is large
nontransferable_details: published gains, dimensional frequencies, species-specific C-start envelopes, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: combine body-frame bearing with observed anterior joint angle to demodulate beat-scale error; retain slip-aware rectification near the route and smoothly replace it at large error with a bounded two-joint curvature setpoint around which posterior lag is preserved
falsification: reject if propulsion or the alternating wake collapses, rate-cap occupancy worsens, minimum distance fails to beat 10.062L, or large wrong-side bearing and the upper-boundary exit persist
