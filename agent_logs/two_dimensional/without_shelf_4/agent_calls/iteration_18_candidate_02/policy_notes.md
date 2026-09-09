# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheets are byte-identical and show the fish held at the
  common upper-right release pose while four developed, overlapping cylinder
  streets fill the target corridor. They establish the common wake layout but
  cannot rank candidate policies.
- Three current samples reproduce the pure rolling-progress selector with a
  `0.015 L/time` transition scale exactly. The fourth is the otherwise matched
  `0.020 L/time` parent. All four remain finite and capture, so there is no
  current failure sheet; the inherited `75%` progress / `25%` drift-magnitude
  blend is the informative failure boundary. It retained the gait but made
  repeated reversals and a deep lower-corridor excursion, then missed the
  `300` horizon at `3.689L` final and `7.507L` mean distance. Therefore this
  candidate keeps rolling closing speed as the sole selector and does not
  blend another signal into its schedule.
- Relative to `0.020`, the replicated `0.015` policy takes a distinct late wake
  band and captures at `210.370` rather than `213.659`. Score/mean distance
  improve from `-3.863/5.856L` to `-3.528/5.519L`; mean controller-relative
  upstream transport rises from `0.01261` to `0.01672`, upstream head
  displacement rises from `10.915L` to `11.040L`, and total command energy
  falls from `148695` to `147846`.
- The gain is selector timing rather than added propulsion or a relaxed guard:
  maximum anterior acceleration stays `31.055 rad/time^2`, maximum lateral
  target offset stays `4.293L`, and anterior joint angle/velocity extrema are
  unchanged. The tradeoff is higher RMS lateral force/moment,
  `18.426/363.057` versus `17.761/354.838`, even though relative crossflow is
  slightly lower (`0.13289` versus `0.13353`). This rules out treating sharper
  switching or lower crossflow as a monotone proxy for route quality.
- Visually, both successful sheets show active self-propulsion through the
  broad release turn and repeated wake-band crossings, followed by nearly
  horizontal target entry. Their early routes are closely matched; the clear
  separation is later, where `0.015` holds a different central-wake approach.
  No collision, exit, instability, or terminal rebound is visible or reported.
  That topology supports preserving the sharp closing-side selection while
  testing whether the load cost comes from using the same sharpness during
  temporary recession and recovery.

## Single candidate hypothesis

Preserve the replicated `20.25 deg`, `0.67`-period gait, posterior lag and
damping, `10 deg` steering bound, `0.30` bearing scale, `0.25` bearing-rate
lead, sign-gated target-away lateral correction, `0.07--0.08` lookahead
envelope, `0.10` lateral-velocity clamp, and `31.2` acceleration guard. Keep
rolling closing speed as the only schedule input, but split the transition
scale by its sign: use the improved anchor's `0.015 L/time` for positive
closing speed and the lower-load parent's `0.020 L/time` for zero or negative
closing speed. The resulting selector remains continuous at zero, bounded by
the fully evaluated endpoints, and uses no coordinate, route, clock,
prescribed inflow, remote wake probe, or target-station flow signal.

This one candidate isolates which half of the transition produced the sampled
route/load tradeoff. The expectation is to retain the `0.015` policy's late
wake-band choice and route quality while softening recovery-phase steering
enough to move force/moment toward the `0.020` parent. Call it an improvement
only if it captures with mean distance near or below `5.519L`, arrival no later
than `210.370`, positive upstream margin, and lower force/moment without larger
excursion, switching, guard contact, or effort growth. Falsify the hypothesis
if route divergence actually depends on the receding-side sharpness: later or
lost capture, mean distance above the `0.020` parent's `5.856L`, upstream margin
below `0.01261`, or renewed wide reversals would show that the full symmetric
`0.015` anchor should be restored. Scope is limited to the retained gait and
certified fixed-prewarm phase until later CFD and held-out-phase evidence exist;
no same-worker outcome is claimed.
