# Multi-Wake Candidate Diagnosis and Hypothesis

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four developed cylinder streets overlap around the
  target. This is common initial-condition evidence, not a controller effect.
  Every released example remains to the right of the useful wake corridor, so
  this decision concerns far-field course retention and propulsion rather than
  wake capture.
- Uniform `0.04` opposing recent-turn-rate feedback is still the strongest
  finite anchor. Its released sheet shows a sustained, nearly horizontal
  upstream leg followed by a broad upper U-turn and top exit. The head moves
  `(-4.08,+1.80)L`, mean x velocity exceeds the local upstream flow in
  magnitude (`-0.0673` versus `-0.0457`), and minimum range reaches `6.71L`.
  RMS force/moment remain `66.5/958`, although joint-one speed reaches
  `4.36 rad/time`, so the local joint guards and smooth acceleration bound
  should remain.
- The assigned parent's isolated `0.045` continuation is now evaluated. Its
  keyframes do not split the upper/lower course outcomes: the upstream leg
  shortens sharply and the fish repeats the upper U-turn. Head displacement is
  only `(-0.15,+1.76)L`, minimum range worsens to `9.59L`, progress becomes
  `-0.046`, and release lifetime falls to `51.12`. Its mean x velocity is only
  `-0.0131` while local flow is `+0.0104`, compared with the anchor's stronger
  self-propelled upstream motion. RMS force/moment rise to `80.0/1259`, and
  joint-one speed rises to `4.40 rad/time`; the added damping therefore neither
  improves approach nor relieves actuation.
- This negative result sharpens the inherited course boundary. Uniform `0.05`
  initially reaches `6.83L` but then makes a lower return whose mean y velocity
  nearly follows local flow (`-0.142/-0.150`), ending at
  `(+0.33,-13.31)L`. The range-gated increase toward `0.06` also degraded the
  approach to `8.59L`. Changing the `0.04` anchor's steering ceiling to
  `10 deg` or `14 deg` likewise preserves an upper exit while reducing upstream
  travel to `-1.43L` or `-2.46L`. The evidence supports retaining the
  `12 deg` ceiling, oscillator, lag, and guards while testing only the newly
  narrowed derivative-gain bracket.

## One candidate hypothesis

Restore the strongest finite controller and change only its uniform opposing
recent-turn-rate gain from `0.04` to `0.0425`, the midpoint of the now-observed
`0.04--0.045` boundary. Keep bearing gain `0.60`, the `12 deg` steering limit,
the `0.75`-period angle-only gait, posterior lag, local joint guards, and the
smooth `1600 deg/time^2` demand bound unchanged. Every active constant remains
owned by `target_policy_params`; the controller uses only body-frame bearing,
recent turn rate, and joint state, with no coordinates, clock, route, prescribed
inflow, remote probes, or omitted research shelf.

This candidate is supported only if it remains finite and preserves meaningful
negative head-x travel while shifting the anchor's `+1.80L` upper-exit course;
strong support would preserve or improve the `6.71L` minimum without repeating
either U-turn. It is falsified if upstream displacement collapses toward the
`0.045` result, either boundary exit repeats, hard joint/action caps are
touched, or force/moment loads rise materially. No result for the unevaluated
candidate is claimed here.
