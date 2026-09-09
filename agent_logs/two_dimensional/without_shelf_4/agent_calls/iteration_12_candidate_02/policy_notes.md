# Wake-policy candidate diagnosis

## Evidence diagnosis

- The assigned parent guidance is the prefilled `optimizer_529aed940593`
  state. The four sampled released rollouts are all finite target captures, so
  there is no sampled failure keyframe sheet to compare. I used the weakest
  sampled successful variant as the visual counterexample and the inherited
  horizon miss as the failure boundary.
- The shared prewarm sheet shows the fish held at the same upper-right release
  pose while four fully developed, interacting vortex streets fill the route
  toward the target. This is common initial-condition evidence, not a policy
  effect.
- The strongest sampled rollout (`solver_ac224f5d5313`) visibly makes a broad
  initial turn, crosses the developed wake from the upper right, and continues
  upstream through alternating lateral excursions until first target entry;
  it neither collides nor leaves the domain. Its mean body velocity x is
  `-0.04895` while mean local-flow x is `-0.03293`, giving a positive
  controller-relative upstream margin of `0.01602`; the approach is therefore
  not passive advection. Maximum anterior acceleration is `31.055`, below the
  `31.2` local guard and the episode hard cap.
- The otherwise matched static bearing/rate anchor (`solver_c702dfa33df7`)
  retains a visibly jagged sequence of large turn reversals and captures at
  `244.547` with `6.452L` mean distance. Adding only the sampled `0.08`
  sign-gated body-frame lateral-velocity lookahead captures at `224.488`,
  reduces mean distance to `6.311L`, raises relative upstream margin from
  `0.00793` to `0.01602`, and reduces RMS force/moment from
  `18.263/362.214` to `17.943/361.014`. This joint improvement is stronger
  evidence than arrival alone.
- Global `0.05` heading-rate damping (`solver_467ba7697b1d`) visibly preserves
  the long stair-step/reversal route and delays capture to `259.160`; its lower
  moment comes with `6.502L` mean distance and only `0.00359` relative upstream
  margin. The inherited horizon miss reached a `3.290L` minimum but ended at
  `3.632L` after the full horizon despite lower RMS force `17.349`, so load
  reduction without route progress is not a useful objective.

## Single candidate hypothesis

Use the successful sign-gated lateral-translation structure and keep its
demonstrated `0.67`-period, `20.25 deg`, posterior lag/damping, static bearing,
and rate-lookahead anchor unchanged. Increase only
`lateral_velocity_lookahead` from the sampled `0.08` to `0.10`. At the existing
`0.10` velocity limit this adds at most `0.01 rad` to the bounded steering
error, and it is active only when `-bearing * lateral_velocity` indicates
translation away from the target. The falsifiable expectation is earlier wake
corridor recovery with retained capture, lower mean distance, and no increase
in force/moment or guard contact. Reject the continuation if it causes a larger
rebound, later or lost capture, reduced relative upstream margin, greater
loads, or switching near zero bearing. No same-worker CFD result is claimed.
