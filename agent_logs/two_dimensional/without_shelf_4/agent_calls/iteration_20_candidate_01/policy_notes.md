# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the common upper-right release pose while the four staggered-cylinder
  streets develop through the target corridor; this fixes the wake layout and
  phase but does not rank controllers.
- All four current samples reproduce the symmetric `0.015 L/time` pure
  rolling-closing-speed selector exactly. Their released sheets show an
  actively oscillating, self-propelled fish making a broad initial descent,
  several jagged wake-band reversals, and a nearly horizontal target entry.
  The metrics confirm useful propulsion rather than passive advection: mean
  upstream head speed is `0.05223`, versus `0.03551` mean local-flow magnitude
  in x, leaving `0.01672` controller-relative upstream transport. The policy
  captures at `210.370`, with score/mean distance `-3.528/5.519L`, upstream
  displacement `11.040L`, maximum lateral offset `4.293L`, command energy
  `147846`, and RMS relative crossflow/force/moment
  `0.13289/18.426/363.057`. Maximum anterior acceleration is already
  `31.055 rad/time^2` under the `31.2` guard, so the opportunity is steering
  timing rather than more drive.
- The inherited receding-soft sign split (`0.015` while closing, `0.020` while
  receding) is a finite but inferior contrast. It arrives `3.899` earlier and
  lowers effort and moment, yet worsens mean distance to `5.943L`, score to
  `-3.956`, and upstream transport to `0.01215`. Its calmer-looking middle
  path therefore does not justify weakening recovery.
- Three inherited logs independently evaluate the complementary closing-soft
  split (`0.020` while closing, `0.015` while receding) and reproduce the same
  semantic failure. The released sheet initially descends like the anchor but
  then loops on the right, reverses upward, and crosses the top boundary
  without entering the useful central wake. Diagnostics agree: termination is
  `left_domain`, progress is `-0.00953`, mean/final/minimum distance is
  `11.062/12.542/7.316L`, upstream head displacement collapses from `11.040L`
  to `0.651L`, and maximum lateral offset expands from `4.293L` to `6.011L`.
  Unchanged gait extrema and similar finite crossflow/loads isolate the lost
  route to closing-side selector timing. Thus neither sign of the successful
  `0.015` transition should be softened, and lower force alone is not evidence
  of corridor retention.
- Constant bearing-rate leads of `0.20` and `0.30` are also inherited negative
  controls around the `0.25` anchor: both capture later, increase mean distance
  and lateral force, and reduce upstream transport. The remaining supported
  rate-timing question is not another constant gain but a bounded
  convergence/divergence isolation. The visible anchor's repeated reversals
  make converging-error anticipation a specific, falsifiable target.

## Single candidate hypothesis

Preserve the reproduced `20.25 deg`, `0.67`-period propulsion, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, target-away lateral
correction, symmetric `0.015 L/time` pure progress selector, `0.07--0.08`
lookahead envelope, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Keep the demonstrated `0.25` bearing-rate lead whenever bearing error
is stationary or diverging. Only when `bearing * bearing_window_rate < 0`,
smoothly raise the lead toward the previously evaluated `0.30` endpoint using
a dimensionless convergence magnitude normalized by the existing bearing and
rate limits. The schedule is continuous, bounded in `0.25--0.30`, expressed
entirely in target-relative body-frame observations, and adds no coordinate,
route, clock, prescribed inflow, wake probe, or target-station signal.

The hypothesis is that extra anticipation during error convergence will brake
imminent bearing overshoot and reduce the anchor's jagged wake-band reversals,
while the unchanged `0.25` divergence response preserves acquisition and the
fully restored progress selector preserves upstream recovery. Count it as an
improvement only if it retains capture, lowers mean distance below `5.519L`
or score above `-3.528`, keeps upstream transport near `0.01672`, and does not
increase arrival time, lateral offset, force/moment, effort, switching, or
guard contact materially. Falsify it on later or lost capture, worse distance
integral, lower upstream margin, a larger loop, or load growth; that would show
that even phase-gated excursions from the constant `0.25` lead should be
avoided for this gait. Scope is limited to the certified fixed-prewarm phase
until later held-out wake conditions test transfer. No same-worker CFD result
is claimed.
