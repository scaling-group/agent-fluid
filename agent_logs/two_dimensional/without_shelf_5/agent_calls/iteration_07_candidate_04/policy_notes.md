# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet fixes the common initial condition: the fish is held
  at the upper-right release pose while four staggered cylinder streets develop
  and merge around the target. It gives no candidate-specific controller
  credit.
- The four current sampled policies and the prefill are byte-identical
  `steering_gain=1.7` controllers. Their released sheets and metrics are also
  identical: each fish actively turns left-down, leaves a dense alternating
  tailbeat trail, enters the developed wake corridor, and crosses the `0.75L`
  target ring at `39.710`, with mean distance `1.874L`, total command energy
  `54703.2`, relative-crossflow RMS `0.2265`, and force/moment RMS
  `38.40/618.59`. The motion is self-propelled rather than passive advection,
  and no collision, exit, or instability precedes capture. These repeats
  establish deterministic replay for the certified snapshot, not robustness to
  a different wake phase or pose.
- No sampled semantic-failure sheet is available in this workspace. The most
  informative visual negative comparators are therefore the finite gain-`1.9`
  and gain-`1.725` regressions. Both preserve the same visible turn-then-
  diagonal topology and capture, but the `1.9` run arrives at `40.034`, raises
  mean distance to `1.901L`, crossflow RMS to `0.2329`, force/moment RMS to
  `41.31/657.28`, and maximum joint angles to `0.523/0.548` rad. Gain `1.725`
  is slower still at `40.832`, with `1.915L` mean distance,
  `0.2364` crossflow RMS, `42.50/674.61` force/moment RMS, and
  `0.526/0.556` rad joint maxima. These embedded diagnostics cross-check the
  slightly flatter visible final approaches and falsify both extrapolation and
  sparse interpolation above `1.7`.
- At the replicated `1.7` anchor, embedded diagnostics report maximum anterior
  and posterior joint angles of `0.507` and `0.528` rad, a `0.021` rad
  posterior excess, while both joints touch the same rate and acceleration
  envelopes. The inherited target-blind exit and mixed flow/moment-feedback
  instability remain outer boundaries only: neither has an available failure
  sheet here, and neither isolates steering distribution.

## Candidate hypothesis

Keep the evaluated `0.55`-period, 28-degree oscillator, posterior phase lag,
`steering_gain=1.7`, positive bearing sign, and 12-degree bounded total steering
command. Change only `anterior_steering_fraction` from `0.4` to `0.45`. At the
outer steering bound this transfers `0.0105` rad of the center command from the
posterior joint to the anterior joint, approximately half the observed
`0.021` rad peak-angle gap, while leaving the summed two-joint steering center
and bearing sensitivity unchanged.

The later CFD rollout should test whether this small redistribution preserves
the visible self-propelled turn and target capture while reducing the posterior
joint excursion and moment/load envelope. Falsify it on loss of capture,
arrival later than `39.710`, mean distance above `1.874L`, posterior excursion
not falling below `0.528` rad, anterior excursion rising enough to erase the
joint-balance gain, or crossflow/force/moment exceeding the `1.7` anchor. On
falsification, restore the measured `0.4` distribution; do not combine the
result with another gain, gait, or feedback change.
