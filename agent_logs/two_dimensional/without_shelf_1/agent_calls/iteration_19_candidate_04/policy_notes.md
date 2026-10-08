# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet confirms the common initial condition: the held fish
starts above and downstream of the target while the asymmetric four-cylinder
streets develop and merge across the route. The four current sampled policies
are controller-identical apart from comments and reproduce the same finite
arrival metrics. Their released sheet shows active upstream propulsion, an
early downward turn into the interacting wake, and a broad terminal loop that
nevertheless crosses the `0.75L` target radius after `88.13` release units.
The metrics support that reading: the head moves `(-10.92,-4.44)L`, its mean
x velocity is more upstream than the local flow (`-0.124` versus `-0.092`),
closest/mean distance are `0.747/2.736L`, and progress is `0.940`.

The assigned parent's isolated `1650` to `1550 deg/time^2` command-ceiling
reduction is the most informative failure. Its released sheet initially shows
the same self-propelled upstream approach, but the fish turns nearly vertical,
passes above the target, and makes an upper hook into a domain exit. This is
neither collision nor numerical instability. Quantitatively it reaches only
`(-7.06,+1.79)L` head displacement, misses at `1.560L`, regresses mean distance
and progress to `8.005L` and `0.386`, and exits after `70.64` units. Although
mean command energy falls from `866` to `792`, RMS force/moment rise from
`445/4597` to `715/6922`. The compact diagnostics also show that the lower cap
does not desaturate the mechanism: posterior angle remains exactly `45 deg`
and both joint rates remain exactly `260 deg/time`. Thus simple ceiling
reduction is a negative result, and lower effort without route preservation is
not useful here.

## Single candidate hypothesis

Restore every demonstrated propulsion and navigation parameter, including the
successful `1650 deg/time^2` arrival anchor, then change only the policy-owned
command ceiling to `1700 deg/time^2`. The successful policy itself reaches its
`1650` cap on both joints, while the failed lower-cap result loses mean upstream
speed and capture; this supports a conservative opposite-side authority
bracket. The `50 deg/time^2` increment is half the failed reduction and remains
below the episode's `1800 deg/time^2` safety envelope. It adds no coordinate,
route, elapsed-time, prescribed-flow, remote-probe, or target-station signal.

The hypothesis is supported only if the diagonal target capture survives and
the extra tracking authority improves arrival time and/or mean distance without
a disproportionate force/moment increase. It is falsified by loss of capture,
return of the upper exit, worse mean distance, or higher loads without a route
or timing benefit. A negative result should restore exactly `1650` and close
simple command-ceiling tuning on both sides; later work should preserve the
complete arrival controller and test a genuinely distinct, evidence-scaled
within-cycle actuator mechanism one at a time.
