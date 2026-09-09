# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

The shared prewarm sheet is common initial-condition evidence: the held fish is
near the upper-right boundary while four developed cylinder streets fill the
route to the target behind the second row. The released sheets show active
self-propulsion rather than passive wake advection. In the strongest sampled
run, mean head velocity is `-0.141 L/time` while mean local flow is
`-0.099 L/time`; the fish travels `-7.89L` upstream. Nevertheless, all sampled
controllers remain above the useful target corridor, curl sharply upward, and
exit the top boundary after about `+1.79L` head-y displacement.

The static `10 deg`, direct-body-rate `0.70/0.35` controller is the finite
anchor: progress `0.380`, closest approach `5.33L`, upstream head travel
`-6.93L`, and RMS force/moment `325/3331`. Increasing bias to `11 deg` improves
progress to `0.424` and closest approach to `4.87L`, but leaves the upper exit
unchanged, raises posterior peak angle from `0.770` to `0.781 rad` (within
`0.005 rad` of the hard limit), and raises loads to `406/4113`. The sampled
`20 deg` bearing scale and direct-rate variants `0.80/0.35`, `1.05/0.35`, and
`0.70/0.25` all lose approach while retaining the same upper loop.

Inherited optimizer results now falsify the assigned parent's proposed
preemptive phase-allocation branch. Attenuating steering by up to `35%` when
the nominal posterior traveling-wave component aligned with the bearing
request regressed progress from `0.380` to `0.250`, closest approach from
`5.33L` to `6.88L`, and upstream travel from `-6.93L` to `-4.59L`; the head-y
exit remained `+1.78L`. A separate `32 deg` nominal-target headroom gate was
more destructive: progress `0.035`, closest approach `8.94L`, upstream travel
`-1.33L`, and the same `+1.80L` head-y exit. Its lower loads (`161/1861`) came
from suppressing useful propulsion, not from repairing the route. Together
with the earlier global `8 deg` result, these runs show that reducing the
posterior request before an actual joint-boundary event behaves like global
gait weakening.

## Single candidate hypothesis

Restore the complete `10 deg`, `25 deg`, `0.70/0.35` anchor and preserve its
static posterior steering request. Add one symmetric, state-local posterior
soft stop: between measured posterior angles `40 deg` and `45 deg`, blend the
ordinary servo acceleration toward bounded inward braking only while the joint
is moving farther outward. Inward motion immediately restores the original
servo. This differs from both failed phase gates because it does not infer
headroom from the nominal gait target or attenuate steering throughout a
reinforcing half-cycle; it acts only on an observed near-boundary state.

The candidate is supported if it retains upstream progress near the anchor
while reducing the `0.770 rad` posterior peak, rate/command-cap contact, loads,
or late upper curl and improves on `5.33L` closest approach or `55.38` release
survival. It is falsified if the soft stop again loses substantial upstream
travel, or if the fish repeats the `+1.8L` upper exit without lowering
posterior saturation. Later workers should then restore the static anchor and
avoid further phase/headroom attenuation; the remaining steering repair must
preserve the posterior waveform rather than suppress it.
