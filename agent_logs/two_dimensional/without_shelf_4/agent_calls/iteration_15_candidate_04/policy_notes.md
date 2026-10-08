# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets show the same fish held at the upper-right
  release pose while the four staggered-cylinder streets develop and overlap
  through the target corridor. This is the certified common initial condition,
  not candidate-ranking evidence.
- All four current released sheets terminate in target capture, so there is no
  current hard-failure sheet. The score-leading assigned parent is the most
  useful finite reference: its rolling progress schedule makes a broad initial
  turn, crosses several alternating wake bands under active body oscillation,
  and then approaches the target almost horizontally without collision, exit,
  instability, or visible rebound. It captures at `213.659`, with score
  `-3.863`, mean distance `5.856L`, controller-relative upstream transport
  `0.01261`, RMS relative crossflow `0.13353`, RMS force/moment
  `17.761/354.838`, and mean command energy `695.945`.
- The current `0.07` constant-lookahead sample is the most informative visual
  negative comparator. Its sheet reaches the same central-wake approach only
  after a longer sequence of corridor reversals and captures at `245.449`.
  Mean distance rises to `6.305L`, upstream transport is similar at `0.01284`,
  RMS force/moment rise to `18.399/363.454`, and total effort rises to
  `169649` from the parent's `148695`. Identical maximum lateral offset
  `4.293L`, anterior acceleration `31.055 rad/time^2`, and joint extrema show
  a steering-timing regression rather than lost propulsion or saturation.
- The away-drift-magnitude schedule is a complementary positive contrast. Its
  keyframes retain the large release turn and productive wake entry, but it
  completes the route earliest at `196.900`; controller-relative upstream
  transport rises to `0.01735`, RMS force/moment fall to `17.672/352.909`, and
  total effort falls to `136830`. Its mean distance and score, however, regress
  from the parent to `6.211L/-4.230`. Thus it improves transport timing and
  loads without matching the progress schedule's route integral.
- The constant `0.08` sample is dominated by the two schedules on route timing
  or integral (`224.488`, `6.311L`) and has higher force/moment than either.
  Inherited notes further bound constant tuning: `0.10` delayed capture to
  `263.346` with a late lower-corridor excursion, while rotational-rate changes
  delayed or lost capture. The inherited sign-asymmetric bearing-rate horizon
  miss is the available hard failure, but no corresponding current keyframe
  sheet is present. More drive is also unsupported because every current
  anterior maximum is already `31.055` against the `31.2` policy guard.

## Single candidate hypothesis

Preserve the assigned parent's demonstrated `20.25 deg`, `0.67`-period gait,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, `0.02L/time` progress
scale, and `31.2` acceleration guard. Change only the schedule that selects the
target-away lateral counter-drift lookahead. Form a convex combination of the
two evaluated schedule weights,

```text
schedule_weight = 0.75 * progress_loss_weight
                + 0.25 * away_drift_weight
lookahead = 0.07 + (0.08 - 0.07) * schedule_weight
```

with the `0.75` progress fraction owned by `target_policy_params()`. This
retains the evidence-backed score-leading schedule as the dominant signal and
admits a conservative fraction of the magnitude schedule that produced faster,
lower-load, higher-margin transport. Both inputs and their convex blend are
bounded in `[0,1]`; the correction remains exactly zero for stationary or
targetward lateral translation and never exceeds the evaluated `0.008 rad`
addition before the steering nonlinearity. It uses only normalized body-frame
task feedback and adds no coordinate, route, target identity, clock,
prescribed-inflow value, or remote wake probe.

The falsifiable expectation is retained capture with the parent's route
integral largely preserved while arrival, controller-relative upstream margin,
or load moves toward the away-drift schedule. Call this an improvement only if
score exceeds `-3.863` or mean distance is below `5.856L` without later capture
or load growth; alternatively require capture before `213.659` with mean
distance below `6.0L` and force/moment no higher than `17.761/354.838`.
Falsify the blend on a miss, capture later than `213.659` without a better
score/integral, mean distance at or above `6.211L`, upstream margin below
`0.01261`, higher force/moment or effort, guard contact, larger lateral
excursion, or visible switching. This scope is limited to the certified
fixed-prewarm phase until held-out wake-phase evidence exists; no same-worker
CFD result is claimed.
