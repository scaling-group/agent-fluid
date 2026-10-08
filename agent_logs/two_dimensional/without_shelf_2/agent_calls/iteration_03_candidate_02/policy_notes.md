# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

The assigned parent guidance treats the target-blind `0.55`-period gait as a
negative saturation anchor, and its inherited logs add two useful boundaries:
weak `1.05`-period oscillators were swept out before steering could matter,
whereas an unbounded moving-center controller coupled to raw heading rate became
unstable almost immediately. The current samples confirm both boundaries and,
crucially, include one completed target-reaching rollout.

The common prewarm sheet shows the fish held above and downstream of four fully
developed, interacting vortex streets, with the target in the second-row wake
overlap. Because this sheet is identical across candidates, it establishes only
the shared release condition; it does not justify a memorized route or phase.

In the successful released sheet, the `0.75`-period, `22 deg` energy-regulated
gait visibly produces sustained alternating body bends and upstream motion. The
fish traverses the downstream wake, makes a broad excursion below the target,
then turns back and reaches the `0.75L` circle from the right. This is active
self-propulsion rather than favorable advection: over `130.23` release units its
center moves `(-10.872,-4.712)L`, while mean velocity is
`(-0.0835,-0.0362)` and mean local flow is only `(-0.0455,-0.0508)`. It reaches
the target with `0.9397` progress and mean/final distance `3.516/0.750L`.
Its finite loads (`26.34` RMS lateral force, `427.54` RMS moment), joint speeds
(`3.220/3.184 rad/time` maxima), and angles (`0.523/0.423 rad` maxima) distinguish
it from numerical failure, although both acceleration commands touch the
candidate's `28 rad/time^2` guard. The visible loop and `5.425L` maximum lateral
target offset leave room to improve route efficiency without changing the
propulsive mechanism.

The failures show what should not be traded for that improvement. The
target-blind seed bends vigorously but swims `13.30L` downward and exits after
`50.13` units, with both hard velocity and acceleration caps active, mean
command energy `1496.25`, and RMS moment `541.70`. The prefilled slow controller
barely bends, is advected `+2.20L` downstream, and exits after `16.73` units;
its mean command energy is only `0.218`, maximum anterior acceleration only
`1.09 rad/time^2`, and progress is `-0.148`. The aggressive `0.82`-period,
`30 deg` candidate deforms violently in the second frame and terminates as
`unstable_dynamics` after `4.45` units; its anterior speed reaches the hard cap,
relative crossflow RMS is `3.139`, and force/moment RMS explode to
`5.50e4/5.68e5`. Thus neither slower startup, a larger gait, sign reversal, nor
raw turn-rate coupling is supported as the next refinement.

## One candidate hypothesis

Retain the successful energy-regulated oscillator, posterior phase lag,
amplitude, period, damping, and `28 rad/time^2` candidate-side burst guard.
Increase only the smooth positive-bearing steering response from gain/limit
`0.55/8 deg` to `0.70/10 deg`. This preserves the empirically successful sign
and keeps the nominal anterior excursion near `22 + 10 = 32 deg`, below the
`45 deg` joint envelope, while giving the target-relative feedback about
20--27 percent more curvature at representative bearing errors. No flow,
force, heading-rate, clock, coordinate, or route signal is added.

The falsifiable expectation for later CFD is the same upstream gait and finite
load regime, but an earlier reversal of the broad below-target excursion,
smaller lateral target offset, lower mean distance or earlier capture than
`130.23`, and continued target reach. Reject the refinement if it loses capture,
creates persistent action clipping, pushes joint angle or speed toward the hard
envelope, or raises force/moment toward the sampled instability; in that case
the successful `0.55/8 deg` steering pair is the evidence-backed fallback.
