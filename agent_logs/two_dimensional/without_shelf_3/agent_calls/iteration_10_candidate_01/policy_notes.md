# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish at the common upper-right release
  pose after the four staggered cylinder streets have developed and overlapped
  around the target. This is identical initial-condition evidence for every
  policy, not a candidate-specific effect. None of the compared released sheets
  reaches the cylinder/target corridor, so the present problem is still
  far-field propulsion and course retention rather than wake capture.
- The strongest finite sample remains the guarded angle-only oscillator with
  bearing gain `0.60`, steering ceiling `12 deg`, opposing recent-turn gain
  `0.04`, and anterior steering fraction `0.35`. Its sheet shows a sustained
  nearly horizontal upstream leg through the middle frames, followed by an
  upward pitch and broad upper return. Head travel `(-4.08,+1.80)L`, minimum
  range `6.71L`, progress `0.217`, and mean x velocity/local flow
  `-0.0673/-0.0457` confirm active propulsion rather than passive advection.
  RMS force/moment remain finite at `66.5/958`.
- The assigned parent's bounded body-lateral-velocity correction does not cure
  that topology. Its sheet turns upward after a visibly shorter leftward leg
  and repeats the upper exit; head-x travel falls to `-2.72L`, minimum range
  worsens to `8.20L`, and progress falls to `0.129`. RMS force/moment rise to
  `78.6/1084`, while anterior peak speed rises from `4.361` to `4.453 rad/time`.
  The correction therefore perturbed the progress gait and triggered the same
  turn earlier instead of rejecting a flow-driven lateral disturbance.
- Inherited controlled results close the remaining scalar turn-damping
  interpolation. Gains `0.0425` and `0.045` shortened the upstream leg, and the
  evaluated `0.0375` sample also visibly makes the upper turn early: it moves
  only `-0.63L` upstream, reaches `9.92L`, has progress `-0.014`, and exits after
  `51.55` time. Together with the failed `10/14 deg` ceiling variants and the
  failed absolute-bearing rolloff, this evidence does not support another
  steering-magnitude, turn-rate-gain, or additive motion-damping change.
- The anchor's joint diagnostics identify an orthogonal allocation axis. Peak
  anterior angle/speed are `0.568 rad` (`32.6 deg`) and `4.361 rad/time`
  (`249.9 deg/time`), close to the `34 deg` guard and `260 deg/time` hard cap;
  the posterior joint peaks at only `0.453 rad` (`25.9 deg`) and
  `3.337 rad/time` (`191.2 deg/time`). The latest additive feedback increased
  the already larger anterior rate and loads. The anterior oscillator therefore
  has less demonstrated margin for steering bias than the posterior joint.

## One candidate hypothesis

Restore the strongest finite controller exactly and change only
`anterior_steering_fraction` from `0.35` to `0.25`. At the `12 deg` steering
ceiling this transfers at most `1.2 deg` of mean target-relative bias from the
near-guard anterior oscillator to the posterior joint, which has roughly
`8 deg` more observed angle margin. Because anterior and posterior fractions
still sum to one, the bounded bearing law, total requested mean curvature,
turn-rate damping, oscillator, phase lag, local guards, and acceleration bound
remain unchanged. The intended effect is to reduce interference between
course bias and the progress-producing anterior limit cycle while retaining
target-relative steering through posterior curvature.

This isolated allocation test is supported only if it remains finite, preserves
or improves the anchor's `-4.08L` upstream travel and `6.71L` closest approach,
delays the upper turn, and reduces anterior rate/guard engagement without merely
moving saturation or load to joint two. It is falsified by an earlier upper or
lower return, materially worse progress, posterior cap contact, or higher
force/moment extrema. The candidate uses no coordinates, clock, route,
prescribed inflow, remote wake probe, target-station flow, or omitted research
shelf, and no outcome is claimed before its later CFD evaluation.
