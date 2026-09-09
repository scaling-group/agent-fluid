# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose while four staggered vortex streets develop and merge around
  the target. It fixes the initial wake for every candidate and gives no
  controller-specific credit.
- The three sampled `steering_gain=1.7`, `tail_damping=0.65` replicas show
  active propulsion: after a brief left-down heading correction, a dense
  alternating tail trail follows the fish diagonally through the developed
  wake into the `0.75L` target ring. Each reaches at `39.710` with mean
  distance `1.874L`, total command energy `54703`, relative-crossflow RMS
  `0.2265`, and force/moment RMS `38.40/618.59`. Mean leftward speed
  (`0.274L/time`) also exceeds the magnitude of mean local leftward flow
  (`0.163L/time`), so this is not passive advection.
- The sampled gain-`1.9` rollout retains the same safe route but is a finite
  regression: arrival is `40.034`, mean distance `1.901L`, total energy
  `54954`, crossflow RMS `0.2329`, and force/moment RMS `41.31/657.28`.
  The inherited gain-`1.725` rollout is worse still at `40.832` and
  `1.915L`. These results reject another bearing-gain interpolation while
  preserving positive bounded bearing curvature as the navigation anchor.
- The assigned-parent damping experiment supplies the new one-axis negative
  result. Increasing only posterior `tail_damping` from `0.65` to `0.70`
  preserves the visible turn-then-diagonal capture topology, but adds two
  keyframes of slow wake traversal and delays capture to `49.549`. Mean
  distance rises to `2.159L`, total command energy to `70416`, power proxy to
  `5348`, and posterior maximum angle to `0.570` rad. Force/moment RMS fall
  only to `37.22/616.36`, while relative-crossflow RMS actually rises to
  `0.2294`; both joints still touch the same rate and acceleration limits.
  Thus extra posterior damping did not deliver its proposed gentler-excursion
  regime and instead removed useful propulsive response.
- No current sampled solver is a semantic failure. The inherited target-blind
  downward exit and mixed-signal instability remain outer boundaries against
  removing bearing guidance, slowing the whole gait, reversing curvature, or
  adding unscaled velocity/moment feedback; the finite damping regression is
  the informative nearby negative comparator for this candidate.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, positive
two-joint bearing center, `steering_gain=1.7`, posterior phase-lag target, and
12-degree `tanh` steering bound. Change only posterior `tail_damping` from
`0.65` to `0.625`, half the magnitude and opposite direction of the failed
`+0.05` test. The direct evidence that added damping greatly slowed traversal
without reducing saturation, crossflow, or posterior excursion supports a
small release of posterior damping as a falsifiable propulsion test. Keeping
the decrement small limits the expected load tradeoff and introduces no new
observation, coordinate, route, elapsed-time, cylinder identity, or external
phase dependence.

The later CFD rollout should falsify this candidate if it loses capture, does
not improve on the `39.710` arrival and `1.874L` mean-distance anchor, or
raises crossflow and force/moment loads beyond the gain-`1.9` finite-regression
envelope (`0.2329` and `41.31/657.28`). If falsified, later workers should
restore `tail_damping=0.65`; together with the failed `0.70` result, that would
close this local damping direction rather than justify a larger decrement.
