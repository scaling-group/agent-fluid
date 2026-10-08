# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, assigned-parent control
experience, all four current sampled scores, observations, compact metrics,
nested wake diagnostics, and policies, plus the available inherited optimizer
notes and evaluated descendants. I inspected the common held-fish prewarm sheet
first, then the released sheets for the replicated `tail_steering_gain=0.65`
anchor, the isolated `0.70` continuation, and the inherited failed
`oscillator_energy_gain=2.075` midpoint. No omitted Bookshelf material,
neighboring configuration, repository history, coordinate route, clock, or
external research was used.

The common prewarm sheet shows the fish held above and downstream of the four
staggered cylinders while their developed streets merge around the second-row
target. It establishes an identical initial wake for the candidates; it is not
evidence for a memorized phase or route.

The three executable `tail_steering_gain=0.65` samples are deterministic
replications. Their sheets show a bounded down-left turn, sustained productive
beating, diagonal entry into the developed wake, a modest lower-to-target
correction, and capture without a loop, collision, boundary exit, or numerical
failure. Mean world/local-flow x velocities `-0.15180/-0.08448` give `0.06732`
upstream-relative x speed, confirming self-propulsion rather than passive
advection. Capture takes `72.160` release units with `2.46383L` mean distance,
`51284` total command energy, `0.13603` RMS relative crossflow, and RMS
force/moment `25.32/420.32`. Both commands touch the policy's `28 rad/time^2`
guard, but peak joint angles and speeds remain inside the task envelope.

The isolated `0.70` posterior-share sample retains the same compact wake
corridor and visibly reaches the capture circle without a deeper detour. Its
score improves from `-0.56561` to `-0.55577`, mean distance improves to
`2.45409L`, RMS relative crossflow falls to `0.13063`, and force/moment fall to
`23.85/408.89`. Peak anterior angle/speed fall from `0.514/3.125` to
`0.500/3.086`; posterior speed falls from `3.367` to `3.293` while posterior
angle changes only from `0.436` to `0.438`. These diagnostics support a bounded
redistribution of curvature rather than a load-producing tail escalation.
The tradeoff is real: arrival slows slightly to `72.457`, upstream-relative x
speed falls to `0.06620`, and total/mean command energy rise to `51842/715.49`
from `51284/710.70`. Thus `0.70` is a mean-distance/load improvement, not a
universal speed or efficiency improvement.

The inherited `2.075` energy-restoration midpoint is the closest informative
failed optimization comparator. Its sheet selects a less compact route and its
metrics regress to `77.264` arrival, `2.55118L` mean distance, `0.06386`
upstream-relative speed, `53643` effort, and `31.45/454.27` RMS force/moment.
Together with inherited guard and damping regressions, this shows that small
static parameter changes can switch wake routes and should not be assumed to
interpolate smoothly. No current sample is a semantic termination failure; the
older reversed-sign instability remains an inherited safety boundary rather
than a newly available failure sheet.

## Single candidate hypothesis

Adopt the exactly evaluated `tail_steering_gain=0.70` controller. Preserve the
evaluated `0.75` period, `22 deg` oscillator, static `2.1` energy restoration,
bounded positive-bearing `0.75/10 deg` anterior steering, `0.55` tail lag,
`0.65` tail damping, and common `28/28 rad/time^2` acceleration guard. This
adds no observation, switching surface, global coordinate, timing signal,
remote wake probe, or extrapolation above the sampled value.

Later CFD should reproduce finite capture through the compact diagonal
corridor and the sampled mean-distance, crossflow, peak-speed, and load gains.
Count `0.70` as preferable only while those gains justify the documented small
arrival, relative-propulsion, and effort costs. Reject it if reevaluation
selects a lower detour, loses capture, materially degrades upstream-relative
motion, or raises effort/load without compact closure. This deterministic
same-snapshot result remains falsifiable under held-out wake phase, inflow,
geometry, and target placement; no outcome for the unevaluated current worker
is claimed here.
