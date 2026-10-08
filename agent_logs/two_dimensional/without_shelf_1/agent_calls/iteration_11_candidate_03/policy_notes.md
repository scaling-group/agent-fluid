# Candidate visual diagnosis and policy hypothesis

## Evidence diagnosis

The common prewarm sheet shows the released fish above and far downstream of
the four developed cylinder streets, with the target between the second-row
wakes. The released sheets show genuine self-propulsion rather than passive
advection: the static `11 deg` posterior-bias anchor travels `-7.89L` in head x
while mean local x flow is only `-0.0995`, and reaches the best sampled
`4.87L` minimum distance and `0.424` progress. It does not enter the useful
target/wake region. After a nearly horizontal upstream leg, it makes a broad
upward hook and exits with `+1.79L` head-y displacement; posterior angle reaches
`0.781 rad`, both joints hit `4.538 rad/time` and `28.798 rad/time^2`, and RMS
force/moment rise to `406/4113`.

The two sampled repairs do not change that route topology. Reducing the
`11 deg` steering bias only after distance falls below `6L` still exits through
the upper boundary with `+1.78L` head-y drift, while x travel falls to `-7.19L`
and progress to `0.393`. On the `10 deg` anchor, blending the posterior servo
into an inward brake only during measured `40--45 deg` outward motion also
retains the upper hook and the same angle/rate/acceleration maxima; it worsens
minimum distance from `5.33L` to `5.77L` and raises RMS force/moment from
`325/3331` to `357/3779`. These outcomes agree with inherited failures from
phase/headroom attenuation: suppressing the posterior request sacrifices
propulsion without supplying the missing lateral route control.

## Candidate hypothesis

Restore the evidence-best `11 deg`, `0.70/0.35` static far-field anchor and
leave the anterior oscillator, posterior traveling-wave lag, and actuator
ceiling unchanged. Add one bounded derivative-like term from measured
body-frame lateral translation: divide lateral velocity by total body speed
with a small floor, pass the resulting dimensionless slip fraction through a
`tanh`, and subtract it from the bearing command. The correction is exactly
zero at release and whenever there is no lateral translation, so it preserves
the sampled propulsion request until cross-track motion develops. Unlike the
failed bearing-rate term, it does not mix target-vector rotation with
translation; unlike the failed relief and soft stop, it does not pre-emptively
weaken the posterior waveform merely because distance, phase, or joint angle
crosses a threshold.

The next CFD evaluation should retain the early upstream leg of the `11 deg`
anchor, then reduce the broad upward hook, upper-domain exit, and persistent
`+1.79L` lateral drift. Falsify this mechanism if upstream travel or closest
approach materially regresses from `-7.89L`/`4.87L`, if the same upper-exit
topology survives, or if saturation/load increases without a lateral-route
change. This worker does not claim an outcome before that evaluation exists.
