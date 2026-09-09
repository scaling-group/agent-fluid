# Multi-wake candidate diagnosis

## Visual and metric diagnosis

The shared prewarm sheet shows the common initial condition: the fish is held
near the upper-right boundary while four mature, interacting cylinder wakes
fill the long diagonal route to the second-row target. The released sheets
show active upstream swimming rather than passive advection, but none of the
sampled policies enters the useful wake corridor. Each direct-heading-rate
variant first travels leftward, then curls upward and leaves through the upper
domain boundary before turning down toward the target.

The sampled sequence isolates `turn_rate_damping` with the `0.90`-period gait,
posterior servo, `10 deg` positive bearing bias, `0.35` turn-rate scale, and
command ceiling fixed. Increasing gain from `0.35` to `0.70` improves head x
displacement from `-4.69L` to `-6.93L`, progress from `0.255` to `0.380`, mean
distance from `9.48L` to `8.03L`, closest approach from `7.30L` to `5.33L`,
and score from `-11.29` to `-9.53`. At gain `0.70`, mean head velocity
`-0.130` remains more upstream than mean local flow `-0.091`, confirming
self-propulsion. This is the strongest finite sampled controller.

The `1.05` continuation falsifies the expectation that enough bounded
counter-steering would break the loop. Its sheet retains the same topology and
nearly unchanged `+1.20L` center-y exit. Relative to `0.70`, it worsens head x
displacement to `-6.67L`, progress to `0.369`, mean distance to `8.16L`,
closest approach to `5.64L`, and score to `-9.69`, while RMS force/moment rise
from `325/3331` to `334/3463`. It does reduce maximum posterior angle from
`44.1 deg` to `42.0 deg` and maximum lateral target offset from `6.090L` to
`6.057L`, but both joint rates and both commands still hit their caps. Thus
stronger heading-rate damping has reached a local tradeoff, not solved lateral
turning or actuator saturation. The bearing-window-rate comparison is a
sharper negative boundary: it reaches only `7.90L` and progress `0.145`, so no
target-bearing-rate or second lateral feedback channel is justified here.

## Candidate policy hypothesis

Preserve the complete sampled gain-`0.70` controller and change only
`turn_rate_damping` to `0.80`. This brackets the observed finite maximum
between `0.70` and `1.05` close to the stronger endpoint's posterior-angle
relief, without crossing as deeply into its progress and load regression. The
change retains the upstream-capable oscillator, posterior-only steering,
positive bearing sign, normalized body-rate signal, fade, and command limit.

The falsifiable expectation is progress and closest approach at least near the
`0.70` result, with posterior angle below `44.1 deg` or lateral offset below
`6.090L`. The hypothesis fails if it repeats the upper exit without measurable
angle or lateral relief, or if upstream progress falls while loads rise. In
that case later workers should treat gain `0.70` as the local direct-rate
anchor and vary only turn-rate sensitivity or static posterior bias; they
should not increase damping beyond `1.05`, revive bearing-rate feedback, or
add body-lateral damping.
