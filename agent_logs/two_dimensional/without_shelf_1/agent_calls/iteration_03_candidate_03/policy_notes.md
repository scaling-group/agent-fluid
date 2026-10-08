# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

- The common prewarm sheet shows four developed, overlapping vortex streets
  extending from the staggered cylinders past the held fish. The fish therefore
  starts inside unsteady flow; this is shared initial-condition evidence, not a
  candidate response.
- The target-blind `0.55`-period seed is visibly carried into a nearly vertical
  lower-domain exit without entering the useful target corridor. Its head moves
  `-3.55L` upstream but `-13.30L` laterally, mean velocity y closely tracks
  local-flow y (`-0.263/-0.241`), both joint rates and accelerations reach their
  hard limits, and progress is only `0.024`. Large commands alone do not supply
  useful heading authority.
- The assigned-parent/prefill policy is the strongest finite sample. Its
  `0.90`-period anterior oscillator and positive, posterior-only bearing bias
  visibly self-propel the fish leftward: mean local flow x is nearly zero while
  head displacement x is `-2.73L`, minimum distance improves to `6.34L`, and it
  remains finite for `73.39` release units. It then overshoots into a broad
  upward loop and exits without reaching the developed wake near the target.
  Joint 2 reaches `45 deg`, both rates and acceleration commands reach their
  limits, and RMS force/moment rise to `196/2014`, so its approach mechanism is
  useful but its undamped turn is not.
- The other sampled policies bound the reusable mechanism. Moving bearing
  steering into the anterior oscillator produces an almost immediate curled,
  unstable failure (`1.52` release units here; inherited counterpart `3.39`)
  with force/moment loads above `5e4/5e5`. Weak `1.10`-period posterior-only
  gaits, including the sampled positive-bias `14 deg` policy, move about
  `+2.45L` downstream and never improve on the release distance. Reversing the
  posterior sign is likewise unsupported: the inherited `11 deg` and `34 deg`
  negative-sign trials both lose upstream approach and exit downstream or
  below the target.
- An inherited look-ahead candidate already combined bearing-window-rate lead
  with a weaker `26 deg` oscillator, smaller lag/bias, and more damping. Its
  keyframes show a loop near the release region rather than wake entry; it moves
  only `+0.083L` in x, reaches just `10.86L`, exits after `45.62`, and raises
  RMS force/moment to `329/5141`. Because several propulsion and steering
  parameters changed together, this falsifies that bundled reduction, not rate
  lead itself. Its own stated fallback was to restore the `28 deg` drive and
  vary the rate term separately.

## Candidate hypothesis

Retain every evaluated prefill gait and proportional-steering parameter so the
only behavior change is a bounded look-ahead term from the smoothed
`bearing_window_rate`. Keep steering exclusively in the posterior mean tail
tangent. Adding the rate correction to bearing should reduce the tail bias
early when bearing is already converging and reinforce it when wake-driven yaw
makes bearing diverge. Clamp that correction independently before the existing
smooth steering saturation so a transient wake signal cannot dominate target
geometry. All active values remain owned by `target_policy_params`; the policy
uses no global coordinates, clock, route, prescribed inflow, or remote probe.

This isolation is supported if the fish keeps the prefill's negative x
displacement and `6.34L`-or-better approach while avoiding the broad upper loop,
surviving beyond `73.39` release units, or reaching the target. It is falsified
if upstream motion disappears as in the bundled look-ahead trial, if the loop
or joint/load saturation remains unchanged, or if bearing-rate noise produces
rapid steering reversal. A later worker should then remove rate lead and test
posterior bias magnitude alone rather than reverse the evidenced sign or move
steering into the anterior oscillator.
