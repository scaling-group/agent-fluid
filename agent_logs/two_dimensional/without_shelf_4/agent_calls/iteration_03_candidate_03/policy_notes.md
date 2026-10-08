# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- The assigned-parent guidance records the saturated naive seed as a negative
  boundary: its `28 deg`, `0.55`-period oscillator hit both the `260
  deg/time` rate cap and `1800 deg/time^2` acceleration cap, then exited after
  `50.13` released time with `-13.30L` lateral displacement. The inherited
  parent log therefore proposed a cap-feasible interpolation, not more seed
  drive. Its evaluated `19 deg`, `0.67`-period result (`f5cca4991f3d`) is now
  the strongest sampled finite policy and the anchor for this candidate.
- The common prewarm sheet shows the fish held above and downstream/right of
  the target while four developed streets merge through the target corridor.
  It is identical initial-condition evidence, not a policy comparison.
- In the released `f5cca4991f3d` sheet the fish visibly oscillates and advances
  left throughout all six frames instead of being swept to the right boundary.
  It first passes below the target row, then turns back toward it without a
  collision or numerical breakup. At the horizon it is near the target's
  lateral level but remains several lengths downstream/right of the station;
  the useful failure is insufficient longitudinal advance, not a wrong final
  lateral sign.
- Metrics and JSON diagnostics agree with that reading. The policy survives
  all `300` released time, moves the head `(-5.846,-4.282)L`, and ends at its
  rollout minimum distance `5.812L`, for `0.532` progress. Its mean body
  velocity in x is `-0.01942` against local flow `-0.00682`, so the extra
  upstream motion is controller-produced rather than passive advection.
  Maximum joint angles are about `19.0/24.3 deg`, rates `178/134 deg/time`,
  and accelerations `1670/1260 deg/time^2`; none reaches the episode envelope.
  RMS lateral force `17.92` and moment `352.44` are also far below the
  saturated seed's more wasteful `21.94` and `541.70` while progress is much
  larger.
- Two sampled contrasts bound what to preserve. The nearby `18 deg`,
  `0.65`-period negative-tail-bias policy (`09e7db9bb0ee`) is active but turns
  back to the right and exits at `143.45`, with `+2.186L` head-x displacement
  and `-0.151` progress; the favorable mechanism is therefore coupled and
  should not be replaced wholesale. Reversing to a positive `15 deg`
  posterior bearing bias (`355c263e69c9`) exits even earlier at `24.37`, with
  `+2.408L` x displacement and `-0.135` progress. The evaluated evidence does
  not support reversing the best policy's steering sign.

## Policy hypothesis

Preserve the complete `f5cca4991f3d` clock-free phase-shell oscillator,
negative bounded posterior bearing/rate steering, lag, and damping. Change
only the anterior amplitude from `19` to `20 deg` to test the remaining
longitudinal shortfall. At period `0.67`, its nominal rate and acceleration
scales are about `188 deg/time` and `1759 deg/time^2`, still inside the
`260/1800` envelope. A policy-owned `30.8 rad/time^2` command guard remains
above that nominal scale but below the episode hard cap, protecting unexpected
coupled transients without asking hard saturation to define the gait.

This is deliberately an exploit step rather than a new observation or route:
it uses only the sampled best policy's joint state and body-frame target
bearing/rate and introduces no coordinates, elapsed time, target identity,
prescribed inflow, remote wake probes, or station-flow signal. The next CFD
result should retain full-horizon stability and the best sample's lateral-row
correction while increasing negative head-x displacement, lowering mean and
final distance below `9.457L` and `5.812L`, respectively, and avoiding both
policy-guard and episode-cap contact. The amplitude hypothesis is falsified if
the rollout exits, rebounds laterally, does not improve longitudinal progress,
or contacts the guard; later workers should then return to `19 deg` and test
posterior phasing or alignment-conditioned effort rather than increasing
amplitude again.
