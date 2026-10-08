# Multi-wake target-policy candidate notes

## Evidence diagnosis

The common prewarm sheet shows the held fish near the upper-right boundary,
already roughly pointed toward the target, while four mature cylinder streets
fill the long approach.  The released sheets show active upstream swimming,
not passive advection: the best sampled controller's mean head velocity is
`-0.130 L/time` while its mean local flow is only `-0.091`, and it travels
`-6.93L` in x.  Nevertheless, no sample enters the target's second-row wake
corridor.  Each moves left or down-left, straightens while still well above the
target, and then curls sharply upward immediately before leaving the domain.
The best case therefore approaches to only `5.33L` and finishes at `7.71L`.

The current four samples complete the direct-heading-rate sweep around the
inherited `0.90`-period gait, `10 deg` posterior steering limit, and `0.35`
turn-rate scale.  Gain `0.70` remains best: upstream head travel `-6.93L`,
progress `0.380`, mean distance `8.03L`, and minimum distance `5.33L`.
Increasing gain to `0.80` or `1.05` preserves the upper-exit topology and
regresses progress to `0.351` or `0.369`.  At `1.05`, force/moment also rise
from `325/3331` to `334/3463`.  The assigned parent's isolated sensitivity
test is more strongly negative: lowering only the scale from `0.35` to `0.25`
at gain `0.70` retains the same approximately `+1.20L` center-y upper exit,
but upstream travel falls to `-5.30L`, progress to `0.291`, mean distance rises
to `9.02L`, and closest approach worsens to `6.41L`.  Direct-rate gain and
sensitivity tuning have therefore reached their evidence boundary.

Inherited logs also rule out global bias reduction, bearing-rate feedback,
body-lateral-rate feedback, anterior steering, and a globally weakened gait.
In particular, changing the static bias from `10` to `8 deg` throughout the
rollout collapses progress to `0.095` while preserving the upper exit.  The
next mechanism must therefore preserve the best controller while it is
closing and intervene only in the visible late receding/off-axis state.

## Single candidate hypothesis

Restore the evidence-best `turn_rate_scale=0.35`, gain `0.70`, and complete
propulsion/posterior servo.  Add one bounded late-recovery term formed from
the history-window closing speed and current bearing.  A smooth receding gate
is zero unless `state.window_closing_speed_L < -0.01`; a smooth off-axis gate
is small near zero bearing.  Their product subtracts at most `1.20` times the
same-sign bearing request.  Thus the early approach is exactly the best
sampled controller while distance is closing, but after a sustained miss the
bearing contribution can be cancelled or slightly reversed and the retained
heading-rate damper can unload the posterior bend.  The signal is normalized,
body-frame, history-smoothed, and contains no coordinates, time, target-
bearing rate, body-lateral rate, anterior action, or global gait weakening.

The hypothesis is supported only if the next CFD rollout retains approximately
the best case's upstream approach while avoiding the `+1.20L` upper exit,
extending release survival beyond `55.38`, or improving on the `5.33L` closest
approach.  It is falsified if the receding gate disrupts early propulsion,
causes rapid switching/downstream escape, raises loads beyond the `1.05` case,
or repeats the same upper loop.  In that event later workers should remove the
distance-trend recovery rather than increase its gain or shorten its window,
and test a differently observed posterior-only recovery mechanism.
