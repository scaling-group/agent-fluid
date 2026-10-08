# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, assigned-parent
experience, all four sampled policies, scores, compact observations, metrics,
embedded wake diagnostics, and the relevant inherited optimizer note and
evaluated descendant. I inspected a shared held-fish prewarm sheet before the
released sheets for the distinct sampled `tail_steering_gain=0.65`, the three
identical-output `0.70` rollouts, and the inherited evaluated `0.75`
continuation. I used no omitted Bookshelf material, neighboring configuration,
repository history, coordinate route, clock, or external research.

The shared prewarm sheet shows the fish held at the common upper-right release
pose while the four staggered cylinder streets develop and merge around the
second-row target. It is common initial-condition evidence, not evidence for a
candidate-specific wake phase or route.

The three sampled `tail_steering_gain=0.70` released sheets are byte-identical.
They show a finite, bounded beat that turns the fish down-left, drives it
upstream through the developed wake, and closes along a compact diagonal route
without a loop, collision, domain exit, or instability. Mean world/local-flow
x velocities `-0.15005/-0.08386` imply `0.06620` upstream-relative x speed, so
the motion is materially self-propelled rather than passive advection. Capture
takes `72.457` release units with `2.45409L` mean distance, `51842` command
energy, `0.13063` RMS relative crossflow, and RMS force/moment
`23.85/408.89`. Anterior/posterior peak speeds are `3.086/3.293 rad/time`, and
both commands touch the policy's `28 rad/time^2` guard.

The sampled `0.65` sheet follows nearly the same compact topology and arrives
slightly sooner at `72.160`, with greater upstream-relative x speed `0.06732`,
but it regresses mean distance to `2.46383L` and raises crossflow and
force/moment to `0.13603` and `25.32/420.32`. Thus `0.70` is the sampled
compactness/load anchor even though no single metric varies monotonically.

The assigned parent's proposed static continuation to `0.75` has now been
evaluated in inherited logs. Repeated records have byte-identical released
sheets and metrics, so they count as one executable result rather than
independent robustness evidence. Its visual route remains finite and broadly
diagonal but is marginally less compact during the lower final approach. It
reaches in `72.275`, improves upstream-relative x speed to `0.06873`, and
reduces crossflow and force/moment to `0.12785` and `22.60/394.40`; however,
mean distance regresses to `2.50932L`, command energy rises to `52496`, and the
scalar score falls from `-0.55577` to `-0.61098`. Posterior peak speed also
rises from `3.293` to `3.370 rad/time` even as anterior peak speed falls. This
falsifies smooth static extrapolation above `0.70`: extra posterior steering
share can trade compact target closure and effort for relative propulsion and
lower aggregate loads.

No current sampled sheet is a semantic termination failure. The inherited
`0.75` sheet is therefore the most informative failed policy hypothesis
available for direct visual comparison. The older reversed-sign instability
remains a safety boundary in inherited guidance, but its keyframe sheet is not
present in this workspace, so I infer no new visual detail from it.

## Single-candidate hypothesis

Preserve the evaluated `tail_steering_gain=0.70` controller and introduce only
a smooth, bounded high-speed posterior damping increment. Keep base damping at
`0.65`; add at most `0.025` only as normalized posterior speed
`abs(qd2) / (omega * oscillator_amplitude)` crosses `1.0`, using a `0.08`
transition width. The increment is inactive through the low- and mid-speed
parts of each beat and self-limits if it suppresses the peak. All gait,
bearing steering, lag, and common `28/28` guards remain fixed.

This directly tests the inherited boundary left by the failed constant
`tail_damping=0.675` rollout: constant damping reduced posterior peak speed to
`3.145` but shifted work to the anterior joint, took a deeper route, arrived
at `91.50`, and raised effort and loads. Localizing the same maximum damping to
the observed high-speed regime may trim the `0.70` posterior peak without
perturbing the entire phase orbit. It also avoids the newly falsified static
posterior-share interpolation and adds no coordinate, route, clock, external
phase, or forbidden wake probe.

The falsifiable expectation is finite compact diagonal capture with posterior
peak speed below `3.293 rad/time` and no transfer to higher anterior speed,
while arrival, `2.45409L` mean distance, `0.06620` upstream-relative x speed,
`51842` effort, and `23.85/408.89` loads remain at least competitive with the
`0.70` anchor. Reject the mechanism if it reproduces the constant-damping deep
route, materially delays capture, raises anterior speed or command effort, or
fails to reduce both posterior peak speed and hydrodynamic load. Any
same-snapshot benefit remains unproven until CFD and must later survive held-out
wake phase, inflow, geometry, and target position.
