# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while the four staggered cylinder
  streets develop and overlap around the target corridor. Every released sheet
  inspected remains above and to the right of that corridor. The immediate
  control problem is therefore far-field course retention, not wake
  exploitation or `0.75L` capture.
- All four current sampled rollouts are finite and genuinely self-propelled on
  their useful leftward legs, but their sheets then show the same nose-up
  return and upper-domain exit. Their mean x velocities are more negative than
  local flow, while head-y exit displacement stays near `+1.8L`; the visible
  approach is active swimming rather than passive advection, and the late turn
  is wasteful rather than productive wake interaction.
- The strongest sampled controller applies the inherited bearing law while the
  target is ahead, then a `-0.25` fraction after the signed body-frame target
  projection passes abeam. It has head travel `(-4.44,+1.78)L`, minimum/mean/
  final range `6.63/9.45/9.43L`, progress `0.241`, lifetime `74.48`, and finite
  RMS force/moment `76.8/1030`. Against matched zero rearward bearing, it
  improves upstream travel, distance statistics, progress, and lifetime, so it
  is the target-ahead and near-abeam anchor even though its sheet still exits
  upward without reaching the useful wake region.
- The newly inherited `-0.50` continuation is a concrete negative result. Its
  sheet repeats the upper exit, and stronger reversal starting at abeam cuts
  upstream travel to `-3.49L`, worsens minimum/mean/final range to
  `6.76/10.12/10.18L`, lowers progress to `0.180`, and shortens lifetime to
  `65.44`. Its lower `65.5/901` RMS loads do not compensate for losing the
  approach. Thus rearward-bearing magnitude is not monotone, and `-0.50`
  authority must not replace `-0.25` at the original crossing.
- A separate inherited attempt kept `-0.25` but added `12` of rearward-only
  overspeed damping. It also repeats the visible upper exit and reduces head-x
  travel to `-3.71L` and progress to `0.194`, despite a `6.60L` transient
  minimum and finite `71.3/925` RMS loads. Together with the sampled
  zero-bearing plus rearward-damping result (`-4.15L`, progress `0.222`), this
  rejects treating the abeam crossing alone as permission for a strong guard
  or derivative correction.
- Earlier inherited logs also reject always-active lateral-velocity feedback,
  short-window opening attenuation, full-circle bearing reconstruction, and
  changes around the sharply isolated `0.04`/`12 deg` approach law. No omitted
  research shelf or neighboring configuration was consulted.

## Candidate hypothesis

Start from the strongest sampled `-0.25` fore/aft policy and leave its
oscillator, guards, `0.60` bearing gain, `12 deg` steering ceiling,
`0.35/0.65` curvature allocation, fixed `0.04` recent-turn damping, and `0.5L`
abeam transition unchanged. Preserve its bearing authority exactly until the
target is more than `1.0L` behind in the normalized body frame. Only beyond
that deeper terminal state, smoothly add another `-0.25` bearing fraction over
`0.5L`, asymptoting to the inherited `-0.50` authority. This two-stage gate
isolates timing from magnitude: the failed stronger reversal no longer acts at
the first abeam crossing, while the best sampled law remains responsible for
the entire demonstrated approach.

The hypothesis is supported only if the rollout remains finite, retains about
`-4.4L` upstream travel and a `6.7L` or better approach, then delays or removes
the visible upper return while improving progress or mean/final range without
raising loads materially above the sampled `77/1030` scale. It is falsified if
the deeper gate is never reached, the useful leg shortens, the same upper exit
persists without material metric gain, a lower full return appears, joint one
rides its hard speed cap, or loads rise. The mechanism is bounded and uses only
normalized body-frame target geometry; it contains no coordinate, clock,
route, prescribed inflow, remote wake probe, target-station signal, or omitted
shelf dependency. Its CFD result is deferred to EvE and is not claimed here.
