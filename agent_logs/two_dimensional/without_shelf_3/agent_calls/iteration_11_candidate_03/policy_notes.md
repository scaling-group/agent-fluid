# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheets are identical common-initial-condition evidence:
  the fish is held above/right of the target while four developed cylinder
  streets overlap around the target corridor. Every released sheet examined
  remains outside that corridor, so this candidate addresses far-field course
  retention rather than claiming wake capture.
- The strongest finite sampled controller is the guarded angle-only oscillator
  with bearing gain `0.60`, steering ceiling `12 deg`, anterior allocation
  `0.35`, and fixed opposing recent-turn gain `0.04`. Its sheet shows an active
  nearly horizontal leftward leg followed by a sharp upper pitch and return.
  Metrics agree: head travel `(-4.08,+1.80)L`, minimum/final range
  `6.71/9.73L`, progress `0.217`, mean velocity/local-flow x
  `-0.0673/-0.0457`, and finite RMS force/moment `66.5/958`.
- The current prefill's range-gated damping increase repeats that upper exit
  earlier. Although its joint extrema remain almost identical to the anchor,
  it moves only `-2.48L` upstream, reaches `8.59L`, and raises RMS force/moment
  to `78.2/1119`. The sampled always-active lateral-velocity correction likewise
  repeats the upper exit with `-2.72L` travel and `8.20L` closest range. These
  results reject corrections that are active during the demonstrated closing
  leg.
- The assigned parent's opening-range steering release is negative as well.
  Its sheet preserves the upper-pitch topology but shortens head-x travel to
  `-2.27L`, worsens minimum range to `7.99L`, lowers progress to `0.099`, and
  raises RMS force/moment to `117/1568`. The eight-observation history spans
  only several CFD coupling steps, so the sign of
  `window_closing_speed_L` does not establish a sustained terminal return.
  Moreover, scaling the combined steering command attenuates the anchor's
  stabilizing `0.04` turn-rate term along with the bearing term.
- The other inherited step-10 result shifts anterior steering allocation from
  `0.35` to `0.30`; its sheet loses the leftward leg almost entirely, with
  `+0.07L` head-x travel, `9.82L` minimum range, and negative progress despite
  finite loads. Together with failed nearby damping, steering-ceiling, and
  bearing-gain variants, this supports restoring the complete finite anchor
  rather than changing another scalar.

## Candidate hypothesis

Restore the strongest finite controller's gait, guards, `0.35/0.65` steering
allocation, `12 deg` ceiling, and fixed `0.04` turn-rate damping. Change only
the target-bearing contribution using the signed, normalized forward component
already present in `state.target_body_L`. While the target is ahead, a smooth
fore/aft gate is effectively one and the anchor law is preserved. As the
visible upper pitch carries the target abeam and then behind, smoothly reduce
the bearing contribution to zero over a `0.5L` forward-projection scale while
leaving recent-turn damping fully active. This addresses a structural
observation alias: the supplied compact bearing uses the absolute forward
distance and therefore cannot by itself distinguish an ahead target from a
behind target during the return.

The hypothesis is supported only if the rollout remains finite, retains the
anchor's roughly `-4.08L` upstream leg and `6.71L` approach, and delays or
arrests the upper return without increasing joint/load extrema materially. It
is falsified if the fore/aft transition activates during the useful leg, the
same upper or a lower return persists, closest range worsens, or target-bearing
authority chatters near the abeam crossing. The gate is bounded and uses only
normalized body-frame target geometry; it contains no coordinates, clock,
route, prescribed inflow, remote wake probe, target-station flow, or omitted
research-shelf dependency. No same-worker CFD result is claimed.
