# Multi-wake target-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet is a common initial condition: the held fish starts
near the upper-right boundary, above and downstream of four developed,
interacting cylinder streets, while the target lies in the second-row wake
corridor. It does not distinguish candidates.

The released keyframes show active self-propulsion rather than passive
advection, but all four current samples retain the same failure topology. The
fish travels diagonally upstream toward the target, straightens while still
several body lengths away, then makes a broad turn toward the upper boundary
without entering the useful near-target wake. The strongest finite sample is
the static `11 deg` posterior-bias policy: mean head velocity is
`-0.141L/time` versus mean local flow `-0.099L/time`, head travel is `-7.89L`,
progress is `0.424`, and closest approach is `4.87L`. It nevertheless exits
after `57.93` release units with center-y displacement `+1.20L`, posterior
angle `0.781 rad` (about `0.005 rad` below the hard limit), both joint rates at
`4.538 rad/time`, both commands at `28.798 rad/time^2`, and RMS force/moment
`406/4113`. Relative to the prefilled static `10 deg` policy, the extra degree
improves progress (`0.380 -> 0.424`) and closest approach (`5.33L -> 4.87L`)
but increases RMS loads from `325/3331`; it is a stronger approach mechanism,
not a loop or saturation repair.

The two current repairs are negative controls. Reducing the whole bounded
steering command to a `0.70` floor as distance falls through `6.0L` improves
neither topology nor saturation: it exits with the same `+1.20L` center-y
drift and both rate/command caps, while progress falls to `0.393` and mean
distance worsens from `7.52L` to `7.85L` relative to static `11 deg`.
Likewise, a measured posterior soft stop on the `10 deg` anchor fails to lower
peak posterior angle (`0.772` versus `0.770 rad`), retains every rate/command
cap and the upper exit, and worsens closest approach to `5.77L`. Inherited
optimizer logs give a stronger boundary: a
phase/headroom gate reduced posterior peak to `0.698 rad` and loads to
`161/1861`, but collapsed progress to `0.035`, closest approach to `8.94L`,
and upstream head travel to `-1.33L`. The current distance and inherited phase
gates both multiply a command in which target-bearing drive and direct
body-rate damping have already been combined, so their attenuation also
removes the braking term that should arrest the visible curl.

The state contract exposes a task-general geometric discriminator that those
repairs did not use. `bearing` is deliberately computed with the absolute
forward target projection, so it does not distinguish a target ahead from one
abeam or behind; `forward_distance_L` preserves that distinction. The visual
turn becomes wasteful as the target moves toward the fish's beam, where
continuing the saturated bearing drive can sustain rotation away from the
target even though the direct heading-rate term is asking for braking.

## Single candidate hypothesis

Restore the complete evidence-best `11 deg`, `25 deg` bearing-scale,
`0.70/0.35` direct-body-rate controller and its propulsion gait. Split the
steering command into a target-bearing drive and a body-rate damping term.
Leave damping at full authority, but smoothly reduce only the bearing drive
from full strength at a forward target projection of `2.0L` to a `0.15` floor
when the target is abeam or behind. Keep the final-distance fade, posterior
traveling-wave servo, and command ceiling unchanged. This uses normalized
body-frame geometry rather than coordinates, time, a learned route, target
rates, lateral velocity, or hidden flow observations.

The candidate is supported only if it retains approximately the static
`11 deg` run's upstream progress while arresting the late upper curl: a later
or non-upper exit, center-y displacement below `+1.20L`, closest approach
below `4.87L`, or materially lower load/saturation with comparable approach
would support the separated allocation. Early loss of upstream travel,
closest approach above `5.33L`, unchanged upper-exit topology, or a stall when
the target becomes abeam falsifies the mechanism. A later worker should then
restore static `11 deg` and test a different late-turn discriminator; it
should not further relax steering by raw distance, revive joint-phase
headroom gating, or tighten the near-hard-limit soft stop.
