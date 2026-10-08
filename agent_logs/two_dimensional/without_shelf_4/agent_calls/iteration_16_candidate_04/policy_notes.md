# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheet shows the fish held at the upper-right
  release pose while the four staggered-cylinder streets develop and overlap
  through the target corridor. The sheets are the certified common initial
  condition and do not rank policies.
- All four current sampled solvers are finite captures with the same
  `20.25 deg`, `0.67`-period gait, posterior response, bearing/rate bundle, and
  actuator envelope. They are actively self-propelled rather than simply
  advected: mean upstream head velocity exceeds the magnitude of mean local
  flow x. Their common `31.055 rad/time^2` anterior maximum stays below the
  `31.2` policy guard, while the identical `4.293L` lateral-offset maximum
  isolates their differences to steering timing.
- The score-leading rolling-progress schedule is the strongest finite anchor.
  Its keyframes show a broad release turn, several active crossings of the
  interacting wake bands, and an almost horizontal target entry. It captures
  at `213.659` with score `-3.863`, mean distance `5.856L`, upstream transport
  margin `0.01261`, RMS force/moment `17.761/354.838`, and total effort
  `148695`; there is no collision, exit, instability, or terminal rebound.
- The away-drift-magnitude schedule is a useful complementary success. Its
  sheet reaches the central wake sooner and captures earliest at `196.900`,
  with higher upstream margin `0.01735`, lower force/moment
  `17.672/352.909`, and lower total effort `136830`. Its route integral and
  score regress to `6.211L/-4.230`, so it supplies a timing/load mechanism but
  does not replace the progress schedule. The constant `0.07` comparator has
  wider, longer reversals and captures at `245.449` with `6.305L` mean
  distance and higher `18.399/363.454` loads.
- The assigned parent's inherited `75/25` arithmetic blend is the informative
  hard failure. Despite keeping the same gait and the lookahead inside the
  two successful endpoints' `0.07--0.08` envelope, it misses at the `300`
  horizon with score `-8.045`, mean/minimum/final distance
  `7.507/3.381/3.689L`, and only `0.703` progress. Its sheet shows repeated
  large upper/lower reversals and failure to retain the central approach;
  maximum lateral offset expands to `5.342L`, total effort rises to `213651`,
  and upstream margin falls to `0.01033`. The unchanged anterior maximum and
  finite loads rule out propulsion saturation or numerical instability. The
  arithmetic interpolation itself changed wake-entry timing enough to destroy
  capture, so pointwise bounds and successful endpoints do not establish a
  convex policy-response region.

## Single candidate hypothesis

Preserve the evaluated rolling-progress anchor's propulsion, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lookahead, `0.10` lateral-velocity clamp, `0.02L/time` progress scale, and
`31.2` acceleration guard. Replace only the failed arithmetic combination
with a one-sided schedule:

```text
schedule_weight = max(progress_loss_weight, away_drift_weight)
lookahead = 0.07 + (0.08 - 0.07) * schedule_weight
```

This keeps every recovery command of the score-leading progress schedule: the
away-drift signal cannot lower lookahead when rolling distance is stalled or
receding. It can only raise lookahead, within the two evaluated endpoint
values, when target-away lateral drift is stronger than the progress demand.
That isolates the earliest/lower-load schedule's useful counter-drift timing
without repeating the convex blend's unevidenced weakening of progress-loss
recovery. Because the existing away-drift factor still gates the correction,
stationary or targetward lateral translation receives exactly zero added
term. Both inputs and their maximum remain bounded in `[0,1]`; the entire
addition stays below `0.008 rad` before the steering nonlinearity. The policy
uses only normalized body-frame task feedback and adds no coordinate, route,
target identity, clock, prescribed inflow, or remote wake probe.

The falsifiable expectation is retained capture and the progress anchor's
central-wake acquisition, with arrival, upstream margin, or loads moving
toward the drift-scheduled success. Call it an improvement if score exceeds
`-3.863` or mean distance falls below `5.856L` without later capture or load
growth; alternatively require capture before `213.659` with mean distance
below `6.0L` and force/moment no higher than `17.761/354.838`. Falsify the
one-sided selector on a miss, capture later than `213.659` without better
integral, mean distance at or above `6.211L`, upstream margin below `0.01261`,
higher load/effort, guard contact, lateral offset above `4.293L`, or visible
switching. This scope is limited to the certified fixed-prewarm phase, and no
same-worker CFD outcome is claimed.
