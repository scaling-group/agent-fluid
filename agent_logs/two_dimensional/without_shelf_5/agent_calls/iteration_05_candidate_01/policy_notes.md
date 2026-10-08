# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose while the four staggered cylinder wakes develop and merge near
  the target. It fixes the wake initial condition but gives no candidate
  controller credit.
- The sampled gain-`1.7` sheet and the gain-`1.9` and inherited gain-`1.725`
  sheets all show active propulsion: each fish corrects its heading, leaves a
  dense alternating tail trail, and traverses left-down into the merged wake
  and `0.75L` capture ring. None is passive advection, collision, domain exit,
  or numerical failure. No current sampled solver is a semantic failure, so
  the two finite regressions are the informative negative comparators.
- Gain `1.7` is the measured anchor: it reaches in `39.710`, with mean distance
  `1.874L`, total command energy `54703.2`, power proxy `4092.5`, relative-
  crossflow RMS `0.2265`, and force/moment RMS `38.40/618.59`. Three
  deterministic gain-`1.9` replicas arrive at `40.034`, raise mean distance to
  `1.901L`, energy to `54954.5`, power to `4136.9`, crossflow RMS to `0.2329`,
  and force/moment RMS to `41.31/657.28`. Their slightly flatter head path and
  smaller downward displacement (`-4.224L` rather than `-4.360L`) do not
  produce an earlier turn or capture.
- The inherited gain-`1.725` rollout falsifies the earlier sparse quadratic
  interpolation: despite lying much closer to `1.7`, it is the slowest of the
  three at `40.832`, with mean distance `1.915L`, energy `56614.5`, power
  `4263.5`, crossflow RMS `0.2364`, and force/moment RMS `42.50/674.61`.
  Embedded diagnostics also show larger maximum joint angles
  (`0.526/0.556` rad) than gain `1.7` (`0.507/0.528` rad), while every tested
  gain touches the same rate and acceleration envelopes. Thus proximity in
  gain does not support a smooth local performance fit under this wake.
- The assigned parent and inherited notes give a wider boundary: gain `1.5`
  was slower than `1.7`, the target-blind seed exited downward, and a slower
  controller that simultaneously reversed/rearranged steering and added
  velocity/moment feedback became unstable. Current evidence supports neither
  a new feedback signal nor a propulsion change; it supports retaining the
  demonstrated bounded positive-bearing mechanism and rejecting the failed
  gain extrapolation/interpolation.

## Candidate hypothesis

Restore only `steering_gain` from the regressed prefill value `1.9` to the
evaluated best value `1.7`. Preserve the `0.55`-period, 28-degree oscillator,
posterior phase lag, positive two-joint steering distribution, and 12-degree
`tanh` bound. This is a recovery to the strongest finite measured controller,
not a claim that the current worker has new CFD evidence or that `1.7` is a
universal optimum.

The later CFD rollout should reproduce target capture near `39.710`, mean
distance near `1.874L`, and the lower crossflow/load envelope. A materially
later arrival, mean distance above `1.901L`, or force/moment load approaching
the gain-`1.9` replica would falsify deterministic recovery and require later
workers to repeat the `1.7` anchor before probing one separately bounded axis.
Until such repeat evidence exists, later workers should not fit another
sub-step steering gain from the sparse, visibly similar trajectories.
