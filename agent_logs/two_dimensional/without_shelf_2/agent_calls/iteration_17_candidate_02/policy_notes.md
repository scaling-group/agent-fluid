# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the complete Phase 2 workspace and guidance contracts, assigned-parent
experience, all four sampled solver policies, scores, observations, compact
metrics, and embedded wake diagnostics, and the available assigned-parent
optimizer notes and evaluated descendants. I inspected the common held-fish
prewarm sheet first, then the released sheets for the three replicated
`tail_steering_gain=0.70` results, the sampled `0.60` comparator, and the
inherited failed `oscillator_energy_gain=2.075` split-gain mechanism. I used no
omitted Bookshelf material, neighboring configuration, repository history,
global-coordinate route, clock, or external research.

The prewarm sheet shows the fish held above and downstream of four staggered
cylinders while their developed vortex streets merge around the second-row
target. This is the identical initial condition for every sampled candidate,
not evidence for a memorized wake phase or route.

The three executable `tail_steering_gain=0.70` samples are deterministic
replications. Their released sheets show a bounded down-left turn, sustained
lateral beating, diagonal entry into the developed wake, a modest late
lower-to-target correction, and target crossing without a loop, collision,
domain exit, or numerical instability. The fish is self-propelled rather than
merely advected: mean world/local-flow x velocities are
`-0.15005/-0.08386`, giving `0.06620` mean upstream-relative x speed. Capture
takes `72.457` release units with `2.45409L` mean distance and score
`-0.55577`. Command energy is `51842`, RMS relative crossflow is `0.13063`,
and RMS force/moment are `23.85/408.89`. Both accelerations reach the policy's
`28 rad/time^2` guard, but peak joint angles (`0.500/0.438 rad`) and speeds
(`3.086/3.293 rad/time`) remain within the task envelope.

The sampled `0.60` share follows the same broad compact corridor but reaches
later (`73.859`) with worse mean distance (`2.48002L`) and score (`-0.58059`).
It has nearly the same upstream-relative x speed (`0.06565`) and total effort
(`51797`), while its force/moment are slightly higher (`24.94/410.68`) and its
joint-angle and speed peaks are also higher. Assigned-parent logs supply the
intermediate evaluated `0.65` point: it improves arrival to `72.160`, mean
distance to `2.46383L`, relative x speed to `0.06732`, and effort to `51284`,
but raises crossflow and force/moment to `0.13603` and `25.32/420.32`.
Increasing share from `0.65` to `0.70` therefore trades `0.297` release units
and `558` command-energy units for a smaller distance integral, lower
crossflow, lower loads, and lower joint-speed peaks. The evidence supports
posterior curvature sharing as a useful route-shaping mechanism through
`0.70`; it does not establish monotonic improvement beyond that point.

No current sampled solver supplies a semantic-failure keyframe. The closest
inherited failed mechanism is the `2.075` split energy-restoration gain. Its
sheet takes a visibly deeper lower route before returning to the target, and
metrics corroborate the route regression: score `-0.67552`, mean distance
`2.57441L`, and `4.706L` downward center displacement despite finite capture.
Its lower crossflow and loads (`0.12631`, `21.85/389.56`) show why a scalar or
load metric alone cannot identify the better route. Earlier inherited guard
and damping interpolations likewise selected nonlinear route branches, so the
next candidate should isolate one already useful mechanism rather than combine
it with a new schedule.

## Single candidate hypothesis

Preserve the replicated `0.75` period, `22 deg` oscillator, static `2.1`
energy restoration, bounded positive-bearing `0.75/10 deg` anterior steering,
`0.55` posterior lag, `0.65` damping, and common `28/28 rad/time^2` command
guard. Increase only `tail_steering_gain` from `0.70` to `0.75`, the same
`0.05` step that produced both evaluated improvements from `0.60` through
`0.70`. At saturated anterior steering, this adds at most `0.5 deg` to the
posterior mean-curvature target while leaving oscillatory propulsion,
observations, frequency, and command authority unchanged. The hypothesis is
that slightly more posterior sharing will tighten the visible late correction
and continue the distance/load benefit without the guard, damping, or
energy-gain route switches already seen in inherited evidence.

Later CFD should count this unevaluated continuation as an improvement only if
it retains finite capture through the compact diagonal corridor and improves
mean distance, arrival, effort, or loads without a material regression in the
others. Reject extrapolation beyond `0.70` if `0.75` selects a deeper route,
loses capture, slows materially beyond `72.457`, lowers upstream-relative x
speed, increases persistent guard contact, or raises effort and force/moment
without tighter closure. Even a same-snapshot gain remains falsifiable under
held-out wake phase, inflow, geometry, and target placement.
