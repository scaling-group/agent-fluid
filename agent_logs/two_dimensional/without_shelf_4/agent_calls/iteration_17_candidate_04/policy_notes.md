# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish held at the common upper-right
  release pose while the four staggered-cylinder streets develop and overlap
  through the target corridor. This is the certified common initial condition,
  not candidate-ranking evidence.
- The four sampled rollouts reduce to two exactly reproduced policies, and all
  four reach the target without collision, domain exit, instability, or a
  horizon miss. There is therefore no current hard-failure sheet. The
  `0.015L/time` pure rolling-progress transition is the strongest finite
  reference: both copies capture at `210.370`, score `-3.528`, and hold mean
  distance to `5.519L`. Mean upstream head speed `0.05223` exceeds the
  `0.03551` magnitude of mean local-flow x, leaving `0.01672` controller-
  relative upstream transport; the fish is actively self-propelled through
  the developed wake rather than passively advected.
- The otherwise matched `0.020L/time` pair is the informative finite contrast.
  Both copies capture at `213.659`, score `-3.863`, and have `5.856L` mean
  distance and `0.01261` upstream margin. The `0.015` sheet replaces its
  pronounced penultimate upper-corridor turn with a lower, more direct late
  approach before the same nearly horizontal target entry. The scalar and
  visual improvement agrees with slightly lower RMS relative crossflow
  (`0.13289` versus `0.13353`) and lower total command energy (`147846` versus
  `148695`).
- Sharpening is not an unqualified load improvement: relative to `0.020`, the
  `0.015` pair raises mean command energy from `695.945` to `702.794` and RMS
  lateral force/moment from `17.761/354.838` to `18.426/363.057`. Both pairs
  retain the same `4.293L` maximum lateral target offset and
  `31.055 rad/time^2` anterior acceleration, while their gait parameters and
  steering bounds are identical. The change therefore acts through steering
  timing and wake-route selection, not stronger propulsion, a relaxed guard,
  or a smaller excursion envelope.
- Inherited optimizer logs bound nearby alternatives. Constant `0.07` and
  `0.08` counter-drift policies both captured later than the progress
  schedules, `0.10` added a late lower-corridor excursion, and mixing 25%
  away-drift magnitude into the schedule missed the horizon despite bounded
  commands and lower force. The current result supports retaining rolling
  distance progress as the only selector and the evaluated `0.07--0.08`
  correction envelope; it does not support more drive, rotational feedback,
  or another selector blend.

## Single candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, target-away lateral-translation gate, `0.10`
lateral-velocity clamp, `0.015L/time` closing-side transition, and `31.2`
acceleration guard. Add one separately owned `0.0125L/time` receding-side
transition scale. When rolling closing speed is negative, the smaller scale
makes the existing progress weight approach the already evaluated `0.08`
recovery endpoint more decisively; at zero and for all positive closing speeds,
the candidate is identical to the reproduced `0.015` anchor. The selector
remains continuous at zero, stays exclusively on a normalized rolling-progress
signal, and never leaves the evaluated `0.07--0.08` lookahead interval. The
target-away gate still makes the correction zero for stationary or targetward
lateral translation and bounds it by `0.008 rad` before the steering
nonlinearity.

This one-sided test isolates whether the score-leading transition gained from
faster stalled/receding recovery without further driving closing motion toward
the higher-load `0.07` endpoint. The `0.0125` scale is local to the observed
`0.01261--0.01672L/time` upstream-margin range; no coordinate, route, clock,
prescribed inflow, or remote wake probe is introduced. Call it an improvement
only if capture remains no later than `210.370`, score exceeds `-3.528` or mean
distance falls below `5.519L`, and RMS force/moment do not materially exceed
`18.426/363.057`. Falsify the one-sided sharpening on a miss, a renewed late
corridor excursion, worse route integral, nonpositive upstream margin, visible
switching, larger excursion, acceleration-guard contact, or load/effort growth
without a compensating score gain. Its scope is the certified fixed-prewarm
phase until later held-out wake-phase evidence exists; no same-worker CFD
result is claimed.
