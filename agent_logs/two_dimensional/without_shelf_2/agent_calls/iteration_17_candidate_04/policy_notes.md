# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned-parent
experience, all four sampled solver policies, scores, observations, compact
metrics, and embedded wake diagnostics, plus the available inherited optimizer
notes and evaluated descendants. I inspected a shared held-fish prewarm sheet
first, then the released sheets for the three replicated
`tail_steering_gain=0.70` policies and the distinct `0.60` policy. I used no
omitted Bookshelf material, neighboring configuration, repository history,
coordinate route, clock, or external research.

The four prewarm sheets are byte-identical. They show the fish held at the
common upper-right release pose while the four staggered cylinder streets
develop and merge around the second-row target. This is common
initial-condition evidence, not candidate-specific evidence for a memorized
wake phase or route.

The three executable `tail_steering_gain=0.70` policies and their released
sheets are also byte-identical. From release, the fish turns down-left,
sustains a bounded lateral beat, crosses upstream through the developed wake,
and closes on the target along a compact diagonal route without a loop,
collision, domain exit, or instability. Mean world/local-flow x velocities
`-0.15005/-0.08386` give `0.06620` upstream-relative x speed, so this motion is
materially self-propelled rather than passive advection. Capture takes
`72.457` release units with `2.45409L` mean distance, `51842` command energy,
`0.13063` RMS relative crossflow, and RMS force/moment `23.85/408.89`.
Anterior/posterior peak angles are `0.500/0.438 rad`, peak speeds are
`3.086/3.293 rad/time`, and both commands touch the policy's
`28 rad/time^2` guard while remaining inside the task actuator envelope.

The distinct current `tail_steering_gain=0.60` sheet follows the same broad
finite diagonal topology but closes less efficiently: arrival is `73.859`,
mean distance `2.48002L`, upstream-relative x speed `0.06565`, command energy
`51797`, and RMS force/moment `24.94/410.68`. The inherited isolated `0.65`
result lies between these steering shares in mean distance (`2.4638L`) and is
the fastest/most propulsive point (`72.160`, `0.06732` relative x speed), but
has higher crossflow and loads (`0.13603`, `25.32/420.32`). Thus the observed
`0.60 -> 0.65 -> 0.70` response supports posterior curvature sharing as a
useful isolated mechanism, while arrival, effort, and load are plainly not
monotone.

No sampled sheet in this workspace is a semantic termination failure. The
closest inherited failed optimization hypothesis is the static
`oscillator_energy_gain=2.075` midpoint: inherited notes report a visibly
deeper lower route with `77.264` arrival, `2.5512L` mean distance, `0.06386`
upstream-relative x speed, `53643` effort, and `31.45/454.27` RMS
force/moment. That result, together with inherited guard and damping
regressions, warns that small static changes can switch wake routes. The older
reversed-sign instability remains a safety boundary, but its keyframe sheet is
not present among the current samples, so I infer no new visual detail from it.

## Single-candidate hypothesis

Continue only the evaluated posterior-sharing mechanism by one equal bounded
step, changing `tail_steering_gain` from `0.70` to `0.75`. Preserve the
`0.75` period, `22 deg` oscillator, static `2.1` energy restoration, bounded
positive-bearing `0.75/10 deg` anterior steering, `0.55` posterior lag,
`0.65` damping, and common `28/28 rad/time^2` guard. At saturated anterior
steering the proposed change adds at most `0.5 deg` of posterior mean-curvature
target. It leaves oscillatory propulsion, observations, and actuator authority
unchanged and adds no switching surface, coordinate, route, timing signal, or
wake probe.

The falsifiable expectation is that slightly greater curvature sharing will
retain finite compact diagonal capture and may continue the `0.70` reduction
in mean distance, crossflow, joint-speed peaks, or load without sacrificing the
`0.65` point's closure advantage. Reject the continuation if it takes a deeper
route, loses capture, arrives materially later than `72.457`, reduces
upstream-relative x speed materially below `0.06620`, raises command effort
without a closure benefit, or exceeds the `0.70` force/moment baseline. The
prior response is not smooth enough to claim improvement before CFD, and any
same-snapshot gain would remain falsifiable under held-out wake phase, inflow,
geometry, and target position.
