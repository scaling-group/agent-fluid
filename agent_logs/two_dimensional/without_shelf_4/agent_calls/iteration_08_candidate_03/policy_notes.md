# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right of the target while the staggered
  cylinder streets develop and overlap across the target corridor. This is a
  common initial condition and cannot rank policies.
- The four sampled released sheets and physical metrics are also exact
  replicas of the `20.25 deg`, `0.67`-period anchor. From release to capture,
  the fish makes a broad down/up loop on the right, enters the interacting
  central wake, and finishes on a nearly horizontal target approach without
  collision, exit, instability, or rebound. It captures at `244.547`, with
  mean/final distance `6.452/0.750L`, maximum lateral target offset `4.293L`,
  and head travel `(-10.916,-4.187)L`.
- The anchor is wake-assisted but not passively advected. Mean head velocity x
  is `-0.04443` versus mean local-flow x `-0.03649`, giving `0.00793` of
  controller-relative upstream transport. Maximum anterior acceleration is
  already `31.055 rad/time^2` against the `31.2` policy guard and `31.416`
  episode cap, while RMS lateral force/moment are finite at
  `18.263/362.214`. This supports preserving propulsion and its guard.
- The assigned parent's bounded closing-speed relief is a concrete negative
  result. It changed effective bearing scale only from `0.30` toward `0.32`
  during positive closure, yet the released sheet acquires the central wake
  later and approaches from above. Capture regressed to `256.663` and mean
  distance to `7.394L`; maximum lateral offset remained `4.293L`, relative
  crossflow rose from `0.13437` to `0.13733`, and RMS force rose from `18.263`
  to `18.426`. Closing speed therefore did not identify when steering relief
  was safe in this fixed-prewarm rollout.
- The inherited `0.30` bearing-rate-lead test is the most informative failed
  hypothesis. Its sheet shows a tighter early loop followed by additional
  reversals before the final corridor entry. Compared with the anchor's
  `0.25` lead, it captures `25.900` later at `270.446`, worsens mean distance
  by `2.048L` to `8.499L`, and raises RMS force to `18.958`. Mean velocity x
  `-0.04032` is slightly less upstream than local-flow x `-0.04086`, so the
  controller-relative upstream margin falls from `0.00793` to `-0.00055`.
  The policy still captures and never contacts a joint or acceleration limit;
  the regression is route/control inefficiency, not failure penalty or
  numerical instability.
- Earlier inherited evidence also rules out compensating through the static
  bearing denominator or gait shell: `0.28` bearing scale produced a larger
  detour than `0.30`, while the evaluated `20.25 deg` shell is already the
  supported endpoint below the acceleration envelope. The next test must keep
  those axes fixed.

## Candidate hypothesis

Preserve the sampled `20.25 deg`, `0.67`-period oscillator, `0.65/0.80`
posterior lag/damping, `10 deg` steering limit, `0.30` bearing scale,
`0.30 rad/time` bearing-rate bound, and `31.2 rad/time^2` acceleration guard.
Change only bearing-rate lead from `0.25` to `0.20`. This is the equal-sized
opposite perturbation to the failed `0.30` test and uses the same bounded,
rolling body-frame bearing-rate signal. It neither adds an observation nor
changes propulsion or static target-bearing response.

Reducing the rate term should delay premature steering unwind when bearing is
already converging and reduce rate-driven amplification while bearing is
diverging. Under the certified prewarm, the next CFD rollout should preserve
central-wake acquisition and capture while reducing the visible early
loop/reversal sequence, mean distance, or arrival time relative to the
replicated `0.25` anchor. Falsify this local directional hypothesis if capture
is later than `244.547`, mean distance exceeds `6.452L`, controller-relative
upstream transport falls, lateral force/crossflow rises, or the final approach
develops a new overshoot. If falsified, restore `0.25` and treat the sampled
static-bearing/rate bundle as a local optimum; later workers should test a
distinct normalized corridor signal, not closing-speed relief, higher rate
lead, sharper static bearing, or more gait amplitude.
