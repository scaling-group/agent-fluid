# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled prewarm sheets are byte-identical. They show the fish held at
  the upper-right while the four staggered cylinder streets develop and
  overlap around the target corridor. This common initial condition cannot
  distinguish controllers.
- Three current released sheets and their metrics exactly reproduce the
  strongest finite anchor: the `20.25 deg`, `0.67`-period, `0.25`-lead policy
  makes several large but productive turns on the right, enters the central
  interacting wake, and captures on an almost horizontal approach at
  `244.547`. Its mean/final distance is `6.452/0.750L`, maximum lateral target
  offset is `4.293L`, and there is no collision, domain exit, instability, or
  rebound. Mean velocity x `-0.04443` exceeds the magnitude of mean local-flow
  x `-0.03649`, leaving `0.00793` controller-relative upstream transport, so
  the route is wake-assisted rather than passive advection.
- The prefilled `20 deg` controller follows the same route family but captures
  later at `266.255` with mean distance `7.218L`. The anchor's anterior
  acceleration already reaches `31.055 rad/time^2` below its `31.2` guard and
  the `31.416` episode cap. This supports restoring the sampled `20.25 deg`
  propulsion shell but rules out further amplitude increase.
- The assigned parent's extra heading-rate damping is a concrete negative
  component-separation result. Its keyframes retain the anchor's broad turn
  sequence and central-wake capture, but the added term delays capture to
  `259.160`, slightly worsens mean distance to `6.502L`, reduces
  controller-relative upstream transport from `0.00793` to `0.00359`, and
  raises relative crossflow from `0.13437` to `0.13610`. RMS force and moment
  improve from `18.263/362.214` to `18.202/357.284`, but those load reductions
  do not compensate for weaker transport and later arrival.
- The inherited sign-asymmetric rate-lead rollout is the informative hard
  failure. Its sheet shows repeated right-side reversals without acquisition
  of the successful central corridor. It times out at `300` with final/minimum
  distance `3.632/3.290L`, mean distance `8.447L`, maximum lateral offset
  `4.703L`, and only `0.708` progress. Its lower RMS force (`17.349`) is not an
  efficiency gain because the fish advances only `8.038L` upstream and never
  reaches the target. Therefore neither more heading damping nor reducing the
  bearing-rate lead only when `bearing * bearing_rate > 0` is supported.

## Candidate hypothesis

Restore every demonstrated `20.25 deg` anchor setting, including its
`0.25` bearing-rate lead and `31.2` acceleration guard. Add one independently
bounded, opposite-direction heading-rate term: clamp `heading_rate` to
`0.30 rad/time` and add it to predicted bearing with a `0.025`-time
coefficient. Because body-frame bearing rate contains inertial target-line
rotation minus body heading rate, this keeps the demonstrated `0.25`
coefficient on target-line motion while changing only the heading-rate
coefficient from `-0.25` to `-0.225`. The maximum perturbation before the
bearing nonlinearity is `0.0075 rad`, half the magnitude of the failed parent
test and only `2.5%` of the bearing scale.

The parent's more-damped route retained capture and lowered loads but lost
upstream margin and time, which suggests that some of the anchor's visible
turning is productive for timely wake entry. This candidate tests whether a
small yaw-damping relief preserves that target-line anticipation while
advancing central-wake acquisition. Improvement requires capture earlier than
`244.547` or mean distance below `6.452L` without increasing the `4.293L`
lateral excursion, losing the `0.00793` relative-upstream margin, contacting
the acceleration guard, or materially raising `18.263/362.214` force/moment
loads. Falsify on later/lost capture, wider reversals, lower upstream margin,
or load growth; then restore the plain anchor and treat direct heading-rate
decomposition as exhausted until time-resolved evidence identifies a safer
phase or observation.
