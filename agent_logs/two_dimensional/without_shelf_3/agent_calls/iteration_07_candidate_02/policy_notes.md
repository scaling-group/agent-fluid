# Wake-Policy Candidate Notes

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while four developed cylinder streets overlap around the target.
  It is identical initial-condition evidence, not a candidate effect. Every
  released sample remains to the right of the useful wake corridor, so the
  present decision concerns far-field propulsion and course retention rather
  than wake capture.
- The strongest finite sampled controller uses the `0.75`-period angle-only
  oscillator, `0.60` positive-bearing gain, `12 deg` steering ceiling, fixed
  `0.04` recent-turn damping, and local joint guards. Its keyframes show a
  sustained nearly horizontal upstream leg followed by a broad upward turn and
  top exit. The metrics confirm active, low-load propulsion: head displacement
  `(-4.08,+1.80)L`, mean velocity/local-flow x `-0.0673/-0.0457`, minimum
  range `6.71L`, progress `0.217`, and RMS force/moment `66.5/958`. Its
  anterior speed still reached `4.36 rad/time`, so the existing guards and
  `1600 deg/time^2` smooth demand bound remain necessary.
- The assigned parent's isolated reduction of that controller's steering
  ceiling from `12 deg` to `10 deg` is now evaluated. Its released sheet shows
  a shorter leftward leg followed by the same upward-loop topology. Upstream
  head travel fell from `-4.08L` to `-1.43L`, minimum range worsened from
  `6.71L` to `9.00L`, progress fell from `0.217` to `0.0417`, and final
  range worsened to `11.91L`. RMS force/moment fell only modestly to
  `53.8/788`; finite low loads did not compensate for the lost approach.
  Reducing bearing gain alone from `0.60` to `0.45` likewise retained the
  upper exit while cutting upstream travel to `-0.73L` and worsening minimum
  range to `9.90L`. Static steering attenuation is therefore not supported as
  the remedy for the visible turn.
- The inherited exact `0.05` turn-damping continuation is an equally important
  negative boundary. Its keyframes do not interpolate gently from the `0.04`
  upper exit: after approaching, the fish makes a full lower return and is
  advected out. It survives `92.81` released time and reaches `6.83L`, but
  ends with head displacement `(+0.33,-13.31)L`, progress `-0.208`, and mean
  y velocity/local flow `-0.142/-0.150`. The range-gated increase toward
  `0.06` also degraded the initial approach. This candidate therefore keeps
  the demonstrated fixed `0.04` value rather than assuming a derivative-gain
  midpoint is safe.
- The sampled `16 deg` bearing-only guarded controller cannot identify the
  effect of a higher steering ceiling because it simultaneously changes
  steering gain, posterior damping, guards, action shaping, and removes turn
  damping; its RMS force/moment `350/5007` reinforce the need for a
  single-variable test.

## Candidate hypothesis

Restore the strongest finite controller exactly and change only its
policy-owned steering ceiling from `12 deg` to `14 deg`. Because
`limit*tanh(request/limit)` is nearly linear for small requests, the early
target-directed course and demonstrated propulsion should change less than the
large-bearing response. The added saturation authority is aimed at the late
course error for which the isolated `10 deg` reduction was harmful. The
controller retains the same normalized body-frame bearing and recent-turn-rate
signals, oscillator, posterior lag, guards, and smooth action bound; it adds no
coordinates, route, clock, target identity, prescribed inflow, remote probe,
or omitted research-shelf dependency.

The next CFD rollout supports the hypothesis only if it preserves meaningful
negative head-x displacement and finite loads while improving on the `6.71L`
minimum range or delaying the `65.47`-time upper exit. It is falsified if the
extra ceiling strengthens the upper loop, collapses upstream propulsion, or
raises joint excursions and force/moment loads toward the confounded
`16 deg` sample. No result for this unevaluated candidate is claimed here.
