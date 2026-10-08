# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience, all four sampled solver observations, metrics, embedded wake
diagnostics, and policies, and the four unique inherited optimizer records
available in this workspace. I inspected the common held-fish prewarm sheet
first, then the released keyframes for the duplicated `oscillator_energy_gain`
`2.0` anchor, the score-leading `2.1` energy-restoration probe, the sampled
`28/27` split guard, and the assigned parent's evaluated high-speed tail
damping schedule. I used no omitted Bookshelf material, neighboring
configuration, repository history, global-coordinate route, clock, or external
research.

The prewarm sheet shows the fish held above and downstream of four developed,
interacting vortex streets, with the target inside the merged second-row wake.
This establishes the common wake at release; it is not candidate-specific
evidence and does not justify coordinate memorization.

The duplicated `oscillator_energy_gain=2.0`, common-`28 rad/time^2` anchor
shows a bounded down-left turn, productive lateral beating, and a compact
diagonal entry into the useful wake before target crossing. Its mean world x
velocity `-0.14682` differs materially from mean local-flow x `-0.08249`, so
the `0.06433` upstream-relative x speed confirms self-propulsion rather than
passive advection. It captures in `74.23` release units with `2.561L` mean
distance, `50940` command energy, and RMS force/moment `22.39/393.08`.
Joint angles and speeds stay inside the task envelope, although both action
channels touch the candidate's `28` guard.

Increasing only energy-restoration gain from `2.0` to `2.1` is the strongest
sampled result. Its keyframes retain the compact turn and useful-wake entry and
finish from slightly less far below the target, without a collision, boundary
excursion, loop, or numerical failure. Metrics corroborate the visual result:
score improves from `-0.6617` to `-0.5806`, arrival from `74.23` to `73.86`,
mean distance from `2.561L` to `2.480L`, and upstream-relative x speed from
`0.06433` to `0.06565`. The benefit is not free: command energy rises to
`51797`, RMS force/moment to `24.94/410.68`, and posterior peak speed from
`3.225` to `3.323 rad/time`. Thus `2.1` is a closure/propulsion improvement,
not evidence that still higher restoration or effort will improve load.

The assigned parent's normalized high-speed damping schedule is the most
informative failed optimization hypothesis in the available inherited logs.
It raises posterior damping from `0.65` toward `0.675` only above normalized
tail-speed ratio `0.95`, but its sheet takes a lower, kinked correction rather
than the anchor's compact route. Tail peak speed falls only from `3.225` to
`3.216`, while arrival regresses to `77.29`, mean distance to `2.630L`, score
to `-0.7286`, command energy to `53167`, and force/moment to
`22.76/398.31`. The sampled `28/27` guard likewise captures from farther
below while slowing arrival and raising effort and load. These results reject
combining the score-leading energy gain with either damping schedule or reduced
posterior authority in this candidate. All current sampled rollouts reach the
target, so "failed" here means a finite route/efficiency regression rather
than a safety termination.

## Single candidate hypothesis

Use the exactly evaluated `oscillator_energy_gain=2.1` controller while
retaining the anchor's positive-bearing gain `0.75`, `10 deg` steering cap,
`0.75` period, `22 deg` requested orbit, tail steering share and lag, `0.65`
damping, and common `28 rad/time^2` guard. This leaves the requested orbit,
frequency, steering map, posterior phase target, observations, and actuator
authority unchanged; it only strengthens state-based recovery toward the
nominal phase-space energy after wake disturbances. Selecting the observed
value avoids unsupported interpolation or extrapolation in a lineage where
small static guard and damping changes produced distinct route branches.

The same-snapshot evaluation should reproduce finite compact capture and
material upstream-relative propulsion close to the sampled `2.1` result.
Treat it as the current improvement only while its arrival and distance gain
outweigh the documented effort/load cost; do not infer that restoration gain
is monotone or load-regulating. Falsify its reuse if held-out wake phase,
inflow, geometry, or target placement loses capture, shifts to a lower route,
or raises saturation and load without improved closure.
