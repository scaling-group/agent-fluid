# Multi-wake candidate diagnosis

## Evidence read before policy editing

- The shared prewarm sheet shows the fish held near the upper-right boundary
  while four mature, interacting cylinder streets occupy the route to the
  second-row target. This is the common initial condition, not evidence for a
  particular controller.
- The positive-bearing, posterior-only anchor (`0.90` period, `28 deg`
  oscillator, `10 deg` steering limit) visibly self-propels upstream before a
  broad upper loop. Its mean head x velocity exceeds the local upstream flow
  (`-0.0447` versus `-0.0293`), but it reaches only `6.34L`, exits after
  `73.39` release units, and reaches the posterior angle plus both joint-rate
  and command limits with RMS force/moment `196/2014`.
- The assigned parent's normalized heading-rate damper at gain `0.35` keeps
  the propulsion oscillator intact and strengthens self-propulsion: head x
  displacement improves to `-4.69L`, progress to `0.255`, and mean distance
  to `9.48L`. Its released sheet nevertheless repeats the upper-loop exit,
  with `+1.80L` head-y displacement, `6.09L` maximum target-lateral offset,
  a `7.30L` closest approach, all rate/command caps, and RMS force/moment
  `284/2797`.
- Doubling only that damping gain to `0.70` is the strongest current sampled
  policy. The sheet shows substantially farther leftward translation before
  the same final upward curl. Metrics confirm self-propulsion rather than
  passive advection: mean head velocity is `-0.1300` while mean local flow is
  `-0.0908`. Relative to gain `0.35`, x displacement improves from `-4.69L`
  to `-6.93L`, closest approach from `7.30L` to `5.33L`, mean distance from
  `9.48L` to `8.03L`, progress from `0.255` to `0.380`, and score from
  `-11.29` to `-9.53`. This is not a loop or load solution: release survival
  is slightly lower (`55.38` versus `56.93`), head-y displacement and maximum
  lateral offset remain essentially fixed at `+1.80L` and `6.09L`, both rate
  and command caps remain active, the posterior angle still reaches
  `44.1 deg`, and RMS force/moment rise to `325/3331`.
- The sampled addition of a bounded body-lateral-velocity damper to gain
  `0.35` is a negative result. It leaves the same `+1.79L` upper exit and
  `6.09L` maximum lateral offset while worsening x displacement to `-3.40L`,
  closest approach to `7.73L`, progress to `0.174`, and score to `-12.37`.
  Body-lateral damping therefore should not be strengthened or added to the
  current best controller.

## Single candidate hypothesis

Retain the complete gain-`0.70` direct-heading-rate policy, including its
upstream-capable oscillator, posterior servo, positive bearing sign, turn-rate
scale, and action limit. Isolate one change: reduce the static posterior
steering ceiling from `10` to `8 deg`. Stronger turn-rate damping improved
leftward approach monotonically but had no measurable lateral benefit, so a
further gain increase is not supported. The persistent near-limit posterior
bend instead supports testing less steady steering authority, without the
failed bearing-rate or body-lateral-rate channels and without weakening
propulsion.

This candidate is a falsifiable next test, not a claimed CFD improvement. It
should preserve most of the gain-`0.70` upstream displacement while reducing
the upper excursion, posterior angle occupancy, and force/moment loads enough
to survive beyond `55.38` units; retaining a closest approach near or below
`5.33L` would support the mechanism. If upstream progress falls materially or
closest approach worsens without lateral relief, restore the `10 deg` ceiling.
If the same upper loop persists while upstream progress survives, static bias
is not the missing channel; later workers should vary the direct turn-rate
sensitivity scale rather than revive target-bearing-rate or lateral-velocity
damping.
