# Candidate wake-policy notes

## Visual diagnosis

The common prewarm sheet shows the held fish at the same upper-right release
pose while the four staggered cylinders develop overlapping vortex streets;
this is shared initial-condition evidence, not a policy difference. In the
released sheets, the fixed `0.10/0.65` terminal allocation and the sampled
`0.10/0.75` posterior-enhancement variant are visually almost identical. Both
produce a real upstream swimming leg, remain far to the right of the cylinder
rows and target corridor, turn nose-up after their closest approach, and exit
the upper boundary. Neither collides nor visibly folds or becomes nonfinite.

The metrics confirm that this is active but misdirected propulsion rather than
passive advection. The fixed-allocation anchor moves its head `-4.676L` in x;
its mean x velocity is `-0.0708` while mean local flow is only `-0.0494`. It
reaches `6.609L`, then opens to `9.266L` at exit after `70.14` released time,
with `+1.798L` head-y displacement. RMS relative crossflow, force, and moment
are `0.204`, `75.6`, and `985`. Joint 1, not joint 2, is the remaining actuator
outlier: maxima are about `33.23/25.93 deg`, `251.35/191.21 deg/time`, and
`1591.9/1463.3 deg/time^2`. Raising terminal posterior allocation to `0.75`
does not change the `6.609L` closest range or topology and slightly worsens
score (`-11.178` versus `-11.149`), head-x travel (`-4.642L`), mean/final
range (`9.366/9.296L`), and progress (`0.252` versus `0.254`).

Inherited optimizer logs and sampled guidance complete the bracket. Full
terminal anterior unload reduced joint-1 speed only to about `249.86 deg/time`
while worsening navigation, and posterior attenuation to `0.55` was worse
again. Together with the new posterior `0.75` result, this rules out further
terminal allocation interpolation as a credible recovery mechanism. The
assigned parent instead identifies conditional anterior speed protection as
the next isolated test, because the useful orbit was nominally near
`184 deg/time` while failed/returning variants approached the `260 deg/time`
hard cap.

## Policy hypothesis

Preserve the current gait, bearing law, `0.10/0.65` terminal allocation, and
the deeply rearward dual-opening selector exactly. Reuse that selector to
smoothly move only joint 1 from the existing `200 deg/time`, damping-`6` guard
toward a `190 deg/time`, damping-`12` terminal guard. Joint 2 keeps the current
guard, because its measured `191 deg/time` maximum has headroom and changing
posterior allocation in either direction was negative. The selector is zero
on the demonstrated range-closing leg, so this should preserve upstream
self-propulsion and act only once body-relative geometry and both range-rate
scales identify the terminal return.

The candidate is supported if it lowers maximum joint-1 speed materially
(preferably below about `235 deg/time`) while retaining roughly `-4.68L`
head-x travel and the `6.61L` approach, and then delays or avoids the upper
return without raising force/moment or transferring saturation to joint 2. It
is falsified if the closing leg degrades, the closest range worsens, loads rise,
joint 2 approaches its caps, or the same boundary return persists with worse
mean/final distance. No same-worker CFD result is claimed.
