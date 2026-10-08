# Candidate wake-policy notes

## Evidence diagnosis

The shared prewarm sheet establishes the common initial condition: the held
fish is near the upper-right boundary, well downstream and above the target,
while four developed cylinder streets fill the approach. In the released
sheets the clean posterior-only heading-rate sequence is self-propelled rather
than passively advected: at gains `0.35`, `0.70`, and `1.05`, mean upstream
fish speeds are `0.0878`, `0.1300`, and `0.1252 L/time`, all larger in
magnitude than their mean upstream local flows (`0.0587`, `0.0908`, and
`0.0911`). None enters the useful second-row wake or turns down toward the
target; each makes the same broad upper loop and exits the top boundary after
about `+1.20L` center displacement.

Gain `0.70` remains the strongest finite sample: progress `0.3796`, mean
distance `8.026L`, closest approach `5.334L`, and upstream head displacement
`-6.934L`. Raising only the gain to `1.05` falsifies the inherited hypothesis
that allowing counter-steering would brake the loop. The keyframes preserve
the same trajectory topology, while progress falls to `0.3686`, mean distance
rises to `8.159L`, closest approach worsens to `5.644L`, and upstream head
travel falls to `-6.673L`. RMS force/moment also rise from `325/3331` to
`334/3463`, despite posterior peak angle falling from `0.770` to `0.734 rad`.
Both candidates still hit both rate and command limits. This is evidence
against increasing the feedback ceiling beyond `0.70`, not against direct
heading-rate feedback itself: gains `0.35 -> 0.70` had improved progress
`0.255 -> 0.380` with the same gait. The sampled bearing-rate variant is not a
fallback; it managed only `0.145` progress and a `7.904L` closest approach.

## Policy hypothesis

Return to the evidence-best `turn_rate_damping=0.70` and change only
`turn_rate_scale` from `0.35` to `0.25`. The lower normalization scale makes
the same bounded damping ceiling engage at a smaller body rotation rate, while
the `0.70` ceiling cannot reverse a saturated positive bearing request. This
isolates whether earlier braking can retain the strong upstream gait while
reducing the initial rise, without repeating the unsupported stronger-gain or
bearing-rate mechanisms.

The candidate is supported only if it preserves approximately the `0.70`
case's upstream progress and bends away from the upper boundary before the
prior exit. An unchanged `+1.20L` upper exit, progress below `0.380`, closest
approach above `5.334L`, or loads above `325/3331` falsifies the sensitivity
continuation. Later workers should then restore scale `0.35` and test a
different single posterior-steering mechanism rather than further lowering
the scale or raising the damping gain.
