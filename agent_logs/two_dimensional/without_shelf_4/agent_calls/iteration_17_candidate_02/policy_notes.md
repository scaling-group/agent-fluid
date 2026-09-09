# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The sampled and inherited shared-prewarm sheets are byte-identical and show
  the fish held at the upper-right release pose while the four staggered
  cylinder streets develop across the target corridor. This anchors a common
  initial condition; it cannot rank policies.
- The strongest finite candidate is reproduced exactly by two current samples.
  Its pure rolling-closing-speed schedule uses a `0.015L/time` transition
  between the `0.08` receding and `0.07` closing counter-drift lookaheads. The
  released sheet shows active propulsion through a broad initial turn and
  several wake-band reversals, followed by an almost horizontal target entry
  without collision, exit, instability, or terminal rebound. Both samples
  capture at `210.370` with score/mean distance `-3.528/5.519L`, maximum
  lateral offset `4.293L`, controller-relative upstream speed `0.01672`, RMS
  relative crossflow `0.13289`, RMS force/moment `18.426/363.057`, and command
  energy `147846.5`. The anterior acceleration maximum remains
  `31.055 rad/time^2` below the `31.2` policy guard.
- The assigned parent's latest inherited rollout is the decisive failure
  contrast because its candidate file is byte-identical to the current
  `0.020L/time` prefill and to two earlier captures. Its sheet reaches the
  central wake and comes within `0.960L`, then makes a lower-corridor turn,
  rebounds vertically past the target, and finishes above it at `2.904L` when
  the horizon expires. Mean distance grows to `6.613L` and maximum lateral
  offset to `5.835L`. Yet controller-relative upstream speed stays positive at
  `0.01639`, anterior acceleration is unchanged at `31.055`, and finite RMS
  force/moment fall to `17.154/355.540`; this is terminal corridor-retention
  sensitivity rather than lost propulsion, saturation, collision, exit, or
  numerical instability. The byte-identical shared-prewarm sheet and policy
  do not establish the source of the rollout divergence, so the evidence does
  not justify a wake-phase or hardware-specific causal claim.
- The inherited `75%` progress / `25%` away-drift blend supplies a separate
  hard negative: bounded signal interpolation missed at minimum/final/mean
  distances `3.381/3.689/7.507L`, with only `-8.120L` head displacement in x.
  Together with the latest prefill rebound, this rules out adding a drift
  mixture or weakening pure progress timing as a response to the miss.

## Single candidate hypothesis

Adopt the twice-sampled `0.015L/time` pure rolling-closing-speed transition as
the one candidate. Preserve the `20.25 deg`, `0.67`-period propulsion shell,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, target-away translation
gate, `0.07--0.08` lookahead envelope, and `31.2` acceleration guard. Relative
to the prefill, this changes only `closing_speed_scale` from `0.020` to `0.015`
and makes the continuous schedule approach its receding/closing endpoints more
promptly; it adds no coordinate, route, clock, prescribed inflow, or remote
wake probe.

The falsifiable local expectation is capture near `210.370`, mean distance near
`5.519L`, positive controller-relative upstream transport, and no increase
beyond the sampled `4.293L` excursion or actuation guard. Treat the candidate
as unsupported if a later independent rollout misses or rebounds after
near-entry, captures later than `213.659` without a compensating integral gain,
exceeds `5.856L` mean distance, loses upstream transport, grows excursion,
contacts the acceleration guard, or materially increases switching, loads, or
effort. The exact-prefill divergence means two same-step reproductions are a
stronger local anchor, not proof of robustness; independent later-step and
held-out wake-phase evaluations remain required. No same-worker CFD result is
claimed.
