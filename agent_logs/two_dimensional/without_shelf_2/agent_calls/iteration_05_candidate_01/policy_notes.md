# Multi-wake candidate diagnosis

## Evidence and visual diagnosis

I read the assigned parent guidance, all four sampled solver observations,
metrics and nested wake diagnostics, and the available inherited optimizer
notes before writing this hypothesis. I inspected the common prewarm sheet
first, then all four current released sheets and the inherited unstable
failure. No omitted Bookshelf material, neighboring configuration, repository
history, coordinate route, clock, or external research was used.

The shared prewarm frames establish a common release: the fish is held in the
upper-right, above and downstream of four fully developed, interacting vortex
streets. The target lies inside the second-row wake overlap. This sheet is
initial-condition evidence only.

The inherited reversed-sign `30 deg`, `0.82`-period failure visibly coils and
spins beside the release point by `4.45` units instead of beginning a target
turn. Its `unstable_dynamics` termination agrees with RMS relative crossflow
`3.139`, force `5.50e4`, moment `5.68e5`, anterior angle `0.721 rad`, and hard
velocity-limit contact. It rules out recovering performance through that
combined sign and amplitude change.

All four current samples instead retain the finite positive-bearing,
state-energy gait and visibly self-propel down-left through the developed wake
to first capture. Their upstream motion is not local-flow advection alone:
mean x velocity ranges from `-0.1208` to `-0.1468`, compared with mean local
flow x from `-0.0691` to `-0.0825`. Because gait, posterior response, and
acceleration guard are otherwise identical, the pure-bearing samples with a
`10 deg` cap isolate the steering-gain response:

- gain `0.70` reaches in `91.61` units with mean distance `2.834L`, RMS
  force/moment `38.81/550.75`, and upstream-relative x speed `0.0515`;
- gain `0.75` reaches in `74.23` units with mean distance `2.561L`, RMS
  force/moment `22.39/393.08`, and upstream-relative x speed `0.0643`;
- gain `0.82` regresses to `83.83` units, mean distance `2.668L`, loads
  `36.11/515.17`, and upstream-relative x speed `0.0582`.

The `0.80/11 deg` sample is slower still at `87.63` units and has the largest
finite sampled loads, `52.88/687.45`, but its simultaneous limit change means
it cannot isolate gain. The keyframe sheets agree with the metrics: `0.75/10
deg` takes the most compact approach and enters the capture wake earliest;
the weaker and stronger responses show longer or more wavy corrections. The
best case stays finite with maximum joint angles `0.516/0.427 rad` and speeds
`3.121/3.225 rad/time`, below the hard joint limits, although its candidate
acceleration guard is reached.

## One candidate hypothesis

Replace the `0.70/10 deg` prefill with the directly evaluated `0.75/10 deg`
pure-bearing controller while preserving the common `0.75`-period, `22 deg`
energy-regulated oscillator, posterior traveling-bend response, and `28
rad/time^2` guard. This selects the interior gain supported by the current
same-snapshot sweep rather than extrapolating beyond it or adding rate, force,
flow, moment, or position feedback that the evidence has not isolated.

The falsifiable expectation is finite first capture near or before the
`74.23`-unit sample, mean distance near `2.56L`, material upstream velocity
relative to local flow, no joint-angle or velocity hard-limit contact, and
force/moment loads closer to `22.39/393.08` than the neighboring samples.
Reject the mechanism as a reusable optimum if a held-out wake phase or geometry
makes `0.75` lose capture or if its apparent advantage disappears when gain is
isolated under otherwise identical conditions. No result for this unevaluated
workspace candidate is claimed.
