# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four developed, interacting cylinder streets; the target lies inside the
second-row wake corridor. It is therefore an identical disturbed release for
all candidates, not a policy-specific advantage.

The strongest sampled finite run is the `11 deg` posterior-bias policy
(`solver_5960b98e7e7d`, score `-8.911`). Its released sheet shows genuine
self-propulsion upstream from the upper-right start into the wake, followed by
the same broad upward loop and top-domain exit seen in the
assigned `20 deg` bearing-scale parent (`solver_84104139ce47`, score
`-10.464`) and the higher-rate-damping failure (`solver_ff3400b3ac97`, score
`-9.691`). The best run is not merely advected: mean head velocity is
`-0.141L/time` while mean local streamwise flow is `-0.099L/time`, and it
travels `-7.89L` upstream. It approaches the target more closely (`4.87L`)
than the otherwise matched `10 deg` bias anchor (`5.33L`) but never enters the
useful near-target corridor and exits with essentially unchanged head-y and
center-y drift (`+1.79L`, `+1.20L`).

The scalar improvement from `10` to `11 deg` is therefore not a loop repair.
It raises progress from `0.380` to `0.424` and upstream head travel from
`-6.93L` to `-7.89L`, but raises RMS force/moment from `325/3331` to
`406/4113`, increases relative-crossflow RMS from `0.288` to `0.299`, and
pushes posterior peak angle from `0.770` to `0.781 rad`, only about `0.005 rad`
below the `45 deg` hard limit. Both runs hit the joint-rate and acceleration
caps. Inherited optimizer evidence also brackets direct turn damping: relative
to `damping/scale=0.70/0.35`, `0.80/0.35`, `1.05/0.35`, and `0.70/0.25` all
lose upstream travel and closest approach while retaining the upward curl.
The sampled `20 deg` bearing scale likewise regresses progress to `0.310`
versus the `25 deg` anchor. More static bias, rate damping, or near-zero rate
sensitivity is not supported.

## Candidate hypothesis

Restore the evidence-backed `0.90`-period gait, `10 deg` posterior bias,
`25 deg` bearing scale, and `0.70/0.35` direct body-rate anchor. Replace the
static full-cycle posterior bias with a smooth phase-aware allocation computed
from the unsteered posterior target
`-tail_lag_gain * qd1 / omega - q1`. Pass the bearing command when this gait
target has room in the commanded steering direction, and fade it as the
unsteered target approaches a parameter-owned `32 deg` soft headroom boundary
over a `6 deg` band. This preserves steering on the relieving half of the
state-feedback oscillator and suppresses only the phase where static bias
would add to an already extreme posterior bend; it does not add time, route,
coordinate, flow, or target-rate dependence.

The hypothesis is that phase allocation can retain the anchor's upstream
self-propulsion and closest approach while lowering posterior peak angle,
force/moment load, and the persistent upper-loop drift. It is falsified if the
run loses substantial upstream progress or closest approach, still exits with
about `+1.8L` head-y drift, or continues to hit the posterior limit and load
levels without improved target clearance. Later workers should then return to
the static `10 deg` anchor rather than increasing bias or revisiting the closed
direct-rate sweep.
