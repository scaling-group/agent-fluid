# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace and guidance contracts, assigned-parent experience, all
four sampled solver scores, observations, compact metrics, nested diagnostics,
and policies, plus the available inherited optimizer notes and their evaluated
descendants. I inspected the shared held-fish prewarm sheet first, then the
released sheets for the duplicated `28/28` anchor, the sampled `28/27` guard
split and `22.25 deg` amplitude probe, and the inherited `28/27.5`, posterior
damping, and turn-amplitude hypotheses. No omitted Bookshelf material,
neighboring configuration, repository history, global-coordinate route, clock,
or external research was used.

The shared prewarm sheet shows the fish held above and downstream of the four
developed, interacting vortex streets, while the target sits in the merged
second-row wake. This is the common initial condition, not candidate-specific
support or a wake phase to memorize.

The duplicated `28/28 rad/time^2` anchor is the strongest physical reference.
Its sheets show a bounded down-left turn, productive lateral beating, and a
compact diagonal entry into the developed wake followed by target crossing
without a loop, collision, or domain excursion. It captures in `74.23` release
units with `2.561L` mean distance. Mean world x velocity `-0.14682` against
mean local-flow x `-0.08249` gives `0.06433` upstream-relative speed, so the
motion is self-propelled rather than passive advection. RMS force/moment are
`22.39/393.08`, command energy is `50940`, and joint angles and speeds remain
inside the hard envelope, although both accelerations touch the candidate's
`28` guard.

The nominal score leader, which lowers only the posterior guard to `27`, is a
mixed result rather than a better physical anchor. Its keyframes show useful
wake entry but a lower late correction. The score and mean distance improve
slightly to `-0.654416` and `2.555L`, while capture slows to `76.44`,
upstream-relative x speed falls to `0.06199`, command energy rises to `53200`,
and RMS force/moment rise to `24.69/417.71`. The `22.25 deg` amplitude probe
also takes a slightly lower correction and regresses to `76.95`, `2.579L`,
`0.05926`, and `24.75/420.04`, so more fixed oscillation is not supported.

The inherited sheets make the nonlinear route boundary clearer. The posterior
`27.5` midpoint dives well below the compact corridor and returns from beneath,
taking `95.96` with `2.806L` mean distance, `0.05344` upstream-relative speed,
`64918` command energy, and `51.98/665.46` force/moment. Increasing posterior
damping from `0.65` to `0.675` on the restored `28/28` anchor reduces posterior
peak speed from `3.225` to `3.145` and mean power from `45.38` to `44.91`, but
its sheet still develops a long lower correction; capture regresses to `91.50`,
mean distance to `2.788L`, upstream-relative speed to `0.05262`, and loads to
`42.13/581.11`. Likewise, a `5%` turn-demand amplitude reduction on the
`28/27` controller lowers joint-speed peaks and mean power but worsens capture,
mean distance, relative propulsion, and loads to `79.70`, `2.594L`, `0.06073`,
and `28.03/438.71`. Thus reduced peak motion or power alone is not evidence of
a productive route. All inspected current and inherited sheets reach the
target; these are failed optimization hypotheses rather than collision,
domain-exit, or numerical failures. The older reversed-sign instability remains
only a logged safety boundary.

## Single candidate hypothesis

Restore the reproducible `28/28` anchor and retain its positive-bearing gain
`0.75`, `10 deg` steering cap, `0.75` period, `22 deg` state-energy oscillator,
energy gain, tail curvature sharing, damping, and common action guard. Change
only `tail_lag_gain` from `0.55` to `0.525`. This reduces the posterior target's
quadrature term by about `4.5%` before saturation without damping measured tail
velocity, shrinking anterior propulsion, changing mean steering curvature, or
withholding the evaluated acceleration authority. It is an isolated posterior
target-formation probe, not a claim that less phase lag is generally better.

Later CFD should retain finite capture, the compact diagonal corridor, and
material upstream-relative propulsion while reducing posterior guard contact,
effort, or force/moment load. Treat it as an improvement only if those benefits
do not materially worsen the anchor's `74.23` arrival or `2.561L` mean distance.
Reject it if reduced tail lag recreates the lower excursion, drops
upstream-relative x speed below `0.06433`, raises loads, or loses target capture.
Any same-snapshot benefit remains subject to held-out wake phase, inflow,
geometry, and target-position falsification; no CFD result for this unevaluated
candidate is claimed here.
