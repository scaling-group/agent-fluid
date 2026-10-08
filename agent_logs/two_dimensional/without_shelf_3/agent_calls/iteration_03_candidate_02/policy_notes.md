# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent preserves the target-blind seed's only reusable result:
  its state-encoded gait briefly propelled leftward, but without course
  feedback it followed the downward local-flow branch, touched both joint rate
  and acceleration caps, and exited after `50.13` released time. The inherited
  optimizer notes proposed positive bearing curvature, phase-radius
  regulation, and rate damping; their then-pending outcomes are now present in
  the sampled solver evidence.
- The shared prewarm sheet shows the fish held at the upper-right release pose
  while all four staggered-cylinder streets develop through the target
  corridor. This is common initial-condition evidence, not a policy effect.
  None of the released sheets reaches the target-centered cylinder region, so
  the current candidate is a far-field propulsion, course, and stability test.
- The `0.75`-period, `22 deg` position-only oscillator with positive bounded
  bearing curvature is the strongest finite trajectory. Its sheet shows active
  leftward travel with roughly constant vertical station before the body folds
  into a tight terminal turn. The head moves `(-3.59,+0.15)L`, range falls to
  `9.01L`, and mean x velocity is `-0.149` versus local-flow x `-0.077`, so the
  approach is not advection alone. The terminal geometry is not useful wake
  entry: both acceleration commands reach `31.416 rad/time^2`, joint one
  reaches the rate cap, RMS force/moment rise to `20024`/`314391`, and the
  rollout ends as `unstable_dynamics` at `33.06` time.
- The target-blind seed is the informative longer failure. Its sheet first
  shows diagonal self-propulsion, then a near-vertical lower-boundary escape.
  The transient `8.61L` minimum rebounds to `12.12L`; head displacement is
  `(-3.55,-13.30)L`, and mean y velocity `-0.263` nearly matches local-flow y
  `-0.241`. Its visible body wave therefore does not demonstrate wake
  rejection.
- The two sampled phase-radius-regulated descendants are stable and low-load
  but visibly drift down and right without useful body-wave translation. They
  never improve on the initial `12.4239L` range and exit with head x
  displacement `+2.24L` and `+2.27L`. Their mean relative-flow x values are
  only `-0.00324` and `+0.00170`, with RMS moments near `379` and `377`, versus
  active upstream relative motion and the load spike of the position-only
  candidate. Thus avoiding saturation by suppressing effective propulsion is
  not an improvement. Because period, amplitude, and steering terms also
  changed, this comparison does not prove the phase-radius term is the sole
  cause.
- An inherited bearing-window-rate candidate placed a high-gain negative
  steering center entirely on joint one; it reached `0.781 rad` joint angle
  and became unstable after `1.66` time with RMS force/moment
  `59346`/`608198`. The inherited notes also report other rate-augmented
  steering failures. Current evidence therefore does not support adding
  another bearing-rate, turn-rate, moment, or compound wake-load term before
  preserving and stabilizing the only active upstream gait.

## One candidate hypothesis

Return to the position-only self-excited oscillator that produced active
upstream motion, retain the empirically useful positive body-frame bearing
sign, and reduce its opportunity to fold the fish. Use a `0.80` period and
`20 deg` amplitude: nominal anterior harmonic speed and acceleration are about
`157 deg/time` and `1234 deg/time^2`, below the `260/1800` hard envelope while
remaining close to the progress-producing gait. Reduce the bearing gain and
curvature limit to `0.45` and `10 deg`, split mean curvature `35/65` across the
joints, and critically damp the posterior response so the initial down-left
attitude is not driven into the sampled large reorientation.

Own an action bound in the parameter object and apply a smooth shoulder only
above `85%` of a `1500 deg/time^2` limit. The shoulder is linear through the
nominal anterior harmonic but asymptotically prevents either joint from reaching the
evaluator's `1800 deg/time^2` clip after a wake-driven error. Do not add rate,
moment, coordinates, route, clock, or unavailable probe feedback in this
candidate; this isolates whether bounded position-only self-excitation can
retain propulsion without the sampled fold.

The next CFD rollout supports the hypothesis only if head x displacement and
mean relative-flow x remain negative, minimum/final range improve, and the
fish remains finite and in-domain beyond `33.06` time without hard cap contact
or a force/moment blow-up. It is falsified by the low-load downstream drift of
the phase-radius descendants, renewed folding/instability, the seed's steep
lower exit, or loss of useful propulsion. The new candidate is not evaluated
in this worker, so no improvement is claimed.
