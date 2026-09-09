# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish is
above and downstream of the target while the four asymmetric cylinder streets
are already developed.  The released sheets for the best scalar sample
(`solver_dbfcc8041ceb`) and the closest sampled miss
(`solver_3070af40c7fc`) show the same topology.  Each fish actively propels
upstream through the disturbed flow, stays above the second-row target
corridor, then bends into a broad upward hook; an almost vertical fish crossing
the top boundary immediately precedes `left_domain`.  Active propulsion is
confirmed by mean head velocities `-0.171/-0.174`, more negative than mean
local x-flow `-0.119/-0.123`, and head travel `-11.33L/-12.28L`.

The `0.35` posterior phase-headroom anchor is still the best balanced finite
sample: score `-7.595`, mean/final distance `6.44L/6.00L`, progress `0.517`,
and `3.03L` closest approach.  Raising its boost to `0.50` reaches `2.13L` and
travels farther upstream, but retains `+1.78L` head-y drift, the upper hook,
both joint rate/command caps, and raises RMS force/moment from `511/5305` to
`535/5416`.  The inherited `0.55` result is sharply worse (`5.70L` closest,
`0.206` progress, `-3.89L` head-x travel, and `518/5969` loads), so further
boost increases are not a reliable approach gradient.  A `42 deg` posterior
target clamp is also a concrete negative result: although it lowers posterior
excursion and RMS loads, it destroys propulsion (`-1.89L` head-x travel,
`8.21L` closest, and `0.074` progress) while preserving `+1.78L` upper exit.
The sampled receding, forward-sign, and one-sided behind-target gates likewise
retain about `+1.77--1.80L` head-y exit while regressing the `0.35` anchor.
Earlier inherited lateral-velocity and yaw-moment feedback failed the same
route criterion, so neither is revived.

The policy code exposes a structural source of late authority not isolated by
those tests: `bearing` divides lateral target offset by the absolute forward
separation.  Its magnitude therefore grows as the fish closes streamwise even
when lateral error is not improving, and it deliberately loses the fore/aft
quadrant.  This agrees with the sheets: useful early upstream motion is
followed by an increasingly curved pass and terminal hook.  The diagnostics
also show maximum absolute lateral target offset near `6L` for every sample,
while the current bearing-based variants all reach the same limits.

## Single candidate hypothesis

Restore the complete `0.35` phase-headroom anchor and remove the sampled
behind-target reversal.  Change only its geometric steering drive from scaled
bearing to a bounded normalized body-lateral target error,
`tanh(lateral_distance_L / 5L)`.  The positive bearing-to-posterior sign,
anterior oscillator, traveling-wave lag, heading-rate damping, capture fade,
and command ceiling remain unchanged.  The `5L` scale gives the observed
roughly `6L` terminal lateral offset bounded authority without automatically
increasing it merely because forward separation has collapsed.  It is
target-relative and body-frame normalized, with no global coordinate, elapsed
time, target identity, or encoded route.

The next CFD result supports this hypothesis only if it preserves approximately
the anchor's `-11.33L` upstream leg and `0.517` progress while reducing the
upper hook/head-y displacement and improving either the `3.03L` closest
approach or the rate/command/load pattern.  It is falsified if upstream travel
collapses, the exit remains near `+1.7--1.8L`, or the fixed lateral-error drive
merely trades bearing saturation for persistent lateral error.  In that case
later workers should restore the plain `0.35` bearing anchor and distrust
memoryless lateral-position steering as a route repair.
