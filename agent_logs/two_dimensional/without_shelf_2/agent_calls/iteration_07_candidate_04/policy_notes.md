# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the assigned parent guidance, all four current sampled solver results,
their policies, observation summaries, compact metrics and nested diagnostics,
and the inherited optimizer notes before forming this candidate. Following the
wake-visual-signals procedure, I inspected the common held-fish prewarm sheet
first and then the released sheets for the best `0.75` controller and the
assigned parent's newly evaluated `0.745` probe. The current samples contain
no failed termination or failure keyframe sheet, so the `0.745` finite
regression is the strongest current counterexample; the older coiling
`unstable_dynamics` case is used only through inherited notes as an aggressive
sign/amplitude boundary. I did not use the omitted Bookshelf, neighboring
configurations, repository history, coordinates, or a clock.

The identical prewarm sheet shows the fish held in the upper-right while the
four cylinder streets develop and overlap around the second-row target. This
is a common initial condition, not policy-specific evidence.

The gain `0.75` released sheet shows an alternating traveling bend and a
compact down-left turn through the developed wake. The fish is self-propelled,
not simply advected: mean world x velocity is `-0.14682` while mean local-flow
x velocity is `-0.08249`, leaving `0.06433` upstream-relative speed. It first
crosses the target radius in `74.23` release units with `2.561L` mean distance,
`22.39/393.08` RMS force/moment, and maximum joint angles and speeds of
`0.516/0.427 rad` and `3.121/3.225 rad/time`. Both actions touch the
candidate-owned `28 rad/time^2` guard but the joints remain below the hard
angle and speed limits.

The assigned parent's gain `0.745` sheet retains the broad self-propelled
down-left route, but shows a deeper, wavier correction through the target wake
before capture. Its maximum lateral target offset is effectively unchanged
(`4.2966L` versus `4.2965L`), so the regression is not a new gross loop,
collision, or boundary-exit mechanism. Instead, capture slows to `86.99`, mean
distance rises to `2.694L`, upstream-relative x speed falls to `0.05865`, and
maximum anterior angle/speed rise to `0.558 rad` and `3.220 rad/time`. RMS
force/moment increase sharply to `39.84/540.72`, even though RMS relative
crossflow is nearly unchanged (`0.12876` versus `0.12919`). Identical `0.745`
keyframes and metrics appear in the inherited optimizer samples, consistent
with a deterministic same-snapshot response rather than sampling noise.

Together with the duplicated current gain `0.77` regression (`78.58` release
units, `2.661L` mean distance) and inherited gain-only results at `0.70` and
`0.82`, the failed `0.745` interpolation makes `0.75` the narrow empirical
anchor. It also rejects treating arrival and distance as a smooth function of
fine gain changes in this wake phase. Further steering-gain interpolation is
not justified by the available evidence.

## One candidate hypothesis

Freeze the evaluated gain `0.75`, `10 deg` steering limit, positive-bearing
sign, `0.75`-period and `22 deg` state-energy oscillator, and posterior
traveling-bend parameters. Change only the candidate acceleration guard from
`28.0` to `27.5 rad/time^2`. The unforced anterior restoring peak
`omega^2 * amplitude` is about `26.95 rad/time^2`, so the new guard retains the
nominal gait while trimming only transient commands above it. This isolates an
orthogonal burst-control axis after both sides of the gain anchor regressed and
avoids the inherited failed bearing-rate and aggressive sign/amplitude
mechanisms.

Later CFD should retain the compact target-reaching topology and material
upstream-relative propulsion while reducing peak-command exposure or loads
without worsening `74.23` release time and `2.561L` mean distance. Reject the
trim if capture is lost or slower, mean distance rises, the route develops a
larger correction, or reduced actuation destroys the established traveling
bend. If it does not change loads or command behavior, later workers should
treat max-only guard contact as insufficient evidence for further guard
tuning. No outcome for this unevaluated candidate is claimed here.
