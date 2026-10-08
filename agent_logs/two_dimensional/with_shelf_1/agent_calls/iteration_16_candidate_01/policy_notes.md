# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled solvers are behaviorally identical successes despite two
  source hashes that differ only in comments: target capture at `34.7105`,
  mean distance `1.62283L`, total/mean command energy `46985.9/1353.65`, and
  force/moment RMS `68.96/1036.40`. Both joints reach the `4.53786` speed cap
  and both commands reach the `30.0` policy envelope.
- The shared prewarm sheet shows the same developed, interacting four-cylinder
  streets surrounding the station while the held fish remains far upper-right.
  The released sheet shows a sharp targetward redirect followed by a coherent
  leftward traveling bend; the fish enters the interacting wake only on the
  final approach and reaches without a visible reversal or near-miss. The mean
  head motion `(-10.923,-4.166)L`, monotone minimum/final distance `0.74651L`,
  and success termination support that visual reading.
- No informative failure keyframe is present in the four sampled solver
  examples. The inherited quantitative contrast is therefore used only as a
  boundary: predictive bearing in persistent mean steering exited after
  `18.304` with negative progress, and replacing the successful carrier with a
  slower/smaller curvature carrier became unstable with force/moment RMS
  `16749.8/290421`. The current mean route and carrier must remain intact.
- The assigned parent and sampled inherited guidance show a four-iteration
  exact-result plateau. They also report that stacking previous-command
  pressure onto the coherent speed release preserved capture but worsened
  arrival (`35.1285`), mean distance (`1.64127L`), energy (`47457`),
  crossflow (`0.24265`), and force/moment RMS (`71.47/1078.27`) without
  removing limit contact. A new direct response cue should alter, rather than
  duplicate, the optional-burst release path.

## Policy hypothesis

Preserve the validated oscillator, posterior lag, raw-bearing mean steering,
course-slip correction, reserve allocation, base half-cycle asymmetry, and
coherent two-joint speed release. Add one bounded target-aligned lateral-force
response to the existing hydrodynamic assistance term. Because force is a fast
body response that can precede bearing closure, it should withdraw only the
extra redirect burst when the wake/body interaction is already pushing in the
requested turn direction; opposing force leaves all established authority.
Use `force_body_L[2]`, already normalized by body length, with an evidence-scale
soft saturation (`68.96 / 64 = 1.078` RMS in the sampled rollout). This is a
structural response cue, not a change to carrier gains.

bookshelf_consulted: true
source_domain: wake-interacting biological swimmers and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful hydrodynamic response by separating fast measured wake/body assistance from slow target-directed route steering
transferable_invariant: target geometry owns persistent steering, while a bounded fast body-frame response may release only surplus maneuver authority when it already assists the requested turn
nontransferable_details: published gains, species kinematics, prescribed CPG clocks, exact Karman phase, single-cylinder geometry, and task-specific routes
policy_translation: keep the two-joint traveling-bend carrier and mean steering unchanged; use the sign of body-frame bearing to admit normalized assisting lateral force into optional half-cycle-burst release only
falsification: reject if capture is lost, arrival or mean distance materially regresses, force/moment load does not fall, limit contact persists without another benefit, or a changed wake phase loses the coherent route

## Expected evaluation signature

Target reach and the redirect-to-leftward route topology should survive. Relative
to `34.7105 / 1.62283L / 46985.9 / 68.96 / 1036.40`, accept the mechanism only
if it produces a meaningful load or limit-contact reduction without a material
arrival, distance, or energy regression. The current worker cannot claim that
outcome because CFD evaluation occurs after exit.
