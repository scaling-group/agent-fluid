# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the fish held above and to the right of four
  developed, interacting cylinder streets. It is the certified common initial
  condition, not candidate-specific control evidence. Every released sheet
  remains to the right and above the target-centered second-row wake corridor,
  so the immediate problem is far-field course retention rather than wake
  capture.
- The strongest finite sample is the guarded angle-only oscillator with
  bearing gain `0.60`, steering ceiling `12 deg`, and opposing recent-turn gain
  `0.04`. Its sheet shows genuine self-propelled leftward travel through the
  middle frames, then a sharp upward pitch and broad upper return. The embedded
  diagnostics agree: mean x velocity `-0.0673` exceeds the local upstream-flow
  magnitude `-0.0457`, head travel is `(-4.08,+1.80)L`, minimum range is
  `6.71L`, progress is `0.217`, and finite RMS force/moment are `66.5/958`.
- The newly sampled body-frame lateral-velocity correction does not arrest
  that upper loop. With the anchor fixed, adding gain `0.35` capped at `2 deg`
  repeats the same visible upper exit and leaves head-y travel essentially
  unchanged (`+1.803L` versus `+1.804L`). It cuts head-x travel to `-2.72L`,
  worsens minimum range to `8.20L`, lowers progress to `0.129`, and raises RMS
  force/moment to `78.6/1084`; joint-one peak speed also rises from `4.36` to
  `4.45 rad/time`. The lower mean command power does not compensate for the
  lost course and target approach.
- The assigned parent's `0.0375` recent-turn candidate is now evaluated and
  also rejects local damping interpolation. Its sheet repeats the early upper
  pitch and return, while head-x travel collapses to `-0.63L`, minimum range
  worsens to `9.92L`, progress becomes `-0.014`, and final range grows to
  `12.60L`. Finite RMS force/moment `73.2/1099` show course loss rather than
  numerical instability. Together with inherited `0.0425`, `0.045`, `0.05`,
  and range-gated increases, this brackets `0.04` as an isolated empirical
  anchor rather than a derivative gain to interpolate around.
- The higher-authority `16 deg`, gain-`0.75` sample folds into the same upper
  failure sooner, reaches only `10.35L`, and raises RMS force/moment to
  `350/5007`. The isolated `14 deg` ceiling also shortens travel to `-2.46L`
  and reaches only `8.85L`. A `45 deg` large-bearing rolloff also shortens the
  useful upstream leg. Thus neither steering magnitude, nearby derivative
  damping in either direction, static bearing rolloff, nor the tested
  lateral-velocity term is supported.

## One candidate hypothesis

Restore the strongest finite controller's `0.04` recent-turn gain and change
only its mean-curvature allocation from `0.35` to `0.30` on the anterior joint,
with the complementary posterior share increasing from `0.65` to `0.70`. Every
evaluated scalar change to steering ceiling, bearing authority, nearby damping,
or lateral-velocity feedback repeats the upper loop while shortening the useful
leg. A small posterior allocation shift instead preserves the same bounded
total target-relative steering request while testing whether less mean anterior
bend can soften the visible nose-up pitch. Keep the `0.60` bearing gain,
`12 deg` ceiling, `0.75`-period oscillator, posterior lag, local joint guards,
and smooth `1600 deg/time^2` demand bound unchanged, and add no new observation.

The hypothesis is supported only if the rollout remains finite, retains the
anchor's upstream leg and closest approach, and delays or softens the upper
pitch without increasing its loads materially. It is falsified if head-x travel
falls materially short of `-4.08L`, minimum range worsens from `6.71L`, the
same upper or lower return appears, hard joint/action caps are touched, or RMS
force/moment rise materially. The policy uses only body-frame bearing, recent
turn rate, and joint state; it adds no coordinates, clock, route, prescribed
inflow, remote probe, station flow, or
omitted research-shelf dependency. Its CFD evaluation occurs after this worker
exits, so no result for this candidate is claimed here.
