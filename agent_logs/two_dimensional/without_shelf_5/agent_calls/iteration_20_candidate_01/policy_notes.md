# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- This diagnosis uses only the task contract, assigned-parent guidance,
  sampled solver results, inherited optimizer logs, and the current compact
  rollout evidence. No omitted research shelf or neighboring configuration is
  used.
- The sampled shared-prewarm sheets are identical and show the fish held at
  the upper-right release pose while four staggered cylinder wakes develop and
  merge through the target region. This is the certified common initial
  condition, not a policy effect.
- All four current samples are successful finite captures; there is no current
  collision, exit, instability, or horizon-miss sheet. The visual comparison
  therefore uses the `1600 deg/time^2` best capture and the
  `1675 deg/time^2` weakest current capture, with inherited negative results
  supplying the failure boundary rather than inventing missing visual
  evidence. Both sheets show the same safe topology: an initial bounded turn,
  active diagonal swimming down and left under an alternating propulsive
  trail, late entry into the merged wake corridor, and target capture without
  approaching a cylinder. Useful leftward motion is self-propelled: mean fish
  velocity changes from `-0.3238L/time` at `1675` to `-0.3380L/time` at
  `1600`, versus mean local flow near `-0.18L/time` in both cases.
- With gait, lag, damping, bearing feedback, allocation, and observations
  fixed, the current cap sequence is directionally consistent. The single
  `1675` sample captures at `33.605` with mean distance `1.6954L`, command
  energy/power `43589/3272`, and posterior excursion `0.5006` rad. Two exact
  `1650` samples reproduce `33.027/1.6831L`, `42310/3183`, and `0.4950` rad.
  The single `1600` sample improves those measures to `32.202/1.6541L`,
  `40126/3010`, and `0.4736` rad, while preserving the visible route. Its
  posterior command reaches the intended `27.925 rad/time^2` ceiling but its
  posterior rate maximum falls to `4.4609 rad/time`, below the
  `4.5379 rad/time` episode limit touched at `1675` and `1650`.
- Tightening is not established as an unloading mechanism. From `1675` to
  `1650` to `1600`, relative-crossflow RMS is
  `0.2356 -> 0.2358 -> 0.2321`, while force/moment RMS is
  `57.87/797.09 -> 63.93/859.31 -> 64.77/860.25`. Thus loads rise over the
  wider interval but nearly plateau from `1650` to `1600`; the visibly denser
  disturbed trail at capture is consistent with retaining explicit rejection
  limits. Assigned-parent and inherited logs also show that weakening the gait
  fell behind on the same route and that mixed auxiliary feedback became
  unstable at release time `2.807`, so neither mechanism is combined with the
  cap test.

## Single-candidate hypothesis

Continue only the posterior acceleration-bound axis by one established
`50 deg/time^2` step, from `1600` to `1550 deg/time^2`. Preserve the
`0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`, bounded
body-frame bearing gain `1.7`, 12-degree steering limit, fraction-`0.35`
allocation, and observation set. The hypothesis is that a slightly tighter
posterior command will retain the same safe self-propelled route while reducing
posterior excursion and effort enough to improve arrival or mean distance.
This is one boundary probe, not a claim that continued tightening is generally
beneficial.

The later CFD evaluation supports `1550` only if it preserves capture and the
visible turn-then-diagonal route and materially improves at least one of the
`1600` navigation/effort anchors (`32.202` arrival, `1.6541L` mean distance,
`40126/3010` energy/power) without material regression in the others. Loss of
capture or route, collision, exit, instability, posterior excursion above the
`0.521`-rad unbounded anchor, relative-crossflow RMS above `0.25`, force RMS
above `75`, or moment RMS above `1000` rejects further tightening. Any positive
result remains limited to the certified wake phase and start pose until
held-out evidence exists; no current-worker CFD outcome is assumed.
