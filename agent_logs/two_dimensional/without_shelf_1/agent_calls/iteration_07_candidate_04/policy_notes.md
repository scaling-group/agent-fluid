# Multi-wake target-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet establishes the common initial condition: the held
fish begins near the upper-right boundary, already approximately aimed at the
target, while the four developed cylinder streets occupy the long approach.
The released sheets show self-propulsion rather than passive wake advection,
but no sampled controller enters the target's second-row wake corridor. Each
first travels down-left or left, straightens above the target, and then curls
sharply upward immediately before the upper-domain exit.

The clean direct-heading-rate sweep preserves the same `0.90`-period gait,
`10 deg` posterior bias, `0.35` turn-rate scale, and `1650 deg/time^2` command
ceiling. Increasing damping gain from `0.35` to `0.70` improves upstream head
travel from `-4.69L` to `-6.93L`, closest approach from `7.30L` to `5.33L`,
progress from `0.255` to `0.380`, and mean distance from `9.48L` to `8.03L`.
The best case's mean head velocity (`-0.130`) also exceeds its mean local-flow
contribution (`-0.091`), confirming useful propulsion. It does not correct the
lateral failure: both gains end at about `+1.80L` head-y displacement and
`+1.20L` center-y displacement, while both joint rates and commands reach
their caps. The `0.70` case also raises RMS force/moment to `325/3331`.

Two inherited step-6 results set the next boundaries. Increasing only the
damping gain to `1.05` retains the same upper-loop exit and slightly worsens
upstream head travel (`-6.67L`), closest approach (`5.64L`), progress (`0.369`),
mean distance (`8.16L`), release survival (`54.76`), and RMS load (`334/3463`)
relative to gain `0.70`. Reducing only the static bias to `8 deg` is strongly
negative: it still exits upward, but head travel collapses to `-2.19L`, closest
approach worsens to `8.22L`, progress falls to `0.095`, and release survival
falls to `51.49`. Thus neither more maximum damping nor less static posterior
bias survives the evidence. The bearing-window-rate case is also worse
(`7.90L` closest approach and `0.145` progress), so target-vector-rate or an
additional lateral-rate channel should not be revived.

## Single candidate hypothesis

Restore the complete best `0.70`/`10 deg` controller and vary only the direct
turn-rate sensitivity scale from `0.35` to `0.25`. Around zero heading rate,
this changes the normalized damping slope from `0.70/0.35 = 2.0` to
`0.70/0.25 = 2.8`, close to the `1.05/0.35 = 3.0` slope of the inherited
comparison. Unlike gain `1.05`, however, the damping contribution remains
bounded at `0.70`, so a saturated target-bearing request retains at least
`0.30` of its sign and cannot be reversed by the rate term. This isolates
earlier yaw arrest from the already negative increase in maximum damping.

The falsifiable expectation is retention of the `0.70` case's strong upstream
self-propulsion with a later or smaller final upward curl, lower posterior
angle/rate occupancy, and survival or closest approach better than `55.38`
and `5.33L`. If it instead reproduces the upper exit or trends toward the
`1.05` load/score regression, later workers should restore scale `0.35` and
stop tuning direct-rate gain or sensitivity; the missing mechanism would then
need to reverse the late off-axis state without bearing-rate or globally
weakened-gait feedback.
