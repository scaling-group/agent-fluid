# Multi-wake target-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the common initial condition rather than a
candidate advantage: the held fish begins near the upper-right boundary while
four developed, interacting cylinder wakes fill the approach to the
second-row target.  The released sheets for all four current samples show an
actively generated traveling bend and substantial upstream self-propulsion,
but no entry into the useful target wake.  Each fish first moves diagonally
toward the target, then straightens above it and curls sharply into the upper
boundary.  For the best gain-`0.70`, scale-`0.35` sample, mean head velocity x
is `-0.1300 L/time` versus mean local flow x `-0.0908`, so the `-6.93L` head-x
travel is not passive advection.  Its closest approach is `5.33L`, progress is
`0.380`, and center-y displacement at exit is still `+1.20L`.

The new samples close the inherited direct-heading-rate continuation.  At the
same `0.35` rate scale, raising damping from `0.70` to `0.80` reduces the
posterior peak only from `0.770` to `0.759 rad` and lowers RMS force/moment
from `325/3331` to `306/3151`, but regresses progress to `0.351`, closest
approach to `5.66L`, and upstream head travel to `-6.35L`.  Gain `1.05` also
retains the upper loop while regressing to `0.369` progress and raising loads
to `334/3463`.  Keeping gain `0.70` but lowering the rate scale from `0.35` to
`0.25` is worse again: progress `0.291`, closest approach `6.41L`, upstream
head travel `-5.30L`, and the same `+1.20L` center-y exit.  All four samples
still hit both joint-rate and candidate acceleration caps; their common peak
anterior angle is `0.669 rad`.  Thus neither a higher damping ceiling nor
earlier rate-feedback onset fixes the trajectory topology, and the original
`0.70/0.35` pair remains the finite anchor.

The assigned-parent guidance and inherited logs provide one complementary
directional boundary: weakening posterior target bias to `8 deg` lost most of
the upstream travel and worsened closest approach, whereas the positive
`10 deg` sign is the mechanism retained by every strong sample.  The evidence
therefore does not support weaker geometric steering, another turn-rate
tuning step, target-bearing-rate feedback, lateral-velocity feedback, or a
simultaneous propulsion retune.

## Single candidate hypothesis

Restore the complete best gain-`0.70`, rate-scale-`0.35` controller and change
only `bearing_scale` from `25 deg` to `20 deg`.  This increases the response to
small and moderate body-frame target bearing, where the released sheets show
the fish beginning a useful diagonal approach but failing to descend far
enough before the upper curl.  It leaves the bounded `10 deg` maximum bias,
the anterior oscillator, posterior lag, heading-rate ceiling, final-distance
fade, and acceleration ceiling unchanged.  Unlike increasing the bias limit,
the change cannot demand a larger saturated mean posterior bend; unlike the
failed rate variants, it changes geometric target authority rather than yaw
damping.

The candidate is supported only if it retains approximately the anchor's
upstream progress while producing a deeper targetward approach, a closest
distance below `5.33L`, or a later/non-upper exit without worse saturation or
loads.  Repetition of the `+1.20L` upper exit, reduced upstream travel, or load
growth without better target approach falsifies bearing sensitivity as the
missing mechanism.  Later workers should then restore `25 deg` and test a
single posterior-servo saturation repair rather than revive direct-rate-scale,
bearing-rate, lateral-rate, or globally weakened-gait changes.
