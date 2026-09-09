# Multi-wake target-policy candidate notes

## Evidence diagnosis recorded before the policy edit

- The shared prewarm sheet shows the same held fish at the upper-right release
  pose while four staggered vortex streets develop through the target corridor.
  It is a common initial condition, not evidence for any controller.
- The target-blind seed is the stable finite failure: it briefly reaches
  `8.61495L` range but is carried into a near-vertical descent and exits after
  `50.1269` released time. Its head displacement `(-3.545,-13.300)L`, fish
  velocity `(-0.0725,-0.2633)`, and local flow `(-0.0414,-0.2414)` show little
  upstream or lateral motion relative to the wake. Both joint velocities and
  accelerations touch their hard caps, so more oscillator drive is not a
  supported drift remedy.
- The current prefilled negative-bearing controller is the most acute failure:
  its bearing-window-rate term accompanies instability after only `1.6603`,
  essentially zero progress, and RMS force/moment `59345.5/608198` even though
  its recorded accelerations remain below the hard cap. It provides no support
  for carrying a target-bearing rate term into the next candidate.
- The assigned parent's negative-bearing, heading-rate-damped curvature also
  fails this mechanism test: it exits downward after `32.9673`, moves
  `(+0.983,-13.246)L`, regresses to `-0.2469` progress, and again touches both
  acceleration caps. The other negative-bearing sample exits downstream/right
  after `15.8619` with `-0.1702` progress. Thus neither added negative curvature
  nor its rate/moment damping variants convert the seed gait into target travel.
- The positive-bearing curvature sample is the best-progress finite segment.
  Its keyframes show an initial turn followed by sustained leftward travel,
  rather than the seed and parent controllers' downward escape. Metrics agree:
  head displacement is `(-3.593,+0.146)L`, mean fish velocity x is `-0.149`
  against local-flow x `-0.0774`, and progress reaches `0.25895` with mean/final
  distance `9.486/9.207L`. This supports its cumulative-curvature sign for
  early far-field course correction, although it has not yet entered the tight
  target neighborhood.
- That same sample is not a viable incumbent: at `33.0573` it folds sharply in
  the final keyframe and terminates as `unstable_dynamics`; both accelerations
  hit `31.4159`, joint-one velocity hits `4.53786`, and RMS force/moment rise to
  `20023.6/314391`. Its position-only Van der Pol drive therefore does not keep
  the demonstrated steering trajectory inside the load and actuation envelope.
- A radial-energy sample with a negative steering sign does not make target
  progress, but it supplies a narrower gait-control observation: before its
  domain exit its joint accelerations remain below `21.85`, joint velocities
  below `3.04`, and RMS force/moment are only `21.13/430.3`. This does not prove
  navigation quality; it supports testing radial amplitude regulation while
  changing only the evidence-backed steering sign.

## Single candidate hypothesis

Use the positive cumulative-curvature convention of the best-progress sample,
driven only by bounded body-frame bearing, but reduce its limit and small-error
gain so downward target displacement is not over-corrected into horizontal or
upward travel. Remove bearing-rate, heading-rate, and moment terms because the
sampled variants containing those terms did not establish a stabilizing target
effect.

Around that slowly moving steering center, regulate the joint-one oscillator by
normalized phase radius instead of position alone. A `0.9` period and `18 deg`
amplitude give nominal harmonic velocity and acceleration near `126 deg/time`
and `880 deg/time^2`, leaving margin below the `260/1800` envelope. Retain a
damped posterior phase lag and split the mean curvature `35/65` across the two
joints so the observed traveling bend remains available for propulsion.

The next CFD rollout supports this candidate only if it preserves negative-x
motion relative to local flow, avoids the early downward/right exits, remains
finite beyond the prior `33.06`-unit positive-steering rollout, and materially
reduces cap contact and load spikes. It is falsified by renewed instability,
loss of upstream progress, or lateral error that keeps growing even when the
bearing command is unsaturated; capture is not claimed before that evaluation.
